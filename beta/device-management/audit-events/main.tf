# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activity"              = var.activity
    "activityDateTime"      = var.activity_date_time
    "activityOperationType" = var.activity_operation_type
    "activityResult"        = var.activity_result
    "activityType"          = var.activity_type
    "actor"                 = (var.actor == null ? null : { for key0, value0 in { "@odata.type" = var.actor["odata_type"], "applicationDisplayName" = var.actor["applicationDisplayName"], "applicationId" = var.actor["applicationId"], "auditActorType" = var.actor["auditActorType"], "ipAddress" = var.actor["ipAddress"], "remoteTenantId" = var.actor["remoteTenantId"], "remoteUserId" = var.actor["remoteUserId"], "servicePrincipalName" = var.actor["servicePrincipalName"], "type" = var.actor["type"], "userId" = var.actor["userId"], "userPermissions" = (var.actor["userPermissions"] == null ? null : [for item1 in var.actor["userPermissions"] : item1 if item1 != null]), "userPrincipalName" = var.actor["userPrincipalName"], "userRoleScopeTags" = (var.actor["userRoleScopeTags"] == null ? null : [for item1 in var.actor["userRoleScopeTags"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "displayName" = item1["displayName"], "roleScopeTagId" = item1["roleScopeTagId"] } : key2 => value2 if value2 != null }) if item1 != null]) } : key0 => value0 if value0 != null })
    "category"              = var.category
    "componentName"         = var.component_name
    "correlationId"         = var.correlation_id
    "displayName"           = var.display_name
    "@odata.type"           = var.odata_type
    "resources"             = (var.resources == null ? null : [for item0 in var.resources : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "auditResourceType" = item0["auditResourceType"], "displayName" = item0["displayName"], "modifiedProperties" = (item0["modifiedProperties"] == null ? null : [for item2 in item0["modifiedProperties"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "displayName" = item2["displayName"], "newValue" = item2["newValue"], "oldValue" = item2["oldValue"] } : key3 => value3 if value3 != null }) if item2 != null]), "resourceId" = item0["resourceId"], "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/auditEvents"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
