param routeTableName string = 'rt-use2-dr-cons-app-prod-01'
param virtualApplianceIp string = '100.100.100.100'
param vnetRange string = '10.254.74.0/23'
param subnetRange string = '10.254.74.0/28'

resource routeTable 'Microsoft.Network/routeTables@2025-07-01' = {
  name: routeTableName
  location: 'eastus2'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {
    disableBgpRoutePropagation: true
    routes: [
      {
        name: 'route-default'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: virtualApplianceIp
        }
      }
      {
        name: 'route-intra-subnet'
        properties: {
          addressPrefix: subnetRange
          nextHopType: 'VnetLocal'
        }
      }
      {
        name: 'route-intra-vnet'
        properties: {
          addressPrefix: vnetRange
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: virtualApplianceIp
        }
      }
    ]
  }
}
