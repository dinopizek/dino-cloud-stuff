# Empty arrays to hold all items found across subscriptions.

$allVnets = @()
$allSubnets = @()
$allResourceGroups = @()
$allRecoveryVaults = @()
$allSubscriptions = @()

# Define expected items based on naming conventions and known inventory.

$expectedSubscriptions = @(
    "rev-sub-identity-prod",
    "rev-sub-corporate-workload-dev",
    "rev-sub-corporate-workload-prod"
)

$expectedResourceGroups = @(
    "rg-use2-id-tools-prod-01",
    "rg-use2-kms-prod-01",
    "rg-use2-corp-print-prod-01"
)

$expectedVnets = @(
    "vn-use2-id-prod-01",
    "vn-use2-corp-app-dev-01",
    "vn-use2-corp-it-prod-01"
)

$expectedSubnets = @(
    "sn-tools-prod-01",
    "sn-app-dev-01",
    "sn-kms-prod-01"
)

$expectedRecoveryVaults = @(
    "rsv-use2-id-backup-prod-01",
    "rsv-use2-corp-app-backup-dev-01",
    "rsv-use2-corp-it-backup-prod-01",
    "rsv-use2-corp-app-backup-test-01"
)

# Get all enabled subscriptions and loop through each to gather resources.

$subscriptions = Get-AzSubscription | Where-Object { $_.State -eq "Enabled" }

Write-Host "`nFound $($subscriptions.Count) subscriptions." -ForegroundColor Yellow

$counter = 1

foreach ($sub in $subscriptions) {
    Set-AzContext -SubscriptionId $sub.Id | Out-Null

    Write-Host "`n[$counter/$($subscriptions.Count)] $($sub.Name)" -ForegroundColor Cyan

    Write-Host "    Fetching virtual networks and subnets..." -ForegroundColor Green
    $vnets = Get-AzVirtualNetwork
    Write-Host "    Fetching resource groups..." -ForegroundColor Green
    $resourceGroups = Get-AzResourceGroup
    Write-Host "    Fetching recovery vaults..." -ForegroundColor Green
    $recoveryVaults = Get-AzRecoveryServicesVault

    Write-Host "    Found $($vnets.Count) virtual networks, $($resourceGroups.Count) resource groups, and $($recoveryVaults.Count) recovery vaults." -ForegroundColor Green
    $allVnets += $vnets.Name
    $allSubnets += $vnets.Subnets.Name
    $allResourceGroups += $resourceGroups.ResourceGroupName
    $allRecoveryVaults += $recoveryVaults.Name
    $allSubscriptions += $sub.Name

    $counter++
}

# List all items.

# Write-Host "`n=== Subscriptions ===" -ForegroundColor Cyan
# $allSubscriptions

# Write-Host "`n=== Resource Groups ===" -ForegroundColor Cyan
# $allResourceGroups

# Write-Host "`n=== VNets ===" -ForegroundColor Cyan
# $allVnets

# Write-Host "`n=== Subnets ===" -ForegroundColor Cyan
# $allSubnets

# Write-Host "`n=== Recovery Vaults ===" -ForegroundColor Cyan
# $allRecoveryVaults

# List missing and present items only.

Write-Host "`n=== Subscriptions ===" -ForegroundColor Cyan
$expectedSubscriptions | Where-Object { $_ -notin $allSubscriptions } | ForEach-Object { Write-Host "[Missing] $_" -ForegroundColor Red }
#$expectedSubscriptions | Where-Object { $_ -in $allSubscriptions } | ForEach-Object { Write-Host "[OK] $_" -ForegroundColor Green }

Write-Host "`n=== Resource Groups ===" -ForegroundColor Cyan
$expectedResourceGroups | Where-Object { $_ -notin $allResourceGroups } | ForEach-Object { Write-Host "[Missing] $_" -ForegroundColor Red }
#$expectedResourceGroups | Where-Object { $_ -in $allResourceGroups } | ForEach-Object { Write-Host "[OK] $_" -ForegroundColor Green }

Write-Host "`n=== Recovery Vaults ===" -ForegroundColor Cyan
$expectedRecoveryVaults | Where-Object { $_ -notin $allRecoveryVaults } | ForEach-Object { Write-Host "[Missing] $_" -ForegroundColor Red }
#$expectedRecoveryVaults | Where-Object { $_ -in $allRecoveryVaults } | ForEach-Object { Write-Host "[OK] $_" -ForegroundColor Green }

Write-Host "`n=== VNets ===" -ForegroundColor Cyan
$expectedVnets | Where-Object { $_ -notin $allVnets } | ForEach-Object { Write-Host "[Missing] $_" -ForegroundColor Red }
#$expectedVnets | Where-Object { $_ -in $allVnets } | ForEach-Object { Write-Host "[OK] $_" -ForegroundColor Green }

Write-Host "`n=== Subnets ===" -ForegroundColor Cyan
$expectedSubnets | Where-Object { $_ -notin $allSubnets } | ForEach-Object { Write-Host "[Missing] $_" -ForegroundColor Red }
#$expectedSubnets | Where-Object { $_ -in $allSubnets } | ForEach-Object { Write-Host "[OK] $_" -ForegroundColor Green }