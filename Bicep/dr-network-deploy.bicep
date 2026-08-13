resource nsgConsApp 'Microsoft.Network/networkSecurityGroups@2025-07-01' = {
  name: 'nsg-vn-usc-dr-prod-01-sn-cons-app-prod-01'
  location: 'centralus'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {
    securityRules: []
  }
}

resource nsgConsGlobalsales 'Microsoft.Network/networkSecurityGroups@2025-07-01' = {
  name: 'nsg-vn-usc-dr-prod-01-sn-cons-globalsales-prod-01'
  location: 'centralus'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {
    securityRules: []
  }
}

resource nsgCorpMicrstg 'Microsoft.Network/networkSecurityGroups@2025-07-01' = {
  name: 'nsg-vn-usc-dr-prod-01-sn-corp-micrstg-prod-01'
  location: 'centralus'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {
    securityRules: []
  }
}

resource nsgCorpOneinbeauty 'Microsoft.Network/networkSecurityGroups@2025-07-01' = {
  name: 'nsg-vn-usc-dr-prod-01-sn-corp-oneinbeauty-prod-01'
  location: 'centralus'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {
    securityRules: []
  }
}

resource nsgCorpSapDev 'Microsoft.Network/networkSecurityGroups@2025-07-01' = {
  name: 'nsg-vn-usc-dr-prod-01-sn-corp-sap-dev-01'
  location: 'centralus'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {
    securityRules: []
  }
}

resource nsgCorpSap 'Microsoft.Network/networkSecurityGroups@2025-07-01' = {
  name: 'nsg-vn-usc-dr-prod-01-sn-corp-sap-prod-01'
  location: 'centralus'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {
    securityRules: []
  }
}

resource nsgCorpSqlsvc 'Microsoft.Network/networkSecurityGroups@2025-07-01' = {
  name: 'nsg-vn-usc-dr-prod-01-sn-corp-sqlsvc-prod-01'
  location: 'centralus'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {
    securityRules: []
  }
}

resource nsgFinVertex 'Microsoft.Network/networkSecurityGroups@2025-07-01' = {
  name: 'nsg-vn-usc-dr-prod-01-sn-fin-vertex-prod-01'
  location: 'centralus'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {
    securityRules: []
  }
}

resource nsgMgmtPanorama 'Microsoft.Network/networkSecurityGroups@2025-07-01' = {
  name: 'nsg-vn-usc-dr-prod-01-sn-mgmt-panorama-prod-01'
  location: 'centralus'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {
    securityRules: []
  }
}

resource nsgSecPki 'Microsoft.Network/networkSecurityGroups@2025-07-01' = {
  name: 'nsg-vn-usc-dr-prod-01-sn-sec-pki-prod-01'
  location: 'centralus'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {
    securityRules: []
  }
}

resource nsgSecSyslog 'Microsoft.Network/networkSecurityGroups@2025-07-01' = {
  name: 'nsg-vn-usc-dr-prod-01-sn-sec-syslog-prod-01'
  location: 'centralus'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {
    securityRules: []
  }
}

resource nsgSecTools 'Microsoft.Network/networkSecurityGroups@2025-07-01' = {
  name: 'nsg-vn-usc-dr-prod-01-sn-sec-tools-prod-01'
  location: 'centralus'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {
    securityRules: []
  }
}

resource nsgSpcKnowportal 'Microsoft.Network/networkSecurityGroups@2025-07-01' = {
  name: 'nsg-vn-usc-dr-prod-01-sn-spc-knowportal-prod-01'
  location: 'centralus'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {
    securityRules: []
  }
}

resource nsgSpcLoft 'Microsoft.Network/networkSecurityGroups@2025-07-01' = {
  name: 'nsg-vn-usc-dr-prod-01-sn-spc-loft-prod-01'
  location: 'centralus'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {
    securityRules: []
  }
}

resource networkWatcher 'Microsoft.Network/networkWatchers@2025-07-01' = {
  name: 'nw-usc-dr-prod-01'
  location: 'centralus'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {}
}

resource routeTableConsApp 'Microsoft.Network/routeTables@2025-07-01' = {
  name: 'rt-usc-dr-cons-app-prod-01'
  location: 'centralus'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {
    disableBgpRoutePropagation: true
    routes: [
      {
        name: 'route-default'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '100.100.100.100'
        }
      }
      {
        name: 'route-intra-subnet'
        properties: {
          addressPrefix: '10.254.74.0/28'
          nextHopType: 'VnetLocal'
        }
      }
      {
        name: 'route-intra-vnet'
        properties: {
          addressPrefix: '10.254.74.0/23'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '100.100.100.100'
        }
      }
    ]
  }
}

