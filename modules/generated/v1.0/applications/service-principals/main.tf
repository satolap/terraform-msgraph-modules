# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appId"                              = var.app_id
    "accountEnabled"                     = var.account_enabled
    "addIns"                             = (var.add_ins == null ? null : [for item0 in var.add_ins : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "id" = item0["id"], "properties" = (item0["properties"] == null ? null : [for item2 in item0["properties"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "key" = item2["key"], "value" = item2["value"] } : key3 => value3 if value3 != null }) if item2 != null]), "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "alternativeNames"                   = (var.alternative_names == null ? null : [for item0 in var.alternative_names : item0 if item0 != null])
    "appDescription"                     = var.app_description
    "appDisplayName"                     = var.app_display_name
    "appManagementPolicies"              = (var.app_management_policies == null ? null : [for item0 in var.app_management_policies : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "appliesTo" = (item0["appliesTo"] == null ? null : [for item2 in item0["appliesTo"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "deletedDateTime" = item2["deletedDateTime"] } : key3 => value3 if value3 != null }) if item2 != null]), "deletedDateTime" = item0["deletedDateTime"], "description" = item0["description"], "displayName" = item0["displayName"], "isEnabled" = item0["isEnabled"], "restrictions" = item0["restrictions"] } : key1 => value1 if value1 != null }) if item0 != null])
    "appOwnerOrganizationId"             = var.app_owner_organization_id
    "appRoleAssignedTo"                  = (var.app_role_assigned_to == null ? null : [for item0 in var.app_role_assigned_to : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "appRoleId" = item0["appRoleId"], "deletedDateTime" = item0["deletedDateTime"], "principalId" = item0["principalId"], "resourceDisplayName" = item0["resourceDisplayName"], "resourceId" = item0["resourceId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "appRoleAssignmentRequired"          = var.app_role_assignment_required
    "appRoleAssignments"                 = (var.app_role_assignments == null ? null : [for item0 in var.app_role_assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "appRoleId" = item0["appRoleId"], "deletedDateTime" = item0["deletedDateTime"], "principalId" = item0["principalId"], "resourceDisplayName" = item0["resourceDisplayName"], "resourceId" = item0["resourceId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "appRoles"                           = (var.app_roles == null ? null : [for item0 in var.app_roles : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "allowedMemberTypes" = (item0["allowedMemberTypes"] == null ? null : [for item2 in item0["allowedMemberTypes"] : item2 if item2 != null]), "description" = item0["description"], "displayName" = item0["displayName"], "id" = item0["id"], "isEnabled" = item0["isEnabled"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "claimsMappingPolicies"              = (var.claims_mapping_policies == null ? null : [for item0 in var.claims_mapping_policies : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "appliesTo" = (item0["appliesTo"] == null ? null : [for item2 in item0["appliesTo"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "deletedDateTime" = item2["deletedDateTime"] } : key3 => value3 if value3 != null }) if item2 != null]), "definition" = (item0["definition"] == null ? null : [for item2 in item0["definition"] : item2 if item2 != null]), "deletedDateTime" = item0["deletedDateTime"], "description" = item0["description"], "displayName" = item0["displayName"], "isOrganizationDefault" = item0["isOrganizationDefault"] } : key1 => value1 if value1 != null }) if item0 != null])
    "customSecurityAttributes"           = var.custom_security_attributes
    "delegatedPermissionClassifications" = (var.delegated_permission_classifications == null ? null : [for item0 in var.delegated_permission_classifications : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "classification" = item0["classification"], "permissionId" = item0["permissionId"], "permissionName" = item0["permissionName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "deletedDateTime"                    = var.deleted_date_time
    "description"                        = var.description
    "disabledByMicrosoftStatus"          = var.disabled_by_microsoft_status
    "displayName"                        = var.display_name
    "endpoints"                          = (var.endpoints == null ? null : [for item0 in var.endpoints : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "capability" = item0["capability"], "deletedDateTime" = item0["deletedDateTime"], "providerId" = item0["providerId"], "providerName" = item0["providerName"], "providerResourceId" = item0["providerResourceId"], "uri" = item0["uri"] } : key1 => value1 if value1 != null }) if item0 != null])
    "federatedIdentityCredentials"       = (var.federated_identity_credentials == null ? null : [for item0 in var.federated_identity_credentials : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "audiences" = (item0["audiences"] == null ? null : [for item2 in item0["audiences"] : item2 if item2 != null]), "description" = item0["description"], "issuer" = item0["issuer"], "name" = item0["name"], "subject" = item0["subject"] } : key1 => value1 if value1 != null }) if item0 != null])
    "homeRealmDiscoveryPolicies"         = (var.home_realm_discovery_policies == null ? null : [for item0 in var.home_realm_discovery_policies : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "appliesTo" = (item0["appliesTo"] == null ? null : [for item2 in item0["appliesTo"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "deletedDateTime" = item2["deletedDateTime"] } : key3 => value3 if value3 != null }) if item2 != null]), "definition" = (item0["definition"] == null ? null : [for item2 in item0["definition"] : item2 if item2 != null]), "deletedDateTime" = item0["deletedDateTime"], "description" = item0["description"], "displayName" = item0["displayName"], "isOrganizationDefault" = item0["isOrganizationDefault"] } : key1 => value1 if value1 != null }) if item0 != null])
    "homepage"                           = var.homepage
    "info"                               = var.info
    "isDisabled"                         = var.is_disabled
    "keyCredentials"                     = (var.key_credentials == null ? null : [for item0 in var.key_credentials : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "customKeyIdentifier" = item0["customKeyIdentifier"], "displayName" = item0["displayName"], "endDateTime" = item0["endDateTime"], "key" = item0["key"], "keyId" = item0["keyId"], "startDateTime" = item0["startDateTime"], "type" = item0["type"], "usage" = item0["usage"] } : key1 => value1 if value1 != null }) if item0 != null])
    "loginUrl"                           = var.login_url
    "logoutUrl"                          = var.logout_url
    "notes"                              = var.notes
    "notificationEmailAddresses"         = (var.notification_email_addresses == null ? null : [for item0 in var.notification_email_addresses : item0 if item0 != null])
    "oauth2PermissionScopes"             = (var.oauth2_permission_scopes == null ? null : [for item0 in var.oauth2_permission_scopes : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "adminConsentDescription" = item0["adminConsentDescription"], "adminConsentDisplayName" = item0["adminConsentDisplayName"], "id" = item0["id"], "isEnabled" = item0["isEnabled"], "origin" = item0["origin"], "type" = item0["type"], "userConsentDescription" = item0["userConsentDescription"], "userConsentDisplayName" = item0["userConsentDisplayName"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"                        = var.odata_type
    "owners"                             = (var.owners == null ? null : [for item0 in var.owners : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "deletedDateTime" = item0["deletedDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "passwordCredentials"                = (var.password_credentials == null ? null : [for item0 in var.password_credentials : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "customKeyIdentifier" = item0["customKeyIdentifier"], "displayName" = item0["displayName"], "endDateTime" = item0["endDateTime"], "keyId" = item0["keyId"], "startDateTime" = item0["startDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "preferredSingleSignOnMode"          = var.preferred_single_sign_on_mode
    "preferredTokenSigningKeyThumbprint" = var.preferred_token_signing_key_thumbprint
    "remoteDesktopSecurityConfiguration" = var.remote_desktop_security_configuration
    "replyUrls"                          = (var.reply_urls == null ? null : [for item0 in var.reply_urls : item0 if item0 != null])
    "samlSingleSignOnSettings"           = var.saml_single_sign_on_settings
    "servicePrincipalNames"              = (var.service_principal_names == null ? null : [for item0 in var.service_principal_names : item0 if item0 != null])
    "servicePrincipalType"               = var.service_principal_type
    "synchronization"                    = var.synchronization
    "tags"                               = (var.tags == null ? null : [for item0 in var.tags : item0 if item0 != null])
    "tokenEncryptionKeyId"               = var.token_encryption_key_id
    "tokenIssuancePolicies"              = (var.token_issuance_policies == null ? null : [for item0 in var.token_issuance_policies : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "appliesTo" = (item0["appliesTo"] == null ? null : [for item2 in item0["appliesTo"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "deletedDateTime" = item2["deletedDateTime"] } : key3 => value3 if value3 != null }) if item2 != null]), "definition" = (item0["definition"] == null ? null : [for item2 in item0["definition"] : item2 if item2 != null]), "deletedDateTime" = item0["deletedDateTime"], "description" = item0["description"], "displayName" = item0["displayName"], "isOrganizationDefault" = item0["isOrganizationDefault"] } : key1 => value1 if value1 != null }) if item0 != null])
    "tokenLifetimePolicies"              = (var.token_lifetime_policies == null ? null : [for item0 in var.token_lifetime_policies : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "appliesTo" = (item0["appliesTo"] == null ? null : [for item2 in item0["appliesTo"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "deletedDateTime" = item2["deletedDateTime"] } : key3 => value3 if value3 != null }) if item2 != null]), "definition" = (item0["definition"] == null ? null : [for item2 in item0["definition"] : item2 if item2 != null]), "deletedDateTime" = item0["deletedDateTime"], "description" = item0["description"], "displayName" = item0["displayName"], "isOrganizationDefault" = item0["isOrganizationDefault"] } : key1 => value1 if value1 != null }) if item0 != null])
    "transitiveMemberOf"                 = (var.transitive_member_of == null ? null : [for item0 in var.transitive_member_of : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "deletedDateTime" = item0["deletedDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "verifiedPublisher"                  = var.verified_publisher
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "servicePrincipals"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
