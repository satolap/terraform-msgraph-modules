# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignments"          = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdDateTime"      = var.created_date_time
    "description"          = var.description
    "displayName"          = var.display_name
    "errorCode"            = var.error_code
    "guidedDeploymentTags" = (var.guided_deployment_tags == null ? null : [for item0 in var.guided_deployment_tags : item0 if item0 != null])
    "items"                = (var.items == null ? null : [for item0 in var.items : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdDateTime" = item0["createdDateTime"], "displayName" = item0["displayName"], "errorCode" = item0["errorCode"], "guidedDeploymentTags" = (item0["guidedDeploymentTags"] == null ? null : [for item2 in item0["guidedDeploymentTags"] : item2 if item2 != null]), "itemType" = item0["itemType"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "payloadId" = item0["payloadId"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "lastModifiedDateTime" = var.last_modified_date_time
    "@odata.type"          = var.odata_type
    "roleScopeTags"        = (var.role_scope_tags == null ? null : [for item0 in var.role_scope_tags : item0 if item0 != null])
    "status"               = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/policySets"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
