# /servicePrincipals

Create servicePrincipal

[Catalog](../../README.md) · [Applications](../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/serviceprincipal?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /servicePrincipals`, `GET/PATCH/DELETE /servicePrincipals/{servicePrincipal-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./applications/service-principals"
  app_id = "example"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `app_id` | `appId` | `string` | yes | no |
| `account_enabled` | `accountEnabled` | `bool` | no | no |
| `add_ins` | `addIns` | `list(object({       odata_type = optional(string, "#microsoft.graph.addIn")       id = optional(string)       properties = optional(list(object({       odata_type = optional(string, "#microsoft.graph.keyValue")       key = optional(string)       value = optional(string)     })))       type = optional(string)     }))` | no | no |
| `alternative_names` | `alternativeNames` | `list(string)` | no | no |
| `app_description` | `appDescription` | `string` | no | no |
| `app_display_name` | `appDisplayName` | `string` | no | no |
| `app_management_policies` | `appManagementPolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.appManagementPolicy")       appliesTo = optional(any)       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isEnabled = optional(bool)       restrictions = optional(object({       odata_type = optional(string, "#microsoft.graph.customAppManagementConfiguration")       applicationRestrictions = optional(object({       odata_type = optional(string, "#microsoft.graph.customAppManagementApplicationConfiguration")       audiences = optional(object({       odata_type = optional(string, "#microsoft.graph.audiencesConfiguration")       azureAdMultipleOrgs = optional(any)       personalMicrosoftAccount = optional(any)     }))       identifierUris = optional(object({       odata_type = optional(string, "#microsoft.graph.identifierUriConfiguration")       nonDefaultUriAddition = optional(any)       uriAdditionWithoutUniqueTenantIdentifier = optional(any)     }))       redirectUris = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriConfiguration")       uriWithBlockedDomain = optional(any)       uriWithBlockedScheme = optional(any)       uriWithWildcard = optional(any)       uriWithoutAllowedDomain = optional(any)       uriWithoutAllowedScheme = optional(any)     }))     }))       keyCredentials = optional(list(object({       odata_type = optional(string, "#microsoft.graph.keyCredentialConfiguration")       certificateBasedApplicationConfigurationIds = optional(any)       excludeActors = optional(any)       maxLifetime = optional(string)       restrictForAppsCreatedAfterDateTime = optional(string)       restrictionType = optional(string)       state = optional(string)     })))       passwordCredentials = optional(list(object({       odata_type = optional(string, "#microsoft.graph.passwordCredentialConfiguration")       excludeActors = optional(any)       maxLifetime = optional(string)       restrictForAppsCreatedAfterDateTime = optional(string)       restrictionType = optional(string)       state = optional(string)     })))     }))     }))` | no | yes |
| `app_owner_organization_id` | `appOwnerOrganizationId` | `string` | no | no |
| `app_role_assigned_to` | `appRoleAssignedTo` | `list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     }))` | no | no |
| `app_role_assignment_required` | `appRoleAssignmentRequired` | `bool` | no | no |
| `app_role_assignments` | `appRoleAssignments` | `list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     }))` | no | no |
| `app_roles` | `appRoles` | `list(object({       odata_type = optional(string, "#microsoft.graph.appRole")       allowedMemberTypes = optional(list(string))       description = optional(string)       displayName = optional(string)       id = optional(string)       isEnabled = optional(bool)       value = optional(string)     }))` | no | no |
| `claims_mapping_policies` | `claimsMappingPolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.claimsMappingPolicy")       appliesTo = optional(any)       definition = optional(list(string))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isOrganizationDefault = optional(bool)     }))` | no | no |
| `claims_policy` | `claimsPolicy` | `any` | no | no |
| `custom_security_attributes` | `customSecurityAttributes` | `any` | no | no |
| `delegated_permission_classifications` | `delegatedPermissionClassifications` | `list(object({       odata_type = optional(string, "#microsoft.graph.delegatedPermissionClassification")       classification = optional(string)       permissionId = optional(string)       permissionName = optional(string)     }))` | no | no |
| `deleted_date_time` | `deletedDateTime` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `disabled_by_microsoft_status` | `disabledByMicrosoftStatus` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `endpoints` | `endpoints` | `list(object({       odata_type = optional(string, "#microsoft.graph.endpoint")       deletedDateTime = optional(string)     }))` | no | no |
| `error_url` | `errorUrl` | `string` | no | no |
| `federated_identity_credentials` | `federatedIdentityCredentials` | `list(object({       odata_type = optional(string, "#microsoft.graph.federatedIdentityCredential")       audiences = optional(list(string))       claimsMatchingExpression = optional(object({       odata_type = optional(string, "#microsoft.graph.federatedIdentityExpression")       languageVersion = optional(number)       value = optional(string)     }))       description = optional(string)       issuer = optional(string)       name = optional(string)       subject = optional(string)     }))` | no | yes |
| `home_realm_discovery_policies` | `homeRealmDiscoveryPolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.homeRealmDiscoveryPolicy")       appliesTo = optional(any)       definition = optional(list(string))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isOrganizationDefault = optional(bool)     }))` | no | no |
| `homepage` | `homepage` | `string` | no | no |
| `info` | `info` | `object({       odata_type = optional(string, "#microsoft.graph.informationalUrl")       marketingUrl = optional(string)       privacyStatementUrl = optional(string)       supportUrl = optional(string)       termsOfServiceUrl = optional(string)     })` | no | no |
| `is_disabled` | `isDisabled` | `bool` | no | no |
| `key_credentials` | `keyCredentials` | `list(object({       odata_type = optional(string, "#microsoft.graph.keyCredential")       customKeyIdentifier = optional(string)       displayName = optional(string)       endDateTime = optional(string)       key = optional(string)       keyId = optional(string)       startDateTime = optional(string)       type = optional(string)       usage = optional(string)     }))` | no | yes |
| `license_details` | `licenseDetails` | `list(object({       odata_type = optional(string, "#microsoft.graph.licenseDetails")     }))` | no | no |
| `login_url` | `loginUrl` | `string` | no | no |
| `logout_url` | `logoutUrl` | `string` | no | no |
| `notes` | `notes` | `string` | no | no |
| `notification_email_addresses` | `notificationEmailAddresses` | `list(string)` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `owners` | `owners` | `any` | no | no |
| `password_credentials` | `passwordCredentials` | `list(object({       odata_type = optional(string, "#microsoft.graph.passwordCredential")       customKeyIdentifier = optional(string)       displayName = optional(string)       endDateTime = optional(string)       keyId = optional(string)       startDateTime = optional(string)     }))` | no | yes |
| `permission_grant_pre_approval_policies` | `permissionGrantPreApprovalPolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.permissionGrantPreApprovalPolicy")       conditions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.preApprovalDetail")       permissions = optional(any)       scopeType = optional(string)       sensitivityLabels = optional(any)     })))       deletedDateTime = optional(string)     }))` | no | no |
| `preferred_single_sign_on_mode` | `preferredSingleSignOnMode` | `string` | no | no |
| `preferred_token_signing_key_end_date_time` | `preferredTokenSigningKeyEndDateTime` | `string` | no | no |
| `preferred_token_signing_key_thumbprint` | `preferredTokenSigningKeyThumbprint` | `string` | no | no |
| `published_permission_scopes` | `publishedPermissionScopes` | `list(object({       odata_type = optional(string, "#microsoft.graph.permissionScope")       adminConsentDescription = optional(string)       adminConsentDisplayName = optional(string)       id = optional(string)       isEnabled = optional(bool)       origin = optional(string)       type = optional(string)       userConsentDescription = optional(string)       userConsentDisplayName = optional(string)       value = optional(string)     }))` | no | no |
| `publisher_name` | `publisherName` | `string` | no | no |
| `remote_desktop_security_configuration` | `remoteDesktopSecurityConfiguration` | `any` | no | no |
| `reply_urls` | `replyUrls` | `list(string)` | no | no |
| `saml_metadata_url` | `samlMetadataUrl` | `string` | no | no |
| `saml_single_sign_on_settings` | `samlSingleSignOnSettings` | `object({       odata_type = optional(string, "#microsoft.graph.samlSingleSignOnSettings")       relayState = optional(string)     })` | no | no |
| `service_principal_names` | `servicePrincipalNames` | `list(string)` | no | no |
| `service_principal_type` | `servicePrincipalType` | `string` | no | no |
| `synchronization` | `synchronization` | `any` | no | no |
| `tags` | `tags` | `list(string)` | no | no |
| `token_encryption_key_id` | `tokenEncryptionKeyId` | `string` | no | no |
| `token_issuance_policies` | `tokenIssuancePolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.tokenIssuancePolicy")       appliesTo = optional(any)       definition = optional(list(string))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isOrganizationDefault = optional(bool)     }))` | no | no |
| `token_lifetime_policies` | `tokenLifetimePolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.tokenLifetimePolicy")       appliesTo = optional(any)       definition = optional(list(string))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isOrganizationDefault = optional(bool)     }))` | no | no |
| `transitive_member_of` | `transitiveMemberOf` | `any` | no | no |
| `verified_publisher` | `verifiedPublisher` | `object({       odata_type = optional(string, "#microsoft.graph.verifiedPublisher")       addedDateTime = optional(string)       displayName = optional(string)       verifiedPublisherId = optional(string)     })` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Excluded by conditional read-only prose: passwordSingleSignOnSettings. Add a reviewed contract if the property is writable for your account type.
- Microsoft Graph beta contracts can change without notice.
- Reviewed create-required correction: appId.
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
- claimsMappingPolicies[].appliesTo[]: polymorphic schema; accepts an untyped value
- claimsPolicy: navigation property; accepts an untyped value
- customSecurityAttributes: polymorphic schema; accepts an untyped value
- homeRealmDiscoveryPolicies[].appliesTo[]: polymorphic schema; accepts an untyped value
- owners[]: polymorphic schema; accepts an untyped value
- permissionGrantPreApprovalPolicies[].conditions[].permissions: polymorphic schema; accepts an untyped value
- permissionGrantPreApprovalPolicies[].conditions[].sensitivityLabels: polymorphic schema; accepts an untyped value
- remoteDesktopSecurityConfiguration: navigation property; accepts an untyped value
- synchronization: navigation property; accepts an untyped value
- tokenIssuancePolicies[].appliesTo[]: polymorphic schema; accepts an untyped value
- tokenLifetimePolicies[].appliesTo[]: polymorphic schema; accepts an untyped value
- transitiveMemberOf[]: polymorphic schema; accepts an untyped value

## Licensing and prerequisites

Baseline rules reviewed on 2026-09-18 for the equivalent curated module `curated/service-principals` (confidence: inferred). Input-dependent rules were not re-verified against this module's inputs.

- **DIRECTORY-BASIC**: The reviewed create APIs for users, assigned security groups, applications and service principals specify no additional premium license. This covers the object operation only; features built on these objects can require licenses. No additional license specified. Coverage: No per-user entitlement for the object operation itself. Assignment: direct; capacity: per_tenant. Sources: [Create user](https://learn.microsoft.com/en-us/graph/api/user-post-users?view=graph-rest-1.0), [Create group](https://learn.microsoft.com/en-us/graph/api/group-post-groups?view=graph-rest-1.0), [Create application](https://learn.microsoft.com/en-us/graph/api/application-post-applications?view=graph-rest-1.0), [Create servicePrincipal](https://learn.microsoft.com/en-us/graph/api/serviceprincipal-post-serviceprincipals?view=graph-rest-1.0).

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
