# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "expiryTime"       = var.expiry_time
    "invitationDomain" = var.invitation_domain
    "invitationStatus" = var.invitation_status
    "@odata.type"      = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "domains/${urlencode(var.domain_id)}/sharedEmailDomainInvitations"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
