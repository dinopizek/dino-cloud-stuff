# Define the following parameters.
$SubscriptionName = "Span-CS-DPavlovic-MPN"
$ResourceGroup = "rg-sc-network-dino-01"
$Location = "Sweden Central"
$VnetAddressPrefix = "10.1.0.0/16"
$VirtualApplianceIp = "10.254.0.10"

# Define route tables as name -> subnet range pairs.
$RouteTables = @{
    "rt-frontend"   = "10.1.0.0/24"
    "rt-backend"    = "10.1.1.0/24"
    "rt-data"       = "10.1.2.0/24"
    "rt-management" = "10.1.3.0/24"
    "rt-shared"     = "10.1.4.0/24"
}

# Set the subscription context.
$Subscription = Get-AzSubscription -SubscriptionName $SubscriptionName
Set-AzContext -SubscriptionId $Subscription.Id

# Iterate and create each route table.
foreach ($RouteTableName in $RouteTables.Keys) {
    $SubnetAddressPrefix = $RouteTables[$RouteTableName]

    Write-Host "Creating $RouteTableName for subnet $SubnetAddressPrefix..." -ForegroundColor Cyan

    $routeDefault = New-AzRouteConfig -Name "route-default"      -AddressPrefix "0.0.0.0/0"          -NextHopType "VirtualAppliance" -NextHopIpAddress $VirtualApplianceIp
    $routeIntraSubnet = New-AzRouteConfig -Name "route-intra-subnet" -AddressPrefix $SubnetAddressPrefix -NextHopType "VnetLocal"
    $routeIntraVnet = New-AzRouteConfig -Name "route-intra-vnet"   -AddressPrefix $VnetAddressPrefix   -NextHopType "VirtualAppliance" -NextHopIpAddress $VirtualApplianceIp

    New-AzRouteTable -Name $RouteTableName -ResourceGroupName $ResourceGroup -Location $Location -DisableBgpRoutePropagation -Route $routeDefault, $routeIntraSubnet, $routeIntraVnet
}