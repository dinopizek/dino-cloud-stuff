# Define the following parameters.
$ResourceGroup = "rg-gewe-dino-lab-01"
$Location = "Germany West Central"
$RouteTableName = "RouteTable01"
$VnetAddressPrefix = "10.1.0.0/16"
$SubnetAddressPrefix = "10.1.0.0/24"
$VirtualApplianceIp = "10.254.0.10"

# Define the three routes.
$routeDefault = New-AzRouteConfig -Name "route-default" -AddressPrefix "0.0.0.0/0" -NextHopType "VirtualAppliance" -NextHopIpAddress $VirtualApplianceIp
$routeIntraSubnet = New-AzRouteConfig -Name "route-intra-subnet" -AddressPrefix $SubnetAddressPrefix -NextHopType "VnetLocal"
$routeIntraVnet = New-AzRouteConfig -Name "route-intra-vnet" -AddressPrefix $VnetAddressPrefix -NextHopType "VirtualAppliance" -NextHopIpAddress $VirtualApplianceIp

# Create the route table with all three routes.
New-AzRouteTable -Name $RouteTableName -ResourceGroupName $ResourceGroup -Location $Location -Route $routeDefault, $routeIntraSubnet, $routeIntraVnet