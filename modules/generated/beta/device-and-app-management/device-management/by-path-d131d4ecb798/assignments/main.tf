# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "intent"      = var.intent
    "@odata.type" = var.odata_type
    "sourceId"    = var.source_id
    "target"      = (var.target == null ? null : { for key0, value0 in { "@odata.type" = var.target["odata_type"], "deviceAndAppManagementAssignmentFilterId" = var.target["deviceAndAppManagementAssignmentFilterId"], "deviceAndAppManagementAssignmentFilterType" = var.target["deviceAndAppManagementAssignmentFilterType"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/resourceAccessProfiles/${urlencode(var.device_management_resource_access_profile_base_id)}/assignments"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
