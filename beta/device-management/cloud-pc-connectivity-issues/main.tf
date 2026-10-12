# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "deviceId"          = var.device_id
    "errorCode"         = var.error_code
    "errorDateTime"     = var.error_date_time
    "errorDescription"  = var.error_description
    "@odata.type"       = var.odata_type
    "recommendedAction" = var.recommended_action
    "userId"            = var.user_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/cloudPCConnectivityIssues"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
