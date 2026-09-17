# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "version"     = var.graph_version
    "@odata.type" = var.odata_type
    "policy"      = (var.policy == null ? null : { for key0, value0 in { "@odata.type" = var.policy["odata_type"], "description" = var.policy["description"], "name" = var.policy["name"], "policyRules" = (var.policy["policyRules"] == null ? null : [for item1 in var.policy["policyRules"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "name" = item1["name"] } : key2 => value2 if value2 != null }) if item1 != null]), "version" = var.policy["version"] } : key0 => value0 if value0 != null })
    "state"       = var.state
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "networkAccess/filteringProfiles/${urlencode(var.filtering_profile_id)}/policies"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
