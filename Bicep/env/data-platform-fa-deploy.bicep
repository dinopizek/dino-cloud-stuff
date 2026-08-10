targetScope = 'resourceGroup'

// rev-sub-data-platform-hr-shared
// rg-use2-data-hr-monitor-prod-01

/*
Standalone hardcoded Bicep file for the Management Monitoring workload.
Creates: Log Analytics Workspace, Application Insights, Storage Account,
App Service Plan (Flex Consumption), Function App, 3 custom LAW tables (Power BI),
and Power BI custom DCR (Logs Ingestion API, no DCE required).
*/

//********************************************
// Variables
//********************************************

var location = 'eastus2'

var logAnalyticsWorkspaceName = 'law-use2-data-hr-operational-prod-01'
var applicationInsightsName = 'ai-use2-data-hr-operational-prod-01'
var storageAccountName = 'sause2revfadatahr01'
var appServicePlanName = 'fsp-use2-data-hr-operational-prod-01'
var functionAppName = 'fa-use2-data-hr-operational-prod-01'
var dcrName = 'dcr-use2-data-hr-powerbi-prod-01'

var deploymentStorageContainerName = 'fa-package'
var storageBlobDataOwnerRoleId = 'b7e6dc6d-f1e8-4753-8033-0f276bb0955b'
var monitoringMetricsPublisherId = '3913510d-42f4-4e42-8a64-420c390055eb'

//********************************************
// Log Analytics Workspace
//********************************************

resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2023-09-01' existing = {
  name: logAnalyticsWorkspaceName
}

//********************************************
// Application Insights
//********************************************

resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: applicationInsightsName
  location: location
  kind: 'other'
  properties: {
    Application_Type: 'other'
    WorkspaceResourceId: logAnalytics.id
    DisableLocalAuth: true
  }
}

//********************************************
// Storage Account
//********************************************

resource storage 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: { name: 'Standard_LRS' }
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: false
    dnsEndpointType: 'Standard'
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
    }
    publicNetworkAccess: 'Enabled'
  }
  resource blobServices 'blobServices' = {
    name: 'default'
    properties: {
      deleteRetentionPolicy: {}
    }
    resource deploymentContainer 'containers' = {
      name: deploymentStorageContainerName
      properties: {
        publicAccess: 'None'
      }
    }
  }
}

//********************************************
// App Service Plan (Flex Consumption)
//********************************************

resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: appServicePlanName
  location: location
  kind: 'functionapp'
  sku: {
    tier: 'FlexConsumption'
    name: 'FC1'
  }
  properties: {
    reserved: true
  }
}

//********************************************
// Function App
//********************************************

resource functionApp 'Microsoft.Web/sites@2024-04-01' = {
  name: functionAppName
  location: location
  kind: 'functionapp,linux'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      minTlsVersion: '1.2'
      appSettings: [
        { name: 'AzureWebJobsStorage__accountName', value: storage.name }
        { name: 'AzureWebJobsStorage__credential', value: 'managedidentity' }
        { name: 'APPLICATIONINSIGHTS_CONNECTION_STRING', value: applicationInsights.properties.ConnectionString }
        { name: 'APPLICATIONINSIGHTS_AUTHENTICATION_STRING', value: 'Authorization=AAD' }
        { name: 'TENANT_ID', value: tenant().tenantId }
      ]
    }
    functionAppConfig: {
      deployment: {
        storage: {
          type: 'blobContainer'
          value: '${storage.properties.primaryEndpoints.blob}${deploymentStorageContainerName}'
          authentication: {
            type: 'SystemAssignedIdentity'
          }
        }
      }
      scaleAndConcurrency: {
        maximumInstanceCount: 40
        instanceMemoryMB: 2048
      }
      runtime: {
        name: 'powerShell'
        version: '7.4'
      }
    }
  }
}

//********************************************
// Role Assignments
//********************************************

resource roleAssignmentBlobDataOwner 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(subscription().id, storage.id, functionApp.id, 'Storage Blob Data Owner')
  scope: storage
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', storageBlobDataOwnerRoleId)
    principalId: functionApp.identity.principalId
    principalType: 'ServicePrincipal'
  }
}

