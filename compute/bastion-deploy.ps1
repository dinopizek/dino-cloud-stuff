# Define the following parameters.
$ResourceGroup = "rg-gewe-dino-lab-01"
$Location = "Germany West Central"

$BastionName = "bastion-gewe-dino-lab-01"
$BastionSku = "Standard"

$PublicIPName = "pip-gewe-dino-lab-01"
$VnetName = "vn-gewe-dino-lab-02"
$AddressPrefix = "10.1.1.0/26"

# Create a new Vnet and Bastion subnet.
$vnet = Get-AzVirtualNetwork -Name $VnetName -ResourceGroupName $ResourceGroup
Add-AzVirtualNetworkSubnetConfig -Name "BastionSubnet" -VirtualNetwork $vnet -AddressPrefix $AddressPrefix | Set-AzVirtualNetwork

# Create a public IP address for the Bastion.
$publicip = New-AzPublicIpAddress -ResourceGroupName $ResourceGroup -name $PublicIPName -location $Location -AllocationMethod Static -Sku Standard

# Create a Bastion.
New-AzBastion -ResourceGroupName $ResourceGroup -Name $BastionName -PublicIpAddressId $publicip.Id -VirtualNetworkId $vnet.Id -Sku $azureBastionSku