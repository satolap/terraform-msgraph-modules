# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accountType"                = var.account_type
    "createdDateTime"            = var.created_date_time
    "effectivePolicyAssignments" = (var.effective_policy_assignments == null ? null : [for item0 in var.effective_policy_assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "policyAssignment" = (item0["policyAssignment"] == null ? null : { for key2, value2 in { "@odata.type" = item0["policyAssignment"]["odata_type"], "assignmentType" = item0["policyAssignment"]["assignmentType"], "displayName" = item0["policyAssignment"]["displayName"], "groupId" = item0["policyAssignment"]["groupId"], "policyId" = item0["policyAssignment"]["policyId"] } : key2 => value2 if value2 != null }), "policyType" = item0["policyType"] } : key1 => value1 if value1 != null }) if item0 != null])
    "featureTypes"               = (var.feature_types == null ? null : [for item0 in var.feature_types : item0 if item0 != null])
    "isEnterpriseVoiceEnabled"   = var.is_enterprise_voice_enabled
    "modifiedDateTime"           = var.modified_date_time
    "@odata.type"                = var.odata_type
    "telephoneNumbers"           = (var.telephone_numbers == null ? null : [for item0 in var.telephone_numbers : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "assignmentCategory" = item0["assignmentCategory"], "telephoneNumber" = item0["telephoneNumber"] } : key1 => value1 if value1 != null }) if item0 != null])
    "tenantId"                   = var.tenant_id
    "user"                       = var.user
    "userPrincipalName"          = var.user_principal_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "admin/teams/userConfigurations"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