resource roleAssignmentMonitoringMetricsPublisher 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(subscription().id, applicationInsights.id, functionApp.id, 'Monitoring Metrics Publisher')
  scope: applicationInsights
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', monitoringMetricsPublisherId)
    principalId: functionApp.identity.principalId
    principalType: 'ServicePrincipal'
  }
}

//********************************************
// Custom LAW Tables - Power BI
//********************************************

resource tablePowerBiWorkspaces 'Microsoft.OperationalInsights/workspaces/tables@2022-10-01' = {
  parent: logAnalytics
  name: 'powerbi_Workspaces_CL'
  properties: {
    schema: {
      name: 'powerbi_Workspaces_CL'
      columns: [
        { name: 'TimeGenerated', type: 'dateTime' }
        { name: 'Timestamp', type: 'string' }
        { name: 'isReadOnly', type: 'boolean' }
        { name: 'isOnDedicatedCapacity', type: 'boolean' }
        { name: 'name', type: 'string' }
        { name: 'datasetCount', type: 'int' }
      ]
    }
  }
}

resource tablePowerBiDatasets 'Microsoft.OperationalInsights/workspaces/tables@2022-10-01' = {
  parent: logAnalytics
  name: 'powerbi_Datasets_CL'
  properties: {
    schema: {
      name: 'powerbi_Datasets_CL'
      columns: [
        { name: 'TimeGenerated', type: 'dateTime' }
        { name: 'workspaceId', type: 'string' }
        { name: 'name', type: 'string' }
        { name: 'webUrl', type: 'string' }
        { name: 'addRowsAPIEnabled', type: 'boolean' }
        { name: 'configuredBy', type: 'string' }
        { name: 'isRefreshable', type: 'boolean' }
        { name: 'isEffectiveIdentityRequired', type: 'boolean' }
        { name: 'isEffectiveIdentityRolesRequired', type: 'boolean' }
        { name: 'targetStorageMode', type: 'string' }
        { name: 'createdDate', type: 'dateTime' }
        { name: 'contentProviderType', type: 'dynamic' }
        { name: 'createReportEmbedURL', type: 'string' }
        { name: 'qnaEmbedURL', type: 'string' }
        { name: 'upstreamDatasets', type: 'dynamic' }
        { name: 'users', type: 'dynamic' }
        { name: 'isInPlaceSharingEnabled', type: 'boolean' }
        { name: 'queryScaleOutSettings', type: 'dynamic' }
      ]
    }
  }
}

resource tablePowerBiRefreshHistory 'Microsoft.OperationalInsights/workspaces/tables@2022-10-01' = {
  parent: logAnalytics
  name: 'powerbi_RefreshHistory_CL'
  properties: {
    schema: {
      name: 'powerbi_RefreshHistory_CL'
      columns: [
        { name: 'TimeGenerated', type: 'dateTime' }
        { name: 'averageDuration', type: 'real' }
        { name: 'configuredBy', type: 'dynamic' }
        { name: 'DatasetID', type: 'string' }
        { name: 'lastRefresh', type: 'dynamic' }
        { name: 'medianDuration', type: 'real' }
        { name: 'ObjectKind', type: 'string' }
        { name: 'requestId', type: 'string' }
        { name: 'refreshType', type: 'string' }
        { name: 'startTime', type: 'dateTime' }
        { name: 'endTime', type: 'dateTime' }
        { name: 'serviceExceptionJson', type: 'string' }
        { name: 'status', type: 'string' }
        { name: 'refreshAttempts', type: 'dynamic' }
        { name: 'refreshCount', type: 'int' }
        { name: 'refreshesPerDay', type: 'int' }
        { name: 'refreshFailures', type: 'int' }
        { name: 'name', type: 'string' }
        { name: 'id', type: 'string' }
        { name: 'extendedStatus', type: 'string' }
        { name: 'WorkspaceId', type: 'string' }
        { name: 'WorkspaceName', type: 'string' }
      ]
    }
  }
}

//********************************************
// Data Collection Rule - Power BI (Logs Ingestion API)
//********************************************

