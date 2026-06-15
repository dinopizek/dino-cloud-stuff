# Check all available publishers
Get-AzVMImagePublisher -Location "eastus2"

# Check all available offers for a specific publisher
Get-AzVMImageOffer -Location "eastus2" -PublisherName "MicrosoftWindowsServer"

# Check all available SKUs for a specific offer and publisher
Get-AzVMImageSku -Location "eastus2" -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer"

# Check VM SKU availabilityfor a specific location
Get-AzComputeResourceSku -Location "eastus2"

Get-AzComputeResourceSku -Location "eastus2" | Where-Object { $_.ResourceType -eq "virtualMachines" -and $_.Name -like "*D4als*" }