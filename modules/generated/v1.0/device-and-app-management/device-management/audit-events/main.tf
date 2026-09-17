# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activity"              = var.activity
    "activityDateTime"      = var.activity_date_time
    "activityOperationType" = var.activity_operation_type
    "activityResult"        = var.activity_result
    "activityType"          = var.activity_type
    "actor"                 = var.actor
    "category"              = var.category
    "componentName"         = var.component_name
    "correlationId"         = var.correlation_id
    "displayName"           = var.display_name
    "@odata.type"           = var.odata_type
    "resources"             = (var.resources == null ? null : [for item0 in var.resources : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "auditResourceType" = item0["auditResourceType"], "displayName" = item0["displayName"], "modifiedProperties" = (item0["modifiedProperties"] == null ? null : [for item2 in item0["modifiedProperties"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "displayName" = item2["displayName"], "newValue" = item2["newValue"], "oldValue" = item2["oldValue"] } : key3 => value3 if value3 != null }) if item2 != null]), "resourceId" = item0["resourceId"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/auditEvents"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
