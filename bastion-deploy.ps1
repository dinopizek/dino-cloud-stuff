# Define the following parameters.
$azureResourceGroup = "rg-gewe-dino-vm-lab-01"
$azureLocation = "Germany West Central"
$azureVnetName = "vn-gewe-dino-lab-02"
$azurePublicIPName = "pip-gewe-dino-lab-01"
$azureBastionName = "bastion-gewe-dino-lab-01"
$azureBastionSku = "Standard"

# Create the new Vnet and subnet.
$vnet = Get-AzVirtualNetwork -Name $azureVnetName -ResourceGroupName $azureResourceGroup
Add-AzVirtualNetworkSubnetConfig -Name "AzureBastionSubnet" -VirtualNetwork $vnet -AddressPrefix "10.1.1.0/26" | Set-AzVirtualNetwork

# Create the public IP address for the Bastion.
$publicip = New-AzPublicIpAddress -ResourceGroupName $azureResourceGroup -name $azurePublicIPName -location $azureLocation -AllocationMethod Static -Sku Standard

# Create the Bastion.
New-AzBastion -ResourceGroupName $azureResourceGroup -Name $azureBastionName -PublicIpAddressId $publicip.Id -VirtualNetworkId $vnet.Id -Sku $azureBastionSku