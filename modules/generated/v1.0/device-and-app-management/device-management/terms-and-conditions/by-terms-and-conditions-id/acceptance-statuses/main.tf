# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "acceptedDateTime"   = var.accepted_date_time
    "acceptedVersion"    = var.accepted_version
    "@odata.type"        = var.odata_type
    "termsAndConditions" = var.terms_and_conditions
    "userDisplayName"    = var.user_display_name
    "userPrincipalName"  = var.user_principal_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/termsAndConditions/${urlencode(var.terms_and_conditions_id)}/acceptanceStatuses"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
