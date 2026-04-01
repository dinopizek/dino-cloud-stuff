# Define the following parameters.
$ResourceGroup = "rg-gewe-dino-lab-01"

$HubVnetName = "vn-gewe-dino-lab-02"
$RemoteVnetId = "/subscriptions/5af5c8c0-baee-4377-86fa-3094bd3f497c/resourceGroups/rg-sdc-nikola-vm-lab-01/providers/Microsoft.Network/virtualNetworks/vn-sdc-nikola-lab-01"
$PeeringName = "hub-to-spoke"

# Get the hub Vnet.
$HubVnet = Get-AzVirtualNetwork -Name $HubVnetName -ResourceGroupName $ResourceGroup

# Create a peering between the hub and spoke Vnet.
Add-AzVirtualNetworkPeering -Name $PeeringName -VirtualNetwork $HubVnet -RemoteVirtualNetworkId $RemoteVnetId