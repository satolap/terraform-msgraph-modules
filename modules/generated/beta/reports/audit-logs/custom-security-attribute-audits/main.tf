# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activityDateTime"    = var.activity_date_time
    "activityDisplayName" = var.activity_display_name
    "additionalDetails"   = (var.additional_details == null ? null : [for item0 in var.additional_details : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "key" = item0["key"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "category"            = var.category
    "correlationId"       = var.correlation_id
    "initiatedBy"         = (var.initiated_by == null ? null : { for key0, value0 in { "@odata.type" = var.initiated_by["odata_type"], "app" = var.initiated_by["app"], "linkableIdentifiers" = var.initiated_by["linkableIdentifiers"], "user" = var.initiated_by["user"] } : key0 => value0 if value0 != null })
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
