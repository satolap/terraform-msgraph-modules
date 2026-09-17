# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "bgpRoutesAdvertisedCount" = var.bgp_routes_advertised_count
    "createdDateTime"          = var.created_date_time
    "description"              = var.description
    "destinationIp"            = var.destination_ip
    "@odata.type"              = var.odata_type
    "receivedBytes"            = var.received_bytes
    "remoteNetworkId"          = var.remote_network_id
    "sentBytes"                = var.sent_bytes
    "sourceIp"                 = var.source_ip
    "status"                   = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "networkAccess/logs/remoteNetworks"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
