Get-AzVMImagePublisher -Location "SouthAfricaNorth"

Get-AzVMImageOffer -Location "SouthAfricaNorth" -PublisherName "MicrosoftWindowsServer"

Get-AzVMImageSku -Location "SouthAfricaNorth" -PublisherName "MicrosoftWindowsServer" -Offer "windowsserver2022"

Get-AzComputeResourceSku -Location "SouthAfricaNorth"