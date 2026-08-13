conn_data_resource_groups = {
  "rg-use2-private-dns-hub-01" = {
    location = "eastus2"
  }
}

id_data_virtual_networks = {
  "vn-use2-identity-01" = {
    resource_group_name = "rg-use2-identity-network-prod-01"
  }
}

private_dns_zones = {
  eastus2_data_privatelink_azurecr_io = {
    name                = "eastus2.data.privatelink.azurecr.io"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_eastus2_azmk8s_io = {
    name                = "privatelink.eastus2.azmk8s.io"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_eastus2_azurecontainerapps_io = {
    name                = "privatelink.eastus2.azurecontainerapps.io"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_eastus2_kusto_windows_net = {
    name                = "privatelink.eastus2.kusto.windows.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_adf_azure_com = {
    name                = "privatelink.adf.azure.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_afs_azure_net = {
    name                = "privatelink.afs.azure.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_agentsvc_azure_automation_net = {
    name                = "privatelink.agentsvc.azure-automation.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_analysis_windows_net = {
    name                = "privatelink.analysis.windows.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_api_azureml_ms = {
    name                = "privatelink.api.azureml.ms"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_appconfig_io = {
    name                = "privatelink.appconfig.io"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_arc_azure_com = {
    name                = "privatelink.arc.azure.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_attest_azure_net = {
    name                = "privatelink.attest.azure.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_autoheal_trafficmanager_net = {
    name                = "privatelink.autoheal.trafficmanager.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_automation_azure_com = {
    name                = "privatelink.automation.azure.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_azconfig_io = {
    name                = "privatelink.azconfig.io"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_azure_api_net = {
    name                = "privatelink.azure-api.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_azure_automation_net = {
    name                = "privatelink.azure-automation.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_azurecr_io = {
    name                = "privatelink.azurecr.io"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_azuredatabricks_net = {
    name                = "privatelink.azuredatabricks.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_azure_devices_net = {
    name                = "privatelink.azure-devices.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_azure_devices_provisioning_net = {
    name                = "privatelink.azure-devices-provisioning.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_azuredns_com = {
    name                = "privatelink.azuredns.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_azurehdinsight_net = {
    name                = "privatelink.azurehdinsight.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_azurekusto_windows_net = {
    name                = "privatelink.azurekusto.windows.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_azureml_ms = {
    name                = "privatelink.azureml.ms"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_azure_staticapps_net = {
    name                = "privatelink.azure-staticapps.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_azuresynapse_net = {
    name                = "privatelink.azuresynapse.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_azurewebsites_net = {
    name                = "privatelink.azurewebsites.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_batch_azure_com = {
    name                = "privatelink.batch.azure.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_blob_core_windows_net = {
    name                = "privatelink.blob.core.windows.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_cassandra_cosmos_azure_com = {
    name                = "privatelink.cassandra.cosmos.azure.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_cognitiveservices_azure_com = {
    name                = "privatelink.cognitiveservices.azure.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_communication_azure_com = {
    name                = "privatelink.communication.azure.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_database_windows_net = {
    name                = "privatelink.database.windows.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_datafactory_azure_net = {
    name                = "privatelink.datafactory.azure.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_dev_azuresynapse_net = {
    name                = "privatelink.dev.azuresynapse.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_dfs_core_windows_net = {
    name                = "privatelink.dfs.core.windows.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_dicom_azurehealthcareapis_com = {
    name                = "privatelink.dicom.azurehealthcareapis.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_digitaltwins_azure_net = {
    name                = "privatelink.digitaltwins.azure.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_directline_botframework_com = {
    name                = "privatelink.directline.botframework.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_documents_azure_com = {
    name                = "privatelink.documents.azure.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_eventgrid_azure_net = {
    name                = "privatelink.eventgrid.azure.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_eventhubs_servicebus_windows_net = {
    name                = "privatelink.eventhubs.servicebus.windows.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_fabric_microsoft_com = {
    name                = "privatelink.fabric.microsoft.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_fhir_azurehealthcareapis_com = {
    name                = "privatelink.fhir.azurehealthcareapis.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_file_core_windows_net = {
    name                = "privatelink.file.core.windows.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_fluidrelay_azure_com = {
    name                = "privatelink.fluidrelay.azure.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_grafana_azure_com = {
    name                = "privatelink.grafana.azure.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_gremlin_cosmos_azure_com = {
    name                = "privatelink.gremlin.cosmos.azure.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_guestconfiguration_azure_com = {
    name                = "privatelink.guestconfiguration.azure.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_his_arc_azure_com = {
    name                = "privatelink.his.arc.azure.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_iothub_net = {
    name                = "privatelink.iothub.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_keyvault_azure_net = {
    name                = "privatelink.keyvault.azure.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_kubernetesconfiguration_azure_com = {
    name                = "privatelink.kubernetesconfiguration.azure.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_managedhsm_azure_net = {
    name                = "privatelink.managedhsm.azure.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_mariadb_database_azure_com = {
    name                = "privatelink.mariadb.database.azure.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_media_azure_net = {
    name                = "privatelink.media.azure.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_migr_his_arc_azure_com = {
    name                = "privatelink.migr.his.arc.azure.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_mongo_cosmos_azure_com = {
    name                = "privatelink.mongo.cosmos.azure.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_monitor_azure_com = {
    name                = "privatelink.monitor.azure.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_mysql_database_azure_com = {
    name                = "privatelink.mysql.database.azure.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_notebooks_azure_net = {
    name                = "privatelink.notebooks.azure.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_ods_opinsights_azure_com = {
    name                = "privatelink.ods.opinsights.azure.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_oms_opinsights_azure_com = {
    name                = "privatelink.oms.opinsights.azure.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_openai_azure_com = {
    name                = "privatelink.openai.azure.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_openpolicyagent_azure_com = {
    name                = "privatelink.openpolicyagent.azure.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_pbidedicated_windows_net = {
    name                = "privatelink.pbidedicated.windows.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_postgres_database_azure_com = {
    name                = "privatelink.postgres.database.azure.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_prod_powerquery_microsoft_com = {
    name                = "privatelink.prod.powerquery.microsoft.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_purview_azure_com = {
    name                = "privatelink.purview.azure.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_purviewstudio_azure_com = {
    name                = "privatelink.purviewstudio.azure.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_queue_core_windows_net = {
    name                = "privatelink.queue.core.windows.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_redis_cache_windows_net = {
    name                = "privatelink.redis.cache.windows.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_redisenterprise_cache_azure_net = {
    name                = "privatelink.redisenterprise.cache.azure.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_search_windows_net = {
    name                = "privatelink.search.windows.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_servicebus_azure_net = {
    name                = "privatelink.servicebus.azure.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_servicebus_windows_net = {
    name                = "privatelink.servicebus.windows.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_services_ai_azure_com = {
    name                = "privatelink.services.ai.azure.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_signalr_net = {
    name                = "privatelink.signalr.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_siterecovery_windowsazure_com = {
    name                = "privatelink.siterecovery.windowsazure.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_sql_azuresynapse_net = {
    name                = "privatelink.sql.azuresynapse.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_table_core_windows_net = {
    name                = "privatelink.table.core.windows.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_table_cosmos_azure_com = {
    name                = "privatelink.table.cosmos.azure.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_vaultcore_azure_net = {
    name                = "privatelink.vaultcore.azure.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_web_core_windows_net = {
    name                = "privatelink.web.core.windows.net"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
  privatelink_webpubsub_azure_com = {
    name                = "privatelink.webpubsub.azure.com"
    resource_group_name = "rg-use2-private-dns-hub-01"
  }
}

private_dns_zone_virtual_network_links = {
  eastus2-data-privatelink-azurecr-io-dns-link = {
    private_dns_zone_key = "eastus2_data_privatelink_azurecr_io"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-eastus2-azmk8s-io-dns-link = {
    private_dns_zone_key = "privatelink_eastus2_azmk8s_io"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-eastus2-azurecontainerapps-io-dns-link = {
    private_dns_zone_key = "privatelink_eastus2_azurecontainerapps_io"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-eastus2-kusto-windows-net-dns-link = {
    private_dns_zone_key = "privatelink_eastus2_kusto_windows_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-adf-azure-com-dns-link = {
    private_dns_zone_key = "privatelink_adf_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-afs-azure-net-dns-link = {
    private_dns_zone_key = "privatelink_afs_azure_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-agentsvc-azure-automation-net-dns-link = {
    private_dns_zone_key = "privatelink_agentsvc_azure_automation_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-analysis-windows-net-dns-link = {
    private_dns_zone_key = "privatelink_analysis_windows_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-api-azureml-ms-dns-link = {
    private_dns_zone_key = "privatelink_api_azureml_ms"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-appconfig-io-dns-link = {
    private_dns_zone_key = "privatelink_appconfig_io"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-arc-azure-com-dns-link = {
    private_dns_zone_key = "privatelink_arc_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-attest-azure-net-dns-link = {
    private_dns_zone_key = "privatelink_attest_azure_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-autoheal-trafficmanager-net-dns-link = {
    private_dns_zone_key = "privatelink_autoheal_trafficmanager_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-automation-azure-com-dns-link = {
    private_dns_zone_key = "privatelink_automation_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-azconfig-io-dns-link = {
    private_dns_zone_key = "privatelink_azconfig_io"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-azure-api-net-dns-link = {
    private_dns_zone_key = "privatelink_azure_api_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-azure-automation-net-dns-link = {
    private_dns_zone_key = "privatelink_azure_automation_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-azurecr-io-dns-link = {
    private_dns_zone_key = "privatelink_azurecr_io"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-azuredatabricks-net-dns-link = {
    private_dns_zone_key = "privatelink_azuredatabricks_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-azure-devices-net-dns-link = {
    private_dns_zone_key = "privatelink_azure_devices_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-azure-devices-provisioning-net-dns-link = {
    private_dns_zone_key = "privatelink_azure_devices_provisioning_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-azuredns-com-dns-link = {
    private_dns_zone_key = "privatelink_azuredns_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-azurehdinsight-net-dns-link = {
    private_dns_zone_key = "privatelink_azurehdinsight_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-azurekusto-windows-net-dns-link = {
    private_dns_zone_key = "privatelink_azurekusto_windows_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-azureml-ms-dns-link = {
    private_dns_zone_key = "privatelink_azureml_ms"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-azure-staticapps-net-dns-link = {
    private_dns_zone_key = "privatelink_azure_staticapps_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-azuresynapse-net-dns-link = {
    private_dns_zone_key = "privatelink_azuresynapse_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-azurewebsites-net-dns-link = {
    private_dns_zone_key = "privatelink_azurewebsites_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-batch-azure-com-dns-link = {
    private_dns_zone_key = "privatelink_batch_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-blob-core-windows-net-dns-link = {
    private_dns_zone_key = "privatelink_blob_core_windows_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-cassandra-cosmos-azure-com-dns-link = {
    private_dns_zone_key = "privatelink_cassandra_cosmos_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-cognitiveservices-azure-com-dns-link = {
    private_dns_zone_key = "privatelink_cognitiveservices_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-communication-azure-com-dns-link = {
    private_dns_zone_key = "privatelink_communication_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-database-windows-net-dns-link = {
    private_dns_zone_key = "privatelink_database_windows_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-datafactory-azure-net-dns-link = {
    private_dns_zone_key = "privatelink_datafactory_azure_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-dev-azuresynapse-net-dns-link = {
    private_dns_zone_key = "privatelink_dev_azuresynapse_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-dfs-core-windows-net-dns-link = {
    private_dns_zone_key = "privatelink_dfs_core_windows_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-dicom-azurehealthcareapis-com-dns-link = {
    private_dns_zone_key = "privatelink_dicom_azurehealthcareapis_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-digitaltwins-azure-net-dns-link = {
    private_dns_zone_key = "privatelink_digitaltwins_azure_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-directline-botframework-com-dns-link = {
    private_dns_zone_key = "privatelink_directline_botframework_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-documents-azure-com-dns-link = {
    private_dns_zone_key = "privatelink_documents_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-eventgrid-azure-net-dns-link = {
    private_dns_zone_key = "privatelink_eventgrid_azure_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-eventhubs-servicebus-windows-net-dns-link = {
    private_dns_zone_key = "privatelink_eventhubs_servicebus_windows_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-fabric-microsoft-com-dns-link = {
    private_dns_zone_key = "privatelink_fabric_microsoft_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-fhir-azurehealthcareapis-com-dns-link = {
    private_dns_zone_key = "privatelink_fhir_azurehealthcareapis_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-file-core-windows-net-dns-link = {
    private_dns_zone_key = "privatelink_file_core_windows_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-fluidrelay-azure-com-dns-link = {
    private_dns_zone_key = "privatelink_fluidrelay_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-grafana-azure-com-dns-link = {
    private_dns_zone_key = "privatelink_grafana_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-gremlin-cosmos-azure-com-dns-link = {
    private_dns_zone_key = "privatelink_gremlin_cosmos_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-guestconfiguration-azure-com-dns-link = {
    private_dns_zone_key = "privatelink_guestconfiguration_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-his-arc-azure-com-dns-link = {
    private_dns_zone_key = "privatelink_his_arc_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-iothub-net-dns-link = {
    private_dns_zone_key = "privatelink_iothub_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-keyvault-azure-net-dns-link = {
    private_dns_zone_key = "privatelink_keyvault_azure_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-kubernetesconfiguration-azure-com-dns-link = {
    private_dns_zone_key = "privatelink_kubernetesconfiguration_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-managedhsm-azure-net-dns-link = {
    private_dns_zone_key = "privatelink_managedhsm_azure_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-mariadb-database-azure-com-dns-link = {
    private_dns_zone_key = "privatelink_mariadb_database_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-media-azure-net-dns-link = {
    private_dns_zone_key = "privatelink_media_azure_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-migr-his-arc-azure-com-dns-link = {
    private_dns_zone_key = "privatelink_migr_his_arc_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-mongo-cosmos-azure-com-dns-link = {
    private_dns_zone_key = "privatelink_mongo_cosmos_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-monitor-azure-com-dns-link = {
    private_dns_zone_key = "privatelink_monitor_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-mysql-database-azure-com-dns-link = {
    private_dns_zone_key = "privatelink_mysql_database_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-notebooks-azure-net-dns-link = {
    private_dns_zone_key = "privatelink_notebooks_azure_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-ods-opinsights-azure-com-dns-link = {
    private_dns_zone_key = "privatelink_ods_opinsights_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-oms-opinsights-azure-com-dns-link = {
    private_dns_zone_key = "privatelink_oms_opinsights_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-openai-azure-com-dns-link = {
    private_dns_zone_key = "privatelink_openai_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-openpolicyagent-azure-com-dns-link = {
    private_dns_zone_key = "privatelink_openpolicyagent_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-pbidedicated-windows-net-dns-link = {
    private_dns_zone_key = "privatelink_pbidedicated_windows_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-postgres-database-azure-com-dns-link = {
    private_dns_zone_key = "privatelink_postgres_database_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-prod-powerquery-microsoft-com-dns-link = {
    private_dns_zone_key = "privatelink_prod_powerquery_microsoft_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-purview-azure-com-dns-link = {
    private_dns_zone_key = "privatelink_purview_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-purviewstudio-azure-com-dns-link = {
    private_dns_zone_key = "privatelink_purviewstudio_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-queue-core-windows-net-dns-link = {
    private_dns_zone_key = "privatelink_queue_core_windows_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-redis-cache-windows-net-dns-link = {
    private_dns_zone_key = "privatelink_redis_cache_windows_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-redisenterprise-cache-azure-net-dns-link = {
    private_dns_zone_key = "privatelink_redisenterprise_cache_azure_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-search-windows-net-dns-link = {
    private_dns_zone_key = "privatelink_search_windows_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-servicebus-azure-net-dns-link = {
    private_dns_zone_key = "privatelink_servicebus_azure_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-servicebus-windows-net-dns-link = {
    private_dns_zone_key = "privatelink_servicebus_windows_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-services-ai-azure-com-dns-link = {
    private_dns_zone_key = "privatelink_services_ai_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-signalr-net-dns-link = {
    private_dns_zone_key = "privatelink_signalr_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-siterecovery-windowsazure-com-dns-link = {
    private_dns_zone_key = "privatelink_siterecovery_windowsazure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-sql-azuresynapse-net-dns-link = {
    private_dns_zone_key = "privatelink_sql_azuresynapse_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-table-core-windows-net-dns-link = {
    private_dns_zone_key = "privatelink_table_core_windows_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-table-cosmos-azure-com-dns-link = {
    private_dns_zone_key = "privatelink_table_cosmos_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-vaultcore-azure-net-dns-link = {
    private_dns_zone_key = "privatelink_vaultcore_azure_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-web-core-windows-net-dns-link = {
    private_dns_zone_key = "privatelink_web_core_windows_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  privatelink-webpubsub-azure-com-dns-link = {
    private_dns_zone_key = "privatelink_webpubsub_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
}