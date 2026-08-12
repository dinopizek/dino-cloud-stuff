targetScope = 'subscription'

param location string = 'swedencentral'
param paloAltoRgName string = 'rg-sc-paloalto-prod-01'
param connectivityRgName string = 'rg-sc-connectivity-prod-01'

resource rgPaloAlto 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: paloAltoRgName
  location: location
}

resource rgConnectivity 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: connectivityRgName
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
