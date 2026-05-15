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
Write-Host "`nFound $($subscriptions.Count) subscriptions. Querying in parallel..." -ForegroundColor Yellow
 
# Emit peering rows directly — pipeline flattens them into a single array.
$allPeerings = $subscriptions | ForEach-Object -ThrottleLimit 10 -Parallel {
    $currentSubscription = $_
    $context = Set-AzContext -SubscriptionId $currentSubscription.Id -Scope Process
 
    Write-Host "[$($currentSubscription.Name)] fetching..." -ForegroundColor Cyan
 
    $vnets = Get-AzVirtualNetwork -DefaultProfile $context
 
    foreach ($vnet in $vnets) {
        foreach ($peering in $vnet.VirtualNetworkPeerings) {
            # RemoteVirtualNetwork.Id format:
            # /subscriptions/<subId>/resourceGroups/<rg>/providers/Microsoft.Network/virtualNetworks/<vnetName>
            $remoteId = $peering.RemoteVirtualNetwork.Id
            $remoteVnetName = ($remoteId -split "/")[-1]
            $remoteRg = ($remoteId -split "/")[4]
 
            [PSCustomObject]@{
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
 
# Flag expected VNets that have no peerings at all.
# Only meaningful when an explicit expected list is provided.
if ($expectedVnets.Count -gt 0) {
    $vnetsWithPeerings = $scopedPeerings | Select-Object -ExpandProperty VNet -Unique
    $missingPeerings = $expectedVnets | Where-Object { $_ -notin $vnetsWithPeerings }
    if ($missingPeerings) {
        Write-Host "`n=== VNets with no peerings ===" -ForegroundColor Cyan
        $missingPeerings | ForEach-Object { Write-Host "$_" -ForegroundColor Magenta }
    }
}