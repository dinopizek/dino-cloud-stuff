# Define the following parameters.
$ResourceGroup = "rg-gewe-dino-lab-01"
$Location = "Germany West Central"

$VMName = "vm-gewe-dino-lab"
$VmNewDiskName = $VMName + "-data-disk-01"

$DiskSizeGB = 128
$DiskSku = "Standard_LRS" # Standard_LRS = HDD, StandardSSD_LRS = Standard SSD, Premium_LRS = SSD, UltraSSD_LRS = Ultra SSD
$DsikLun = 2

# Create a new disk.
$newDiskConfig = New-AzDiskConfig -Location $Location -CreateOption Empty -DiskSizeGB $DiskSizeGB -SkuName $DiskSku
$newDisk = New-AzDisk -ResourceGroupName $ResourceGroup -DiskName $VmNewDiskName -Disk $newDiskConfig

# Attach the new disk to the existing VM.
$targetVM = Get-AzVM -Name $VMName -ResourceGroupName $ResourceGroup
Add-AzVMDataDisk -VM $targetVM -Name $VmNewDiskName -CreateOption Attach -ManagedDiskId $newDisk.Id -Lun $DsikLun

# Update the VM with the new disk configuration.
Update-AzVM -ResourceGroupName $ResourceGroup -VM $targetVM