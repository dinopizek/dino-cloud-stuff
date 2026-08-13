param location string = 'swedencentral'
param tags object = {
  criticality: 'high'
  domain: 'itoperations'
}

resource rtPaUntrust 'Microsoft.Network/routeTables@2025-07-01' = {
  name: 'vnet-sdc-connectivity-prod-01-PA-Untrust-rt'
  location: location
  tags: tags
  properties: {
    disableBgpRoutePropagation: true
    routes: []
  }
}

resource rtPaTrust 'Microsoft.Network/routeTables@2025-07-01' = {
  name: 'vnet-sdc-connectivity-prod-01-PA-Trust-rt'
  location: location
  tags: tags
  properties: {
    disableBgpRoutePropagation: true
    routes: []
  }
}

resource rtPaMgmt 'Microsoft.Network/routeTables@2025-07-01' = {
  name: 'vnet-sdc-connectivity-prod-01-PA-MGMT-rt'
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
  name: 'vnet-sdc-connectivity-prod-01-Elasticsearch-rt'
  location: location
  tags: tags
  properties: {
    disableBgpRoutePropagation: true
    routes: []
  }
}

resource rtPrivateDmz 'Microsoft.Network/routeTables@2025-07-01' = {
  name: 'vnet-sdc-connectivity-prod-01-PrivateDMZ-rt'
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
  name: 'vnet-sdc-connectivity-prod-01-PublicDMZ-rt'
  location: location
  tags: tags
  properties: {
    disableBgpRoutePropagation: true
    routes: []
  }
}

resource rtTestDev 'Microsoft.Network/routeTables@2025-07-01' = {
  name: 'vnet-sdc-connectivity-prod-01-TestDev-rt'
  location: location
  tags: tags
  properties: {
    disableBgpRoutePropagation: true
    routes: []
  }
}

resource nsgPaUntrust 'Microsoft.Network/networkSecurityGroups@2025-07-01' = {
  name: 'nsg-vn-sdc-connectivity-prod-01-sn-paloalto-untrust-01'
  location: location
  tags: tags
  properties: {
    securityRules: []
  }
}

resource nsgPaTrust 'Microsoft.Network/networkSecurityGroups@2025-07-01' = {
  name: 'nsg-vn-sdc-connectivity-prod-01-sn-paloalto-trust-01'
  location: location
  tags: tags
  properties: {
    securityRules: []
  }
}

resource nsgPaMgmt 'Microsoft.Network/networkSecurityGroups@2025-07-01' = {
  name: 'nsg-vn-sdc-connectivity-prod-01-sn-paloalto-mgmt-01'
  location: location
  tags: tags
  properties: {
    securityRules: []
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
