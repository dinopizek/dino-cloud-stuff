param location string = 'swedencentral'
param tags object = {
  criticality: 'high'
  domain: 'itoperations'
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2025-07-01' = {
  name: 'vnet-sdc-mgmt-prod-01'
  location: location
  tags: tags
  properties: {
    privateEndpointVNetPolicies: 'Disabled'
    addressSpace: {
      addressPrefixes: [
        '10.248.4.0/24'
      ]
    }
    subnets: [
      {
        name: 'sn-papan-01'
        properties: {
          defaultOutboundAccess: false
          addressPrefixes: [
            '10.248.4.0/28'
          ]
          networkSecurityGroup: {
            id: nsgPaPan.id
          }
          routeTable: {
            id: rtPaPan.id
          }
        }
      }
    ]
    enableDdosProtection: false
  }
}

resource rtPaPan 'Microsoft.Network/routeTables@2025-07-01' = {
  name: 'vnet-sdc-mgmt-prod-01-papan-rt'
  location: location
  tags: tags
  properties: {
    disableBgpRoutePropagation: true
    routes: []
  }
}

resource nsgPaPan 'Microsoft.Network/networkSecurityGroups@2025-07-01' = {
  name: 'nsg-vnet-sdc-mgmt-prod-01-sn-papan-01'
  location: location
  tags: tags
  properties: {
    securityRules: [
      {
        name: 'Span_HTTP_In'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: '195.20.153.0/24'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'Span_HTTPS_In'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: '195.20.153.0/24'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 110
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'Span_SSH_In'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '195.20.153.0/24'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 120
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'All_Out'
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 130
          direction: 'Outbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}
