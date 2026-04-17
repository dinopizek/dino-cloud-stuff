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
    "rev-sub-corporate-workload-prod",
    "rev-sub-corporate-workload-test",
    "rev-sub-consumer-workload-test",
    "rev-sub-security-prod",
    "rev-sub-supplychain-workload-test",
    "rev-sub-supplychain-workload-dev",
    "rev-sub-supplychain-workload-prod",
    "rev-sub-consumer-workload-dev",
    "rev-sub-researchdev-workload-prod",
    "rev-sub-finance-workload-prod",
    "rev-sub-consumer-workload-prod",
    "rev-sub-finance-workload-dev"
)

$expectedResourceGroups = @(
    "rg-use2-id-tools-prod-01",
    "rg-use2-kms-prod-01",
    "rg-use2-corp-print-prod-01",
    "rg-use2-edi-dev-01",
    "rg-use2-edi-test-01",
    "rg-use2-corp-tools-prod-01",
    "rg-use2-trailertrack-test-01",
    "rg-use2-sqlservices-test-01",
    "rg-use2-mdf-dev-01",
    "rg-use2-corp-tools-test-01",
    "rg-use2-sec-rapid7-prod-01",
    "rg-use2-globalsales-test-01",
    "rg-use2-knowportal-dev-01",
    "rg-use2-knowportal-prod-01",
    "rg-use2-9ci-dev-01",
    "rg-use2-interspec-dev-01",
    "rg-use2-loftware-test-01",
    "rg-use2-sqlservices-dev-01",
    "rg-use2-voicepick-test-01",
    "rg-use2-voicepick-dev-01",
    "rg-use2-webtms-test-01",
    "rg-use2-oracle-dev-01",
    "rg-use2-precision-dev-01",
    "rg-use2-chromeleon-prod-01",
    "rg-use2-web-prod-01",
    "rg-use2-microstrategy-dev-01",
    "rg-use2-microstrategy-test-01",
    "rg-use2-sec-tools-prod-01",
    "rg-use2-registration-prod-01",
    "rg-use2-sap-dev-01",
    "rg-use2-sec-cyberark-prod-01",
    "rg-use2-sqlsvc-prod-01",
    "rg-use2-kpmg-prod-01",
    "rg-use2-poms-prod-01",
    "rg-use2-sqlservices-prod-01",
    "rg-use2-tops-prod-01",
    "rg-use2-trailertrack-prod-01",
    "rg-use2-voicepick-prod-01",
    "rg-use2-files-prod-01",
    "rg-use2-id-entra-prod-01",
    "rg-use2-tecnest-prod-01",
    "rg-use2-vertex-dev-01",
    "rg-use2-oracle-prod-01",
    "rg-use2-sap-prod-01",
    "rg-use2-globalsales-prod-01",
    "rg-use2-mdf-prod-01",
    "rg-use2-mdm-prod-01",
    "rg-use2-microstrategy-prod-01",
    "rg-use2-toad-prod-01",
    "rg-use2-vertex-prod-01",
    "rg-use2-edi-prod-01",
    "rg-use2-interspec-prod-01",
    "rg-use2-loftware-prod-01",
    "rg-use2-precision-prod-01",
    "rg-use2-9ci-prod-01",
    "rg-use2-gendb-prod-01",
    "rg-use2-sage-prod-01",
    "rg-use2-sap-mobile-prod-01",
    "rg-use2-webtms-prod-01",
    "rg-use2-id-radius-prod-01",
    "rg-use2-sitecore-prod-01",
    "rg-use2-exch-prod-01",
    "rg-use2-mgmt-network-test-01"
)

$expectedVnets = @(
    "vn-use2-id-prod-01",
    "vn-use2-corp-app-dev-01",
    "vn-use2-corp-it-prod-01",
    "vn-use2-corp-app-test-01",
    "vn-use2-cons-app-test-01",
    "vn-use2-corp-it-test-01",
    "vn-use2-sec-prod-01",
    "vn-use2-spc-app-test-01",
    "vn-use2-spc-app-dev-01",
    "vn-use2-spc-app-prod-01",
    "vn-use2-cons-app-dev-01",
    "vn-use2-rnd-app-prod-01",
    "vn-use2-corp-app-prod-01",
    "vn-use2-fin-app-prod-01",
    "vn-use2-cons-app-prod-01",
    "vn-use2-fin-app-dev-01",
    "vn-use2-migrate-test-01"
)