resource routeTableConsGlobalsales 'Microsoft.Network/routeTables@2025-07-01' = {
  name: 'rt-usc-dr-cons-globalsales-prod-01'
  location: 'centralus'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {
    disableBgpRoutePropagation: true
    routes: [
      {
        name: 'route-default'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '100.100.100.100'
        }
      }
      {
        name: 'route-intra-subnet'
        properties: {
          addressPrefix: '10.254.74.16/28'
          nextHopType: 'VnetLocal'
        }
      }
      {
        name: 'route-intra-vnet'
        properties: {
          addressPrefix: '10.254.74.0/23'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '100.100.100.100'
        }
      }
    ]
  }
}

resource routeTableCorpMicrstg 'Microsoft.Network/routeTables@2025-07-01' = {
  name: 'rt-usc-dr-corp-micrstg-prod-01'
  location: 'centralus'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {
    disableBgpRoutePropagation: true
    routes: [
      {
        name: 'route-default'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '100.100.100.100'
        }
      }
      {
        name: 'route-intra-subnet'
        properties: {
          addressPrefix: '10.254.74.48/28'
          nextHopType: 'VnetLocal'
        }
      }
      {
        name: 'route-intra-vnet'
        properties: {
          addressPrefix: '10.254.74.0/23'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '100.100.100.100'
        }
      }
    ]
  }
}

resource routeTableCorpOneinbeauty 'Microsoft.Network/routeTables@2025-07-01' = {
  name: 'rt-usc-dr-corp-oneinbeauty-prod-01'
  location: 'centralus'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {
    disableBgpRoutePropagation: true
    routes: [
      {
        name: 'route-default'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '100.100.100.100'
        }
      }
      {
        name: 'route-intra-subnet'
        properties: {
          addressPrefix: '10.254.74.64/28'
          nextHopType: 'VnetLocal'
        }
      }
      {
        name: 'route-intra-vnet'
        properties: {
          addressPrefix: '10.254.74.0/23'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '100.100.100.100'
        }
      }
    ]
  }
}

resource routeTableCorpSapDev 'Microsoft.Network/routeTables@2025-07-01' = {
  name: 'rt-usc-dr-corp-sap-dev-01'
  location: 'centralus'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {
    disableBgpRoutePropagation: true
    routes: [
      {
        name: 'route-default'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '100.100.100.100'
        }
      }
      {
        name: 'route-intra-subnet'
        properties: {
          addressPrefix: '10.254.74.32/28'
          nextHopType: 'VnetLocal'
        }
      }
      {
        name: 'route-intra-vnet'
        properties: {
          addressPrefix: '10.254.74.0/23'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '100.100.100.100'
        }
      }
    ]
  }
}

resource routeTableCorpSap 'Microsoft.Network/routeTables@2025-07-01' = {
  name: 'rt-usc-dr-corp-sap-prod-01'
  location: 'centralus'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {
    disableBgpRoutePropagation: true
    routes: [
      {
        name: 'route-default'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '100.100.100.100'
        }
      }
      {
        name: 'route-intra-subnet'
        properties: {
          addressPrefix: '10.254.74.80/28'
          nextHopType: 'VnetLocal'
        }
      }
      {
        name: 'route-intra-vnet'
        properties: {
          addressPrefix: '10.254.74.0/23'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '100.100.100.100'
        }
      }
    ]
  }
}

resource routeTableCorpSqlsvc 'Microsoft.Network/routeTables@2025-07-01' = {
  name: 'rt-usc-dr-corp-sqlsvc-prod-01'
  location: 'centralus'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {
    disableBgpRoutePropagation: true
    routes: [
      {
        name: 'route-default'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '100.100.100.100'
        }
      }
      {
        name: 'route-intra-subnet'
        properties: {
          addressPrefix: '10.254.74.96/28'
          nextHopType: 'VnetLocal'
        }
      }
      {
        name: 'route-intra-vnet'
        properties: {
          addressPrefix: '10.254.74.0/23'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '100.100.100.100'
        }
      }
    ]
  }
}

