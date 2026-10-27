# /applications

<!-- state-protection:start -->
## State and plan protection

This module's state and saved plans retain these declared values:

Sensitive inputs: `additional_properties`, `api`, `app_management_policies`, `federated_identity_credentials`, `key_credentials`, `on_premises_publishing`, `optional_claims`, `password_credentials`, `service_principal_lock_configuration`, `web`.
Sensitive outputs: `response`.

Protect these values with an encrypted remote backend and least-privilege access to state, plans and backups. `sensitive` is presentation redaction, not encryption; provider resource values can still appear in plan/show output. Do not publish plan output in CI logs or PR comments for secret-bearing roots; keep saved plans short-lived and rotate credentials after exposure.

See [Terraform sensitive state guidance](https://developer.hashicorp.com/terraform/language/state/sensitive-data). These are exposure indicators, not a complete data classification; unmarked fields and provider responses also need protection.
<!-- state-protection:end -->

Create application

[Catalog](../README.md) Â· [Applications](../README.md#applications) Â· [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/application?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /applications`, `GET/PATCH/DELETE /applications/{application-id}`.

Assurance: **generated (offline contract)**. Schema-derived request construction and mock tests do not prove live service behavior.

> **Beta preview:** Microsoft Graph beta APIs may change without notice. Pin the module release version and provider version, and read `interface-changes.json` in the release before upgrading. Offline tests and live acceptance do not make a beta API production-supported.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//beta/applications"
  version = "<version>"

  display_name = "example"
}
```

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Read-back and drift

`select_response` defaults to `false`. Default reads keep `ignore_missing_property = true` and the full default GET response, including default-returned fields that were not configured. This preserves existing read behavior and response consumers, but can hide missing, null or empty reads. It does not prove a successful write or clear.

Strict read-back is not offered as a module input. Every generated body carries `@odata.type`, which ordinary GET responses omit; strict provider refresh would remove it and cause perpetual drift. Offering strict read-back requires annotation-aware comparison or a provider change, plus live proof.

Enabling `select_response` can plan an in-place resource update even when body values are unchanged. Whether an option-only change sends a write request is unverified; inspect the plan before opting in.

Only with `select_response = true`, the item GET selects `id`, `appId` when exposed as an output, and configured readable body keys (including additional properties). Annotations, known navigation properties and top-level write-only/omitted keys are excluded. This deliberately narrows the sensitive `response` output: an expression such as `module.group.response.mail` can stop working if mail was not selected. Use the default for existing consumers. Selection does not make provider refresh strict or prove a successful write.

Select-only inputs: `authenticationBehaviors`, `keyCredentials`, `onPremisesPublishing`.

Classification remains incomplete, especially for nested null-unless-selected values, permission-hidden properties and beta descriptions. Unclassified omissions can still be hidden by lenient refresh. Provider-refresh characterization tests are offline evidence, not proof of Graph behavior. Before offering strict read-back or changing the selection default, live independent GETs and repeated no-op plans must pass on users, groups, applications and servicePrincipals, including nested credentials and relationship cases.

## Timeouts and replication retries

The optional `timeouts` input (`create`, `read`, `update`, `delete`) is passed to the `msgraph_resource`. Every value defaults to null, which keeps the provider defaults and sends no timeouts block, so adding it changes no existing plan. Durations are whole hours, minutes or seconds greater than zero, such as `30m` or `1h30m`, and `create`, `update` and `delete` must be at least `15s`. Setting `read` plans an in-place update of every deployed object, because the provider's default read timeout is then replaced. The provider already retries 408, 429, 500, 502, 503 and 504 by itself.

This module has no reviewed replication retry.

## Inputs

**On change** says what changing an input does to the Graph object; [declaration.json](declaration.json) declares the same for tools, with the outputs. A nested object attribute behaves like the input that holds it.

| Input | Graph property | Type | Required | Sensitive | On change |
| --- | --- | --- | --- | --- | --- |
| `display_name` | `displayName` | `string` | yes | no | in place |
| `api` | `api` | `object({       odata_type = optional(string, "#microsoft.graph.apiApplication")       acceptMappedClaims = optional(bool)       knownClientApplications = optional(list(string))       oauth2PermissionScopes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.permissionScope")       adminConsentDescription = optional(string)       adminConsentDisplayName = optional(string)       id = optional(string)       isEnabled = optional(bool)       origin = optional(string)       type = optional(string)       userConsentDescription = optional(string)       userConsentDisplayName = optional(string)       value = optional(string)     })))       preAuthorizedApplications = optional(list(object({       odata_type = optional(string, "#microsoft.graph.preAuthorizedApplication")       appId = optional(string)       permissionIds = optional(list(string))     })))       requestedAccessTokenVersion = optional(number)     })` | no | yes | in place |
| `app_management_policies` | `appManagementPolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.appManagementPolicy")       appliesTo = optional(any)       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isEnabled = optional(bool)       restrictions = optional(object({       odata_type = optional(string, "#microsoft.graph.customAppManagementConfiguration")       applicationRestrictions = optional(object({       odata_type = optional(string, "#microsoft.graph.customAppManagementApplicationConfiguration")       audiences = optional(object({       odata_type = optional(string, "#microsoft.graph.audiencesConfiguration")       azureAdMultipleOrgs = optional(any)       personalMicrosoftAccount = optional(any)     }))       identifierUris = optional(object({       odata_type = optional(string, "#microsoft.graph.identifierUriConfiguration")       nonDefaultUriAddition = optional(any)       uriAdditionWithoutUniqueTenantIdentifier = optional(any)     }))       redirectUris = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriConfiguration")       uriWithBlockedDomain = optional(any)       uriWithBlockedScheme = optional(any)       uriWithWildcard = optional(any)       uriWithoutAllowedDomain = optional(any)       uriWithoutAllowedScheme = optional(any)     }))     }))       keyCredentials = optional(list(object({       odata_type = optional(string, "#microsoft.graph.keyCredentialConfiguration")       certificateBasedApplicationConfigurationIds = optional(any)       excludeActors = optional(any)       maxLifetime = optional(string)       restrictForAppsCreatedAfterDateTime = optional(string)       restrictionType = optional(string)       state = optional(string)     })))       passwordCredentials = optional(list(object({       odata_type = optional(string, "#microsoft.graph.passwordCredentialConfiguration")       excludeActors = optional(any)       maxLifetime = optional(string)       restrictForAppsCreatedAfterDateTime = optional(string)       restrictionType = optional(string)       state = optional(string)     })))     }))     }))` | no | yes | in place |
| `app_roles` | `appRoles` | `list(object({       odata_type = optional(string, "#microsoft.graph.appRole")       allowedMemberTypes = optional(list(string))       description = optional(string)       displayName = optional(string)       id = optional(string)       isEnabled = optional(bool)       value = optional(string)     }))` | no | no | in place |
| `authentication_behaviors` | `authenticationBehaviors` | `object({       odata_type = optional(string, "#microsoft.graph.authenticationBehaviors")       blockAzureADGraphAccess = optional(bool)       coopEnforcement = optional(bool)       removeUnverifiedEmailClaim = optional(bool)       requireClientServicePrincipal = optional(bool)     })` | no | no | in place |
| `certification` | `certification` | `object({       odata_type = optional(string, "#microsoft.graph.certification")       certificationExpirationDateTime = optional(string)       isPublisherAttested = optional(bool)       lastCertificationDateTime = optional(string)     })` | no | no | in place |
| `connector_group` | `connectorGroup` | `any` | no | no | in place |
| `default_redirect_uri` | `defaultRedirectUri` | `string` | no | no | in place |
| `deleted_date_time` | `deletedDateTime` | `string` | no | no | in place |
| `description` | `description` | `string` | no | no | in place |
| `disabled_by_microsoft_status` | `disabledByMicrosoftStatus` | `string` | no | no | in place |
| `federated_identity_credentials` | `federatedIdentityCredentials` | `list(object({       odata_type = optional(string, "#microsoft.graph.federatedIdentityCredential")       audiences = optional(list(string))       claimsMatchingExpression = optional(object({       odata_type = optional(string, "#microsoft.graph.federatedIdentityExpression")       languageVersion = optional(number)       value = optional(string)     }))       description = optional(string)       issuer = optional(string)       name = optional(string)       subject = optional(string)     }))` | no | yes | in place |
| `group_membership_claims` | `groupMembershipClaims` | `string` | no | no | in place |
| `home_realm_discovery_policies` | `homeRealmDiscoveryPolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.homeRealmDiscoveryPolicy")       appliesTo = optional(any)       definition = optional(list(string))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isOrganizationDefault = optional(bool)     }))` | no | no | in place |
| `identifier_uris` | `identifierUris` | `list(string)` | no | no | in place |
| `info` | `info` | `object({       odata_type = optional(string, "#microsoft.graph.informationalUrl")       marketingUrl = optional(string)       privacyStatementUrl = optional(string)       supportUrl = optional(string)       termsOfServiceUrl = optional(string)     })` | no | no | in place |
| `is_device_only_auth_supported` | `isDeviceOnlyAuthSupported` | `bool` | no | no | in place |
| `is_disabled` | `isDisabled` | `bool` | no | no | in place |
| `is_fallback_public_client` | `isFallbackPublicClient` | `bool` | no | no | in place |
| `key_credentials` | `keyCredentials` | `list(object({       odata_type = optional(string, "#microsoft.graph.keyCredential")       customKeyIdentifier = optional(string)       displayName = optional(string)       endDateTime = optional(string)       key = optional(string)       keyId = optional(string)       startDateTime = optional(string)       type = optional(string)       usage = optional(string)     }))` | no | yes | in place |
| `logo` | `logo` | `string` | no | no | in place |
| `native_authentication_apis_enabled` | `nativeAuthenticationApisEnabled` | `string` | no | no | in place |
| `notes` | `notes` | `string` | no | no | in place |
| `odata_type` | `@odata.type` | `string` | no | no | in place |
| `on_premises_publishing` | `onPremisesPublishing` | `object({       odata_type = optional(string, "#microsoft.graph.onPremisesPublishing")       alternateUrl = optional(string)       applicationServerTimeout = optional(string)       externalAuthenticationType = optional(string)       externalUrl = optional(string)       internalUrl = optional(string)       isAccessibleViaZTNAClient = optional(bool)       isBackendCertificateValidationEnabled = optional(bool)       isContinuousAccessEvaluationEnabled = optional(bool)       isDeviceAccessEnabled = optional(bool)       isDnsResolutionEnabled = optional(bool)       isHttpOnlyCookieEnabled = optional(bool)       isPersistentCookieEnabled = optional(bool)       isSecureCookieEnabled = optional(bool)       isStateSessionEnabled = optional(bool)       isTranslateHostHeaderEnabled = optional(bool)       isTranslateLinksInBodyEnabled = optional(bool)       onPremisesApplicationSegments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.onPremisesApplicationSegment")       alternateUrl = optional(string)       corsConfigurations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.corsConfiguration")       allowedHeaders = optional(any)       allowedMethods = optional(any)       allowedOrigins = optional(any)       maxAgeInSeconds = optional(number)       resource = optional(string)     })))       externalUrl = optional(string)       internalUrl = optional(string)     })))       segmentsConfiguration = optional(any)       singleSignOnSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.onPremisesPublishingSingleSignOn")       kerberosSignOnSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.kerberosSignOnSettings")       kerberosServicePrincipalName = optional(string)       kerberosSignOnMappingAttributeType = optional(string)     }))       singleSignOnMode = optional(string)     }))       trafficRoutingMethod = optional(string)       useAlternateUrlForTranslationAndRedirect = optional(bool)       verifiedCustomDomainKeyCredential = optional(object({       odata_type = optional(string, "#microsoft.graph.keyCredential")       customKeyIdentifier = optional(string)       displayName = optional(string)       endDateTime = optional(string)       key = optional(string)       keyId = optional(string)       startDateTime = optional(string)       type = optional(string)       usage = optional(string)     }))       verifiedCustomDomainPasswordCredential = optional(object({       odata_type = optional(string, "#microsoft.graph.passwordCredential")       customKeyIdentifier = optional(string)       displayName = optional(string)       endDateTime = optional(string)       keyId = optional(string)       startDateTime = optional(string)     }))       wafAllowedHeaders = optional(any)       wafIpRanges = optional(any)       wafProvider = optional(string)     })` | no | yes | in place |
| `optional_claims` | `optionalClaims` | `object({       odata_type = optional(string, "#microsoft.graph.optionalClaims")       accessToken = optional(list(object({       odata_type = optional(string, "#microsoft.graph.optionalClaim")       additionalProperties = optional(list(string))       essential = optional(bool)       name = optional(string)       source = optional(string)     })))       idToken = optional(list(object({       odata_type = optional(string, "#microsoft.graph.optionalClaim")       additionalProperties = optional(list(string))       essential = optional(bool)       name = optional(string)       source = optional(string)     })))       saml2Token = optional(list(object({       odata_type = optional(string, "#microsoft.graph.optionalClaim")       additionalProperties = optional(list(string))       essential = optional(bool)       name = optional(string)       source = optional(string)     })))     })` | no | yes | in place |
| `parental_control_settings` | `parentalControlSettings` | `object({       odata_type = optional(string, "#microsoft.graph.parentalControlSettings")       countriesBlockedForMinors = optional(list(string))       legalAgeGroupRule = optional(string)     })` | no | no | in place |
| `password_credentials` | `passwordCredentials` | `list(object({       odata_type = optional(string, "#microsoft.graph.passwordCredential")       customKeyIdentifier = optional(string)       displayName = optional(string)       endDateTime = optional(string)       keyId = optional(string)       startDateTime = optional(string)     }))` | no | yes | in place |
| `public_client` | `publicClient` | `object({       odata_type = optional(string, "#microsoft.graph.publicClientApplication")       redirectUris = optional(list(string))     })` | no | no | in place |
| `request_signature_verification` | `requestSignatureVerification` | `object({       odata_type = optional(string, "#microsoft.graph.requestSignatureVerification")       allowedWeakAlgorithms = optional(string)       isSignedRequestRequired = optional(bool)     })` | no | no | in place |
| `required_resource_access` | `requiredResourceAccess` | `list(object({       odata_type = optional(string, "#microsoft.graph.requiredResourceAccess")       resourceAccess = optional(list(object({       odata_type = optional(string, "#microsoft.graph.resourceAccess")       id = optional(string)       type = optional(string)     })))       resourceAppId = optional(string)     }))` | no | no | in place |
| `saml_metadata_url` | `samlMetadataUrl` | `string` | no | no | in place |
| `service_management_reference` | `serviceManagementReference` | `string` | no | no | in place |
| `service_principal_lock_configuration` | `servicePrincipalLockConfiguration` | `object({       odata_type = optional(string, "#microsoft.graph.servicePrincipalLockConfiguration")       allProperties = optional(bool)       credentialsWithUsageSign = optional(bool)       credentialsWithUsageVerify = optional(bool)       isEnabled = optional(bool)       tokenEncryptionKeyId = optional(bool)     })` | no | yes | in place |
| `sign_in_audience` | `signInAudience` | `string` | no | no | in place |
| `sign_in_audience_restrictions` | `signInAudienceRestrictions` | `any` | no | no | in place |
| `spa` | `spa` | `object({       odata_type = optional(string, "#microsoft.graph.spaApplication")       redirectUris = optional(list(string))     })` | no | no | in place |
| `synchronization` | `synchronization` | `any` | no | no | in place |
| `tags` | `tags` | `list(string)` | no | no | in place |
| `token_encryption_key_id` | `tokenEncryptionKeyId` | `string` | no | no | in place |
| `token_issuance_policies` | `tokenIssuancePolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.tokenIssuancePolicy")       appliesTo = optional(any)       definition = optional(list(string))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isOrganizationDefault = optional(bool)     }))` | no | no | in place |
| `token_lifetime_policies` | `tokenLifetimePolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.tokenLifetimePolicy")       appliesTo = optional(any)       definition = optional(list(string))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isOrganizationDefault = optional(bool)     }))` | no | no | in place |
| `verified_publisher` | `verifiedPublisher` | `object({       odata_type = optional(string, "#microsoft.graph.verifiedPublisher")       addedDateTime = optional(string)       displayName = optional(string)       verifiedPublisherId = optional(string)     })` | no | no | in place |
| `web` | `web` | `object({       odata_type = optional(string, "#microsoft.graph.webApplication")       homePageUrl = optional(string)       implicitGrantSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.implicitGrantSettings")       enableAccessTokenIssuance = optional(bool)       enableIdTokenIssuance = optional(bool)     }))       logoutUrl = optional(string)       oauth2AllowImplicitFlow = optional(bool)       redirectUriSettings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.redirectUriSettings")       index = optional(number)       uri = optional(string)     })))       redirectUris = optional(list(string))     })` | no | yes | in place |
| `windows` | `windows` | `object({       odata_type = optional(string, "#microsoft.graph.windowsApplication")       redirectUris = optional(list(string))     })` | no | no | in place |
| `additional_properties` | Additional writable API properties | `any` | no | yes | in place |

Unique values, inferred from the pinned metadata (declaration.json gives each source): `identifier_uris` globally. Graph refuses a value already used in that scope, or, where the rule is a combination, only the same combination; some of these values, such as identity provider claims, are dictated by another system rather than chosen freely.

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Sensitive inputs, `additional_properties`, and the `response` output are redacted in normal Terraform presentation. Their values still exist in saved plans and state: restrict access to those files and the state backend. Sensitivity is not encryption or a substitute for state access controls.

## Outputs

**Known in plan after an update** is whether a plan still knows the value when it updates the object in place; a value read from the Graph response is known only after apply then.

| Output | Provides | Sensitive | Known in plan after an update |
| --- | --- | --- | --- |
| `id` | Graph object ID | no | yes |
| `resource_url` | Graph URL of the object | no | yes |
| `response` | the Graph object as returned | yes | no |
| `app_id` | application (client) ID | no | yes |

Server-assigned properties in `response`: `appId`, `createdByAppId`, `createdDateTime`, `createdOnBehalfOf`, `extensionProperties`, `id`, `managerApplications`, `owners`, `publisherDomain`, `uniqueName`.

Unique server-assigned values: `appId` within `/applications`; `uniqueName` within `/applications`.

Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

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

Baseline rules reviewed on 2026-09-18 for the equivalent verified module `verified/applications` (confidence: inferred). Input-dependent rules were not re-verified against this module's inputs.

- **DIRECTORY-BASIC**: The reviewed create APIs for users, assigned security groups, applications and service principals specify no additional premium license. This covers the object operation only; features built on these objects can require licenses. No additional license specified. Coverage: No per-user entitlement for the object operation itself. Assignment: direct; capacity: per_tenant. Sources: [Create user](https://learn.microsoft.com/en-us/graph/api/user-post-users?view=graph-rest-1.0), [Create group](https://learn.microsoft.com/en-us/graph/api/group-post-groups?view=graph-rest-1.0), [Create application](https://learn.microsoft.com/en-us/graph/api/application-post-applications?view=graph-rest-1.0), [Create servicePrincipal](https://learn.microsoft.com/en-us/graph/api/serviceprincipal-post-serviceprincipals?view=graph-rest-1.0).

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
