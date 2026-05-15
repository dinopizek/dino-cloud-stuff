# Empty hashtables to hold counts for double-checking duplicates.
$vmCounts = @{}

# Define expected items based on naming conventions and known inventory.
$expectedSubscriptions = @(
    "rev-sub-corporate-workload-prod",
    "rev-sub-consumer-workload-test",
    "rev-sub-identity-prod"
)

$expectedVms = @(
    "vm-use2-corp-dc-prod-01",
    "vm-use2-corp-wts-prod-01",
    "vm-use2-id-radius-prod-01"
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
 
# Emit one VM marker per VM + one row per VM-NIC-IPConfig combo; pipeline flattens into a single array.
$allRows = $subscriptions | ForEach-Object -ThrottleLimit 10 -Parallel {
    $currentSubscription = $_
    $context = Set-AzContext -SubscriptionId $currentSubscription.Id -Scope Process
 
    Write-Host "[$($currentSubscription.Name)] fetching..." -ForegroundColor Cyan
 
    $vms = Get-AzVM             -DefaultProfile $context
    $nics = Get-AzNetworkInterface -DefaultProfile $context
 
    # Index NICs by their resource ID for fast lookup per VM.
    $nicById = @{}
    foreach ($n in $nics) { $nicById[$n.Id] = $n }
 
    foreach ($vm in $vms) {
        # VM marker: confirms this VM exists regardless of NIC state.
        [PSCustomObject]@{
            Type         = "VM"
            Subscription = $currentSubscription.Name
            VM           = $vm.Name
            VMRg         = $vm.ResourceGroupName
        }
 
        foreach ($nicRef in $vm.NetworkProfile.NetworkInterfaces) {
            $nic = $nicById[$nicRef.Id]
            if (-not $nic) { continue }
 
            foreach ($ipConfig in $nic.IpConfigurations) {
                # Subnet.Id format:
                # /subscriptions/<subId>/resourceGroups/<rg>/providers/Microsoft.Network/virtualNetworks/<vnet>/subnets/<subnet>
                $subnetParts = $ipConfig.Subnet.Id -split "/"
                $subnetName = $subnetParts[-1]
                $vnetName = $subnetParts[-3]
 
                [PSCustomObject]@{
                    Type             = "Nic"
                    Subscription     = $currentSubscription.Name
                    VM               = $vm.Name
                    VMRg             = $vm.ResourceGroupName
                    Nic              = $nic.Name
                    PrivateIp        = $ipConfig.PrivateIpAddress
                    AllocationMethod = $ipConfig.PrivateIpAllocationMethod
                    VNet             = $vnetName
                    Subnet           = $subnetName
                }
            }
        }
    }
}
 
# Split flat array into VM markers and NIC rows.
$foundVms = ($allRows | Where-Object Type -eq "VM").VM
$nicRows = $allRows | Where-Object Type -eq "Nic"
 
# List report.
Write-Host "`nGenerated on: $(Get-Date)" -ForegroundColor Yellow

$foundVms | Group-Object | ForEach-Object { $vmCounts[$_.Name] = $_.Count }
 
# Apply VM scoping: empty list means "include all".
$scopedRows = $nicRows | Where-Object {
    $expectedVms.Count -eq 0 -or $_.VM -in $expectedVms
} | Sort-Object Subscription, VM, Nic
 
Write-Host "`n=== VM NIC Allocation ===" -ForegroundColor Cyan
foreach ($r in $scopedRows) {
    $allocColor = switch ($r.AllocationMethod) {
        "Static" { "Green" }
        "Dynamic" { "Yellow" }
        default { "Magenta" }
    }
    Write-Host "[$($r.AllocationMethod)] $($r.VM) -> $($r.Nic) | $($r.VNet)/$($r.Subnet)" -ForegroundColor $allocColor
}
 
# Flag VMs in scope that have no NIC rows at all (exists but no usable NIC binding).
$vmsWithNics = $scopedRows | Select-Object -ExpandProperty VM -Unique
$scopedVms = if ($expectedVms.Count -gt 0) { $expectedVms } else { $foundVms | Sort-Object -Unique }
$nicLessVms = $scopedVms | Where-Object { $_ -in $foundVms -and $_ -notin $vmsWithNics }
if ($nicLessVms) {
    Write-Host "`n=== VMs without NICs ===" -ForegroundColor Cyan
    $nicLessVms | ForEach-Object { Write-Host "$_" -ForegroundColor Magenta }
}

$expectedVms | Where-Object { $_ -notin $foundVms } | ForEach-Object { Write-Host "[Missing] $_" -ForegroundColor Red }
$expectedVms | Where-Object { $vmCounts[$_] -gt 1 } | ForEach-Object { Write-Host "[Double Check] $_ (found $($vmCounts[$_]) times)" -ForegroundColor Magenta }