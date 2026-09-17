# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "provider"           = var.graph_provider
    "@odata.type"        = var.odata_type
    "providerType"       = var.provider_type
    "verificationResult" = var.verification_result
    "verifiedDetails"    = var.verified_details
    "verifiedHost"       = var.verified_host
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identity/riskPrevention/webApplicationFirewallVerifications"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
