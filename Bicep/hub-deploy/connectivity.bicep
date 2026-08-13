param location string = 'swedencentral'
param tags object = {
  criticality: 'high'
  domain: 'itoperations'
}
param rtPaUntrustId string
param rtPaTrustId string
param rtPaMgmtId string
param rtGatewayId string
param nsgPaUntrustId string
param nsgPaTrustId string
param nsgPaMgmtId string

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2025-07-01' = {
  name: 'vnet-sdc-connectivity-prod-01'
  location: location
  tags: tags
  properties: {
    privateEndpointVNetPolicies: 'Disabled'
    addressSpace: {
      addressPrefixes: [
        '10.248.0.0/22'
      ]
    }
    subnets: [
      {
        name: 'sn-paloalto-untrust-01'
        properties: {
          defaultOutboundAccess: false
          addressPrefixes: [
            '10.248.0.0/25'
          ]
          networkSecurityGroup: {
            id: nsgPaUntrustId
          }
          routeTable: {
            id: rtPaUntrustId
          }
        }
      }
      {
        name: 'sn-paloalto-trust-01'
        properties: {
          defaultOutboundAccess: false
          addressPrefixes: [
            '10.248.0.128/27'
          ]
          networkSecurityGroup: {
            id: nsgPaTrustId
          }
          routeTable: {
            id: rtPaTrustId
          }
        }
      }
      {
        name: 'sn-paloalto-mgmt-01'
        properties: {
          defaultOutboundAccess: false
          addressPrefixes: [
            '10.248.0.160/28'
          ]
          networkSecurityGroup: {
            id: nsgPaMgmtId
          }
          routeTable: {
            id: rtPaMgmtId
          }
        }
      }
      {
        name: 'GatewaySubnet'
        properties: {
          defaultOutboundAccess: false
          addressPrefixes: [
            '10.248.0.192/27'
          ]
          routeTable: {
            id: rtGatewayId
          }
        }
      }
    ]
    enableDdosProtection: false
  }
}

resource publicIPAddresses 'Microsoft.Network/publicIPAddresses@2025-07-01' = {
  name: 'pip-sdc-connectivity-prod-01-vpngw'
  location: location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  zones: [
    '1'
    '2'
    '3'
  ]
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
  }
}

resource virtualNetworkGateway 'Microsoft.Network/virtualNetworkGateways@2025-07-01' = {
  name: 'vgw-sdc-connectivity-prod-01'
  location: location
  tags: tags
  properties: {
    bgpSettings: {
      asn: 65515
    }

    ipConfigurations: [
      {
        name: 'default'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses.id
          }
          subnet: {
            id: '${virtualNetwork.id}/subnets/GatewaySubnet'
          }
        }
      }
    ]
    natRules: []
    enableBgpRouteTranslationForNat: false
    disableIPSecReplayProtection: false
    sku: {
      name: 'VpnGw1AZ'
      tier: 'VpnGw1AZ'
    }
    gatewayType: 'Vpn'
    vpnType: 'RouteBased'
    vpnGatewayGeneration: 'Generation2'
    enableBgp: true
    enableHighBandwidthVpnGateway: false
    activeActive: false
    allowRemoteVnetTraffic: false
    allowVirtualWanTraffic: false
  }
}

output vnetId string = virtualNetwork.id
output vpnGatewayId string = virtualNetworkGateway.id
