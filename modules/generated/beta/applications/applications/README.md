# /applications

Create application

[Catalog](../../README.md) · [Applications](../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/application?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /applications`, `GET/PATCH/DELETE /applications/{application-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/beta/applications/applications?ref=<release-tag>"
  display_name = "example"
}
```

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `display_name` | `displayName` | `string` | yes | no |
| `api` | `api` | `object({       odata_type = optional(string, "#microsoft.graph.apiApplication")       acceptMappedClaims = optional(bool)       knownClientApplications = optional(list(string))       oauth2PermissionScopes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.permissionScope")       adminConsentDescription = optional(string)       adminConsentDisplayName = optional(string)       id = optional(string)       isEnabled = optional(bool)       origin = optional(string)       type = optional(string)       userConsentDescription = optional(string)       userConsentDisplayName = optional(string)       value = optional(string)     })))       preAuthorizedApplications = optional(list(object({       odata_type = optional(string, "#microsoft.graph.preAuthorizedApplication")       appId = optional(string)       permissionIds = optional(list(string))     })))       requestedAccessTokenVersion = optional(number)     })` | no | yes |
| `app_management_policies` | `appManagementPolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.appManagementPolicy")       appliesTo = optional(any)       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isEnabled = optional(bool)       restrictions = optional(object({       odata_type = optional(string, "#microsoft.graph.customAppManagementConfiguration")       applicationRestrictions = optional(object({       odata_type = optional(string, "#microsoft.graph.customAppManagementApplicationConfiguration")       audiences = optional(object({       odata_type = optional(string, "#microsoft.graph.audiencesConfiguration")       azureAdMultipleOrgs = optional(any)       personalMicrosoftAccount = optional(any)     }))       identifierUris = optional(object({       odata_type = optional(string, "#microsoft.graph.identifierUriConfiguration")       nonDefaultUriAddition = optional(any)       uriAdditionWithoutUniqueTenantIdentifier = optional(any)     }))       redirectUris = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriConfiguration")       uriWithBlockedDomain = optional(any)       uriWithBlockedScheme = optional(any)       uriWithWildcard = optional(any)       uriWithoutAllowedDomain = optional(any)       uriWithoutAllowedScheme = optional(any)     }))     }))       keyCredentials = optional(list(object({       odata_type = optional(string, "#microsoft.graph.keyCredentialConfiguration")       certificateBasedApplicationConfigurationIds = optional(any)       excludeActors = optional(any)       maxLifetime = optional(string)       restrictForAppsCreatedAfterDateTime = optional(string)       restrictionType = optional(string)       state = optional(string)     })))       passwordCredentials = optional(list(object({       odata_type = optional(string, "#microsoft.graph.passwordCredentialConfiguration")       excludeActors = optional(any)       maxLifetime = optional(string)       restrictForAppsCreatedAfterDateTime = optional(string)       restrictionType = optional(string)       state = optional(string)     })))     }))     }))` | no | yes |
| `app_roles` | `appRoles` | `list(object({       odata_type = optional(string, "#microsoft.graph.appRole")       allowedMemberTypes = optional(list(string))       description = optional(string)       displayName = optional(string)       id = optional(string)       isEnabled = optional(bool)       value = optional(string)     }))` | no | no |
| `authentication_behaviors` | `authenticationBehaviors` | `object({       odata_type = optional(string, "#microsoft.graph.authenticationBehaviors")       blockAzureADGraphAccess = optional(bool)       coopEnforcement = optional(bool)       removeUnverifiedEmailClaim = optional(bool)       requireClientServicePrincipal = optional(bool)     })` | no | no |
| `certification` | `certification` | `object({       odata_type = optional(string, "#microsoft.graph.certification")       certificationExpirationDateTime = optional(string)       isPublisherAttested = optional(bool)       lastCertificationDateTime = optional(string)     })` | no | no |
| `connector_group` | `connectorGroup` | `any` | no | no |
| `default_redirect_uri` | `defaultRedirectUri` | `string` | no | no |
| `deleted_date_time` | `deletedDateTime` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `disabled_by_microsoft_status` | `disabledByMicrosoftStatus` | `string` | no | no |
| `federated_identity_credentials` | `federatedIdentityCredentials` | `list(object({       odata_type = optional(string, "#microsoft.graph.federatedIdentityCredential")       audiences = optional(list(string))       claimsMatchingExpression = optional(object({       odata_type = optional(string, "#microsoft.graph.federatedIdentityExpression")       languageVersion = optional(number)       value = optional(string)     }))       description = optional(string)       issuer = optional(string)       name = optional(string)       subject = optional(string)     }))` | no | yes |
| `group_membership_claims` | `groupMembershipClaims` | `string` | no | no |
| `home_realm_discovery_policies` | `homeRealmDiscoveryPolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.homeRealmDiscoveryPolicy")       appliesTo = optional(any)       definition = optional(list(string))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isOrganizationDefault = optional(bool)     }))` | no | no |
| `identifier_uris` | `identifierUris` | `list(string)` | no | no |
| `info` | `info` | `object({       odata_type = optional(string, "#microsoft.graph.informationalUrl")       marketingUrl = optional(string)       privacyStatementUrl = optional(string)       supportUrl = optional(string)       termsOfServiceUrl = optional(string)     })` | no | no |
| `is_device_only_auth_supported` | `isDeviceOnlyAuthSupported` | `bool` | no | no |
| `is_disabled` | `isDisabled` | `bool` | no | no |
| `is_fallback_public_client` | `isFallbackPublicClient` | `bool` | no | no |
| `key_credentials` | `keyCredentials` | `list(object({       odata_type = optional(string, "#microsoft.graph.keyCredential")       customKeyIdentifier = optional(string)       displayName = optional(string)       endDateTime = optional(string)       key = optional(string)       keyId = optional(string)       startDateTime = optional(string)       type = optional(string)       usage = optional(string)     }))` | no | yes |
| `logo` | `logo` | `string` | no | no |
| `native_authentication_apis_enabled` | `nativeAuthenticationApisEnabled` | `string` | no | no |
| `notes` | `notes` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `on_premises_publishing` | `onPremisesPublishing` | `object({       odata_type = optional(string, "#microsoft.graph.onPremisesPublishing")       alternateUrl = optional(string)       applicationServerTimeout = optional(string)       externalAuthenticationType = optional(string)       externalUrl = optional(string)       internalUrl = optional(string)       isAccessibleViaZTNAClient = optional(bool)       isBackendCertificateValidationEnabled = optional(bool)       isContinuousAccessEvaluationEnabled = optional(bool)       isDeviceAccessEnabled = optional(bool)       isDnsResolutionEnabled = optional(bool)       isHttpOnlyCookieEnabled = optional(bool)       isPersistentCookieEnabled = optional(bool)       isSecureCookieEnabled = optional(bool)       isStateSessionEnabled = optional(bool)       isTranslateHostHeaderEnabled = optional(bool)       isTranslateLinksInBodyEnabled = optional(bool)       onPremisesApplicationSegments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesApplicationSegment")       alternateUrl = optional(string)       corsConfigurations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.corsConfiguration")       allowedHeaders = optional(any)       allowedMethods = optional(any)       allowedOrigins = optional(any)       maxAgeInSeconds = optional(number)       resource = optional(string)     })))       externalUrl = optional(string)       internalUrl = optional(string)     })))       segmentsConfiguration = optional(any)       singleSignOnSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.onPremisesPublishingSingleSignOn")       kerberosSignOnSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.kerberosSignOnSettings")       kerberosServicePrincipalName = optional(string)       kerberosSignOnMappingAttributeType = optional(string)     }))       singleSignOnMode = optional(string)     }))       trafficRoutingMethod = optional(string)       useAlternateUrlForTranslationAndRedirect = optional(bool)       verifiedCustomDomainKeyCredential = optional(object({       odata_type = optional(string, "#microsoft.graph.keyCredential")       customKeyIdentifier = optional(string)       displayName = optional(string)       endDateTime = optional(string)       key = optional(string)       keyId = optional(string)       startDateTime = optional(string)       type = optional(string)       usage = optional(string)     }))       verifiedCustomDomainPasswordCredential = optional(object({       odata_type = optional(string, "#microsoft.graph.passwordCredential")       customKeyIdentifier = optional(string)       displayName = optional(string)       endDateTime = optional(string)       keyId = optional(string)       startDateTime = optional(string)     }))       wafAllowedHeaders = optional(any)       wafIpRanges = optional(any)       wafProvider = optional(string)     })` | no | yes |
| `optional_claims` | `optionalClaims` | `object({       odata_type = optional(string, "#microsoft.graph.optionalClaims")       accessToken = optional(list(object({       odata_type = optional(string, "#microsoft.graph.optionalClaim")       additionalProperties = optional(list(string))       essential = optional(bool)       name = optional(string)       source = optional(string)     })))       idToken = optional(list(object({       odata_type = optional(string, "#microsoft.graph.optionalClaim")       additionalProperties = optional(list(string))       essential = optional(bool)       name = optional(string)       source = optional(string)     })))       saml2Token = optional(list(object({       odata_type = optional(string, "#microsoft.graph.optionalClaim")       additionalProperties = optional(list(string))       essential = optional(bool)       name = optional(string)       source = optional(string)     })))     })` | no | yes |
| `parental_control_settings` | `parentalControlSettings` | `object({       odata_type = optional(string, "#microsoft.graph.parentalControlSettings")       countriesBlockedForMinors = optional(list(string))       legalAgeGroupRule = optional(string)     })` | no | no |
| `password_credentials` | `passwordCredentials` | `list(object({       odata_type = optional(string, "#microsoft.graph.passwordCredential")       customKeyIdentifier = optional(string)       displayName = optional(string)       endDateTime = optional(string)       keyId = optional(string)       startDateTime = optional(string)     }))` | no | yes |
| `public_client` | `publicClient` | `object({       odata_type = optional(string, "#microsoft.graph.publicClientApplication")       redirectUris = optional(list(string))     })` | no | no |
| `request_signature_verification` | `requestSignatureVerification` | `object({       odata_type = optional(string, "#microsoft.graph.requestSignatureVerification")       allowedWeakAlgorithms = optional(string)       isSignedRequestRequired = optional(bool)     })` | no | no |
| `required_resource_access` | `requiredResourceAccess` | `list(object({       odata_type = optional(string, "#microsoft.graph.requiredResourceAccess")       resourceAccess = optional(list(object({       odata_type = optional(string, "#microsoft.graph.resourceAccess")       id = optional(string)       type = optional(string)     })))       resourceAppId = optional(string)     }))` | no | no |
| `saml_metadata_url` | `samlMetadataUrl` | `string` | no | no |
| `service_management_reference` | `serviceManagementReference` | `string` | no | no |
| `service_principal_lock_configuration` | `servicePrincipalLockConfiguration` | `object({       odata_type = optional(string, "#microsoft.graph.servicePrincipalLockConfiguration")       allProperties = optional(bool)       credentialsWithUsageSign = optional(bool)       credentialsWithUsageVerify = optional(bool)       isEnabled = optional(bool)       tokenEncryptionKeyId = optional(bool)     })` | no | yes |
| `sign_in_audience` | `signInAudience` | `string` | no | no |
| `sign_in_audience_restrictions` | `signInAudienceRestrictions` | `any` | no | no |
| `spa` | `spa` | `object({       odata_type = optional(string, "#microsoft.graph.spaApplication")       redirectUris = optional(list(string))     })` | no | no |
| `synchronization` | `synchronization` | `any` | no | no |
| `tags` | `tags` | `list(string)` | no | no |
| `token_encryption_key_id` | `tokenEncryptionKeyId` | `string` | no | no |
| `token_issuance_policies` | `tokenIssuancePolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.tokenIssuancePolicy")       appliesTo = optional(any)       definition = optional(list(string))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isOrganizationDefault = optional(bool)     }))` | no | no |
| `token_lifetime_policies` | `tokenLifetimePolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.tokenLifetimePolicy")       appliesTo = optional(any)       definition = optional(list(string))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isOrganizationDefault = optional(bool)     }))` | no | no |
| `verified_publisher` | `verifiedPublisher` | `object({       odata_type = optional(string, "#microsoft.graph.verifiedPublisher")       addedDateTime = optional(string)       displayName = optional(string)       verifiedPublisherId = optional(string)     })` | no | no |
| `web` | `web` | `object({       odata_type = optional(string, "#microsoft.graph.webApplication")       homePageUrl = optional(string)       implicitGrantSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.implicitGrantSettings")       enableAccessTokenIssuance = optional(bool)       enableIdTokenIssuance = optional(bool)     }))       logoutUrl = optional(string)       oauth2AllowImplicitFlow = optional(bool)       redirectUriSettings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.redirectUriSettings")       index = optional(number)       uri = optional(string)     })))       redirectUris = optional(list(string))     })` | no | yes |
| `windows` | `windows` | `object({       odata_type = optional(string, "#microsoft.graph.windowsApplication")       redirectUris = optional(list(string))     })` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Excluded by conditional read-only prose: managerApplications. Add a reviewed contract if the property is writable for your account type.
- Microsoft Graph beta contracts can change without notice.
- Reviewed create-required correction: displayName.
- appManagementPolicies[].appliesTo[]: polymorphic schema; accepts an untyped value
- appManagementPolicies[].restrictions.applicationRestrictions.audiences.azureAdMultipleOrgs: nested schema exceeds depth limit; accepts an untyped value
- appManagementPolicies[].restrictions.applicationRestrictions.audiences.personalMicrosoftAccount: polymorphic schema; accepts an untyped value
- appManagementPolicies[].restrictions.applicationRestrictions.identifierUris.nonDefaultUriAddition: nested schema exceeds depth limit; accepts an untyped value
- appManagementPolicies[].restrictions.applicationRestrictions.identifierUris.uriAdditionWithoutUniqueTenantIdentifier: nested schema exceeds depth limit; accepts an untyped value
- appManagementPolicies[].restrictions.applicationRestrictions.redirectUris.uriWithBlockedDomain: nested schema exceeds depth limit; accepts an untyped value
- appManagementPolicies[].restrictions.applicationRestrictions.redirectUris.uriWithBlockedScheme: nested schema exceeds depth limit; accepts an untyped value
- appManagementPolicies[].restrictions.applicationRestrictions.redirectUris.uriWithWildcard: nested schema exceeds depth limit; accepts an untyped value
- appManagementPolicies[].restrictions.applicationRestrictions.redirectUris.uriWithoutAllowedDomain: nested schema exceeds depth limit; accepts an untyped value
- appManagementPolicies[].restrictions.applicationRestrictions.redirectUris.uriWithoutAllowedScheme: nested schema exceeds depth limit; accepts an untyped value
- appManagementPolicies[].restrictions.keyCredentials[].certificateBasedApplicationConfigurationIds: nested schema exceeds depth limit; accepts an untyped value
- appManagementPolicies[].restrictions.keyCredentials[].excludeActors: nested schema exceeds depth limit; accepts an untyped value
- appManagementPolicies[].restrictions.passwordCredentials[].excludeActors: nested schema exceeds depth limit; accepts an untyped value
- connectorGroup: navigation property; accepts an untyped value
- homeRealmDiscoveryPolicies[].appliesTo[]: polymorphic schema; accepts an untyped value
- onPremisesPublishing.onPremisesApplicationSegments[].corsConfigurations[].allowedHeaders: nested schema exceeds depth limit; accepts an untyped value
- onPremisesPublishing.onPremisesApplicationSegments[].corsConfigurations[].allowedMethods: nested schema exceeds depth limit; accepts an untyped value
- onPremisesPublishing.onPremisesApplicationSegments[].corsConfigurations[].allowedOrigins: nested schema exceeds depth limit; accepts an untyped value
- onPremisesPublishing.segmentsConfiguration: polymorphic schema; accepts an untyped value
- onPremisesPublishing.wafAllowedHeaders: polymorphic schema; accepts an untyped value
- onPremisesPublishing.wafIpRanges[]: object without documented properties; accepts an untyped value
- signInAudienceRestrictions: polymorphic schema; accepts an untyped value
- synchronization: navigation property; accepts an untyped value
- tokenIssuancePolicies[].appliesTo[]: polymorphic schema; accepts an untyped value
- tokenLifetimePolicies[].appliesTo[]: polymorphic schema; accepts an untyped value

## Licensing and prerequisites

Baseline rules reviewed on 2026-09-18 for the equivalent curated module `curated/applications` (confidence: inferred). Input-dependent rules were not re-verified against this module's inputs.

- **DIRECTORY-BASIC**: The reviewed create APIs for users, assigned security groups, applications and service principals specify no additional premium license. This covers the object operation only; features built on these objects can require licenses. No additional license specified. Coverage: No per-user entitlement for the object operation itself. Assignment: direct; capacity: per_tenant. Sources: [Create user](https://learn.microsoft.com/en-us/graph/api/user-post-users?view=graph-rest-1.0), [Create group](https://learn.microsoft.com/en-us/graph/api/group-post-groups?view=graph-rest-1.0), [Create application](https://learn.microsoft.com/en-us/graph/api/application-post-applications?view=graph-rest-1.0), [Create servicePrincipal](https://learn.microsoft.com/en-us/graph/api/serviceprincipal-post-serviceprincipals?view=graph-rest-1.0).

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
