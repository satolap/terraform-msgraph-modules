# /policies/appManagementPolicies

<!-- state-protection:start -->
## State and plan protection

This module's state and saved plans retain these declared values:

Sensitive inputs: `additional_properties`, `restrictions`.
Sensitive outputs: `response`.

Protect these values with an encrypted remote backend and least-privilege access to state, plans and backups. `sensitive` is presentation redaction, not encryption; provider resource values can still appear in plan/show output. Do not publish plan output in CI logs or PR comments for secret-bearing roots; keep saved plans short-lived and rotate credentials after exposure.

See [Terraform sensitive state guidance](https://developer.hashicorp.com/terraform/language/state/sensitive-data). These are exposure indicators, not a complete data classification; unmarked fields and provider responses also need protection.
<!-- state-protection:end -->

Create appManagementPolicy

[Catalog](../../README.md) Â· [Applications](../../README.md#applications) Â· [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/appmanagementpolicy?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /policies/appManagementPolicies`, `GET/PATCH/DELETE /policies/appManagementPolicies/{appManagementPolicy-id}`.

Assurance: **generated (offline contract)**. Schema-derived request construction and mock tests do not prove live service behavior.

> **Beta preview:** Microsoft Graph beta APIs may change without notice. Pin the module release version and provider version, and read `interface-changes.json` in the release before upgrading. Offline tests and live acceptance do not make a beta API production-supported.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//beta/policies/app-management-policies"
  version = "<version>"

}
```

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Read-back and drift

`select_response` defaults to `false`. Default reads keep `ignore_missing_property = true` and the full default GET response, including default-returned fields that were not configured. This preserves existing read behavior and response consumers, but can hide missing, null or empty reads. It does not prove a successful write or clear.

Strict read-back is not offered as a module input. Every generated body carries `@odata.type`, which ordinary GET responses omit; strict provider refresh would remove it and cause perpetual drift. Offering strict read-back requires annotation-aware comparison or a provider change, plus live proof.

Enabling `select_response` can plan an in-place resource update even when body values are unchanged. Whether an option-only change sends a write request is unverified; inspect the plan before opting in.

Only with `select_response = true`, the item GET selects `id`, `appId` when exposed as an output, and configured readable body keys (including additional properties). Annotations, known navigation properties and top-level write-only/omitted keys are excluded. This deliberately narrows the sensitive `response` output: an expression such as `module.group.response.mail` can stop working if mail was not selected. Use the default for existing consumers. Selection does not make provider refresh strict or prove a successful write.

No select-only inputs are identified by this metadata and contract; classification is incomplete.

Classification remains incomplete, especially for nested null-unless-selected values, permission-hidden properties and beta descriptions. Unclassified omissions can still be hidden by lenient refresh. Provider-refresh characterization tests are offline evidence, not proof of Graph behavior. Before offering strict read-back or changing the selection default, live independent GETs and repeated no-op plans must pass on users, groups, applications and servicePrincipals, including nested credentials and relationship cases.

## Timeouts and replication retries

The optional `timeouts` input (`create`, `read`, `update`, `delete`) is passed to the `msgraph_resource`. Every value defaults to null, which keeps the provider defaults and sends no timeouts block, so adding it changes no existing plan. Durations are whole hours, minutes or seconds greater than zero, such as `30m` or `1h30m`, and `create`, `update` and `delete` must be at least `15s`. Setting `read` plans an in-place update of every deployed object, because the provider's default read timeout is then replaced. The provider already retries 408, 429, 500, 502, 503 and 504 by itself.

This module has no reviewed replication retry.

## Inputs

**On change** says what changing an input does to the Graph object; [declaration.json](declaration.json) declares the same for tools, with the outputs. A nested object attribute behaves like the input that holds it.

| Input | Graph property | Type | Required | Sensitive | On change |
| --- | --- | --- | --- | --- | --- |
| `applies_to` | `appliesTo` | `any` | no | no | in place |
| `deleted_date_time` | `deletedDateTime` | `string` | no | no | in place |
| `description` | `description` | `string` | no | no | in place |
| `display_name` | `displayName` | `string` | no | no | in place |
| `is_enabled` | `isEnabled` | `bool` | no | no | in place |
| `odata_type` | `@odata.type` | `string` | no | no | in place |
| `restrictions` | `restrictions` | `object({       odata_type = optional(string, "#microsoft.graph.customAppManagementConfiguration")       applicationRestrictions = optional(object({       odata_type = optional(string, "#microsoft.graph.customAppManagementApplicationConfiguration")       audiences = optional(object({       odata_type = optional(string, "#microsoft.graph.audiencesConfiguration")       azureAdMultipleOrgs = optional(object({       odata_type = optional(string, "#microsoft.graph.azureAdMultipleOrgsAudienceRestriction")       excludeActors = optional(object({       odata_type = optional(string, "#microsoft.graph.appManagementPolicyActorExemptions")       customSecurityAttributes = optional(any)     }))       restrictForAppsCreatedAfterDateTime = optional(string)       state = optional(string)     }))       personalMicrosoftAccount = optional(any)     }))       identifierUris = optional(object({       odata_type = optional(string, "#microsoft.graph.identifierUriConfiguration")       nonDefaultUriAddition = optional(object({       odata_type = optional(string, "#microsoft.graph.identifierUriRestriction")       excludeActors = optional(object({       odata_type = optional(string, "#microsoft.graph.appManagementPolicyActorExemptions")       customSecurityAttributes = optional(any)     }))       excludeAppsReceivingV2Tokens = optional(bool)       excludeSaml = optional(bool)       restrictForAppsCreatedAfterDateTime = optional(string)       state = optional(string)     }))       uriAdditionWithoutUniqueTenantIdentifier = optional(object({       odata_type = optional(string, "#microsoft.graph.identifierUriRestriction")       excludeActors = optional(object({       odata_type = optional(string, "#microsoft.graph.appManagementPolicyActorExemptions")       customSecurityAttributes = optional(any)     }))       excludeAppsReceivingV2Tokens = optional(bool)       excludeSaml = optional(bool)       restrictForAppsCreatedAfterDateTime = optional(string)       state = optional(string)     }))     }))       redirectUris = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriConfiguration")       uriWithBlockedDomain = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriBlockedDomainConfiguration")       blockedDomains = optional(list(string))       excludeActors = optional(object({       odata_type = optional(string, "#microsoft.graph.appManagementPolicyActorExemptions")       customSecurityAttributes = optional(any)     }))       publicClient = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriPlatformBlockedDomainConfiguration")       blockedDomains = optional(any)     }))       restrictForAppsCreatedAfterDateTime = optional(string)       spa = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriPlatformBlockedDomainConfiguration")       blockedDomains = optional(any)     }))       state = optional(string)       web = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriPlatformBlockedDomainConfiguration")       blockedDomains = optional(any)     }))     }))       uriWithBlockedScheme = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriBlockedSchemeConfiguration")       blockedSchemes = optional(list(string))       excludeActors = optional(object({       odata_type = optional(string, "#microsoft.graph.appManagementPolicyActorExemptions")       customSecurityAttributes = optional(any)     }))       exemptFormats = optional(list(string))       publicClient = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriPlatformBlockedSchemeConfiguration")       blockedSchemes = optional(any)       exemptFormats = optional(any)     }))       restrictForAppsCreatedAfterDateTime = optional(string)       spa = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriPlatformBlockedSchemeConfiguration")       blockedSchemes = optional(any)       exemptFormats = optional(any)     }))       state = optional(string)       web = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriPlatformBlockedSchemeConfiguration")       blockedSchemes = optional(any)       exemptFormats = optional(any)     }))     }))       uriWithWildcard = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriWildcardConfiguration")       excludeActors = optional(object({       odata_type = optional(string, "#microsoft.graph.appManagementPolicyActorExemptions")       customSecurityAttributes = optional(any)     }))       excludeFormats = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriWildcardExcludeFormats")       excludeWildcardsInPath = optional(bool)       excludeWildcardsInPathWithDomains = optional(any)     }))       restrictForAppsCreatedAfterDateTime = optional(string)       state = optional(string)     }))       uriWithoutAllowedDomain = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriAllowedDomainConfiguration")       allowedDomains = optional(list(string))       excludeActors = optional(object({       odata_type = optional(string, "#microsoft.graph.appManagementPolicyActorExemptions")       customSecurityAttributes = optional(any)     }))       publicClient = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriPlatformAllowedDomainConfiguration")       allowedDomains = optional(any)     }))       restrictForAppsCreatedAfterDateTime = optional(string)       spa = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriPlatformAllowedDomainConfiguration")       allowedDomains = optional(any)     }))       state = optional(string)       web = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriPlatformAllowedDomainConfiguration")       allowedDomains = optional(any)     }))     }))       uriWithoutAllowedScheme = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriAllowedSchemeConfiguration")       allowedSchemes = optional(list(string))       excludeActors = optional(object({       odata_type = optional(string, "#microsoft.graph.appManagementPolicyActorExemptions")       customSecurityAttributes = optional(any)     }))       publicClient = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriPlatformAllowedSchemeConfiguration")       allowedSchemes = optional(any)     }))       restrictForAppsCreatedAfterDateTime = optional(string)       spa = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriPlatformAllowedSchemeConfiguration")       allowedSchemes = optional(any)     }))       state = optional(string)       web = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriPlatformAllowedSchemeConfiguration")       allowedSchemes = optional(any)     }))     }))     }))     }))       keyCredentials = optional(list(object({       odata_type = optional(string, "#microsoft.graph.keyCredentialConfiguration")       certificateBasedApplicationConfigurationIds = optional(list(string))       excludeActors = optional(object({       odata_type = optional(string, "#microsoft.graph.appManagementPolicyActorExemptions")       customSecurityAttributes = optional(any)     }))       maxLifetime = optional(string)       restrictForAppsCreatedAfterDateTime = optional(string)       restrictionType = optional(string)       state = optional(string)     })))       passwordCredentials = optional(list(object({       odata_type = optional(string, "#microsoft.graph.passwordCredentialConfiguration")       excludeActors = optional(object({       odata_type = optional(string, "#microsoft.graph.appManagementPolicyActorExemptions")       customSecurityAttributes = optional(any)     }))       maxLifetime = optional(string)       restrictForAppsCreatedAfterDateTime = optional(string)       restrictionType = optional(string)       state = optional(string)     })))     })` | no | yes | in place |
| `additional_properties` | Additional writable API properties | `any` | no | yes | in place |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Sensitive inputs, `additional_properties`, and the `response` output are redacted in normal Terraform presentation. Their values still exist in saved plans and state: restrict access to those files and the state backend. Sensitivity is not encryption or a substitute for state access controls.