resource routeTableFinVertex 'Microsoft.Network/routeTables@2025-07-01' = {
  name: 'rt-usc-dr-fin-vertex-prod-01'
  location: 'centralus'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {
    disableBgpRoutePropagation: true
    routes: [
      {
        name: 'route-default'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '100.100.100.100'
        }
      }
      {
        name: 'route-intra-subnet'
        properties: {
          addressPrefix: '10.254.74.144/29'
          nextHopType: 'VnetLocal'
        }
      }
      {
        name: 'route-intra-vnet'
        properties: {
          addressPrefix: '10.254.74.0/23'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '100.100.100.100'
        }
      }
    ]
  }
}

resource routeTableMgmtPanorama 'Microsoft.Network/routeTables@2025-07-01' = {
  name: 'rt-usc-dr-mgmt-panorama-prod-01'
  location: 'centralus'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {
    disableBgpRoutePropagation: true
    routes: [
      {
        name: 'route-default'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '100.100.100.100'
        }
      }
      {
        name: 'route-intra-subnet'
        properties: {
          addressPrefix: '10.254.74.160/29'
          nextHopType: 'VnetLocal'
        }
      }
      {
        name: 'route-intra-vnet'
        properties: {
          addressPrefix: '10.254.74.0/23'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '100.100.100.100'
        }
      }
    ]
  }
}

resource routeTableSecPki 'Microsoft.Network/routeTables@2025-07-01' = {
  name: 'rt-usc-dr-sec-pki-prod-01'
  location: 'centralus'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {
    disableBgpRoutePropagation: true
    routes: [
      {
        name: 'route-default'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '100.100.100.100'
        }
      }
      {
        name: 'route-intra-subnet'
        properties: {
          addressPrefix: '10.254.74.112/28'
          nextHopType: 'VnetLocal'
        }
      }
      {
        name: 'route-intra-vnet'
        properties: {
          addressPrefix: '10.254.74.0/23'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '100.100.100.100'
        }
      }
    ]
  }
}

resource routeTableSecSyslog 'Microsoft.Network/routeTables@2025-07-01' = {
  name: 'rt-usc-dr-sec-syslog-prod-01'
  location: 'centralus'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {
    disableBgpRoutePropagation: true
    routes: [
      {
        name: 'route-default'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '100.100.100.100'
        }
      }
      {
        name: 'route-intra-subnet'
        properties: {
          addressPrefix: '10.254.74.152/29'
          nextHopType: 'VnetLocal'
        }
      }
      {
        name: 'route-intra-vnet'
        properties: {
          addressPrefix: '10.254.74.0/23'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '100.100.100.100'
        }
      }
    ]
  }
}

resource routeTableSecTools 'Microsoft.Network/routeTables@2025-07-01' = {
  name: 'rt-usc-dr-sec-tools-prod-01'
  location: 'centralus'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {
    disableBgpRoutePropagation: true
    routes: [
      {
        name: 'route-default'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '100.100.100.100'
        }
      }
      {
        name: 'route-intra-subnet'
        properties: {
          addressPrefix: '10.254.74.128/28'
          nextHopType: 'VnetLocal'
        }
      }
      {
        name: 'route-intra-vnet'
        properties: {
          addressPrefix: '10.254.74.0/23'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '100.100.100.100'
        }
      }
    ]
  }
}

resource routeTableSpcKnowportal 'Microsoft.Network/routeTables@2025-07-01' = {
  name: 'rt-usc-dr-spc-knowportal-prod-01'
  location: 'centralus'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {
    disableBgpRoutePropagation: true
    routes: [
      {
        name: 'route-default'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '100.100.100.100'
        }
      }
      {
        name: 'route-intra-subnet'
        properties: {
          addressPrefix: '10.254.74.168/29'
          nextHopType: 'VnetLocal'
        }
      }
      {
        name: 'route-intra-vnet'
        properties: {
          addressPrefix: '10.254.74.0/23'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '100.100.100.100'
        }
      }
    ]
  }
}

