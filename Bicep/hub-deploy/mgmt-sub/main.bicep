targetScope = 'subscription'

param location string = 'swedencentral'

resource rgPanorama 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: 'rg-sdc-paloalto-panorama-prod-01'
  location: location
}

resource rgMgmtNetwork 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: 'rg-sdc-mgmt-network-prod-01'
  location: location
}

module mgmtnetwork 'mgmt-network.bicep' = {
  name: 'deploy-mgmt-network'
  scope: rgMgmtNetwork
  params: {
    location: location
  }
}

module panorama 'panorama.bicep' = {
  name: 'deploy-panorama'
  scope: rgPanorama
  params: {
    location: location
  }
}
