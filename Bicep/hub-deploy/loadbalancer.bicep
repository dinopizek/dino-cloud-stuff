param location string = 'swedencentral'
param tags object = {
  criticality: 'high'
  domain: 'itoperations'
}
param vnetId string
param trustSubnetId string

resource nicTrust01 'Microsoft.Network/networkInterfaces@2025-07-01' existing = {
  name: 'vmsdcfwprod01-trust-nic-01'
}

resource nicTrust02 'Microsoft.Network/networkInterfaces@2025-07-01' existing = {
  name: 'vmsdcfwprod02-trust-nic-01'
}

resource internalLoadBalancer 'Microsoft.Network/loadBalancers@2025-07-01' = {
  name: 'ilb-sdc-paloalto-prod-01'
  location: location
  tags: tags
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    frontendIPConfigurations: [
      {
        name: 'fip-sdc-paloalto-trust-prod-01'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: trustSubnetId
          }
        }
      }
    ]
    backendAddressPools: [
      {
        name: 'pool-sdc-paloalto-trust-prod-01'
      }
    ]
    probes: [
      {
        name: 'probe-sdc-paloalto-trust-prod-01'
        properties: {
          protocol: 'Tcp'
          port: 443
          intervalInSeconds: 5
          numberOfProbes: 2
        }
      }
    ]
    loadBalancingRules: [
      {
        name: 'HA'
        properties: {
          frontendIPConfiguration: {
            id: resourceId(
              'Microsoft.Network/loadBalancers/frontendIPConfigurations',
              'ilb-sdc-paloalto-prod-01',
              'fip-sdc-paloalto-trust-prod-01'
            )
          }
          backendAddressPool: {
            id: resourceId(
              'Microsoft.Network/loadBalancers/backendAddressPools',
              'ilb-sdc-paloalto-prod-01',
              'pool-sdc-paloalto-trust-prod-01'
            )
          }
          probe: {
            id: resourceId(
              'Microsoft.Network/loadBalancers/probes',
              'ilb-sdc-paloalto-prod-01',
              'probe-sdc-paloalto-trust-prod-01'
            )
          }
          protocol: 'All'
          frontendPort: 0
          backendPort: 0
          enableFloatingIP: false
          idleTimeoutInMinutes: 4
          loadDistribution: 'SourceIP'
          enableTcpReset: false
        }
      }
    ]
  }
}

resource backendPool 'Microsoft.Network/loadBalancers/backendAddressPools@2025-07-01' = {
  parent: internalLoadBalancer
  name: 'pool-sdc-paloalto-trust-prod-01'
  properties: {
    loadBalancerBackendAddresses: [
      {
        name: 'addr-sdc-paloalto-trust-prod-01'
        properties: {
          virtualNetwork: {
            id: vnetId
          }
          ipAddress: nicTrust01.properties.ipConfigurations[0].properties.privateIPAddress
        }
      }
      {
        name: 'addr-sdc-paloalto-trust-prod-02'
        properties: {
          virtualNetwork: {
            id: vnetId
          }
          ipAddress: nicTrust02.properties.ipConfigurations[0].properties.privateIPAddress
        }
      }
    ]
  }
}

output internalLoadBalancerId string = internalLoadBalancer.id
output feConfigId string = internalLoadBalancer.properties.frontendIPConfigurations[0].id
output backendPoolId string = backendPool.id
