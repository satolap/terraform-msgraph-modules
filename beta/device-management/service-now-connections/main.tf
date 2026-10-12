# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "authenticationMethod"       = var.authentication_method
    "createdDateTime"            = var.created_date_time
    "incidentApiUrl"             = var.incident_api_url
    "instanceUrl"                = var.instance_url
    "lastModifiedDateTime"       = var.last_modified_date_time
    "lastQueriedDateTime"        = var.last_queried_date_time
    "@odata.type"                = var.odata_type
    "serviceNowConnectionStatus" = var.service_now_connection_status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/serviceNowConnections"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
