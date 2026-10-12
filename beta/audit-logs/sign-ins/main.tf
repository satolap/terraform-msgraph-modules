# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "agent"                                    = (var.agent == null ? null : { for key0, value0 in { "@odata.type" = var.agent["odata_type"], "agentSubjectParentId" = var.agent["agentSubjectParentId"], "agentSubjectType" = var.agent["agentSubjectType"], "agentType" = var.agent["agentType"], "parentAppId" = var.agent["parentAppId"] } : key0 => value0 if value0 != null })
    "appDisplayName"                           = var.app_display_name
    "appId"                                    = var.app_id
    "appOwnerTenantId"                         = var.app_owner_tenant_id
    "appTokenProtectionStatus"                 = var.app_token_protection_status
    "appliedConditionalAccessPolicies"         = (var.applied_conditional_access_policies == null ? null : [for item0 in var.applied_conditional_access_policies : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "authenticationStrength" = (item0["authenticationStrength"] == null ? null : { for key2, value2 in { "@odata.type" = item0["authenticationStrength"]["odata_type"], "authenticationStrengthId" = item0["authenticationStrength"]["authenticationStrengthId"], "authenticationStrengthResult" = item0["authenticationStrength"]["authenticationStrengthResult"], "displayName" = item0["authenticationStrength"]["displayName"] } : key2 => value2 if value2 != null }), "conditionsNotSatisfied" = item0["conditionsNotSatisfied"], "conditionsSatisfied" = item0["conditionsSatisfied"], "displayName" = item0["displayName"], "enforcedGrantControls" = (item0["enforcedGrantControls"] == null ? null : [for item2 in item0["enforcedGrantControls"] : item2 if item2 != null]), "enforcedSessionControls" = (item0["enforcedSessionControls"] == null ? null : [for item2 in item0["enforcedSessionControls"] : item2 if item2 != null]), "excludeRulesSatisfied" = (item0["excludeRulesSatisfied"] == null ? null : [for item2 in item0["excludeRulesSatisfied"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "conditionalAccessCondition" = item2["conditionalAccessCondition"], "ruleSatisfied" = item2["ruleSatisfied"] } : key3 => value3 if value3 != null }) if item2 != null]), "id" = item0["id"], "includeRulesSatisfied" = (item0["includeRulesSatisfied"] == null ? null : [for item2 in item0["includeRulesSatisfied"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "conditionalAccessCondition" = item2["conditionalAccessCondition"], "ruleSatisfied" = item2["ruleSatisfied"] } : key3 => value3 if value3 != null }) if item2 != null]), "result" = item0["result"], "sessionControlsNotSatisfied" = (item0["sessionControlsNotSatisfied"] == null ? null : [for item2 in item0["sessionControlsNotSatisfied"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "appliedEventListeners"                    = (var.applied_event_listeners == null ? null : [for item0 in var.applied_event_listeners : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "eventType" = item0["eventType"], "executedListenerId" = item0["executedListenerId"], "handlerResult" = item0["handlerResult"] } : key1 => value1 if value1 != null }) if item0 != null])
    "authenticationAppDeviceDetails"           = (var.authentication_app_device_details == null ? null : { for key0, value0 in { "@odata.type" = var.authentication_app_device_details["odata_type"], "appVersion" = var.authentication_app_device_details["appVersion"], "clientApp" = var.authentication_app_device_details["clientApp"], "deviceId" = var.authentication_app_device_details["deviceId"], "operatingSystem" = var.authentication_app_device_details["operatingSystem"] } : key0 => value0 if value0 != null })
    "authenticationAppPolicyEvaluationDetails" = (var.authentication_app_policy_evaluation_details == null ? null : [for item0 in var.authentication_app_policy_evaluation_details : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "adminConfiguration" = item0["adminConfiguration"], "authenticationEvaluation" = item0["authenticationEvaluation"], "policyName" = item0["policyName"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "authenticationContextClassReferences"     = (var.authentication_context_class_references == null ? null : [for item0 in var.authentication_context_class_references : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "detail" = item0["detail"], "id" = item0["id"] } : key1 => value1 if value1 != null }) if item0 != null])
    "authenticationDetails"                    = (var.authentication_details == null ? null : [for item0 in var.authentication_details : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "authenticationMethod" = item0["authenticationMethod"], "authenticationMethodDetail" = item0["authenticationMethodDetail"], "authenticationStepDateTime" = item0["authenticationStepDateTime"], "authenticationStepRequirement" = item0["authenticationStepRequirement"], "authenticationStepResultDetail" = item0["authenticationStepResultDetail"], "succeeded" = item0["succeeded"] } : key1 => value1 if value1 != null }) if item0 != null])
    "authenticationMethodsUsed"                = (var.authentication_methods_used == null ? null : [for item0 in var.authentication_methods_used : item0 if item0 != null])
    "authenticationProcessingDetails"          = (var.authentication_processing_details == null ? null : [for item0 in var.authentication_processing_details : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "key" = item0["key"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "authenticationProtocol"                   = var.authentication_protocol
    "authenticationRequirement"                = var.authentication_requirement
    "authenticationRequirementPolicies"        = (var.authentication_requirement_policies == null ? null : [for item0 in var.authentication_requirement_policies : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "detail" = item0["detail"], "requirementProvider" = item0["requirementProvider"] } : key1 => value1 if value1 != null }) if item0 != null])
    "autonomousSystemNumber"                   = var.autonomous_system_number
    "azureResourceId"                          = var.azure_resource_id
    "clientAppUsed"                            = var.client_app_used
    "clientCredentialType"                     = var.client_credential_type
    "clientSessionId"                          = var.client_session_id
    "conditionalAccessAudiences"               = (var.conditional_access_audiences == null ? null : [for item0 in var.conditional_access_audiences : item0 if item0 != null])
    "conditionalAccessStatus"                  = var.conditional_access_status
    "correlationId"                            = var.correlation_id
    "createdDateTime"                          = var.created_date_time
    "crossTenantAccessType"                    = var.cross_tenant_access_type
    "deviceDetail"                             = (var.device_detail == null ? null : { for key0, value0 in { "@odata.type" = var.device_detail["odata_type"], "browser" = var.device_detail["browser"], "browserId" = var.device_detail["browserId"], "deviceId" = var.device_detail["deviceId"], "displayName" = var.device_detail["displayName"], "isCompliant" = var.device_detail["isCompliant"], "isManaged" = var.device_detail["isManaged"], "operatingSystem" = var.device_detail["operatingSystem"], "trustType" = var.device_detail["trustType"] } : key0 => value0 if value0 != null })
    "federatedCredentialId"                    = var.federated_credential_id
    "flaggedForReview"                         = var.flagged_for_review
    "globalSecureAccessIpAddress"              = var.global_secure_access_ip_address
    "homeTenantId"                             = var.home_tenant_id
    "homeTenantName"                           = var.home_tenant_name
    "incomingTokenType"                        = var.incoming_token_type
    "ipAddress"                                = var.ip_address
    "ipAddressFromResourceProvider"            = var.ip_address_from_resource_provider
    "isInteractive"                            = var.is_interactive
    "isTenantRestricted"                       = var.is_tenant_restricted
    "isThroughGlobalSecureAccess"              = var.is_through_global_secure_access
    "location"                                 = (var.location == null ? null : { for key0, value0 in { "@odata.type" = var.location["odata_type"], "city" = var.location["city"], "countryOrRegion" = var.location["countryOrRegion"], "geoCoordinates" = (var.location["geoCoordinates"] == null ? null : { for key1, value1 in { "@odata.type" = var.location["geoCoordinates"]["odata_type"], "latitude" = var.location["geoCoordinates"]["latitude"], "longitude" = var.location["geoCoordinates"]["longitude"] } : key1 => value1 if value1 != null }), "state" = var.location["state"] } : key0 => value0 if value0 != null })
    "managedServiceIdentity"                   = (var.managed_service_identity == null ? null : { for key0, value0 in { "@odata.type" = var.managed_service_identity["odata_type"], "associatedResourceId" = var.managed_service_identity["associatedResourceId"], "federatedTokenId" = var.managed_service_identity["federatedTokenId"], "federatedTokenIssuer" = var.managed_service_identity["federatedTokenIssuer"], "msiType" = var.managed_service_identity["msiType"] } : key0 => value0 if value0 != null })
    "mfaDetail"                                = (var.mfa_detail == null ? null : { for key0, value0 in { "@odata.type" = var.mfa_detail["odata_type"], "authDetail" = var.mfa_detail["authDetail"], "authMethod" = var.mfa_detail["authMethod"] } : key0 => value0 if value0 != null })
    "networkLocationDetails"                   = (var.network_location_details == null ? null : [for item0 in var.network_location_details : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "networkNames" = (item0["networkNames"] == null ? null : [for item2 in item0["networkNames"] : item2 if item2 != null]), "networkType" = item0["networkType"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"                              = var.odata_type
    "originalRequestId"                        = var.original_request_id
    "originalTransferMethod"                   = var.original_transfer_method
    "privateLinkDetails"                       = (var.private_link_details == null ? null : { for key0, value0 in { "@odata.type" = var.private_link_details["odata_type"], "policyId" = var.private_link_details["policyId"], "policyName" = var.private_link_details["policyName"], "policyTenantId" = var.private_link_details["policyTenantId"], "resourceId" = var.private_link_details["resourceId"] } : key0 => value0 if value0 != null })
    "processingTimeInMilliseconds"             = var.processing_time_in_milliseconds
    "resourceDisplayName"                      = var.resource_display_name
    "resourceId"                               = var.resource_id
    "resourceOwnerTenantId"                    = var.resource_owner_tenant_id
    "resourceServicePrincipalId"               = var.resource_service_principal_id
    "resourceTenantId"                         = var.resource_tenant_id
    "riskDetail"                               = var.risk_detail
    "riskEventTypes_v2"                        = (var.risk_event_types_v2 == null ? null : [for item0 in var.risk_event_types_v2 : item0 if item0 != null])
    "riskLevelAggregated"                      = var.risk_level_aggregated
    "riskLevelDuringSignIn"                    = var.risk_level_during_sign_in
    "riskState"                                = var.risk_state
    "rootActorId"                              = var.root_actor_id
    "servicePrincipalCredentialKeyId"          = var.service_principal_credential_key_id
    "servicePrincipalCredentialThumbprint"     = var.service_principal_credential_thumbprint
    "servicePrincipalId"                       = var.service_principal_id
    "servicePrincipalName"                     = var.service_principal_name
    "sessionId"                                = var.session_id
    "sessionLifetimePolicies"                  = (var.session_lifetime_policies == null ? null : [for item0 in var.session_lifetime_policies : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "detail" = item0["detail"], "expirationRequirement" = item0["expirationRequirement"] } : key1 => value1 if value1 != null }) if item0 != null])
    "signInEventTypes"                         = (var.sign_in_event_types == null ? null : [for item0 in var.sign_in_event_types : item0 if item0 != null])
    "signInIdentifier"                         = var.sign_in_identifier
    "signInIdentifierType"                     = var.sign_in_identifier_type
    "signInTokenProtectionStatus"              = var.sign_in_token_protection_status
    "status"                                   = (var.status == null ? null : { for key0, value0 in { "@odata.type" = var.status["odata_type"], "additionalDetails" = var.status["additionalDetails"], "errorCode" = var.status["errorCode"], "failureReason" = var.status["failureReason"] } : key0 => value0 if value0 != null })
    "tokenIssuerName"                          = var.token_issuer_name
    "tokenIssuerType"                          = var.token_issuer_type
    "tokenProtectionStatusDetails"             = (var.token_protection_status_details == null ? null : { for key0, value0 in { "@odata.type" = var.token_protection_status_details["odata_type"], "signInSessionStatus" = var.token_protection_status_details["signInSessionStatus"], "signInSessionStatusCode" = var.token_protection_status_details["signInSessionStatusCode"] } : key0 => value0 if value0 != null })
    "uniqueTokenIdentifier"                    = var.unique_token_identifier
    "userAgent"                                = var.user_agent
    "userDisplayName"                          = var.user_display_name
    "userId"                                   = var.user_id
    "userPrincipalName"                        = var.user_principal_name
    "userType"                                 = var.user_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "auditLogs/signIns"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
