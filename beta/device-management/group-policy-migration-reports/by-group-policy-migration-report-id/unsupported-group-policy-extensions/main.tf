# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "extensionType" = var.extension_type
    "namespaceUrl"  = var.namespace_url
    "nodeName"      = var.node_name
    "@odata.type"   = var.odata_type
    "settingScope"  = var.setting_scope
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/groupPolicyMigrationReports/${urlencode(var.group_policy_migration_report_id)}/unsupportedGroupPolicyExtensions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
