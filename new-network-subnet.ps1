# Define the following parameters.
$azureResourceGroup = "rg-gewe-dino-vm-lab-01"
$azureLocation = "Germany West Central"
$azureSubnetName = "FrontEnd"
$azureSubnetAddressPrefix = "10.1.0.0/24"
$azureVnetName = "TestVNet1"
$azureVnetAddressPrefix = "10.1.0.0/16"

# Create the new Vnet and subnet.
$frontendSubnet = New-AzVirtualNetworkSubnetConfig -Name $azureSubnetName -AddressPrefix $azureSubnetAddressPrefix 
$virtualNetwork = New-AzVirtualNetwork -Name $azureVnetName -ResourceGroupName $azureResourceGroup -Location $azureLocation -AddressPrefix $azureVnetAddressPrefix -Subnet $frontendSubnet $virtualNetwork | Set-AzVirtualNetwork