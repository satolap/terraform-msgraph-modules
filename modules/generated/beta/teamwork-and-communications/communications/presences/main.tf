# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activity"            = var.activity
    "availability"        = var.availability
    "@odata.type"         = var.odata_type
    "outOfOfficeSettings" = var.out_of_office_settings
    "statusMessage"       = var.status_message
    "workLocation"        = var.work_location
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "communications/presences"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
