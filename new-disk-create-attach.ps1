# Define the following parameters.
$azureResourceGroup = "rg-gewe-dino-vm-lab-01"
$azureLocation = "Germany West Central"
$azureVMName = "vm-gewe-dino-lab"
$azureVmNewDiskName = $azureVMName + "-data-disk-01"
$azureDiskSizeGB = 128
$azureDiskSku = "Standard_LRS" # Standard_LRS = HDD, StandardSSD_LRS = Standard SSD, Premium_LRS = SSD, UltraSSD_LRS = Ultra SSD
$azureDsikLun = 2

# Create the new disk.
$newDiskConfig = New-AzDiskConfig -Location $azureLocation -CreateOption Empty -DiskSizeGB $azureDiskSizeGB -SkuName $azureDiskSku
$newDisk = New-AzDisk -ResourceGroupName $azureResourceGroup -DiskName $azureVmNewDiskName -Disk $newDiskConfig

# Attach the new disk to the existing VM.
$targetVM = Get-AzVM -Name $azureVMName -ResourceGroupName $azureResourceGroup
Add-AzVMDataDisk -VM $targetVM -Name $azureVmNewDiskName -CreateOption Attach -ManagedDiskId $newDisk.Id -Lun $azureDsikLun

# Update the VM with the new disk configuration.
Update-AzVM -ResourceGroupName $azureResourceGroup -VM $targetVM