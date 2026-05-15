# Define expected subscriptions and VNets to scope the report.
$expectedSubscriptions = @(
    "rev-sub-corporate-workload-prod",
    "rev-sub-consumer-workload-test",
    "rev-sub-identity-prod"
)

$expectedVnets = @(
    "vn-use2-corp-it-prod-01",
    "vn-use2-cons-app-test-01",
    "vn-use2-id-prod-01"
)

# Disable context autosave to prevent cross-runspace contamination
Disable-AzContextAutosave -Scope Process | Out-Null
 
# Filter subscriptions: if list is empty, include all enabled (minus VS).
$subscriptions = Get-AzSubscription | Where-Object {
    $_.State -eq "Enabled" -and
    $_.Name -notlike "*Visual Studio Enterprise Subscription*" -and
    ($expectedSubscriptions.Count -eq 0 -or $_.Name -in $expectedSubscriptions)
}
Write-Host "`nFound $($subscriptions.Count) subscriptions. Querying in parallel...`n" -ForegroundColor Yellow
 
# Emit two row types: VNet markers (one per VNet) + Peering rows (one per peering).
# Pipeline flattens both into a single array, distinguished by the Type property.
$allRows = $subscriptions | ForEach-Object -ThrottleLimit 10 -Parallel {
    $currentSubscription = $_
    $context = Set-AzContext -SubscriptionId $currentSubscription.Id -Scope Process
 
    Write-Host "[$($currentSubscription.Name)] fetching..." -ForegroundColor Cyan
 
    $vnets = Get-AzVirtualNetwork -DefaultProfile $context
 
    foreach ($vnet in $vnets) {
        # Marker row: confirms this VNet exists somewhere in scope.
        [PSCustomObject]@{
            Type         = "VNet"
            Subscription = $currentSubscription.Name
            VNet         = $vnet.Name
        }
 
        foreach ($peering in $vnet.VirtualNetworkPeerings) {
            # RemoteVirtualNetwork.Id format:
            # /subscriptions/<subId>/resourceGroups/<rg>/providers/Microsoft.Network/virtualNetworks/<vnetName>
            $remoteId = $peering.RemoteVirtualNetwork.Id
            $remoteVnetName = ($remoteId -split "/")[-1]
            $remoteRg = ($remoteId -split "/")[4]
 
            [PSCustomObject]@{
                Type                  = "Peering"
                Subscription          = $currentSubscription.Name
                VNet                  = $vnet.Name
                VNetRg                = $vnet.ResourceGroupName
                Name                  = $peering.Name
                RemoteVNet            = $remoteVnetName
                RemoteRg              = $remoteRg
                State                 = $peering.PeeringState
                SyncLevel             = $peering.PeeringSyncLevel
                AllowForwardedTraffic = $peering.AllowForwardedTraffic
                AllowGatewayTransit   = $peering.AllowGatewayTransit
                UseRemoteGateways     = $peering.UseRemoteGateways
            }
        }
    }
}
 
$foundVnets = $allRows | Where-Object Type -eq "VNet"
$allPeerings = $allRows | Where-Object Type -eq "Peering"
 
# Peering report
Write-Host "`nGenerated on: $(Get-Date)" -ForegroundColor Yellow
 
# Apply VNet scoping: empty list means "include all".
$scopedPeerings = $allPeerings | Where-Object {
    $expectedVnets.Count -eq 0 -or $_.VNet -in $expectedVnets
} | Sort-Object Subscription, VNet, Name
 
Write-Host "`n=== Peering Details ===" -ForegroundColor Cyan
foreach ($p in $scopedPeerings) {
    $stateColor = switch ($p.State) {
        "Connected" { "Green" }
        "Initiated" { "Yellow" }
        "Disconnected" { "Red" }
        default { "Magenta" }
    }
    Write-Host "[$($p.State)] $($p.VNet) -> $($p.RemoteVNet) | $($p.Name)" -ForegroundColor $stateColor
    #Write-Host "    Local: $($p.Subscription) / $($p.VNetRg)" -ForegroundColor White
    Write-Host "    SyncLevel: $($p.SyncLevel)   ForwardedTraffic: $($p.AllowForwardedTraffic)   GatewayTransit: $($p.AllowGatewayTransit)   UseRemoteGateways: $($p.UseRemoteGateways)`n" -ForegroundColor White
}
 
# Split into two checks when an explicit expected list is provided:
# Not Found - VNet name doesn't exist anywhere in scope (typo, wrong sub, deleted)
# No Peering - VNet exists but has zero peerings configured
if ($expectedVnets.Count -gt 0) {
    $foundVnetNames = $foundVnets.VNet | Sort-Object -Unique
    $vnetsWithPeerings = $scopedPeerings | Select-Object -ExpandProperty VNet -Unique
 
    $notFound = $expectedVnets | Where-Object { $_ -notin $foundVnetNames }
    $unpeered = $expectedVnets | Where-Object { $_ -in $foundVnetNames -and $_ -notin $vnetsWithPeerings }
 
    if ($notFound) {
        Write-Host "`n=== VNets not found ===" -ForegroundColor Cyan
        $notFound | ForEach-Object { Write-Host "$_" -ForegroundColor Red }
    }
 
    if ($unpeered) {
        Write-Host "`n=== VNets with no peerings ===" -ForegroundColor Cyan
        $unpeered | ForEach-Object { Write-Host "$_" -ForegroundColor Red }
    }
}