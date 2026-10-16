# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "configurationType"    = var.configuration_type
    "createdDateTime"      = var.created_date_time
    "definition"           = var.definition
    "enabled"              = var.enabled
    "lastModifiedDateTime" = var.last_modified_date_time
    "@odata.type"          = var.odata_type
    "presentationValues"   = (var.presentation_values == null ? null : [for item0 in var.presentation_values : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/groupPolicyConfigurations/${urlencode(var.group_policy_configuration_id)}/definitionValues"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
