# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowedCombinations"       = (var.allowed_combinations == null ? null : [for item0 in var.allowed_combinations : item0 if item0 != null])
    "combinationConfigurations" = (var.combination_configurations == null ? null : [for item0 in var.combination_configurations : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "appliesToCombinations" = (item0["appliesToCombinations"] == null ? null : [for item2 in item0["appliesToCombinations"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "createdDateTime"           = var.created_date_time
    "description"               = var.description
    "displayName"               = var.display_name
    "modifiedDateTime"          = var.modified_date_time
    "@odata.type"               = var.odata_type
    "policyType"                = var.policy_type
    "requirementsSatisfied"     = var.requirements_satisfied
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identity/conditionalAccess/authenticationStrength/policies"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
