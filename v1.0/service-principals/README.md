# /servicePrincipals

<!-- state-protection:start -->
## State and plan protection

This module's state and saved plans retain these declared values:

Sensitive inputs: `additional_properties`, `app_management_policies`, `federated_identity_credentials`, `key_credentials`, `password_credentials`.
Sensitive outputs: `response`.

Protect these values with an encrypted remote backend and least-privilege access to state, plans and backups. `sensitive` is presentation redaction, not encryption; provider resource values can still appear in plan/show output. Do not publish plan output in CI logs or PR comments for secret-bearing roots; keep saved plans short-lived and rotate credentials after exposure.

See [Terraform sensitive state guidance](https://developer.hashicorp.com/terraform/language/state/sensitive-data). These are exposure indicators, not a complete data classification; unmarked fields and provider responses also need protection.
<!-- state-protection:end -->

Create servicePrincipal

[Catalog](../README.md) Â· [Applications](../README.md#applications) Â· [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/serviceprincipal?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /servicePrincipals`, `GET/PATCH/DELETE /servicePrincipals/{servicePrincipal-id}`.

Assurance: **generated (offline contract)**. Schema-derived request construction and mock tests do not prove live service behavior.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//v1.0/service-principals"
  version = "<version>"

  app_id = "example"
}
```

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Replacement on change

Microsoft Graph accepts the inputs below only when it creates the object (the generation notes cite the reviewed source; the Core.Immutable annotation of the pinned metadata marks some of them). A change to one, set as a typed input or as the same key in `additional_properties`, plans a destroy and a create of `msgraph_resource.this` through `terraform_data.immutable` and `replace_triggered_by`, so Graph never receives a changed create-only value in an update and `terraform apply -replace` is not needed. Every other input and every other key of `additional_properties` updates the object in place. Terraform deletes the old object before it creates the new one (`create_before_destroy` is not set). The replacement has a new `id`, and anything that stored the old `id` must read the new one. `terraform_data.immutable` holds the values below and makes no API call.

| Input | Graph property |
| --- | --- |
| `app_id` | `appId` |

A change between an unset input and a value that Graph treats as its default also replaces the object here, because no reviewed default is recorded for these inputs.

Compared and sent in lower case, so a change of only the letter case keeps the object and sends no update: `app_id`.

Terraform plans a replacement only when `terraform_data.immutable` is updated or replaced, not when it is created. After an upgrade from a release that lacked it, or after an import, apply once with unchanged inputs; a change to one of these inputs made in the apply that creates it still updates the object in place. The replacement behavior is covered by mocked tests only, not by a live tenant.

## Read-back and drift

`select_response` defaults to `false`. Default reads keep `ignore_missing_property = true` and the full default GET response, including default-returned fields that were not configured. This preserves existing read behavior and response consumers, but can hide missing, null or empty reads. It does not prove a successful write or clear.

Strict read-back is not offered as a module input. Every generated body carries `@odata.type`, which ordinary GET responses omit; strict provider refresh would remove it and cause perpetual drift. Offering strict read-back requires annotation-aware comparison or a provider change, plus live proof.

Enabling `select_response` can plan an in-place resource update even when body values are unchanged. Whether an option-only change sends a write request is unverified; inspect the plan before opting in.

Only with `select_response = true`, the item GET selects `id`, `appId` when exposed as an output, and configured readable body keys (including additional properties). Annotations, known navigation properties and top-level write-only/omitted keys are excluded. This deliberately narrows the sensitive `response` output: an expression such as `module.group.response.mail` can stop working if mail was not selected. Use the default for existing consumers. Selection does not make provider refresh strict or prove a successful write.

Select-only inputs: `customSecurityAttributes`, `keyCredentials`.

Classification remains incomplete, especially for nested null-unless-selected values, permission-hidden properties and beta descriptions. Unclassified omissions can still be hidden by lenient refresh. Provider-refresh characterization tests are offline evidence, not proof of Graph behavior. Before offering strict read-back or changing the selection default, live independent GETs and repeated no-op plans must pass on users, groups, applications and servicePrincipals, including nested credentials and relationship cases.

## Timeouts and replication retries

The optional `timeouts` input (`create`, `read`, `update`, `delete`) is passed to the `msgraph_resource`. Every value defaults to null, which keeps the provider defaults and sends no timeouts block, so adding it changes no existing plan. Durations are whole hours, minutes or seconds greater than zero, such as `30m` or `1h30m`, and `create`, `update` and `delete` must be at least `15s`. Setting `read` plans an in-place update of every deployed object, because the provider's default read timeout is then replaced. The provider already retries 408, 429, 500, 502, 503 and 504 by itself.

This module has no reviewed replication retry.

## Inputs

**On change** says what changing an input does to the Graph object; [declaration.json](declaration.json) declares the same for tools, with the outputs. A nested object attribute behaves like the input that holds it.

| Input | Graph property | Type | Required | Sensitive | On change |
| --- | --- | --- | --- | --- | --- |
| `app_id` | `appId` | `string` | yes | no | replaces object |
| `account_enabled` | `accountEnabled` | `bool` | no | no | in place |
| `add_ins` | `addIns` | `list(object({       odata_type = optional(string, "#microsoft.graph.addIn")       id = optional(string)       properties = optional(list(object({       odata_type = optional(string, "#microsoft.graph.keyValue")       key = optional(string)       value = optional(string)     })))       type = optional(string)     }))` | no | no | in place |
| `alternative_names` | `alternativeNames` | `list(string)` | no | no | in place |
| `app_description` | `appDescription` | `string` | no | no | in place |
| `app_display_name` | `appDisplayName` | `string` | no | no | in place |
| `app_management_policies` | `appManagementPolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.appManagementPolicy")       appliesTo = optional(any)       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isEnabled = optional(bool)       restrictions = optional(object({       odata_type = optional(string, "#microsoft.graph.customAppManagementConfiguration")       applicationRestrictions = optional(object({       odata_type = optional(string, "#microsoft.graph.customAppManagementApplicationConfiguration")       identifierUris = optional(object({       odata_type = optional(string, "#microsoft.graph.identifierUriConfiguration")       nonDefaultUriAddition = optional(any)       uriAdditionWithoutUniqueTenantIdentifier = optional(any)     }))     }))       keyCredentials = optional(list(object({       odata_type = optional(string, "#microsoft.graph.keyCredentialConfiguration")       excludeActors = optional(any)       maxLifetime = optional(string)       restrictForAppsCreatedAfterDateTime = optional(string)       restrictionType = optional(string)       state = optional(string)     })))       passwordCredentials = optional(list(object({       odata_type = optional(string, "#microsoft.graph.passwordCredentialConfiguration")       excludeActors = optional(any)       maxLifetime = optional(string)       restrictForAppsCreatedAfterDateTime = optional(string)       restrictionType = optional(string)       state = optional(string)     })))     }))     }))` | no | yes | in place |
| `app_owner_organization_id` | `appOwnerOrganizationId` | `string` | no | no | in place |
| `app_role_assigned_to` | `appRoleAssignedTo` | `list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     }))` | no | no | in place |
| `app_role_assignment_required` | `appRoleAssignmentRequired` | `bool` | no | no | in place |
| `app_role_assignments` | `appRoleAssignments` | `list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     }))` | no | no | in place |
| `app_roles` | `appRoles` | `list(object({       odata_type = optional(string, "#microsoft.graph.appRole")       allowedMemberTypes = optional(list(string))       description = optional(string)       displayName = optional(string)       id = optional(string)       isEnabled = optional(bool)       value = optional(string)     }))` | no | no | in place |
| `claims_mapping_policies` | `claimsMappingPolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.claimsMappingPolicy")       appliesTo = optional(any)       definition = optional(list(string))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isOrganizationDefault = optional(bool)     }))` | no | no | in place |
| `custom_security_attributes` | `customSecurityAttributes` | `any` | no | no | in place |
| `delegated_permission_classifications` | `delegatedPermissionClassifications` | `list(object({       odata_type = optional(string, "#microsoft.graph.delegatedPermissionClassification")       classification = optional(string)       permissionId = optional(string)       permissionName = optional(string)     }))` | no | no | in place |
| `deleted_date_time` | `deletedDateTime` | `string` | no | no | in place |
| `description` | `description` | `string` | no | no | in place |
| `disabled_by_microsoft_status` | `disabledByMicrosoftStatus` | `string` | no | no | in place |
| `display_name` | `displayName` | `string` | no | no | in place |
| `endpoints` | `endpoints` | `list(object({       odata_type = optional(string, "#microsoft.graph.endpoint")       capability = optional(string)       deletedDateTime = optional(string)       providerId = optional(string)       providerName = optional(string)       providerResourceId = optional(string)       uri = optional(string)     }))` | no | no | in place |
| `federated_identity_credentials` | `federatedIdentityCredentials` | `list(object({       odata_type = optional(string, "#microsoft.graph.federatedIdentityCredential")       audiences = optional(list(string))       description = optional(string)       issuer = optional(string)       name = optional(string)       subject = optional(string)     }))` | no | yes | in place |
| `home_realm_discovery_policies` | `homeRealmDiscoveryPolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.homeRealmDiscoveryPolicy")       appliesTo = optional(any)       definition = optional(list(string))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isOrganizationDefault = optional(bool)     }))` | no | no | in place |
| `homepage` | `homepage` | `string` | no | no | in place |
| `info` | `info` | `object({       odata_type = optional(string, "#microsoft.graph.informationalUrl")       marketingUrl = optional(string)       privacyStatementUrl = optional(string)       supportUrl = optional(string)       termsOfServiceUrl = optional(string)     })` | no | no | in place |
| `is_disabled` | `isDisabled` | `bool` | no | no | in place |
| `key_credentials` | `keyCredentials` | `list(object({       odata_type = optional(string, "#microsoft.graph.keyCredential")       customKeyIdentifier = optional(string)       displayName = optional(string)       endDateTime = optional(string)       key = optional(string)       keyId = optional(string)       startDateTime = optional(string)       type = optional(string)       usage = optional(string)     }))` | no | yes | in place |
| `login_url` | `loginUrl` | `string` | no | no | in place |
| `logout_url` | `logoutUrl` | `string` | no | no | in place |
| `notes` | `notes` | `string` | no | no | in place |
| `notification_email_addresses` | `notificationEmailAddresses` | `list(string)` | no | no | in place |
| `oauth2_permission_scopes` | `oauth2PermissionScopes` | `list(object({       odata_type = optional(string, "#microsoft.graph.permissionScope")       adminConsentDescription = optional(string)       adminConsentDisplayName = optional(string)       id = optional(string)       isEnabled = optional(bool)       origin = optional(string)       type = optional(string)       userConsentDescription = optional(string)       userConsentDisplayName = optional(string)       value = optional(string)     }))` | no | no | in place |
| `odata_type` | `@odata.type` | `string` | no | no | in place |
| `owners` | `owners` | `any` | no | no | in place |
| `password_credentials` | `passwordCredentials` | `list(object({       odata_type = optional(string, "#microsoft.graph.passwordCredential")       customKeyIdentifier = optional(string)       displayName = optional(string)       endDateTime = optional(string)       keyId = optional(string)       startDateTime = optional(string)     }))` | no | yes | in place |
| `preferred_single_sign_on_mode` | `preferredSingleSignOnMode` | `string` | no | no | in place |
| `preferred_token_signing_key_thumbprint` | `preferredTokenSigningKeyThumbprint` | `string` | no | no | in place |
| `remote_desktop_security_configuration` | `remoteDesktopSecurityConfiguration` | `any` | no | no | in place |
| `reply_urls` | `replyUrls` | `list(string)` | no | no | in place |
| `saml_single_sign_on_settings` | `samlSingleSignOnSettings` | `object({       odata_type = optional(string, "#microsoft.graph.samlSingleSignOnSettings")       relayState = optional(string)     })` | no | no | in place |
| `service_principal_names` | `servicePrincipalNames` | `list(string)` | no | no | in place |
| `service_principal_type` | `servicePrincipalType` | `string` | no | no | in place |
| `synchronization` | `synchronization` | `any` | no | no | in place |
| `tags` | `tags` | `list(string)` | no | no | in place |
| `token_encryption_key_id` | `tokenEncryptionKeyId` | `string` | no | no | in place |
| `token_issuance_policies` | `tokenIssuancePolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.tokenIssuancePolicy")       appliesTo = optional(any)       definition = optional(list(string))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isOrganizationDefault = optional(bool)     }))` | no | no | in place |
| `token_lifetime_policies` | `tokenLifetimePolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.tokenLifetimePolicy")       appliesTo = optional(any)       definition = optional(list(string))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isOrganizationDefault = optional(bool)     }))` | no | no | in place |
| `transitive_member_of` | `transitiveMemberOf` | `any` | no | no | in place |
| `verified_publisher` | `verifiedPublisher` | `object({       odata_type = optional(string, "#microsoft.graph.verifiedPublisher")       addedDateTime = optional(string)       displayName = optional(string)       verifiedPublisherId = optional(string)     })` | no | no | in place |
| `additional_properties` | Additional writable API properties | `any` | no | yes | replaces object for keys `appId` |

Unique values, inferred from the pinned metadata (declaration.json gives each source): `app_id` within `/servicePrincipals`. Graph refuses a value already used in that scope, or, where the rule is a combination, only the same combination; some of these values, such as identity provider claims, are dictated by another system rather than chosen freely.

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

Server-assigned properties in `response`: `applicationTemplateId`, `createdByAppId`, `createdObjects`, `id`, `memberOf`, `oauth2PermissionGrants`, `ownedObjects`, `resourceSpecificApplicationPermissions`, `signInAudience`.

Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Reviewed create-only inputs: appId (https://learn.microsoft.com/en-us/graph/api/serviceprincipal-update); a change to one replaces the object and every other input updates in place.
- Reviewed create-required correction: appId.
- appManagementPolicies[].appliesTo[]: polymorphic schema; accepts an untyped value
- appManagementPolicies[].restrictions.applicationRestrictions.identifierUris.nonDefaultUriAddition: nested schema exceeds depth limit; accepts an untyped value
- appManagementPolicies[].restrictions.applicationRestrictions.identifierUris.uriAdditionWithoutUniqueTenantIdentifier: nested schema exceeds depth limit; accepts an untyped value
- appManagementPolicies[].restrictions.keyCredentials[].excludeActors: nested schema exceeds depth limit; accepts an untyped value
- appManagementPolicies[].restrictions.passwordCredentials[].excludeActors: nested schema exceeds depth limit; accepts an untyped value
- claimsMappingPolicies[].appliesTo[]: polymorphic schema; accepts an untyped value
- customSecurityAttributes: polymorphic schema; accepts an untyped value
- homeRealmDiscoveryPolicies[].appliesTo[]: polymorphic schema; accepts an untyped value
- owners[]: polymorphic schema; accepts an untyped value
- remoteDesktopSecurityConfiguration: navigation property; accepts an untyped value
- synchronization: navigation property; accepts an untyped value
- tokenIssuancePolicies[].appliesTo[]: polymorphic schema; accepts an untyped value
- tokenLifetimePolicies[].appliesTo[]: polymorphic schema; accepts an untyped value
- transitiveMemberOf[]: polymorphic schema; accepts an untyped value

## Licensing and prerequisites

Baseline rules reviewed on 2026-09-18 for the equivalent verified module `verified/service-principals` (confidence: inferred). Input-dependent rules were not re-verified against this module's inputs.

- **DIRECTORY-BASIC**: The reviewed create APIs for users, assigned security groups, applications and service principals specify no additional premium license. This covers the object operation only; features built on these objects can require licenses. No additional license specified. Coverage: No per-user entitlement for the object operation itself. Assignment: direct; capacity: per_tenant. Sources: [Create user](https://learn.microsoft.com/en-us/graph/api/user-post-users?view=graph-rest-1.0), [Create group](https://learn.microsoft.com/en-us/graph/api/group-post-groups?view=graph-rest-1.0), [Create application](https://learn.microsoft.com/en-us/graph/api/application-post-applications?view=graph-rest-1.0), [Create servicePrincipal](https://learn.microsoft.com/en-us/graph/api/serviceprincipal-post-serviceprincipals?view=graph-rest-1.0).

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. Its apply runs also check which input changes update the object in place and which replace it. It does not verify permissions or server behavior.
