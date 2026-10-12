# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "connectorServerName"   = var.connector_server_name
    "exchangeAlias"         = var.exchange_alias
    "exchangeConnectorType" = var.exchange_connector_type
    "exchangeOrganization"  = var.exchange_organization
    "version"               = var.graph_version
    "lastSyncDateTime"      = var.last_sync_date_time
    "@odata.type"           = var.odata_type
    "primarySmtpAddress"    = var.primary_smtp_address
    "serverName"            = var.server_name
    "status"                = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/exchangeConnectors"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
