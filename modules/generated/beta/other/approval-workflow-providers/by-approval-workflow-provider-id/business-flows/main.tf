# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "customData"       = var.custom_data
    "deDuplicationId"  = var.de_duplication_id
    "description"      = var.description
    "displayName"      = var.display_name
    "@odata.type"      = var.odata_type
    "policy"           = var.policy
    "policyTemplateId" = var.policy_template_id
    "recordVersion"    = var.record_version
    "schemaId"         = var.schema_id
    "settings"         = var.settings
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "approvalWorkflowProviders/${urlencode(var.approval_workflow_provider_id)}/businessFlows"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
