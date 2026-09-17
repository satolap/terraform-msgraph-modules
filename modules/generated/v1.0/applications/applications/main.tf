# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "displayName"                       = var.display_name
    "addIns"                            = (var.add_ins == null ? null : [for item0 in var.add_ins : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "id" = item0["id"], "properties" = (item0["properties"] == null ? null : [for item2 in item0["properties"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "key" = item2["key"], "value" = item2["value"] } : key3 => value3 if value3 != null }) if item2 != null]), "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "api"                               = var.api
    "appManagementPolicies"             = (var.app_management_policies == null ? null : [for item0 in var.app_management_policies : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "appliesTo" = (item0["appliesTo"] == null ? null : [for item2 in item0["appliesTo"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "deletedDateTime" = item2["deletedDateTime"] } : key3 => value3 if value3 != null }) if item2 != null]), "deletedDateTime" = item0["deletedDateTime"], "description" = item0["description"], "displayName" = item0["displayName"], "isEnabled" = item0["isEnabled"], "restrictions" = item0["restrictions"] } : key1 => value1 if value1 != null }) if item0 != null])
    "appRoles"                          = (var.app_roles == null ? null : [for item0 in var.app_roles : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "allowedMemberTypes" = (item0["allowedMemberTypes"] == null ? null : [for item2 in item0["allowedMemberTypes"] : item2 if item2 != null]), "description" = item0["description"], "displayName" = item0["displayName"], "id" = item0["id"], "isEnabled" = item0["isEnabled"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "authenticationBehaviors"           = var.authentication_behaviors
    "certification"                     = var.certification
    "defaultRedirectUri"                = var.default_redirect_uri
    "deletedDateTime"                   = var.deleted_date_time
    "description"                       = var.description
    "disabledByMicrosoftStatus"         = var.disabled_by_microsoft_status
    "federatedIdentityCredentials"      = (var.federated_identity_credentials == null ? null : [for item0 in var.federated_identity_credentials : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "audiences" = (item0["audiences"] == null ? null : [for item2 in item0["audiences"] : item2 if item2 != null]), "description" = item0["description"], "issuer" = item0["issuer"], "name" = item0["name"], "subject" = item0["subject"] } : key1 => value1 if value1 != null }) if item0 != null])
    "groupMembershipClaims"             = var.group_membership_claims
    "homeRealmDiscoveryPolicies"        = (var.home_realm_discovery_policies == null ? null : [for item0 in var.home_realm_discovery_policies : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "appliesTo" = (item0["appliesTo"] == null ? null : [for item2 in item0["appliesTo"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "deletedDateTime" = item2["deletedDateTime"] } : key3 => value3 if value3 != null }) if item2 != null]), "definition" = (item0["definition"] == null ? null : [for item2 in item0["definition"] : item2 if item2 != null]), "deletedDateTime" = item0["deletedDateTime"], "description" = item0["description"], "displayName" = item0["displayName"], "isOrganizationDefault" = item0["isOrganizationDefault"] } : key1 => value1 if value1 != null }) if item0 != null])
    "identifierUris"                    = (var.identifier_uris == null ? null : [for item0 in var.identifier_uris : item0 if item0 != null])
    "info"                              = var.info
    "isDeviceOnlyAuthSupported"         = var.is_device_only_auth_supported
    "isDisabled"                        = var.is_disabled
    "isFallbackPublicClient"            = var.is_fallback_public_client
    "keyCredentials"                    = (var.key_credentials == null ? null : [for item0 in var.key_credentials : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "customKeyIdentifier" = item0["customKeyIdentifier"], "displayName" = item0["displayName"], "endDateTime" = item0["endDateTime"], "key" = item0["key"], "keyId" = item0["keyId"], "startDateTime" = item0["startDateTime"], "type" = item0["type"], "usage" = item0["usage"] } : key1 => value1 if value1 != null }) if item0 != null])
    "logo"                              = var.logo
    "managerApplications"               = (var.manager_applications == null ? null : [for item0 in var.manager_applications : item0 if item0 != null])
    "nativeAuthenticationApisEnabled"   = var.native_authentication_apis_enabled
    "notes"                             = var.notes
    "oauth2RequirePostResponse"         = var.oauth2_require_post_response
    "@odata.type"                       = var.odata_type
    "optionalClaims"                    = var.optional_claims
    "owners"                            = (var.owners == null ? null : [for item0 in var.owners : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "deletedDateTime" = item0["deletedDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "parentalControlSettings"           = var.parental_control_settings
    "passwordCredentials"               = (var.password_credentials == null ? null : [for item0 in var.password_credentials : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "customKeyIdentifier" = item0["customKeyIdentifier"], "displayName" = item0["displayName"], "endDateTime" = item0["endDateTime"], "keyId" = item0["keyId"], "startDateTime" = item0["startDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "publicClient"                      = var.public_client
    "requestSignatureVerification"      = var.request_signature_verification
    "requiredResourceAccess"            = (var.required_resource_access == null ? null : [for item0 in var.required_resource_access : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "resourceAccess" = (item0["resourceAccess"] == null ? null : [for item2 in item0["resourceAccess"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "id" = item2["id"], "type" = item2["type"] } : key3 => value3 if value3 != null }) if item2 != null]), "resourceAppId" = item0["resourceAppId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "samlMetadataUrl"                   = var.saml_metadata_url
    "serviceManagementReference"        = var.service_management_reference
    "servicePrincipalLockConfiguration" = var.service_principal_lock_configuration
    "signInAudience"                    = var.sign_in_audience
    "spa"                               = var.spa
    "synchronization"                   = var.synchronization
    "tags"                              = (var.tags == null ? null : [for item0 in var.tags : item0 if item0 != null])
    "tokenEncryptionKeyId"              = var.token_encryption_key_id
    "tokenIssuancePolicies"             = (var.token_issuance_policies == null ? null : [for item0 in var.token_issuance_policies : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "appliesTo" = (item0["appliesTo"] == null ? null : [for item2 in item0["appliesTo"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "deletedDateTime" = item2["deletedDateTime"] } : key3 => value3 if value3 != null }) if item2 != null]), "definition" = (item0["definition"] == null ? null : [for item2 in item0["definition"] : item2 if item2 != null]), "deletedDateTime" = item0["deletedDateTime"], "description" = item0["description"], "displayName" = item0["displayName"], "isOrganizationDefault" = item0["isOrganizationDefault"] } : key1 => value1 if value1 != null }) if item0 != null])
    "tokenLifetimePolicies"             = (var.token_lifetime_policies == null ? null : [for item0 in var.token_lifetime_policies : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "appliesTo" = (item0["appliesTo"] == null ? null : [for item2 in item0["appliesTo"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "deletedDateTime" = item2["deletedDateTime"] } : key3 => value3 if value3 != null }) if item2 != null]), "definition" = (item0["definition"] == null ? null : [for item2 in item0["definition"] : item2 if item2 != null]), "deletedDateTime" = item0["deletedDateTime"], "description" = item0["description"], "displayName" = item0["displayName"], "isOrganizationDefault" = item0["isOrganizationDefault"] } : key1 => value1 if value1 != null }) if item0 != null])
    "verifiedPublisher"                 = var.verified_publisher
    "web"                               = var.web
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "applications"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
