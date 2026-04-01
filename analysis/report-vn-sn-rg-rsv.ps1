$allVnets = @()
$allSubnets = @()
$allResourceGroups = @()
$allRecoveryVaults = @()
$allSubscriptions = @()

# 

$expectedSubscriptions = @(
    "rev-sub-supplychain-workload-test",
    "rev-sub-consumer-workload-test",
    "rev-sub-corporate-workload-dev",
    "rev-sub-corporate-workload-test",
    "rev-sub-supplychain-workload-dev",
    "rev-sub-supplychain-workload-prod",
    "rev-sub-consumer-workload-dev"
)

$expectedResourceGroups = @(
    "rg-use2-globalsales-test-01",
    "rg-use2-edi-test-01",
    "rg-use2-edi-dev-01",
    "rg-use2-knowportal-dev-01",
    "rg-use2-knowportal-prod-01",
    "rg-use2-9ci-dev-01",
    "rg-use2-interspec-dev-01",
    "rg-use2-loftware-test-01",
    "rg-use2-sqlservices-dev-01",
    "rg-use2-sqlservices-test-01",
    "rg-use2-voicepick-test-01",
    "rg-use2-voicepick-dev-01",
    "rg-use2-mdf-dev-01",
    "rg-use2-webtms-test-01"
)

$expectedVnets = @(
    "vn-use2-spc-app-test-01",
    "vn-use2-cons-app-test-01",
    "vn-use2-corp-app-dev-01",
    "vn-use2-corp-app-test-01",
    "vn-use2-spc-app-dev-01",
    "vn-use2-spc-app-prod-01",
    "vn-use2-cons-app-dev-01",
    "vn-use2-migrate-test-01"
)

$expectedSubnets = @(
    "sn-edi-test-01",
    "sn-globalsales-test-01",
    "sn-edi-dev-01",
    "sn-knowportal-dev-01",
    "sn-knowportal-prod-01",
    "sn-app-test-01",
    "sn-interspec-dev-01",
    "sn-loft-test-01",
    "sn-sqlsvc-dev-01",
    "sn-sqlsvc-test-01",
    "sn-voicepick-test-01",
    "sn-voicepick-dev-01",
    "sn-mdf-dev-01",
    "sn-webtms-test-01",
    "sn-vm-test-01"
)

$expectedRecoveryVaults = @(
    "rsv-use2-spc-app-backup-test-01",
    "rsv-use2-cons-app-backup-test-01",
    "rsv-use2-corp-app-backup-dev-01",
    "rsv-use2-corp-app-backup-test-01",
    "rsv-use2-spc-app-backup-dev-01",
    "rsv-use2-spc-app-backup-prod-01",
    "rsv-use2-cons-app-backup-dev-01"
)

$subscriptions = Get-AzSubscription | Where-Object { $_.State -eq "Enabled" }

Write-Host "Found $($subscriptions.Count) subscriptions." -ForegroundColor Yellow

$counter = 1

foreach ($sub in $subscriptions) {
    Set-AzContext -SubscriptionId $sub.Id | Out-Null

    Write-Host "[$counter/$($subscriptions.Count)] $($sub.Name)" -ForegroundColor Green

    $vnets = Get-AzVirtualNetwork
    $resourceGroups = Get-AzResourceGroup
    $recoveryVaults = Get-AzRecoveryServicesVault

    $allVnets += $vnets.Name
    $allSubnets += $vnets.Subnets.Name
    $allResourceGroups += $resourceGroups.ResourceGroupName
    $allRecoveryVaults += $recoveryVaults.Name
    $allSubscriptions += $sub.Name

    $counter++
}

# List all items

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

# List missing items

Write-Host "`n=== Missing Subscriptions ===" -ForegroundColor Cyan
$expectedSubscriptions | Where-Object { $_ -notin $allSubscriptions } | ForEach-Object { Write-Host "MISSING: $_" -ForegroundColor Red }

Write-Host "`n=== Missing Resource Groups ===" -ForegroundColor Cyan
$expectedResourceGroups | Where-Object { $_ -notin $allResourceGroups } | ForEach-Object { Write-Host "MISSING: $_" -ForegroundColor Red }

Write-Host "`n=== Missing Recovery Vaults ===" -ForegroundColor Cyan
$expectedRecoveryVaults | Where-Object { $_ -notin $allRecoveryVaults } | ForEach-Object { Write-Host "MISSING: $_" -ForegroundColor Red }

Write-Host "`n=== Missing VNets ===" -ForegroundColor Cyan
$expectedVnets | Where-Object { $_ -notin $allVnets } | ForEach-Object { Write-Host "MISSING: $_" -ForegroundColor Red }

Write-Host "`n=== Missing Subnets ===" -ForegroundColor Cyan
$expectedSubnets | Where-Object { $_ -notin $allSubnets } | ForEach-Object { Write-Host "MISSING: $_" -ForegroundColor Red }