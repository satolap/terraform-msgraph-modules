# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activityDateTime"    = var.activity_date_time
    "activityDisplayName" = var.activity_display_name
    "additionalDetails"   = (var.additional_details == null ? null : [for item0 in var.additional_details : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "key" = item0["key"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "category"            = var.category
    "correlationId"       = var.correlation_id
    "initiatedBy"         = (var.initiated_by == null ? null : { for key0, value0 in { "@odata.type" = var.initiated_by["odata_type"], "app" = (var.initiated_by["app"] == null ? null : { for key1, value1 in { "@odata.type" = var.initiated_by["app"]["odata_type"], "appId" = var.initiated_by["app"]["appId"], "displayName" = var.initiated_by["app"]["displayName"], "servicePrincipalId" = var.initiated_by["app"]["servicePrincipalId"], "servicePrincipalName" = var.initiated_by["app"]["servicePrincipalName"] } : key1 => value1 if value1 != null }), "linkableIdentifiers" = (var.initiated_by["linkableIdentifiers"] == null ? null : { for key1, value1 in { "@odata.type" = var.initiated_by["linkableIdentifiers"]["odata_type"], "deviceId" = var.initiated_by["linkableIdentifiers"]["deviceId"], "sessionId" = var.initiated_by["linkableIdentifiers"]["sessionId"], "tokenDetails" = (var.initiated_by["linkableIdentifiers"]["tokenDetails"] == null ? null : { for key2, value2 in { "@odata.type" = var.initiated_by["linkableIdentifiers"]["tokenDetails"]["odata_type"], "issuedAtDateTime" = var.initiated_by["linkableIdentifiers"]["tokenDetails"]["issuedAtDateTime"], "uniqueTokenIdentifier" = var.initiated_by["linkableIdentifiers"]["tokenDetails"]["uniqueTokenIdentifier"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }), "user" = (var.initiated_by["user"] == null ? null : { for key1, value1 in { "@odata.type" = var.initiated_by["user"]["odata_type"], "displayName" = var.initiated_by["user"]["displayName"], "homeTenantId" = var.initiated_by["user"]["homeTenantId"], "homeTenantName" = var.initiated_by["user"]["homeTenantName"], "id" = var.initiated_by["user"]["id"], "ipAddress" = var.initiated_by["user"]["ipAddress"], "userPrincipalName" = var.initiated_by["user"]["userPrincipalName"] } : key1 => value1 if value1 != null }) } : key0 => value0 if value0 != null })
    "loggedByService"     = var.logged_by_service
    "@odata.type"         = var.odata_type
    "operationType"       = var.operation_type
    "result"              = var.result
    "resultReason"        = var.result_reason
    "targetResources"     = (var.target_resources == null ? null : [for item0 in var.target_resources : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "groupType" = item0["groupType"], "id" = item0["id"], "modifiedProperties" = (item0["modifiedProperties"] == null ? null : [for item2 in item0["modifiedProperties"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "displayName" = item2["displayName"], "newValue" = item2["newValue"], "oldValue" = item2["oldValue"] } : key3 => value3 if value3 != null }) if item2 != null]), "type" = item0["type"], "userPrincipalName" = item0["userPrincipalName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "userAgent"           = var.user_agent
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "auditLogs/customSecurityAttributeAudits"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