resource dcrPowerBi 'Microsoft.Insights/dataCollectionRules@2024-03-11' = {
  name: dcrName
  location: location
  properties: {
    streamDeclarations: {
      'Custom-powerbi_Workspaces_CL': {
        columns: [
          { name: 'TimeGenerated', type: 'datetime' }
          { name: 'Timestamp', type: 'string' }
          { name: 'isReadOnly', type: 'boolean' }
          { name: 'isOnDedicatedCapacity', type: 'boolean' }
          { name: 'name', type: 'string' }
          { name: 'datasetCount', type: 'int' }
        ]
      }
      'Custom-powerbi_Datasets_CL': {
        columns: [
          { name: 'workspaceId', type: 'string' }
          { name: 'TimeGenerated', type: 'datetime' }
          { name: 'name', type: 'string' }
          { name: 'webUrl', type: 'string' }
          { name: 'addRowsAPIEnabled', type: 'boolean' }
          { name: 'configuredBy', type: 'string' }
          { name: 'isRefreshable', type: 'boolean' }
          { name: 'isEffectiveIdentityRequired', type: 'boolean' }
          { name: 'isEffectiveIdentityRolesRequired', type: 'boolean' }
          { name: 'targetStorageMode', type: 'string' }
          { name: 'createdDate', type: 'datetime' }
          { name: 'contentProviderType', type: 'dynamic' }
          { name: 'createReportEmbedURL', type: 'string' }
          { name: 'qnaEmbedURL', type: 'string' }
          { name: 'upstreamDatasets', type: 'dynamic' }
          { name: 'users', type: 'dynamic' }
          { name: 'isInPlaceSharingEnabled', type: 'boolean' }
          { name: 'queryScaleOutSettings', type: 'dynamic' }
        ]
      }
      'Custom-powerbi_RefreshHistory_CL': {
        columns: [
          { name: 'TimeGenerated', type: 'datetime' }
          { name: 'averageDuration', type: 'real' }
          { name: 'configuredBy', type: 'dynamic' }
          { name: 'DatasetID', type: 'string' }
          { name: 'lastRefresh', type: 'dynamic' }
          { name: 'medianDuration', type: 'real' }
          { name: 'ObjectKind', type: 'string' }
          { name: 'requestId', type: 'string' }
          { name: 'refreshType', type: 'string' }
          { name: 'startTime', type: 'datetime' }
          { name: 'endTime', type: 'datetime' }
          { name: 'serviceExceptionJson', type: 'string' }
          { name: 'status', type: 'string' }
          { name: 'refreshAttempts', type: 'dynamic' }
          { name: 'refreshCount', type: 'int' }
          { name: 'refreshesPerDay', type: 'int' }
          { name: 'refreshFailures', type: 'int' }
          { name: 'name', type: 'string' }
          { name: 'id', type: 'string' }
          { name: 'extendedStatus', type: 'string' }
          { name: 'WorkspaceId', type: 'string' }
          { name: 'WorkspaceName', type: 'string' }
        ]
      }
    }
    dataSources: {}
    destinations: {
      logAnalytics: [
        {
          workspaceResourceId: logAnalytics.id
          name: 'la-workspace'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-powerbi_Workspaces_CL']
        destinations: ['la-workspace']
        transformKql: 'source | extend TimeGenerated = now()'
        outputStream: 'Custom-powerbi_Workspaces_CL'
      }
      {
        streams: ['Custom-powerbi_Datasets_CL']
        destinations: ['la-workspace']
        transformKql: 'source'
        outputStream: 'Custom-powerbi_Datasets_CL'
      }
      {
        streams: ['Custom-powerbi_RefreshHistory_CL']
        destinations: ['la-workspace']
        transformKql: 'source | extend TimeGenerated = now()'
        outputStream: 'Custom-powerbi_RefreshHistory_CL'
      }
    ]
  }
  dependsOn: [tablePowerBiDatasets, tablePowerBiRefreshHistory, tablePowerBiWorkspaces]
}

//********************************************
// Outputs
//********************************************

output resourceIds object = {
  logAnalyticsWorkspaceId: logAnalytics.id
  applicationInsightsId: applicationInsights.id
  storageAccountId: storage.id
  appServicePlanId: appServicePlan.id
  functionAppId: functionApp.id
  dcrId: dcrPowerBi.id
}
