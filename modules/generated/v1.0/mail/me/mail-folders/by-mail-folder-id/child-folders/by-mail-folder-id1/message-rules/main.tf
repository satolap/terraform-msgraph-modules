# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "actions"     = var.actions
    "conditions"  = var.conditions
    "displayName" = var.display_name
    "exceptions"  = var.exceptions
    "isEnabled"   = var.is_enabled
    "@odata.type" = var.odata_type
    "sequence"    = var.sequence
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "me/mailFolders/${urlencode(var.mail_folder_id)}/childFolders/${urlencode(var.mail_folder_id1)}/messageRules"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
