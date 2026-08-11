param virtualNetworks_vn_usc_dr_prod_01_name string = 'vn-usc-dr-prod-01'

resource virtualNetworks_vn_usc_dr_prod_01_name_resource 'Microsoft.Network/virtualNetworks@2025-07-01' = {
  name: virtualNetworks_vn_usc_dr_prod_01_name
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
            id: networkSecurityGroups_nsg_vn_usc_dr_prod_01_sn_cons_app_prod_01_name_resource.id
          }
          routeTable: {
            id: routeTables_rt_usc_dr_cons_app_prod_01_name_resource.id
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
            id: networkSecurityGroups_nsg_vn_usc_dr_prod_01_sn_cons_globalsales_prod_01_name_resource.id
          }
          routeTable: {
            id: routeTables_rt_usc_dr_cons_globalsales_prod_01_name_resource.id
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
            id: networkSecurityGroups_nsg_vn_usc_dr_prod_01_sn_corp_sap_dev_01_name_resource.id
          }
          routeTable: {
            id: routeTables_rt_usc_dr_corp_sap_dev_01_name_resource.id
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
            id: networkSecurityGroups_nsg_vn_usc_dr_prod_01_sn_corp_micrstg_prod_01_name_resource.id
          }
          routeTable: {
            id: routeTables_rt_usc_dr_corp_micrstg_prod_01_name_resource.id
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
            id: networkSecurityGroups_nsg_vn_usc_dr_prod_01_sn_corp_oneinbeauty_prod_01_name_resource.id
          }
          routeTable: {
            id: routeTables_rt_usc_dr_corp_oneinbeauty_prod_01_name_resource.id
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
            id: networkSecurityGroups_nsg_vn_usc_dr_prod_01_sn_corp_sap_prod_01_name_resource.id
          }
          routeTable: {
            id: routeTables_rt_usc_dr_corp_sap_prod_01_name_resource.id
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
            id: networkSecurityGroups_nsg_vn_usc_dr_prod_01_sn_corp_sqlsvc_prod_01_name_resource.id
          }
          routeTable: {
            id: routeTables_rt_usc_dr_corp_sqlsvc_prod_01_name_resource.id
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
            id: networkSecurityGroups_nsg_vn_usc_dr_prod_01_sn_sec_pki_prod_01_name_resource.id
          }
          routeTable: {
            id: routeTables_rt_usc_dr_sec_pki_prod_01_name_resource.id
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
            id: networkSecurityGroups_nsg_vn_usc_dr_prod_01_sn_sec_tools_prod_01_name_resource.id
          }
          routeTable: {
            id: routeTables_rt_usc_dr_sec_tools_prod_01_name_resource.id
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
            id: networkSecurityGroups_nsg_vn_usc_dr_prod_01_sn_fin_vertex_prod_01_name_resource.id
          }
          routeTable: {
            id: routeTables_rt_usc_dr_fin_vertex_prod_01_name_resource.id
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
            id: networkSecurityGroups_nsg_vn_usc_dr_prod_01_sn_sec_syslog_prod_01_name_resource.id
          }
          routeTable: {
            id: routeTables_rt_usc_dr_sec_syslog_prod_01_name_resource.id
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
            id: networkSecurityGroups_nsg_vn_usc_dr_prod_01_sn_mgmt_panorama_prod_01_name_resource.id
          }
          routeTable: {
            id: routeTables_rt_usc_dr_mgmt_panorama_prod_01_name_resource.id
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
            id: networkSecurityGroups_nsg_vn_usc_dr_prod_01_sn_spc_knowportal_prod_01_name_resource.id
          }
          routeTable: {
            id: routeTables_rt_usc_dr_spc_knowportal_prod_01_name_resource.id
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
            id: networkSecurityGroups_nsg_vn_usc_dr_prod_01_sn_spc_loft_prod_01_name_resource.id
          }
          routeTable: {
            id: routeTables_rt_usc_dr_spc_loft_prod_01_name_resource.id
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
