# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "displayName"       = var.display_name
    "filter"            = var.filter
    "@odata.type"       = var.odata_type
    "provisioningFlows" = (var.provisioning_flows == null ? null : [for item0 in var.provisioning_flows : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "external/industryData/outboundProvisioningFlowSets"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
