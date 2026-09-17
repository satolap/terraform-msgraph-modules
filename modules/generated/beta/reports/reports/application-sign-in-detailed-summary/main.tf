# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "aggregatedEventDateTime" = var.aggregated_event_date_time
    "appDisplayName"          = var.app_display_name
    "appId"                   = var.app_id
    "@odata.type"             = var.odata_type
    "signInCount"             = var.sign_in_count
    "status"                  = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "reports/applicationSignInDetailedSummary"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
