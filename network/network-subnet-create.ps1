# Define the following parameters.
$ResourceGroup = "rg-gewe-dino-lab-01"
$Location = "Germany West Central"

$VnetName = "TestVNet1"
$VnetAddressPrefix = "10.1.0.0/16"

$SubnetName = "FrontEnd"
$SubnetAddressPrefix = "10.1.0.0/24"

# Create a new Vnet and subnet.
$frontendSubnet = New-AzVirtualNetworkSubnetConfig -Name $SubnetName -AddressPrefix $SubnetAddressPrefix 
$virtualNetwork = New-AzVirtualNetwork -Name $VnetName -ResourceGroupName $ResourceGroup -Location $Location -AddressPrefix $VnetAddressPrefix -Subnet $frontendSubnet $virtualNetwork | Set-AzVirtualNetwork