# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignments"          = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "intent" = item0["intent"], "sourceId" = item0["sourceId"], "target" = (item0["target"] == null ? null : { for key2, value2 in { "@odata.type" = item0["target"]["odata_type"], "deviceAndAppManagementAssignmentFilterId" = item0["target"]["deviceAndAppManagementAssignmentFilterId"], "deviceAndAppManagementAssignmentFilterType" = item0["target"]["deviceAndAppManagementAssignmentFilterType"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }) if item0 != null])
    "creationDateTime"     = var.creation_date_time
    "description"          = var.description
    "displayName"          = var.display_name
    "version"              = var.graph_version
    "lastModifiedDateTime" = var.last_modified_date_time
    "@odata.type"          = var.odata_type
    "roleScopeTagIds"      = (var.role_scope_tag_ids == null ? null : [for item0 in var.role_scope_tag_ids : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/resourceAccessProfiles"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
