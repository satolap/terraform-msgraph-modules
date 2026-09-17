# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activity"              = var.activity
    "activityOperationType" = var.activity_operation_type
    "activityResult"        = var.activity_result
    "actor"                 = (var.actor == null ? null : { for key0, value0 in { "@odata.type" = var.actor["odata_type"], "applicationDisplayName" = var.actor["applicationDisplayName"], "applicationId" = var.actor["applicationId"], "ipAddress" = var.actor["ipAddress"], "remoteTenantId" = var.actor["remoteTenantId"], "remoteUserId" = var.actor["remoteUserId"], "servicePrincipalName" = var.actor["servicePrincipalName"], "type" = var.actor["type"], "userId" = var.actor["userId"], "userPermissions" = (var.actor["userPermissions"] == null ? null : [for item1 in var.actor["userPermissions"] : item1 if item1 != null]), "userPrincipalName" = var.actor["userPrincipalName"], "userRoleScopeTags" = (var.actor["userRoleScopeTags"] == null ? null : [for item1 in var.actor["userRoleScopeTags"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "displayName" = item1["displayName"], "roleScopeTagId" = item1["roleScopeTagId"] } : key2 => value2 if value2 != null }) if item1 != null]) } : key0 => value0 if value0 != null })
    "category"              = var.category
    "@odata.type"           = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/virtualEndpoint/auditEvents"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
