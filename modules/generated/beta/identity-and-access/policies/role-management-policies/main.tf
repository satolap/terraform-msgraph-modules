# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "description"           = var.description
    "displayName"           = var.display_name
    "effectiveRules"        = (var.effective_rules == null ? null : [for item0 in var.effective_rules : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "isOrganizationDefault" = var.is_organization_default
    "lastModifiedBy"        = var.last_modified_by
    "lastModifiedDateTime"  = var.last_modified_date_time
    "@odata.type"           = var.odata_type
    "rules"                 = (var.rules == null ? null : [for item0 in var.rules : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "scopeId"               = var.scope_id
    "scopeType"             = var.scope_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "policies/roleManagementPolicies"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
