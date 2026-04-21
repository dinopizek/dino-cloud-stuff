# Empty arrays to hold all items found across subscriptions.

$allVnets = @()
$allSubnets = @()
$allResourceGroups = @()
$allRecoveryVaults = @()
$allSubscriptions = @()

# Define expected items based on naming conventions and known inventory.

$expectedSubscriptions = @(
    "rev-sub-corporate-workload-prod",
    "rev-sub-consumer-workload-test",
    "rev-sub-identity-prod",
    "rev-sub-consumer-workload-prod",
    "rev-sub-supplychain-workload-dev",
    "rev-sub-security-prod",
    "rev-sub-finance-workload-dev"
)

$expectedResourceGroups = @(
    "rg-use2-corp-tools-prod-01",
    "rg-use2-sqlservices-test-01",
    "rg-use2-id-entra-prod-01",
    "rg-use2-kms-prod-01",
    "rg-use2-tecnest-prod-01",
    "rg-use2-web-prod-01",
    "rg-use2-knowportal-dev-01",
    "rg-use2-poms-prod-01",
    "rg-use2-tops-prod-01",
    "rg-use2-sec-tools-prod-01",
    "rg-use2-vertex-dev-01",
    "rg-use2-mgmt-network-test-01"
)

$expectedVnets = @(
    "vn-use2-corp-it-prod-01",
    "vn-use2-cons-app-test-01",
    "vn-use2-id-prod-01",
    "vn-use2-corp-app-prod-01",
    "vn-use2-cons-app-prod-01",
    "vn-use2-spc-app-dev-01",
    "vn-use2-sec-prod-01",
    "vn-use2-fin-app-dev-01",
    "vn-use2-migrate-test-01"
)

$expectedSubnets = @(
    "sn-vm-test-01",
    "sn-wts-prod-01",
    "sn-sqlsvc-test-01",
    "sn-entc-prod-01",
    "sn-kms-prod-01",
    "sn-app-prod-01",
    "sn-web-prod-01",
    "sn-knowportal-dev-01",
    "sn-poms-prod-01",
    "sn-tops-prod-01",
    "sn-tools-prod-01",
    "sn-vertex-dev-01"
)

$expectedRecoveryVaults = @(
    "rsv-use2-corp-it-backup-prod-01",
    "rsv-use2-cons-app-backup-test-01",
    "rsv-use2-id-backup-prod-01",
    "rsv-use2-corp-app-backup-prod-01",
    "rsv-use2-cons-app-backup-prod-01",
    "rsv-use2-spc-app-backup-dev-01",
    "rsv-use2-sec-backup-prod-01",
    "rsv-use2-fin-app-backup-test-01"
)

# Disable context autosave to prevent cross-runspace contamination
Disable-AzContextAutosave -Scope Process | Out-Null

$subscriptions = Get-AzSubscription | Where-Object { $_.State -eq "Enabled" }
Write-Host "`nFound $($subscriptions.Count) subscriptions. Querying in parallel..." -ForegroundColor Yellow

$results = $subscriptions | ForEach-Object -ThrottleLimit 10 -Parallel {
    $current_sub = $_
    $ctx = Set-AzContext -SubscriptionId $current_sub.Id -Scope Process

    Write-Host "[$($current_sub.Name)] fetching..." -ForegroundColor Cyan

    $vnets          = Get-AzVirtualNetwork        -DefaultProfile $ctx
    $resourceGroups = Get-AzResourceGroup         -DefaultProfile $ctx
    $recoveryVaults = Get-AzRecoveryServicesVault -DefaultProfile $ctx

    [PSCustomObject]@{
        Subscription   = $current_sub.Name
        VNets          = @($vnets.Name)
        Subnets        = @($vnets.Subnets.Name)
        ResourceGroups = @($resourceGroups.ResourceGroupName)
        RecoveryVaults = @($recoveryVaults.Name)
    }
}

$allSubscriptions  = $results.Subscription
$allVnets          = $results.VNets
$allSubnets        = $results.Subnets
$allResourceGroups = $results.ResourceGroups
$allRecoveryVaults = $results.RecoveryVaults

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