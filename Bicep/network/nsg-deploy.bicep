param nsgName string = 'nsg-vn-use2-dr-prod-01-sn-cons-globalsales-prod-01'

resource nsg 'Microsoft.Network/networkSecurityGroups@2025-07-01' = {
  name: nsgName
  location: 'eastus2'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {
    securityRules: []
  }
}
