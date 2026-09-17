# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "controlId"       = var.control_id
    "controlTypeId"   = var.control_type_id
    "createdDateTime" = var.created_date_time
    "displayName"     = var.display_name
    "@odata.type"     = var.odata_type
    "owner"           = var.owner
    "program"         = var.program
    "programId"       = var.program_id
    "resource"        = var.resource
    "status"          = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "programControls/${urlencode(var.program_control_id)}/program/controls"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
