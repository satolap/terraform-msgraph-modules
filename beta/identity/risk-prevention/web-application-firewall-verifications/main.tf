# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "provider"           = var.graph_provider
    "@odata.type"        = var.odata_type
    "providerType"       = var.provider_type
    "verificationResult" = (var.verification_result == null ? null : { for key0, value0 in { "@odata.type" = var.verification_result["odata_type"], "errors" = (var.verification_result["errors"] == null ? null : [for item1 in var.verification_result["errors"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "code" = item1["code"], "message" = item1["message"] } : key2 => value2 if value2 != null }) if item1 != null]), "status" = var.verification_result["status"], "verifiedOnDateTime" = var.verification_result["verifiedOnDateTime"], "warnings" = (var.verification_result["warnings"] == null ? null : [for item1 in var.verification_result["warnings"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "code" = item1["code"], "message" = item1["message"] } : key2 => value2 if value2 != null }) if item1 != null]) } : key0 => value0 if value0 != null })
    "verifiedDetails"    = var.verified_details
    "verifiedHost"       = var.verified_host
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identity/riskPrevention/webApplicationFirewallVerifications"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
