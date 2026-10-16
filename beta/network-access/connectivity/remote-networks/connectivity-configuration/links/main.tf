# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "displayName"         = var.display_name
    "localConfigurations" = (var.local_configurations == null ? null : [for item0 in var.local_configurations : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "asn" = item0["asn"], "bgpAddress" = item0["bgpAddress"], "endpoint" = item0["endpoint"], "region" = item0["region"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"         = var.odata_type
    "peerConfiguration"   = (var.peer_configuration == null ? null : { for key0, value0 in { "@odata.type" = var.peer_configuration["odata_type"], "asn" = var.peer_configuration["asn"], "bgpAddress" = var.peer_configuration["bgpAddress"], "endpoint" = var.peer_configuration["endpoint"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "networkAccess/connectivity/remoteNetworks/${urlencode(var.remote_network_id)}/connectivityConfiguration/links"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
