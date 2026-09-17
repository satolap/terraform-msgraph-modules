# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appliesTo"       = (var.applies_to == null ? null : [for item0 in var.applies_to : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "deletedDateTime" = item0["deletedDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "deletedDateTime" = var.deleted_date_time
    "description"     = var.description
    "displayName"     = var.display_name
    "isEnabled"       = var.is_enabled
    "@odata.type"     = var.odata_type
    "restrictions"    = var.restrictions
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "policies/appManagementPolicies"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