$expectedSubnets = @(
    "sn-tools-prod-01",
    "sn-app-dev-01",
    "sn-kms-prod-01",
    "sn-print-prod-01",
    "sn-edi-dev-01",
    "sn-edi-test-01",
    "sn-app-test-01",
    "sn-sqlsvc-test-01",
    "sn-tools-test-01",
    "sn-wts-prod-01",
    "sn-rapid7-prod-01",
    "sn-globalsales-test-01",
    "sn-knowportal-dev-01",
    "sn-knowportal-prod-01",
    "sn-interspec-dev-01",
    "sn-loft-test-01",
    "sn-sqlsvc-dev-01",
    "sn-voicepick-test-01",
    "sn-voicepick-dev-01",
    "sn-mdf-dev-01",
    "sn-webtms-test-01",
    "sn-oracle-dev-01",
    "sn-precision-dev-01",
    "sn-chrom-prod-01",
    "sn-floorweb-prod-01",
    "sn-micrstg-dev-01",
    "sn-microstg-test-01",
    "sn-app-prod-01",
    "sn-sap-dev-01",
    "sn-cyberark-prod-01",
    "sn-sqlsvc-prod-01",
    "sn-kpmg-prod-01",
    "sn-poms-prod-01",
    "sn-tops-prod-01",
    "sn-trailertrack-prod-01",
    "sn-ve-prod-01",
    "sn-files-prod-01",
    "sn-entc-prod-01",
    "sn-web-prod-01",
    "sn-vertex-dev-01",
    "sn-jdv-prod-01",
    "sn-mdf-prod-01",
    "sn-mdm-prod-01",
    "sn-micrstg-prod-01",
    "sn-toad-prod-01",
    "sn-vertex-prod-01",
    "sn-edi-prod-01",
    "sn-globalsales-prod-01",
    "sn-interspec-prod-01",
    "sn-loft-prod-01",
    "sn-precision-prod-01",
    "sn-9ci-prod-01",
    "sn-sage-prod-01",
    "sn-voiteq-prod-01",
    "sn-sap-prod-01",
    "sn-sapmobile-prod-01",
    "sn-webtms-prod-01",
    "sn-radius-prod-01",
    "sn-sitecore-prod-01",
    "sn-exch-prod-01",
    "sn-vm-test-01"
)

$expectedRecoveryVaults = @(
    "rsv-use2-id-backup-prod-01",
    "rsv-use2-corp-app-backup-dev-01",
    "rsv-use2-corp-it-backup-prod-01",
    "rsv-use2-corp-app-backup-test-01",
    "rsv-use2-cons-app-backup-test-01",
    "rsv-use2-corp-it-backup-test-01",
    "rsv-use2-sec-backup-prod-01",
    "rsv-use2-spc-app-backup-test-01",
    "rsv-use2-spc-app-backup-dev-01",
    "rsv-use2-spc-app-backup-prod-01",
    "rsv-use2-cons-app backup-dev-01",
    "rsv-use2-rnd-app-backup-prod-01",
    "rsv-use2-corp-app-backup-prod-01",
    "rsv-use2-fin-app-backup-prod-01",
    "rsv-use2-cons-app backup-test-01",
    "rsv-use2-cons-app-backup-prod-01",
    "rsv-use2-fin-app-backup-test-01",
    "rsv-use2-cons-app backup-prod-01"
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
$expectedSubscriptions | Where-Object { $_ -in $allSubscriptions } | ForEach-Object { Write-Host "[OK] $_" -ForegroundColor Green }

Write-Host "`n=== Resource Groups ===" -ForegroundColor Cyan
$expectedResourceGroups | Where-Object { $_ -notin $allResourceGroups } | ForEach-Object { Write-Host "[Missing] $_" -ForegroundColor Red }
$expectedResourceGroups | Where-Object { $_ -in $allResourceGroups } | ForEach-Object { Write-Host "[OK] $_" -ForegroundColor Green }

Write-Host "`n=== Recovery Vaults ===" -ForegroundColor Cyan
$expectedRecoveryVaults | Where-Object { $_ -notin $allRecoveryVaults } | ForEach-Object { Write-Host "[Missing] $_" -ForegroundColor Red }
$expectedRecoveryVaults | Where-Object { $_ -in $allRecoveryVaults } | ForEach-Object { Write-Host "[OK] $_" -ForegroundColor Green }

Write-Host "`n=== VNets ===" -ForegroundColor Cyan
$expectedVnets | Where-Object { $_ -notin $allVnets } | ForEach-Object { Write-Host "[Missing] $_" -ForegroundColor Red }
$expectedVnets | Where-Object { $_ -in $allVnets } | ForEach-Object { Write-Host "[OK] $_" -ForegroundColor Green }

Write-Host "`n=== Subnets ===" -ForegroundColor Cyan
$expectedSubnets | Where-Object { $_ -notin $allSubnets } | ForEach-Object { Write-Host "[Missing] $_" -ForegroundColor Red }
$expectedSubnets | Where-Object { $_ -in $allSubnets } | ForEach-Object { Write-Host "[OK] $_" -ForegroundColor Green }