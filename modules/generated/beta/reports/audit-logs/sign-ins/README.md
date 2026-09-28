# /auditLogs/signIns

Create new navigation property to signIns for auditLogs

[Catalog](../../../README.md) · [Reports](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/signin?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /auditLogs/signIns`, `GET/PATCH/DELETE /auditLogs/signIns/{signIn-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./reports/audit-logs/sign-ins"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `agent` | `agent` | `object({       odata_type = optional(string, "#microsoft.graph.agentic.agentSignIn")       agentSubjectParentId = optional(string)       agentSubjectType = optional(string)       agentType = optional(string)       parentAppId = optional(string)     })` | no | no |
| `app_display_name` | `appDisplayName` | `string` | no | no |
| `app_id` | `appId` | `string` | no | no |
| `app_owner_tenant_id` | `appOwnerTenantId` | `string` | no | no |
| `app_token_protection_status` | `appTokenProtectionStatus` | `string` | no | no |
| `applied_conditional_access_policies` | `appliedConditionalAccessPolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.appliedConditionalAccessPolicy")       authenticationStrength = optional(object({       odata_type = optional(string, "#microsoft.graph.authenticationStrength")       authenticationStrengthId = optional(string)       authenticationStrengthResult = optional(string)       displayName = optional(string)     }))       conditionsNotSatisfied = optional(string)       conditionsSatisfied = optional(string)       displayName = optional(string)       enforcedGrantControls = optional(list(string))       enforcedSessionControls = optional(list(string))       excludeRulesSatisfied = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessRuleSatisfied")       conditionalAccessCondition = optional(string)       ruleSatisfied = optional(string)     })))       id = optional(string)       includeRulesSatisfied = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessRuleSatisfied")       conditionalAccessCondition = optional(string)       ruleSatisfied = optional(string)     })))       result = optional(string)       sessionControlsNotSatisfied = optional(list(string))     }))` | no | no |
| `applied_event_listeners` | `appliedEventListeners` | `list(object({       odata_type = optional(string, "#microsoft.graph.appliedAuthenticationEventListener")       eventType = optional(string)       executedListenerId = optional(string)       handlerResult = optional(any)     }))` | no | no |
| `authentication_app_device_details` | `authenticationAppDeviceDetails` | `object({       odata_type = optional(string, "#microsoft.graph.authenticationAppDeviceDetails")       appVersion = optional(string)       clientApp = optional(string)       deviceId = optional(string)       operatingSystem = optional(string)     })` | no | no |
| `authentication_app_policy_evaluation_details` | `authenticationAppPolicyEvaluationDetails` | `list(object({       odata_type = optional(string, "#microsoft.graph.authenticationAppPolicyDetails")       adminConfiguration = optional(string)       authenticationEvaluation = optional(string)       policyName = optional(string)       status = optional(string)     }))` | no | no |
| `authentication_context_class_references` | `authenticationContextClassReferences` | `list(object({       odata_type = optional(string, "#microsoft.graph.authenticationContext")       detail = optional(string)       id = optional(string)     }))` | no | no |
| `authentication_details` | `authenticationDetails` | `list(object({       odata_type = optional(string, "#microsoft.graph.authenticationDetail")       authenticationMethod = optional(string)       authenticationMethodDetail = optional(string)       authenticationStepDateTime = optional(string)       authenticationStepRequirement = optional(string)       authenticationStepResultDetail = optional(string)       succeeded = optional(bool)     }))` | no | no |
| `authentication_methods_used` | `authenticationMethodsUsed` | `list(string)` | no | no |
| `authentication_processing_details` | `authenticationProcessingDetails` | `list(object({       odata_type = optional(string, "#microsoft.graph.keyValue")       key = optional(string)       value = optional(string)     }))` | no | no |
| `authentication_protocol` | `authenticationProtocol` | `string` | no | no |
| `authentication_requirement` | `authenticationRequirement` | `string` | no | no |
| `authentication_requirement_policies` | `authenticationRequirementPolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.authenticationRequirementPolicy")       detail = optional(string)       requirementProvider = optional(string)     }))` | no | no |
| `autonomous_system_number` | `autonomousSystemNumber` | `number` | no | no |
| `azure_resource_id` | `azureResourceId` | `string` | no | no |
| `client_app_used` | `clientAppUsed` | `string` | no | no |
| `client_credential_type` | `clientCredentialType` | `string` | no | yes |
| `client_session_id` | `clientSessionId` | `string` | no | no |
| `conditional_access_audiences` | `conditionalAccessAudiences` | `list(string)` | no | no |
| `conditional_access_status` | `conditionalAccessStatus` | `string` | no | no |
| `correlation_id` | `correlationId` | `string` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `cross_tenant_access_type` | `crossTenantAccessType` | `string` | no | no |
| `device_detail` | `deviceDetail` | `object({       odata_type = optional(string, "#microsoft.graph.deviceDetail")       browser = optional(string)       browserId = optional(string)       deviceId = optional(string)       displayName = optional(string)       isCompliant = optional(bool)       isManaged = optional(bool)       operatingSystem = optional(string)       trustType = optional(string)     })` | no | no |
| `federated_credential_id` | `federatedCredentialId` | `string` | no | yes |
| `flagged_for_review` | `flaggedForReview` | `bool` | no | no |
| `global_secure_access_ip_address` | `globalSecureAccessIpAddress` | `string` | no | no |
| `home_tenant_id` | `homeTenantId` | `string` | no | no |
| `home_tenant_name` | `homeTenantName` | `string` | no | no |
| `incoming_token_type` | `incomingTokenType` | `string` | no | no |
| `ip_address` | `ipAddress` | `string` | no | no |
| `ip_address_from_resource_provider` | `ipAddressFromResourceProvider` | `string` | no | no |
| `is_interactive` | `isInteractive` | `bool` | no | no |
| `is_tenant_restricted` | `isTenantRestricted` | `bool` | no | no |
| `is_through_global_secure_access` | `isThroughGlobalSecureAccess` | `bool` | no | no |
| `location` | `location` | `object({       odata_type = optional(string, "#microsoft.graph.signInLocation")       city = optional(string)       countryOrRegion = optional(string)       geoCoordinates = optional(object({       odata_type = optional(string, "#microsoft.graph.geoCoordinates")       latitude = optional(any)       longitude = optional(any)     }))       state = optional(string)     })` | no | no |
| `managed_service_identity` | `managedServiceIdentity` | `object({       odata_type = optional(string, "#microsoft.graph.managedIdentity")       associatedResourceId = optional(string)       federatedTokenId = optional(string)       federatedTokenIssuer = optional(string)       msiType = optional(string)     })` | no | no |
| `mfa_detail` | `mfaDetail` | `object({       odata_type = optional(string, "#microsoft.graph.mfaDetail")       authDetail = optional(string)       authMethod = optional(string)     })` | no | no |
| `network_location_details` | `networkLocationDetails` | `list(object({       odata_type = optional(string, "#microsoft.graph.networkLocationDetail")       networkNames = optional(list(string))       networkType = optional(string)     }))` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `original_request_id` | `originalRequestId` | `string` | no | no |
| `original_transfer_method` | `originalTransferMethod` | `string` | no | no |
| `private_link_details` | `privateLinkDetails` | `object({       odata_type = optional(string, "#microsoft.graph.privateLinkDetails")       policyId = optional(string)       policyName = optional(string)       policyTenantId = optional(string)       resourceId = optional(string)     })` | no | no |
| `processing_time_in_milliseconds` | `processingTimeInMilliseconds` | `number` | no | no |
| `resource_display_name` | `resourceDisplayName` | `string` | no | no |
| `resource_id` | `resourceId` | `string` | no | no |
| `resource_owner_tenant_id` | `resourceOwnerTenantId` | `string` | no | no |
| `resource_service_principal_id` | `resourceServicePrincipalId` | `string` | no | no |
| `resource_tenant_id` | `resourceTenantId` | `string` | no | no |
| `risk_detail` | `riskDetail` | `string` | no | no |
| `risk_event_types_v2` | `riskEventTypes_v2` | `list(string)` | no | no |
| `risk_level_aggregated` | `riskLevelAggregated` | `string` | no | no |
| `risk_level_during_sign_in` | `riskLevelDuringSignIn` | `string` | no | no |
| `risk_state` | `riskState` | `string` | no | no |
| `root_actor_id` | `rootActorId` | `string` | no | no |
| `service_principal_credential_key_id` | `servicePrincipalCredentialKeyId` | `string` | no | yes |
| `service_principal_credential_thumbprint` | `servicePrincipalCredentialThumbprint` | `string` | no | yes |
| `service_principal_id` | `servicePrincipalId` | `string` | no | no |
| `service_principal_name` | `servicePrincipalName` | `string` | no | no |
| `session_id` | `sessionId` | `string` | no | no |
| `session_lifetime_policies` | `sessionLifetimePolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.sessionLifetimePolicy")       detail = optional(string)       expirationRequirement = optional(string)     }))` | no | no |
| `sign_in_event_types` | `signInEventTypes` | `list(string)` | no | no |
| `sign_in_identifier` | `signInIdentifier` | `string` | no | no |
| `sign_in_identifier_type` | `signInIdentifierType` | `string` | no | no |
| `sign_in_token_protection_status` | `signInTokenProtectionStatus` | `string` | no | no |
| `status` | `status` | `object({       odata_type = optional(string, "#microsoft.graph.signInStatus")       additionalDetails = optional(string)       errorCode = optional(number)       failureReason = optional(string)     })` | no | no |
| `token_issuer_name` | `tokenIssuerName` | `string` | no | no |
| `token_issuer_type` | `tokenIssuerType` | `string` | no | no |
| `token_protection_status_details` | `tokenProtectionStatusDetails` | `object({       odata_type = optional(string, "#microsoft.graph.tokenProtectionStatusDetails")       signInSessionStatus = optional(string)       signInSessionStatusCode = optional(number)     })` | no | no |
| `unique_token_identifier` | `uniqueTokenIdentifier` | `string` | no | no |
| `user_agent` | `userAgent` | `string` | no | no |
| `user_display_name` | `userDisplayName` | `string` | no | no |
| `user_id` | `userId` | `string` | no | no |
| `user_principal_name` | `userPrincipalName` | `string` | no | no |
| `user_type` | `userType` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- appliedEventListeners[].handlerResult: polymorphic schema; accepts an untyped value
- location.geoCoordinates.latitude: polymorphic schema; accepts an untyped value
- location.geoCoordinates.longitude: polymorphic schema; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
