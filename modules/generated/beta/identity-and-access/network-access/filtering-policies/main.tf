# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "action"               = var.action
    "createdDateTime"      = var.created_date_time
    "description"          = var.description
    "version"              = var.graph_version
    "lastModifiedDateTime" = var.last_modified_date_time
    "name"                 = var.name
    "@odata.type"          = var.odata_type
    "policyRules"          = (var.policy_rules == null ? null : [for item0 in var.policy_rules : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "name" = item0["name"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "networkAccess/filteringPolicies"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
