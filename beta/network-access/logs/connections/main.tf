# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "agentVersion"                 = var.agent_version
    "applicationSnapshot"          = (var.application_snapshot == null ? null : { for key0, value0 in { "@odata.type" = var.application_snapshot["odata_type"], "appId" = var.application_snapshot["appId"] } : key0 => value0 if value0 != null })
    "createdDateTime"              = var.created_date_time
    "crossTenantAccessType"        = var.cross_tenant_access_type
    "destinationFqdn"              = var.destination_fqdn
    "destinationIp"                = var.destination_ip
    "destinationPort"              = var.destination_port
    "deviceCategory"               = var.device_category
    "deviceId"                     = var.device_id
    "deviceJoinType"               = var.device_join_type
    "deviceOperatingSystem"        = var.device_operating_system
    "deviceOperatingSystemVersion" = var.device_operating_system_version
    "endDateTime"                  = var.end_date_time
    "homeTenantId"                 = var.home_tenant_id
    "initiatingProcessName"        = var.initiating_process_name
    "lastUpdateDateTime"           = var.last_update_date_time
    "networkProtocol"              = var.network_protocol
    "@odata.type"                  = var.odata_type
    "popProcessingRegion"          = var.pop_processing_region
    "privateAccessDetails"         = (var.private_access_details == null ? null : { for key0, value0 in { "@odata.type" = var.private_access_details["odata_type"], "accessType" = var.private_access_details["accessType"], "appSegmentId" = var.private_access_details["appSegmentId"], "connectionStatus" = var.private_access_details["connectionStatus"], "connectorId" = var.private_access_details["connectorId"], "connectorIp" = var.private_access_details["connectorIp"], "connectorName" = var.private_access_details["connectorName"], "processingRegion" = var.private_access_details["processingRegion"], "thirdPartyTokenDetails" = (var.private_access_details["thirdPartyTokenDetails"] == null ? null : { for key1, value1 in { "@odata.type" = var.private_access_details["thirdPartyTokenDetails"]["odata_type"], "expirationDateTime" = var.private_access_details["thirdPartyTokenDetails"]["expirationDateTime"], "issuedAtDateTime" = var.private_access_details["thirdPartyTokenDetails"]["issuedAtDateTime"], "uniqueTokenIdentifier" = var.private_access_details["thirdPartyTokenDetails"]["uniqueTokenIdentifier"], "validFromDateTime" = var.private_access_details["thirdPartyTokenDetails"]["validFromDateTime"] } : key1 => value1 if value1 != null }) } : key0 => value0 if value0 != null })
    "receivedBytes"                = var.received_bytes
    "sentBytes"                    = var.sent_bytes
    "sourceIp"                     = var.source_ip
    "sourcePort"                   = var.source_port
    "status"                       = var.status
    "tenantId"                     = var.tenant_id
    "trafficType"                  = var.traffic_type
    "transactionBlockCount"        = var.transaction_block_count
    "transactionCount"             = var.transaction_count
    "transportProtocol"            = var.transport_protocol
    "userId"                       = var.user_id
    "userPrincipalName"            = var.user_principal_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "networkAccess/logs/connections"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
