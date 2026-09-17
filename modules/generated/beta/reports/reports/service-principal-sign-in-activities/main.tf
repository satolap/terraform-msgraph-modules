# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appId"                                           = var.app_id
    "applicationAuthenticationClientSignInActivity"   = var.application_authentication_client_sign_in_activity
    "applicationAuthenticationResourceSignInActivity" = var.application_authentication_resource_sign_in_activity
    "delegatedClientSignInActivity"                   = var.delegated_client_sign_in_activity
    "delegatedResourceSignInActivity"                 = var.delegated_resource_sign_in_activity
    "lastSignInActivity"                              = var.last_sign_in_activity
    "@odata.type"                                     = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "reports/servicePrincipalSignInActivities"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
