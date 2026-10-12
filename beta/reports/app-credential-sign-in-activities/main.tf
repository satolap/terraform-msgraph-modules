# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appId"                    = var.app_id
    "appObjectId"              = var.app_object_id
    "createdDateTime"          = var.created_date_time
    "credentialOrigin"         = var.credential_origin
    "expirationDateTime"       = var.expiration_date_time
    "keyId"                    = var.key_id
    "keyType"                  = var.key_type
    "keyUsage"                 = var.key_usage
    "@odata.type"              = var.odata_type
    "resourceId"               = var.resource_id
    "servicePrincipalObjectId" = var.service_principal_object_id
    "signInActivity"           = (var.sign_in_activity == null ? null : { for key0, value0 in { "@odata.type" = var.sign_in_activity["odata_type"], "lastNonInteractiveSignInDateTime" = var.sign_in_activity["lastNonInteractiveSignInDateTime"], "lastNonInteractiveSignInRequestId" = var.sign_in_activity["lastNonInteractiveSignInRequestId"], "lastSignInDateTime" = var.sign_in_activity["lastSignInDateTime"], "lastSignInRequestId" = var.sign_in_activity["lastSignInRequestId"], "lastSuccessfulSignInDateTime" = var.sign_in_activity["lastSuccessfulSignInDateTime"], "lastSuccessfulSignInRequestId" = var.sign_in_activity["lastSuccessfulSignInRequestId"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "reports/appCredentialSignInActivities"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
