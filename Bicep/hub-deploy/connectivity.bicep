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
        // The 4th Palo Alto subnet in the WEU reference has no NSG or route
        // table attached - most likely an HA sync interface. CONFIRM the
        // exact name and purpose (portal truncates it to "sn-paloalto...").
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
        // CONFIRM exact name - portal truncates it to "sn-dns-in-...".
        name: 'sn-dns-inbound-01'
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
        // CONFIRM exact name - portal truncates it to "sn-dns-out...".
        name: 'sn-dns-outbound-01'
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

output vnetId string = virtualNetwork.id