resource routeTableSpcLoft 'Microsoft.Network/routeTables@2025-07-01' = {
  name: 'rt-usc-dr-spc-loft-prod-01'
  location: 'centralus'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {
    disableBgpRoutePropagation: true
    routes: [
      {
        name: 'route-default'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '100.100.100.100'
        }
      }
      {
        name: 'route-intra-subnet'
        properties: {
          addressPrefix: '10.254.74.176/29'
          nextHopType: 'VnetLocal'
        }
      }
      {
        name: 'route-intra-vnet'
        properties: {
          addressPrefix: '10.254.74.0/23'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '100.100.100.100'
        }
      }
    ]
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2025-07-01' = {
  name: 'vn-usc-dr-prod-01'
  location: 'centralus'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.254.74.0/23'
      ]
    }
    summarizedGatewayPrefixes: {
      addressPrefixes: []
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    privateEndpointVNetPolicies: 'Disabled'
    dhcpOptions: {
      dnsServers: [
        '10.254.2.36'
        '10.254.2.37'
      ]
    }
    subnets: [
      {
        name: 'sn-cons-app-prod-01'
        properties: {
          addressPrefixes: [
            '10.254.74.0/28'
          ]
          networkSecurityGroup: {
            id: nsgConsApp.id
          }
          routeTable: {
            id: routeTableConsApp.id
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'sn-cons-globalsales-prod-01'
        properties: {
          addressPrefixes: [
            '10.254.74.16/28'
          ]
          networkSecurityGroup: {
            id: nsgConsGlobalsales.id
          }
          routeTable: {
            id: routeTableConsGlobalsales.id
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'sn-corp-sap-dev-01'
        properties: {
          addressPrefixes: [
            '10.254.74.32/28'
          ]
          networkSecurityGroup: {
            id: nsgCorpSapDev.id
          }
          routeTable: {
            id: routeTableCorpSapDev.id
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'sn-corp-micrstg-prod-01'
        properties: {
          addressPrefixes: [
            '10.254.74.48/28'
          ]
          networkSecurityGroup: {
            id: nsgCorpMicrstg.id
          }
          routeTable: {
            id: routeTableCorpMicrstg.id
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'sn-corp-oneinbeauty-prod-01'
        properties: {
          addressPrefixes: [
            '10.254.74.64/28'
          ]
          networkSecurityGroup: {
            id: nsgCorpOneinbeauty.id
          }
          routeTable: {
            id: routeTableCorpOneinbeauty.id
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'sn-corp-sap-prod-01'
        properties: {
          addressPrefixes: [
            '10.254.74.80/28'
          ]
          networkSecurityGroup: {
            id: nsgCorpSap.id
          }
          routeTable: {
            id: routeTableCorpSap.id
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'sn-corp-sqlsvc-prod-01'
        properties: {
          addressPrefixes: [
            '10.254.74.96/28'
          ]
          networkSecurityGroup: {
            id: nsgCorpSqlsvc.id
          }
          routeTable: {
            id: routeTableCorpSqlsvc.id
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'sn-sec-pki-prod-01'
        properties: {
          addressPrefixes: [
            '10.254.74.112/28'
          ]
          networkSecurityGroup: {
            id: nsgSecPki.id
          }
          routeTable: {
            id: routeTableSecPki.id
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'sn-sec-tools-prod-01'
        properties: {
          addressPrefixes: [
            '10.254.74.128/28'
          ]
          networkSecurityGroup: {
            id: nsgSecTools.id
          }
          routeTable: {
            id: routeTableSecTools.id
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'sn-fin-vertex-prod-01'
        properties: {
          addressPrefixes: [
            '10.254.74.144/29'
          ]
          networkSecurityGroup: {
            id: nsgFinVertex.id
          }
          routeTable: {
            id: routeTableFinVertex.id
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'sn-sec-syslog-prod-01'
        properties: {
          addressPrefixes: [
            '10.254.74.152/29'
          ]
          networkSecurityGroup: {
            id: nsgSecSyslog.id
          }
          routeTable: {
            id: routeTableSecSyslog.id
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'sn-mgmt-panorama-prod-01'
        properties: {
          addressPrefixes: [
            '10.254.74.160/29'
          ]
          networkSecurityGroup: {
            id: nsgMgmtPanorama.id
          }
          routeTable: {
            id: routeTableMgmtPanorama.id
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'sn-spc-knowportal-prod-01'
        properties: {
          addressPrefixes: [
            '10.254.74.168/29'
          ]
          networkSecurityGroup: {
            id: nsgSpcKnowportal.id
          }
          routeTable: {
            id: routeTableSpcKnowportal.id
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'sn-spc-loft-prod-01'
        properties: {
          addressPrefixes: [
            '10.254.74.176/29'
          ]
          networkSecurityGroup: {
            id: nsgSpcLoft.id
          }
          routeTable: {
            id: routeTableSpcLoft.id
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}
