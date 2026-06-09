# Check all available publishers
Get-AzVMImagePublisher -Location "SouthAfricaNorth"

# Check all available offers for a specific publisher
Get-AzVMImageOffer -Location "SouthAfricaNorth" -PublisherName "MicrosoftWindowsServer"

# Check all available SKUs for a specific offer and publisher
Get-AzVMImageSku -Location "SouthAfricaNorth" -PublisherName "MicrosoftWindowsServer" -Offer "windowsserver2022"

# Check VM SKU availabilityfor a specific location
Get-AzComputeResourceSku -Location "SouthAfricaNorth"