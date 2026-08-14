param location string = 'swedencentral'
param tags object = {
  criticality: 'high'
  domain: 'itoperations'
}

resource rtPaUntrust 'Microsoft.Network/routeTables@2025-07-01' = {
  name: 'vnet-sdc-connectivity-prod-01-pa-untrust-rt'
  location: location
  tags: tags
  properties: {
    disableBgpRoutePropagation: true
    routes: []
  }
}

resource rtPaTrust 'Microsoft.Network/routeTables@2025-07-01' = {
  name: 'vnet-sdc-connectivity-prod-01-pa-trust-rt'
  location: location
  tags: tags
  properties: {
    disableBgpRoutePropagation: true
    routes: []
  }
}

resource rtPaMgmt 'Microsoft.Network/routeTables@2025-07-01' = {
  name: 'vnet-sdc-connectivity-prod-01-pa-mgmt-rt'
  location: location
  tags: tags
  properties: {
    disableBgpRoutePropagation: true
    routes: []
  }
}

resource rtGateway 'Microsoft.Network/routeTables@2025-07-01' = {
  name: 'vnet-sdc-connectivity-prod-01-gw-rt'
  location: location
  tags: tags
  properties: {
    disableBgpRoutePropagation: true
    routes: []
  }
}

resource rtElasticsearch 'Microsoft.Network/routeTables@2025-07-01' = {
  name: 'vnet-sdc-connectivity-prod-01-elasticsearch-rt'
  location: location
  tags: tags
  properties: {
    disableBgpRoutePropagation: true
    routes: []
  }
}

resource rtPrivateDmz 'Microsoft.Network/routeTables@2025-07-01' = {
  name: 'vnet-sdc-connectivity-prod-01-privatedmz-rt'
  location: location
  tags: tags
  properties: {
    disableBgpRoutePropagation: true
    routes: []
  }
}

resource rtProduction 'Microsoft.Network/routeTables@2025-07-01' = {
  name: 'vnet-sdc-connectivity-prod-01-production-rt'
  location: location
  tags: tags
  properties: {
    disableBgpRoutePropagation: true
    routes: []
  }
}

resource rtPublicDmz 'Microsoft.Network/routeTables@2025-07-01' = {
  name: 'vnet-sdc-connectivity-prod-01-publicdmz-rt'
  location: location
  tags: tags
  properties: {
    disableBgpRoutePropagation: true
    routes: []
  }
}

resource rtTestDev 'Microsoft.Network/routeTables@2025-07-01' = {
  name: 'vnet-sdc-connectivity-prod-01-testdev-rt'
  location: location
  tags: tags
  properties: {
    disableBgpRoutePropagation: true
    routes: []
  }
}

resource nsgPaUntrust 'Microsoft.Network/networkSecurityGroups@2025-07-01' = {
  name: 'nsg-vnet-sdc-connectivity-prod-01-sn-paloalto-untrust-01'
  location: location
  tags: tags
  properties: {
    securityRules: [
      {
        name: 'All_In'
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
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
        name: 'All_Out'
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 110
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

resource nsgPaTrust 'Microsoft.Network/networkSecurityGroups@2025-07-01' = {
  name: 'nsg-vnet-sdc-connectivity-prod-01-sn-paloalto-trust-01'
  location: location
  tags: tags
  properties: {
    securityRules: [
      {
        name: 'All_In'
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
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
        name: 'All_Out'
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 110
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

resource nsgPaMgmt 'Microsoft.Network/networkSecurityGroups@2025-07-01' = {
  name: 'nsg-vnet-sdc-connectivity-prod-01-sn-paloalto-mgmt-01'
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

resource publicIPPrefixes 'Microsoft.Network/publicIPPrefixes@2025-07-01' = {
  name: 'ippre-sdc-hub-pafw-untrust-prod-01'
  location: location
  tags: tags
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    publicIPAddressVersion: 'IPv4'
    prefixLength: 31
  }
}

output rtPaUntrustId string = rtPaUntrust.id
output rtPaTrustId string = rtPaTrust.id
output rtPaMgmtId string = rtPaMgmt.id
output rtGatewayId string = rtGateway.id
output rtElasticsearchId string = rtElasticsearch.id
output rtPrivateDmzId string = rtPrivateDmz.id
output rtProductionId string = rtProduction.id
output rtPublicDmzId string = rtPublicDmz.id
output rtTestDevId string = rtTestDev.id
output nsgPaUntrustId string = nsgPaUntrust.id
output nsgPaTrustId string = nsgPaTrust.id
output nsgPaMgmtId string = nsgPaMgmt.id