## Outputs

**Known in plan after an update** is whether a plan still knows the value when it updates the object in place; a value read from the Graph response is known only after apply then.

| Output | Provides | Sensitive | Known in plan after an update |
| --- | --- | --- | --- |
| `id` | Graph object ID | no | yes |
| `resource_url` | Graph URL of the object | no | yes |
| `response` | the Graph object as returned | yes | no |

Server-assigned properties in `response`: `id`.

Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- appliesTo[]: polymorphic schema; accepts an untyped value
- restrictions.applicationRestrictions.audiences.azureAdMultipleOrgs.excludeActors.customSecurityAttributes: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.audiences.personalMicrosoftAccount: polymorphic schema; accepts an untyped value
- restrictions.applicationRestrictions.identifierUris.nonDefaultUriAddition.excludeActors.customSecurityAttributes: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.identifierUris.uriAdditionWithoutUniqueTenantIdentifier.excludeActors.customSecurityAttributes: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithBlockedDomain.excludeActors.customSecurityAttributes: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithBlockedDomain.publicClient.blockedDomains: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithBlockedDomain.spa.blockedDomains: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithBlockedDomain.web.blockedDomains: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithBlockedScheme.excludeActors.customSecurityAttributes: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithBlockedScheme.publicClient.blockedSchemes: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithBlockedScheme.publicClient.exemptFormats: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithBlockedScheme.spa.blockedSchemes: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithBlockedScheme.spa.exemptFormats: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithBlockedScheme.web.blockedSchemes: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithBlockedScheme.web.exemptFormats: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithWildcard.excludeActors.customSecurityAttributes: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithWildcard.excludeFormats.excludeWildcardsInPathWithDomains: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithoutAllowedDomain.excludeActors.customSecurityAttributes: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithoutAllowedDomain.publicClient.allowedDomains: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithoutAllowedDomain.spa.allowedDomains: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithoutAllowedDomain.web.allowedDomains: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithoutAllowedScheme.excludeActors.customSecurityAttributes: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithoutAllowedScheme.publicClient.allowedSchemes: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithoutAllowedScheme.spa.allowedSchemes: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithoutAllowedScheme.web.allowedSchemes: nested schema exceeds depth limit; accepts an untyped value
- restrictions.keyCredentials[].excludeActors.customSecurityAttributes[]: nested schema exceeds depth limit; accepts an untyped value
- restrictions.passwordCredentials[].excludeActors.customSecurityAttributes[]: nested schema exceeds depth limit; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
