param location string = 'swedencentral'
param tags object = {
  criticality: 'high'
  domain: 'itoperations'
}
param vnetAddressPrefix string = '10.247.0.0/22'
param rtPaUntrustId string
param rtPaTrustId string
param rtPaMgmtId string
param rtGatewayId string
param nsgPaUntrustId string
param nsgPaTrustId string
param nsgPaMgmtId string

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2025-07-01' = {
  name: 'vnet-sc-connectivity-prod-01'
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: 'sn-paloalto-untrust-01'
        properties: {
          addressPrefixes: [
            '10.247.0.0/24'
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
          addressPrefixes: [
            '10.247.1.0/24'
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
          addressPrefixes: [
            '10.247.2.0/28'
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
        name: 'sn-paloalto-ha-01'
        properties: {
          addressPrefixes: [
            '10.247.2.16/28'
          ]
        }
      }
      {
        name: 'GatewaySubnet'
        properties: {
          addressPrefixes: [
            '10.247.2.32/27'
          ]
          routeTable: {
            id: rtGatewayId
          }
        }
      }
      {
        name: 'sn-dns-in-hub-01'
        properties: {
          addressPrefixes: [
            '10.247.2.64/26'
          ]
          delegations: [
            {
              name: 'dnsResolvers'
              properties: {
                serviceName: 'Microsoft.Network/dnsResolvers'
              }
            }
          ]
        }
      }
      {
        name: 'sn-dns-out-hub-01'
        properties: {
          addressPrefixes: [
            '10.247.2.128/26'
          ]
          delegations: [
            {
              name: 'dnsResolvers'
              properties: {
                serviceName: 'Microsoft.Network/dnsResolvers'
              }
            }
          ]
        }
      }
    ]
    enableDdosProtection: false
  }
}

resource publicIPAddresses 'Microsoft.Network/publicIPAddresses@2025-07-01' = {
  name: 'pip-sc-connectivity-prod-01-vpngw'
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
  }
}

resource virtualNetworkGateway 'Microsoft.Network/virtualNetworkGateways@2025-07-01' = {
  name: 'vgw-sc-connectivity-prod-01'
  location: location
  tags: tags
  properties: {
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
    enableBgp: false
    enableHighBandwidthVpnGateway: false
    activeActive: false
    allowRemoteVnetTraffic: false
    allowVirtualWanTraffic: false
  }
}

output vnetId string = virtualNetwork.id
output vpnGatewayId string = virtualNetworkGateway.id
