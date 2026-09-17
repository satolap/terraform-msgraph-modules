# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "audience"              = var.audience
    "complianceChangeRules" = (var.compliance_change_rules == null ? null : [for item0 in var.compliance_change_rules : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdDateTime" = item0["createdDateTime"], "lastEvaluatedDateTime" = item0["lastEvaluatedDateTime"], "lastModifiedDateTime" = item0["lastModifiedDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "complianceChanges"     = (var.compliance_changes == null ? null : [for item0 in var.compliance_changes : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "createdDateTime" = item0["createdDateTime"], "isRevoked" = item0["isRevoked"], "revokedDateTime" = item0["revokedDateTime"], "updatePolicy" = item0["updatePolicy"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdDateTime"       = var.created_date_time
    "deploymentSettings"    = var.deployment_settings
    "@odata.type"           = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "admin/windows/updates/updatePolicies"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
