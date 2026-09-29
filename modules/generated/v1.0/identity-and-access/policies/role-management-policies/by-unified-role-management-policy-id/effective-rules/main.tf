# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "@odata.type" = var.odata_type
    "target"      = (var.target == null ? null : { for key0, value0 in { "@odata.type" = var.target["odata_type"], "caller" = var.target["caller"], "enforcedSettings" = (var.target["enforcedSettings"] == null ? null : [for item1 in var.target["enforcedSettings"] : item1 if item1 != null]), "inheritableSettings" = (var.target["inheritableSettings"] == null ? null : [for item1 in var.target["inheritableSettings"] : item1 if item1 != null]), "level" = var.target["level"], "operations" = (var.target["operations"] == null ? null : [for item1 in var.target["operations"] : item1 if item1 != null]), "targetObjects" = (var.target["targetObjects"] == null ? null : [for item1 in var.target["targetObjects"] : item1 if item1 != null]) } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "policies/roleManagementPolicies/${urlencode(var.unified_role_management_policy_id)}/effectiveRules"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
