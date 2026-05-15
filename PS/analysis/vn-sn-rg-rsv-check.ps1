# Empty arrays to hold all items found across subscriptions.
$allVnets = @()
$allSubnets = @()
$allResourceGroups = @()
$allRecoveryVaults = @()
$allSubscriptions = @()

# Empty hashtables to hold counts for double-checking duplicates.
$rgCounts = @{};
$rsvCounts = @{}
$vnetCounts = @{};
$subnetCounts = @{}

# Define expected items based on naming conventions and known inventory.
$expectedSubscriptions = @(
    "rev-sub-corporate-workload-prod",
    "rev-sub-consumer-workload-test",
    "rev-sub-identity-prod"
)

$expectedResourceGroups = @(
    "rg-use2-corp-tools-prod-01",
    "rg-use2-sqlservices-test-01",
    "rg-use2-id-entra-prod-01"
)

$expectedVnets = @(
    "vn-use2-corp-it-prod-01",
    "vn-use2-cons-app-test-01",
    "vn-use2-id-prod-01"
)

$expectedSubnets = @(
    "sn-vm-test-01",
    "sn-wts-prod-01",
    "sn-sqlsvc-test-01"
)

$expectedRecoveryVaults = @(
    "rsv-use2-corp-it-backup-prod-01",
    "rsv-use2-cons-app-backup-test-01",
    "rsv-use2-id-backup-prod-01"
)

# Disable context autosave to prevent cross-runspace contamination
Disable-AzContextAutosave -Scope Process | Out-Null

$subscriptions = Get-AzSubscription | Where-Object { $_.State -eq "Enabled" -and $_.Name -like "rev-sub*" }
Write-Host "`nFound $($subscriptions.Count) subscriptions. Querying in parallel..." -ForegroundColor Yellow
 
# Emit one row per resource tagged by Type; pipeline flattens into a single array.
$allRows = $subscriptions | ForEach-Object -ThrottleLimit 10 -Parallel {
    $currentSubscription = $_
    $context = Set-AzContext -SubscriptionId $currentSubscription.Id -Scope Process
 
    Write-Host "[$($currentSubscription.Name)] fetching..." -ForegroundColor Cyan
 
    $vnets = Get-AzVirtualNetwork        -DefaultProfile $context
    $resourceGroups = Get-AzResourceGroup         -DefaultProfile $context
    $recoveryVaults = Get-AzRecoveryServicesVault -DefaultProfile $context
 
    [PSCustomObject]@{ Type = "Subscription"; Subscription = $currentSubscription.Name; Name = $currentSubscription.Name }
 
    foreach ($rg in $resourceGroups) {
        [PSCustomObject]@{ Type = "ResourceGroup"; Subscription = $currentSubscription.Name; Name = $rg.ResourceGroupName }
    }
    foreach ($rsv in $recoveryVaults) {
        [PSCustomObject]@{ Type = "RecoveryVault"; Subscription = $currentSubscription.Name; Name = $rsv.Name }
    }
    foreach ($vnet in $vnets) {
        [PSCustomObject]@{ Type = "VNet"; Subscription = $currentSubscription.Name; Name = $vnet.Name }
        foreach ($subnet in $vnet.Subnets) {
            [PSCustomObject]@{ Type = "Subnet"; Subscription = $currentSubscription.Name; Name = $subnet.Name; VNet = $vnet.Name }
        }
    }
}
 
# Split flat array into per-type name lists.
$allSubscriptions = ($allRows | Where-Object Type -eq "Subscription").Name
$allResourceGroups = ($allRows | Where-Object Type -eq "ResourceGroup").Name
$allRecoveryVaults = ($allRows | Where-Object Type -eq "RecoveryVault").Name
$allVnets = ($allRows | Where-Object Type -eq "VNet").Name
$allSubnets = ($allRows | Where-Object Type -eq "Subnet").Name
 
# List report.
Write-Host "`nGenerated on: $(Get-Date)" -ForegroundColor Yellow
 
