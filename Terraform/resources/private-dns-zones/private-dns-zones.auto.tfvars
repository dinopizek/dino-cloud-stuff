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
  pdnslink1 = {
    private_dns_zone_key = "eastus2_data_privatelink_azurecr_io"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink2 = {
    private_dns_zone_key = "privatelink_eastus2_azmk8s_io"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink3 = {
    private_dns_zone_key = "privatelink_eastus2_azurecontainerapps_io"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink4 = {
    private_dns_zone_key = "privatelink_eastus2_kusto_windows_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink5 = {
    private_dns_zone_key = "privatelink_adf_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink6 = {
    private_dns_zone_key = "privatelink_afs_azure_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink7 = {
    private_dns_zone_key = "privatelink_agentsvc_azure_automation_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink8 = {
    private_dns_zone_key = "privatelink_analysis_windows_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink9 = {
    private_dns_zone_key = "privatelink_api_azureml_ms"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink10 = {
    private_dns_zone_key = "privatelink_appconfig_io"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink11 = {
    private_dns_zone_key = "privatelink_arc_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink12 = {
    private_dns_zone_key = "privatelink_attest_azure_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink13 = {
    private_dns_zone_key = "privatelink_autoheal_trafficmanager_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink14 = {
    private_dns_zone_key = "privatelink_automation_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink15 = {
    private_dns_zone_key = "privatelink_azconfig_io"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink16 = {
    private_dns_zone_key = "privatelink_azure_api_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink17 = {
    private_dns_zone_key = "privatelink_azure_automation_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink18 = {
    private_dns_zone_key = "privatelink_azurecr_io"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink19 = {
    private_dns_zone_key = "privatelink_azuredatabricks_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink20 = {
    private_dns_zone_key = "privatelink_azure_devices_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink21 = {
    private_dns_zone_key = "privatelink_azure_devices_provisioning_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink22 = {
    private_dns_zone_key = "privatelink_azuredns_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink23 = {
    private_dns_zone_key = "privatelink_azurehdinsight_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink24 = {
    private_dns_zone_key = "privatelink_azurekusto_windows_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink25 = {
    private_dns_zone_key = "privatelink_azureml_ms"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink26 = {
    private_dns_zone_key = "privatelink_azure_staticapps_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink27 = {
    private_dns_zone_key = "privatelink_azuresynapse_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink28 = {
    private_dns_zone_key = "privatelink_azurewebsites_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink29 = {
    private_dns_zone_key = "privatelink_batch_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink30 = {
    private_dns_zone_key = "privatelink_blob_core_windows_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink31 = {
    private_dns_zone_key = "privatelink_cassandra_cosmos_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink32 = {
    private_dns_zone_key = "privatelink_cognitiveservices_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink33 = {
    private_dns_zone_key = "privatelink_communication_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink34 = {
    private_dns_zone_key = "privatelink_database_windows_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink35 = {
    private_dns_zone_key = "privatelink_datafactory_azure_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink36 = {
    private_dns_zone_key = "privatelink_dev_azuresynapse_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink37 = {
    private_dns_zone_key = "privatelink_dfs_core_windows_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink38 = {
    private_dns_zone_key = "privatelink_dicom_azurehealthcareapis_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink39 = {
    private_dns_zone_key = "privatelink_digitaltwins_azure_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink40 = {
    private_dns_zone_key = "privatelink_directline_botframework_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink41 = {
    private_dns_zone_key = "privatelink_documents_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink42 = {
    private_dns_zone_key = "privatelink_eventgrid_azure_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink43 = {
    private_dns_zone_key = "privatelink_eventhubs_servicebus_windows_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink44 = {
    private_dns_zone_key = "privatelink_fabric_microsoft_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink45 = {
    private_dns_zone_key = "privatelink_fhir_azurehealthcareapis_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink46 = {
    private_dns_zone_key = "privatelink_file_core_windows_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink47 = {
    private_dns_zone_key = "privatelink_fluidrelay_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink48 = {
    private_dns_zone_key = "privatelink_grafana_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink49 = {
    private_dns_zone_key = "privatelink_gremlin_cosmos_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink50 = {
    private_dns_zone_key = "privatelink_guestconfiguration_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink51 = {
    private_dns_zone_key = "privatelink_his_arc_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink52 = {
    private_dns_zone_key = "privatelink_iothub_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink53 = {
    private_dns_zone_key = "privatelink_keyvault_azure_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink54 = {
    private_dns_zone_key = "privatelink_kubernetesconfiguration_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink55 = {
    private_dns_zone_key = "privatelink_managedhsm_azure_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink56 = {
    private_dns_zone_key = "privatelink_mariadb_database_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink57 = {
    private_dns_zone_key = "privatelink_media_azure_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink58 = {
    private_dns_zone_key = "privatelink_migr_his_arc_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink59 = {
    private_dns_zone_key = "privatelink_mongo_cosmos_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink60 = {
    private_dns_zone_key = "privatelink_monitor_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink61 = {
    private_dns_zone_key = "privatelink_mysql_database_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink62 = {
    private_dns_zone_key = "privatelink_notebooks_azure_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink63 = {
    private_dns_zone_key = "privatelink_ods_opinsights_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink64 = {
    private_dns_zone_key = "privatelink_oms_opinsights_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink65 = {
    private_dns_zone_key = "privatelink_openai_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink66 = {
    private_dns_zone_key = "privatelink_openpolicyagent_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink67 = {
    private_dns_zone_key = "privatelink_pbidedicated_windows_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink68 = {
    private_dns_zone_key = "privatelink_postgres_database_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink69 = {
    private_dns_zone_key = "privatelink_prod_powerquery_microsoft_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink70 = {
    private_dns_zone_key = "privatelink_purview_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink71 = {
    private_dns_zone_key = "privatelink_purviewstudio_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink72 = {
    private_dns_zone_key = "privatelink_queue_core_windows_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink73 = {
    private_dns_zone_key = "privatelink_redis_cache_windows_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink74 = {
    private_dns_zone_key = "privatelink_redisenterprise_cache_azure_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink75 = {
    private_dns_zone_key = "privatelink_search_windows_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink76 = {
    private_dns_zone_key = "privatelink_servicebus_azure_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink77 = {
    private_dns_zone_key = "privatelink_servicebus_windows_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink78 = {
    private_dns_zone_key = "privatelink_services_ai_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink79 = {
    private_dns_zone_key = "privatelink_signalr_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink80 = {
    private_dns_zone_key = "privatelink_siterecovery_windowsazure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink81 = {
    private_dns_zone_key = "privatelink_sql_azuresynapse_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink82 = {
    private_dns_zone_key = "privatelink_table_core_windows_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink83 = {
    private_dns_zone_key = "privatelink_table_cosmos_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink84 = {
    private_dns_zone_key = "privatelink_vaultcore_azure_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink85 = {
    private_dns_zone_key = "privatelink_web_core_windows_net"
    virtual_network_key  = "vn-use2-identity-01"
  }
  pdnslink86 = {
    private_dns_zone_key = "privatelink_webpubsub_azure_com"
    virtual_network_key  = "vn-use2-identity-01"
  }
}