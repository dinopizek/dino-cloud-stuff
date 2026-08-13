targetScope = 'subscription'

resource rgDRNetwork 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: 'rg-usc-dr-prod-01'
  location: 'centralus'
}

module dr 'dr-network-deploy.bicep' = {
  name: 'deploy-dr-network'
  scope: rgDRNetwork
}
