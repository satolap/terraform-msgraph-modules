# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "auditLogs/signIns"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["agent", "appDisplayName", "appId", "appOwnerTenantId", "appTokenProtectionStatus", "appliedConditionalAccessPolicies", "appliedEventListeners", "authenticationAppDeviceDetails", "authenticationAppPolicyEvaluationDetails", "authenticationContextClassReferences", "authenticationDetails", "authenticationMethodsUsed", "authenticationProcessingDetails", "authenticationProtocol", "authenticationRequirement", "authenticationRequirementPolicies", "autonomousSystemNumber", "azureResourceId", "clientAppUsed", "clientCredentialType", "clientSessionId", "conditionalAccessAudiences", "conditionalAccessStatus", "correlationId", "createdDateTime", "crossTenantAccessType", "deviceDetail", "federatedCredentialId", "flaggedForReview", "globalSecureAccessIpAddress", "homeTenantId", "homeTenantName", "incomingTokenType", "ipAddress", "ipAddressFromResourceProvider", "isInteractive", "isTenantRestricted", "isThroughGlobalSecureAccess", "location", "managedServiceIdentity", "mfaDetail", "networkLocationDetails", "originalRequestId", "originalTransferMethod", "privateLinkDetails", "processingTimeInMilliseconds", "resourceDisplayName", "resourceId", "resourceOwnerTenantId", "resourceServicePrincipalId", "resourceTenantId", "riskDetail", "riskEventTypes_v2", "riskLevelAggregated", "riskLevelDuringSignIn", "riskState", "rootActorId", "servicePrincipalCredentialKeyId", "servicePrincipalCredentialThumbprint", "servicePrincipalId", "servicePrincipalName", "sessionId", "sessionLifetimePolicies", "signInEventTypes", "signInIdentifier", "signInIdentifierType", "signInTokenProtectionStatus", "status", "tokenIssuerName", "tokenIssuerType", "tokenProtectionStatusDetails", "uniqueTokenIdentifier", "userAgent", "userDisplayName", "userId", "userPrincipalName", "userType"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    app_display_name                    = "example"
    flagged_for_review                  = false
    autonomous_system_number            = -2147483648
    applied_conditional_access_policies = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appDisplayName"]) == jsonencode("example")
    error_message = "appDisplayName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["flaggedForReview"]) == jsonencode(false)
    error_message = "flaggedForReview must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["autonomousSystemNumber"]) == jsonencode(-2147483648)
    error_message = "autonomousSystemNumber must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["appliedConditionalAccessPolicies"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.appliedConditionalAccessPolicy" }])
    error_message = "appliedConditionalAccessPolicies must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    app_token_protection_status = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.app_token_protection_status]
}
