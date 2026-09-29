# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "description" = var.description
    "version"     = var.graph_version
    "name"        = var.name
    "@odata.type" = var.odata_type
    "policyRules" = (var.policy_rules == null ? null : [for item0 in var.policy_rules : item0 if item0 != null])
    "settings"    = var.settings
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "networkAccess/tlsInspectionPolicies"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
