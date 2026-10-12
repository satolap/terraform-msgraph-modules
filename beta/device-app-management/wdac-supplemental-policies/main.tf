# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignments"          = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "content"              = var.content
    "contentFileName"      = var.content_file_name
    "creationDateTime"     = var.creation_date_time
    "deploySummary"        = var.deploy_summary
    "description"          = var.description
    "deviceStatuses"       = (var.device_statuses == null ? null : [for item0 in var.device_statuses : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "deploymentStatus" = item0["deploymentStatus"], "deviceId" = item0["deviceId"], "deviceName" = item0["deviceName"], "lastSyncDateTime" = item0["lastSyncDateTime"], "osDescription" = item0["osDescription"], "osVersion" = item0["osVersion"], "policy" = item0["policy"], "policyVersion" = item0["policyVersion"], "userName" = item0["userName"], "userPrincipalName" = item0["userPrincipalName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "displayName"          = var.display_name
    "version"              = var.graph_version
    "lastModifiedDateTime" = var.last_modified_date_time
    "@odata.type"          = var.odata_type
    "roleScopeTagIds"      = (var.role_scope_tag_ids == null ? null : [for item0 in var.role_scope_tag_ids : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/wdacSupplementalPolicies"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
