# Set to $true to also export the table to a CSV file.
$exportCsv = $false
$csvPath = ".\subnet-report.csv"

# Empty array to hold all subnet details found across subscriptions.
$allSubnetDetails = @()

# Define expected subscriptions and VNets to scope the report.
$expectedSubscriptions = @(
    "rev-sub-corporate-workload-prod",
    "rev-sub-consumer-workload-dev",
    "rev-sub-research-workload-prod"
)

$expectedVnets = @(
    "vn-use2-corp-it-prod-01",
    "vn-use2-corp-app-prod-01",
    "vn-use2-corp-it-test-01"
)

$expectedSubnets = @(
    "sn-wts-prod-01",
    "sn-files-prod-01",
    "sn-web-prod-01"
)

# Disable context autosave to prevent cross-runspace contamination
Disable-AzContextAutosave -Scope Process | Out-Null
 
$subscriptions = Get-AzSubscription | Where-Object { $_.State -eq "Enabled" -and $_.Name -in $expectedSubscriptions }
Write-Host "`nFound $($subscriptions.Count) subscriptions. Querying in parallel..." -ForegroundColor Yellow
 
# Emit subnet rows directly — pipeline flattens them into a single array.
$allSubnetDetails = $subscriptions | ForEach-Object -ThrottleLimit 10 -Parallel {
    $currentSubscription = $_
    $context = Set-AzContext -SubscriptionId $currentSubscription.Id -Scope Process
 
    Write-Host "[$($currentSubscription.Name)] fetching..." -ForegroundColor Cyan
 
    $vnets = Get-AzVirtualNetwork -DefaultProfile $context
 
    foreach ($vnet in $vnets) {
        foreach ($subnet in $vnet.Subnets) {
            # IpConfigurations = NICs, Private Endpoints, etc. attached to the subnet.
            $deviceCount = if ($subnet.IpConfigurations) { @($subnet.IpConfigurations).Count } else { 0 }

            # AddressPrefix can be a single CIDR string or an array (multi-prefix subnets).
            $addressRange = if ($subnet.AddressPrefix) { ($subnet.AddressPrefix -join ", ") } else { "n/a" }

            # Delegations = service reservations (Container Apps, App Service VNet integration, AKS, etc.).
            # ServiceAssociationLinks = service-managed bindings that also indicate the subnet is in use.
            $delegationNames = @()
            if ($subnet.Delegations) { $delegationNames += $subnet.Delegations.ServiceName }
            if ($subnet.ServiceAssociationLinks) { $delegationNames += $subnet.ServiceAssociationLinks.LinkedResourceType }
            $delegation = if ($delegationNames) { ($delegationNames -join ", ") } else { "" }
 
            [PSCustomObject]@{
                Subscription = $currentSubscription.Name
                VNet         = $vnet.Name
                Subnet       = $subnet.Name
                AddressRange = $addressRange
                DeviceCount  = $deviceCount
                Delegation   = $delegation
            }
        }
    }
}
 
# Subnet usage report
Write-Host "`nGenerated on: $(Get-Date)" -ForegroundColor Yellow
 
$scopedSubnets = $allSubnetDetails | Where-Object { $_.VNet -in $expectedVnets -and $_.Subnet -in $expectedSubnets } | Sort-Object Subscription, VNet, Subnet
 
# Subnets in the expected list that were never discovered in any VNet.
$foundSubnetNames = $scopedSubnets | Select-Object -ExpandProperty Subnet -Unique
$missingSubnets = $expectedSubnets | Where-Object { $_ -notin $foundSubnetNames } | Sort-Object
 
# Quick stats
$vnetCount = ($scopedSubnets | Select-Object -ExpandProperty VNet -Unique).Count
$subnetCount = $scopedSubnets.Count
$uniqueSubnetCount = $foundSubnetNames.Count
$deviceTotal = ($scopedSubnets | Measure-Object -Property DeviceCount -Sum).Sum
$delegatedCount = ($scopedSubnets | Where-Object { $_.Delegation }).Count

Write-Host "`n=== Stats ===" -ForegroundColor Cyan
Write-Host "Subscriptions : $($subscriptions.Count)" -ForegroundColor White
Write-Host "VNets         : $vnetCount" -ForegroundColor White
Write-Host "Subnets       : $subnetCount ($uniqueSubnetCount unique)" -ForegroundColor White
Write-Host "Devices       : $deviceTotal" -ForegroundColor White
Write-Host "Delegated     : $delegatedCount" -ForegroundColor White
 
# Build a unified table
$foundRows = $scopedSubnets | ForEach-Object {
    $status = if ($_.Delegation) { "Delegated" }
    elseif ($_.DeviceCount -eq 0) { "Empty" }
    else { "In Use" }
 
    [PSCustomObject]@{
        Status       = $status
        Subscription = $_.Subscription
        VNet         = $_.VNet
        Subnet       = $_.Subnet
        AddressRange = $_.AddressRange
        Devices      = $_.DeviceCount
        Delegation   = $_.Delegation
    }
}
 
$missingRows = $missingSubnets | ForEach-Object {
    [PSCustomObject]@{
        Status       = "Not Found"
        Subscription = "-"
        VNet         = "-"
        Subnet       = $_
        AddressRange = "-"
        Devices      = "-"
        Delegation   = "-"
    }
}
 
$sortedRows = @($foundRows) + @($missingRows) | Sort-Object Status, Subscription, VNet, Subnet
 
Write-Host "`n=== Subnet Report ===" -ForegroundColor Cyan
$sortedRows | Format-Table -AutoSize | Out-Host
 
if ($exportCsv -and $sortedRows.Count -gt 0) {
    $sortedRows | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8
    Write-Host "Exported to: $csvPath" -ForegroundColor Yellow
}
elseif ($exportCsv) {
    Write-Host "Nothing to export — no matching subnets found." -ForegroundColor DarkGray
}