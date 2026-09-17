# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdDateTime" = var.created_date_time
    "isRevoked"       = var.is_revoked
    "@odata.type"     = var.odata_type
    "revokedDateTime" = var.revoked_date_time
    "updatePolicy"    = var.update_policy
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "admin/windows/updates/updatePolicies/${urlencode(var.update_policy_id)}/complianceChanges"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
