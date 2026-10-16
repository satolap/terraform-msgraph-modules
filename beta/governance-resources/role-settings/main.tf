# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "adminEligibleSettings" = (var.admin_eligible_settings == null ? null : [for item0 in var.admin_eligible_settings : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "ruleIdentifier" = item0["ruleIdentifier"], "setting" = item0["setting"] } : key1 => value1 if value1 != null }) if item0 != null])
    "adminMemberSettings"   = (var.admin_member_settings == null ? null : [for item0 in var.admin_member_settings : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "ruleIdentifier" = item0["ruleIdentifier"], "setting" = item0["setting"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"           = var.odata_type
    "resourceId"            = var.resource_id
    "roleDefinitionId"      = var.role_definition_id
    "userEligibleSettings"  = (var.user_eligible_settings == null ? null : [for item0 in var.user_eligible_settings : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "ruleIdentifier" = item0["ruleIdentifier"], "setting" = item0["setting"] } : key1 => value1 if value1 != null }) if item0 != null])
    "userMemberSettings"    = (var.user_member_settings == null ? null : [for item0 in var.user_member_settings : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "ruleIdentifier" = item0["ruleIdentifier"], "setting" = item0["setting"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "governanceResources/${urlencode(var.governance_resource_id)}/roleSettings"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
