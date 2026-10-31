# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appId"                               = var.appId == null ? null : lower(var.appId)
    "accountEnabled"                      = var.accountEnabled
    "addIns"                              = (var.addIns == null ? null : [for item0 in var.addIns : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "id" = item0["id"], "properties" = (item0["properties"] == null ? null : [for item2 in item0["properties"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "key" = item2["key"], "value" = item2["value"] } : key3 => value3 if value3 != null }) if item2 != null]), "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "alternativeNames"                    = (var.alternativeNames == null ? null : [for item0 in var.alternativeNames : item0 if item0 != null])
    "appDescription"                      = var.appDescription
    "appDisplayName"                      = var.appDisplayName
    "appManagementPolicies"               = (var.appManagementPolicies == null ? null : [for item0 in var.appManagementPolicies : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "appliesTo" = (item0["appliesTo"] == null ? null : [for item2 in item0["appliesTo"] : item2 if item2 != null]), "deletedDateTime" = item0["deletedDateTime"], "description" = item0["description"], "displayName" = item0["displayName"], "isEnabled" = item0["isEnabled"], "restrictions" = (item0["restrictions"] == null ? null : { for key2, value2 in { "@odata.type" = item0["restrictions"]["odata_type"], "applicationRestrictions" = (item0["restrictions"]["applicationRestrictions"] == null ? null : { for key3, value3 in { "@odata.type" = item0["restrictions"]["applicationRestrictions"]["odata_type"], "audiences" = (item0["restrictions"]["applicationRestrictions"]["audiences"] == null ? null : { for key4, value4 in { "@odata.type" = item0["restrictions"]["applicationRestrictions"]["audiences"]["odata_type"], "azureAdMultipleOrgs" = item0["restrictions"]["applicationRestrictions"]["audiences"]["azureAdMultipleOrgs"], "personalMicrosoftAccount" = item0["restrictions"]["applicationRestrictions"]["audiences"]["personalMicrosoftAccount"] } : key4 => value4 if value4 != null }), "identifierUris" = (item0["restrictions"]["applicationRestrictions"]["identifierUris"] == null ? null : { for key4, value4 in { "@odata.type" = item0["restrictions"]["applicationRestrictions"]["identifierUris"]["odata_type"], "nonDefaultUriAddition" = item0["restrictions"]["applicationRestrictions"]["identifierUris"]["nonDefaultUriAddition"], "uriAdditionWithoutUniqueTenantIdentifier" = item0["restrictions"]["applicationRestrictions"]["identifierUris"]["uriAdditionWithoutUniqueTenantIdentifier"] } : key4 => value4 if value4 != null }), "redirectUris" = (item0["restrictions"]["applicationRestrictions"]["redirectUris"] == null ? null : { for key4, value4 in { "@odata.type" = item0["restrictions"]["applicationRestrictions"]["redirectUris"]["odata_type"], "uriWithBlockedDomain" = item0["restrictions"]["applicationRestrictions"]["redirectUris"]["uriWithBlockedDomain"], "uriWithBlockedScheme" = item0["restrictions"]["applicationRestrictions"]["redirectUris"]["uriWithBlockedScheme"], "uriWithWildcard" = item0["restrictions"]["applicationRestrictions"]["redirectUris"]["uriWithWildcard"], "uriWithoutAllowedDomain" = item0["restrictions"]["applicationRestrictions"]["redirectUris"]["uriWithoutAllowedDomain"], "uriWithoutAllowedScheme" = item0["restrictions"]["applicationRestrictions"]["redirectUris"]["uriWithoutAllowedScheme"] } : key4 => value4 if value4 != null }) } : key3 => value3 if value3 != null }), "keyCredentials" = (item0["restrictions"]["keyCredentials"] == null ? null : [for item3 in item0["restrictions"]["keyCredentials"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "certificateBasedApplicationConfigurationIds" = item3["certificateBasedApplicationConfigurationIds"], "excludeActors" = item3["excludeActors"], "maxLifetime" = item3["maxLifetime"], "restrictForAppsCreatedAfterDateTime" = item3["restrictForAppsCreatedAfterDateTime"], "restrictionType" = item3["restrictionType"], "state" = item3["state"] } : key4 => value4 if value4 != null }) if item3 != null]), "passwordCredentials" = (item0["restrictions"]["passwordCredentials"] == null ? null : [for item3 in item0["restrictions"]["passwordCredentials"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "excludeActors" = item3["excludeActors"], "maxLifetime" = item3["maxLifetime"], "restrictForAppsCreatedAfterDateTime" = item3["restrictForAppsCreatedAfterDateTime"], "restrictionType" = item3["restrictionType"], "state" = item3["state"] } : key4 => value4 if value4 != null }) if item3 != null]) } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }) if item0 != null])
    "appOwnerOrganizationId"              = var.appOwnerOrganizationId
    "appRoleAssignedTo"                   = (var.appRoleAssignedTo == null ? null : [for item0 in var.appRoleAssignedTo : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "appRoleId" = item0["appRoleId"], "deletedDateTime" = item0["deletedDateTime"], "principalId" = item0["principalId"], "resourceDisplayName" = item0["resourceDisplayName"], "resourceId" = item0["resourceId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "appRoleAssignmentRequired"           = var.appRoleAssignmentRequired
    "appRoleAssignments"                  = (var.appRoleAssignments == null ? null : [for item0 in var.appRoleAssignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "appRoleId" = item0["appRoleId"], "deletedDateTime" = item0["deletedDateTime"], "principalId" = item0["principalId"], "resourceDisplayName" = item0["resourceDisplayName"], "resourceId" = item0["resourceId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "appRoles"                            = (var.appRoles == null ? null : [for item0 in var.appRoles : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "allowedMemberTypes" = (item0["allowedMemberTypes"] == null ? null : [for item2 in item0["allowedMemberTypes"] : item2 if item2 != null]), "description" = item0["description"], "displayName" = item0["displayName"], "id" = item0["id"], "isEnabled" = item0["isEnabled"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "claimsMappingPolicies"               = (var.claimsMappingPolicies == null ? null : [for item0 in var.claimsMappingPolicies : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "appliesTo" = (item0["appliesTo"] == null ? null : [for item2 in item0["appliesTo"] : item2 if item2 != null]), "definition" = (item0["definition"] == null ? null : [for item2 in item0["definition"] : item2 if item2 != null]), "deletedDateTime" = item0["deletedDateTime"], "description" = item0["description"], "displayName" = item0["displayName"], "isOrganizationDefault" = item0["isOrganizationDefault"] } : key1 => value1 if value1 != null }) if item0 != null])
    "claimsPolicy"                        = var.claimsPolicy
    "customSecurityAttributes"            = var.customSecurityAttributes
    "delegatedPermissionClassifications"  = (var.delegatedPermissionClassifications == null ? null : [for item0 in var.delegatedPermissionClassifications : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "classification" = item0["classification"], "permissionId" = item0["permissionId"], "permissionName" = item0["permissionName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "deletedDateTime"                     = var.deletedDateTime
    "description"                         = var.description
    "disabledByMicrosoftStatus"           = var.disabledByMicrosoftStatus
    "displayName"                         = var.displayName
    "endpoints"                           = (var.endpoints == null ? null : [for item0 in var.endpoints : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "deletedDateTime" = item0["deletedDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "errorUrl"                            = var.errorUrl
    "federatedIdentityCredentials"        = (var.federatedIdentityCredentials == null ? null : [for item0 in var.federatedIdentityCredentials : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "audiences" = (item0["audiences"] == null ? null : [for item2 in item0["audiences"] : item2 if item2 != null]), "claimsMatchingExpression" = (item0["claimsMatchingExpression"] == null ? null : { for key2, value2 in { "@odata.type" = item0["claimsMatchingExpression"]["odata_type"], "languageVersion" = item0["claimsMatchingExpression"]["languageVersion"], "value" = item0["claimsMatchingExpression"]["value"] } : key2 => value2 if value2 != null }), "description" = item0["description"], "issuer" = item0["issuer"], "name" = item0["name"], "subject" = item0["subject"] } : key1 => value1 if value1 != null }) if item0 != null])
    "lifecycle"                           = var.graph_lifecycle
    "homeRealmDiscoveryPolicies"          = (var.homeRealmDiscoveryPolicies == null ? null : [for item0 in var.homeRealmDiscoveryPolicies : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "appliesTo" = (item0["appliesTo"] == null ? null : [for item2 in item0["appliesTo"] : item2 if item2 != null]), "definition" = (item0["definition"] == null ? null : [for item2 in item0["definition"] : item2 if item2 != null]), "deletedDateTime" = item0["deletedDateTime"], "description" = item0["description"], "displayName" = item0["displayName"], "isOrganizationDefault" = item0["isOrganizationDefault"] } : key1 => value1 if value1 != null }) if item0 != null])
    "homepage"                            = var.homepage
    "info"                                = (var.info == null ? null : { for key0, value0 in { "@odata.type" = var.info["odata_type"], "marketingUrl" = var.info["marketingUrl"], "privacyStatementUrl" = var.info["privacyStatementUrl"], "supportUrl" = var.info["supportUrl"], "termsOfServiceUrl" = var.info["termsOfServiceUrl"] } : key0 => value0 if value0 != null })
    "isDisabled"                          = var.isDisabled
    "keyCredentials"                      = (var.keyCredentials == null ? null : [for item0 in var.keyCredentials : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "customKeyIdentifier" = item0["customKeyIdentifier"], "displayName" = item0["displayName"], "endDateTime" = item0["endDateTime"], "key" = item0["key"], "keyId" = item0["keyId"], "startDateTime" = item0["startDateTime"], "type" = item0["type"], "usage" = item0["usage"] } : key1 => value1 if value1 != null }) if item0 != null])
    "licenseDetails"                      = (var.licenseDetails == null ? null : [for item0 in var.licenseDetails : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "loginUrl"                            = var.loginUrl
    "logoutUrl"                           = var.logoutUrl
    "notes"                               = var.notes
    "notificationEmailAddresses"          = (var.notificationEmailAddresses == null ? null : [for item0 in var.notificationEmailAddresses : item0 if item0 != null])
    "@odata.type"                         = var.odata_type
    "owners"                              = (var.owners == null ? null : [for item0 in var.owners : item0 if item0 != null])
    "passwordCredentials"                 = (var.passwordCredentials == null ? null : [for item0 in var.passwordCredentials : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "customKeyIdentifier" = item0["customKeyIdentifier"], "displayName" = item0["displayName"], "endDateTime" = item0["endDateTime"], "keyId" = item0["keyId"], "startDateTime" = item0["startDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "permissionGrantPreApprovalPolicies"  = (var.permissionGrantPreApprovalPolicies == null ? null : [for item0 in var.permissionGrantPreApprovalPolicies : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "conditions" = (item0["conditions"] == null ? null : [for item2 in item0["conditions"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "permissions" = item2["permissions"], "scopeType" = item2["scopeType"], "sensitivityLabels" = item2["sensitivityLabels"] } : key3 => value3 if value3 != null }) if item2 != null]), "deletedDateTime" = item0["deletedDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "preferredSingleSignOnMode"           = var.preferredSingleSignOnMode
    "preferredTokenSigningKeyEndDateTime" = var.preferredTokenSigningKeyEndDateTime
    "preferredTokenSigningKeyThumbprint"  = var.preferredTokenSigningKeyThumbprint
    "publishedPermissionScopes"           = (var.publishedPermissionScopes == null ? null : [for item0 in var.publishedPermissionScopes : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "adminConsentDescription" = item0["adminConsentDescription"], "adminConsentDisplayName" = item0["adminConsentDisplayName"], "id" = item0["id"], "isEnabled" = item0["isEnabled"], "origin" = item0["origin"], "type" = item0["type"], "userConsentDescription" = item0["userConsentDescription"], "userConsentDisplayName" = item0["userConsentDisplayName"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "publisherName"                       = var.publisherName
    "remoteDesktopSecurityConfiguration"  = var.remoteDesktopSecurityConfiguration
    "replyUrls"                           = (var.replyUrls == null ? null : [for item0 in var.replyUrls : item0 if item0 != null])
    "samlMetadataUrl"                     = var.samlMetadataUrl
    "samlSingleSignOnSettings"            = (var.samlSingleSignOnSettings == null ? null : { for key0, value0 in { "@odata.type" = var.samlSingleSignOnSettings["odata_type"], "relayState" = var.samlSingleSignOnSettings["relayState"] } : key0 => value0 if value0 != null })
    "servicePrincipalNames"               = (var.servicePrincipalNames == null ? null : [for item0 in var.servicePrincipalNames : item0 if item0 != null])
    "servicePrincipalType"                = var.servicePrincipalType
    "synchronization"                     = var.synchronization
    "tags"                                = (var.tags == null ? null : [for item0 in var.tags : item0 if item0 != null])
    "tokenEncryptionKeyId"                = var.tokenEncryptionKeyId
    "tokenIssuancePolicies"               = (var.tokenIssuancePolicies == null ? null : [for item0 in var.tokenIssuancePolicies : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "appliesTo" = (item0["appliesTo"] == null ? null : [for item2 in item0["appliesTo"] : item2 if item2 != null]), "definition" = (item0["definition"] == null ? null : [for item2 in item0["definition"] : item2 if item2 != null]), "deletedDateTime" = item0["deletedDateTime"], "description" = item0["description"], "displayName" = item0["displayName"], "isOrganizationDefault" = item0["isOrganizationDefault"] } : key1 => value1 if value1 != null }) if item0 != null])
    "tokenLifetimePolicies"               = (var.tokenLifetimePolicies == null ? null : [for item0 in var.tokenLifetimePolicies : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "appliesTo" = (item0["appliesTo"] == null ? null : [for item2 in item0["appliesTo"] : item2 if item2 != null]), "definition" = (item0["definition"] == null ? null : [for item2 in item0["definition"] : item2 if item2 != null]), "deletedDateTime" = item0["deletedDateTime"], "description" = item0["description"], "displayName" = item0["displayName"], "isOrganizationDefault" = item0["isOrganizationDefault"] } : key1 => value1 if value1 != null }) if item0 != null])
    "transitiveMemberOf"                  = (var.transitiveMemberOf == null ? null : [for item0 in var.transitiveMemberOf : item0 if item0 != null])
    "verifiedPublisher"                   = (var.verifiedPublisher == null ? null : { for key0, value0 in { "@odata.type" = var.verifiedPublisher["odata_type"], "addedDateTime" = var.verifiedPublisher["addedDateTime"], "displayName" = var.verifiedPublisher["displayName"], "verifiedPublisherId" = var.verifiedPublisher["verifiedPublisherId"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "servicePrincipals"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id", "appId"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["appManagementPolicies", "appRoleAssignedTo", "appRoleAssignments", "claimsMappingPolicies", "claimsPolicy", "delegatedPermissionClassifications", "endpoints", "federatedIdentityCredentials", "homeRealmDiscoveryPolicies", "licenseDetails", "lifecycle", "owners", "permissionGrantPreApprovalPolicies", "remoteDesktopSecurityConfiguration", "synchronization", "tokenIssuancePolicies", "tokenLifetimePolicies", "transitiveMemberOf"], name)])]))))] } : null

  response_export_values = {
    response = "@"
  }

  dynamic "timeouts" {
    for_each = local.timeouts_set ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }

  lifecycle {
    replace_triggered_by = [terraform_data.immutable]
  }
}

# Inputs that Microsoft Graph cannot update in place; a change replaces msgraph_resource.this. Makes no API call.
resource "terraform_data" "immutable" {
  input = {
    "appId" = var.appId != null ? lower(var.appId) : try(lower(lookup(var.additional_properties, "appId", null)), null)
  }
}

# The application (client) ID, held from creation so that it stays known in plans that
# update the object in place. Makes no API call.
resource "terraform_data" "app_id" {
  input            = try(msgraph_resource.this.output.response.appId, null)
  triggers_replace = msgraph_resource.this.id

  lifecycle {
    ignore_changes = [input]
  }
}
