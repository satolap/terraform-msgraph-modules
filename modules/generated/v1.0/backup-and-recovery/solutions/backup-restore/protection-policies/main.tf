# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdBy"                     = var.created_by
    "createdDateTime"               = var.created_date_time
    "displayName"                   = var.display_name
    "isEnabled"                     = var.is_enabled
    "lastModifiedBy"                = var.last_modified_by
    "lastModifiedDateTime"          = var.last_modified_date_time
    "@odata.type"                   = var.odata_type
    "protectionPolicyArtifactCount" = var.protection_policy_artifact_count
    "retentionSettings"             = (var.retention_settings == null ? null : [for item0 in var.retention_settings : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "interval" = item0["interval"], "period" = item0["period"] } : key1 => value1 if value1 != null }) if item0 != null])
    "status"                        = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "solutions/backupRestore/protectionPolicies"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
