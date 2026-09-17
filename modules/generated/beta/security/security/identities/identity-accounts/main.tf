# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accounts"                     = (var.accounts == null ? null : [for item0 in var.accounts : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "actions" = (item0["actions"] == null ? null : [for item2 in item0["actions"] : item2 if item2 != null]), "identifier" = item0["identifier"], "identityProvider" = item0["identityProvider"] } : key1 => value1 if value1 != null }) if item0 != null])
    "cloudSecurityIdentifier"      = var.cloud_security_identifier
    "displayName"                  = var.display_name
    "domain"                       = var.domain
    "isEnabled"                    = var.is_enabled
    "@odata.type"                  = var.odata_type
    "onPremisesSecurityIdentifier" = var.on_premises_security_identifier
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/identities/identityAccounts"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
