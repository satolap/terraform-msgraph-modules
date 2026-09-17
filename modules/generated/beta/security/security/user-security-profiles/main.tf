# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accounts"             = (var.accounts == null ? null : [for item0 in var.accounts : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "lastSeenDateTime" = item0["lastSeenDateTime"], "riskScore" = item0["riskScore"], "service" = item0["service"], "signinName" = item0["signinName"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "azureSubscriptionId"  = var.azure_subscription_id
    "azureTenantId"        = var.azure_tenant_id
    "createdDateTime"      = var.created_date_time
    "displayName"          = var.display_name
    "lastModifiedDateTime" = var.last_modified_date_time
    "@odata.type"          = var.odata_type
    "riskScore"            = var.risk_score
    "tags"                 = (var.tags == null ? null : [for item0 in var.tags : item0 if item0 != null])
    "userPrincipalName"    = var.user_principal_name
    "vendorInformation"    = var.vendor_information
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/userSecurityProfiles"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
