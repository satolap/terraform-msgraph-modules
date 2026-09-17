# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "deferralInDays"          = var.deferral_in_days
    "description"             = var.description
    "displayName"             = var.display_name
    "excludedGroupAssignment" = (var.excluded_group_assignment == null ? null : { for key0, value0 in { "@odata.type" = var.excluded_group_assignment["odata_type"], "assignments" = (var.excluded_group_assignment["assignments"] == null ? null : [for item1 in var.excluded_group_assignment["assignments"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "group" = item1["group"] } : key2 => value2 if value2 != null }) if item1 != null]) } : key0 => value0 if value0 != null })
    "includedGroupAssignment" = (var.included_group_assignment == null ? null : { for key0, value0 in { "@odata.type" = var.included_group_assignment["odata_type"], "assignments" = (var.included_group_assignment["assignments"] == null ? null : [for item1 in var.included_group_assignment["assignments"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "group" = item1["group"] } : key2 => value2 if value2 != null }) if item1 != null]) } : key0 => value0 if value0 != null })
    "isPaused"                = var.is_paused
    "@odata.type"             = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "admin/windows/updates/policies/${urlencode(var.policy_id)}/rings"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