Write-Host "`n=== Subscriptions ===" -ForegroundColor Cyan
$expectedSubscriptions | Where-Object { $_ -notin $allSubscriptions } | ForEach-Object { Write-Host "[Missing] $_" -ForegroundColor Red }
#$expectedSubscriptions | Where-Object { $_ -in $allSubscriptions } | ForEach-Object { Write-Host "[OK] $_" -ForegroundColor Green }
 
Write-Host "`n=== Resource Groups ===" -ForegroundColor Cyan
$allResourceGroups | Group-Object | ForEach-Object { $rgCounts[$_.Name] = $_.Count }
$expectedResourceGroups | Where-Object { $_ -notin $allResourceGroups } | ForEach-Object { Write-Host "[Missing] $_" -ForegroundColor Red }
$expectedResourceGroups | Where-Object { $rgCounts[$_] -gt 1 } | ForEach-Object { Write-Host "[Double Check] $_ (found $($rgCounts[$_]) times)" -ForegroundColor Magenta }
#$allResourceGroups | Where-Object { $_ -notin $expectedResourceGroups } | Sort-Object -Unique | ForEach-Object { Write-Host "[Extra] $_" -ForegroundColor Yellow }
#$expectedResourceGroups | Where-Object { $_ -in $allResourceGroups } | ForEach-Object { Write-Host "[OK] $_" -ForegroundColor Green }
 
Write-Host "`n=== Recovery Vaults ===" -ForegroundColor Cyan
$allRecoveryVaults | Group-Object | ForEach-Object { $rsvCounts[$_.Name] = $_.Count }
$expectedRecoveryVaults | Where-Object { $_ -notin $allRecoveryVaults } | ForEach-Object { Write-Host "[Missing] $_" -ForegroundColor Red }
$expectedRecoveryVaults | Where-Object { $rsvCounts[$_] -gt 1 } | ForEach-Object { Write-Host "[Double Check] $_ (found $($rsvCounts[$_]) times)" -ForegroundColor Magenta }
#$allRecoveryVaults | Where-Object { $_ -notin $expectedRecoveryVaults } | Sort-Object -Unique | ForEach-Object { Write-Host "[Extra] $_" -ForegroundColor Yellow }
#$expectedRecoveryVaults | Where-Object { $_ -in $allRecoveryVaults } | ForEach-Object { Write-Host "[OK] $_" -ForegroundColor Green }
 
Write-Host "`n=== VNets ===" -ForegroundColor Cyan
$allVnets | Group-Object | ForEach-Object { $vnetCounts[$_.Name] = $_.Count }
$expectedVnets | Where-Object { $_ -notin $allVnets } | ForEach-Object { Write-Host "[Missing] $_" -ForegroundColor Red }
$expectedVnets | Where-Object { $vnetCounts[$_] -gt 1 } | ForEach-Object { Write-Host "[Double Check] $_ (found $($vnetCounts[$_]) times)" -ForegroundColor Magenta }
#$allVnets | Where-Object { $_ -notin $expectedVnets } | Sort-Object -Unique | ForEach-Object { Write-Host "[Extra] $_" -ForegroundColor Yellow }
#$expectedVnets | Where-Object { $_ -in $allVnets } | ForEach-Object { Write-Host "[OK] $_" -ForegroundColor Green }
 
Write-Host "`n=== Subnets ===" -ForegroundColor Cyan
$allSubnets | Group-Object | ForEach-Object { $subnetCounts[$_.Name] = $_.Count }
$expectedSubnets | Where-Object { $_ -notin $allSubnets } | ForEach-Object { Write-Host "[Missing] $_" -ForegroundColor Red }
$expectedSubnets | Where-Object { $subnetCounts[$_] -gt 1 } | ForEach-Object { Write-Host "[Double Check] $_ (found $($subnetCounts[$_]) times)" -ForegroundColor Magenta }
#$allSubnets | Where-Object { $_ -notin $expectedSubnets } | Sort-Object -Unique | ForEach-Object { Write-Host "[Extra] $_" -ForegroundColor Yellow }
#$expectedSubnets | Where-Object { $_ -in $allSubnets } | ForEach-Object { Write-Host "[OK] $_" -ForegroundColor Green }