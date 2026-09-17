# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "description" = var.description
    "version"     = var.graph_version
    "name"        = var.name
    "@odata.type" = var.odata_type
    "policyRules" = (var.policy_rules == null ? null : [for item0 in var.policy_rules : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "name" = item0["name"] } : key1 => value1 if value1 != null }) if item0 != null])
    "settings"    = (var.settings == null ? null : { for key0, value0 in { "@odata.type" = var.settings["odata_type"], "defaultAction" = var.settings["defaultAction"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "networkAccess/cloudFirewallPolicies"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
