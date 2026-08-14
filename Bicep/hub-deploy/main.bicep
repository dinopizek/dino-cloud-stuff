targetScope = 'subscription'

param location string = 'swedencentral'

resource rgPaloAlto 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: 'rg-sdc-paloalto-prod-01'
  location: location
}

resource rgConnectivity 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: 'rg-sdc-connectivity-prod-01'
  location: location
}

module paloalto 'paloalto.bicep' = {
  name: 'deploy-paloalto'
  scope: rgPaloAlto
  params: {
    location: location
  }
}

module connectivity 'connectivity.bicep' = {
  name: 'deploy-connectivity'
  scope: rgConnectivity
  params: {
    location: location
    rtPaUntrustId: paloalto.outputs.rtPaUntrustId
    rtPaTrustId: paloalto.outputs.rtPaTrustId
    rtPaMgmtId: paloalto.outputs.rtPaMgmtId
    rtGatewayId: paloalto.outputs.rtGatewayId
    nsgPaUntrustId: paloalto.outputs.nsgPaUntrustId
    nsgPaTrustId: paloalto.outputs.nsgPaTrustId
    nsgPaMgmtId: paloalto.outputs.nsgPaMgmtId
  }
}

module loadbalancer 'loadbalancer.bicep' = {
  name: 'deploy-loadbalancer'
  scope: rgPaloAlto
  params: {
    location: location
    vnetId: connectivity.outputs.vnetId
    trustSubnetId: '${connectivity.outputs.vnetId}/subnets/sn-paloalto-trust-01'
  }
}
