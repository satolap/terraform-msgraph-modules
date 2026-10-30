# /identity/conditionalAccess/policies

Create conditionalAccessPolicy

[Catalog](../../../README.md) Â· [Identity and access](../../../README.md#identity-and-access) Â· [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/conditionalaccesspolicy?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /identity/conditionalAccess/policies`, `GET/PATCH/DELETE /identity/conditionalAccess/policies/{conditionalAccessPolicy-id}`.

Assurance: **generated (offline contract)**. Schema-derived request construction and mock tests do not prove live service behavior.

## Lockout warning

This generated module has no emergency-access exclusion guard or report-only default. Policies targeting All users or All applications with block or grant controls can lock out administrators. Start with `state = "enabledForReportingButNotEnforced"`, exclude existing emergency-access users by object ID in `conditions.users.excludeUsers`, and verify the exclusions independently before explicitly enabling enforcement. Keep emergency accounts and their recovery credentials outside Terraform. Prefer the verified Conditional Access policies module for validated inputs and mandatory exclusions; these checks do not prove the accounts can sign in.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//v1.0/identity/conditional-access/policies"
  version = "<version>"

}
```

Replace `<version>` with a release version, such as `1.0.0`; the [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Read-back and drift

`select_response` defaults to `false`. Default reads keep `ignore_missing_property = true` and the full default GET response, including default-returned fields that were not configured. This preserves existing read behavior and response consumers, but can hide missing, null or empty reads. It does not prove a successful write or clear.

Strict read-back is not offered as a module input. Every generated body carries `@odata.type`, which ordinary GET responses omit; strict provider refresh would remove it and cause perpetual drift. Offering strict read-back requires annotation-aware comparison or a provider change, plus live proof.

Enabling `select_response` can plan an in-place resource update even when body values are unchanged. Whether an option-only change sends a write request is unverified; inspect the plan before opting in.

Only with `select_response = true`, the item GET selects `id`, `appId` when exposed as an output, and configured readable body keys (including additional properties). Annotations, known navigation properties and top-level write-only/omitted keys are excluded. This deliberately narrows the sensitive `response` output: an expression such as `module.group.response.mail` can stop working if mail was not selected. Use the default for existing consumers. Selection does not make provider refresh strict or prove a successful write.

No select-only inputs are identified by this metadata and contract; classification is incomplete.

Classification remains incomplete, especially for nested null-unless-selected values, permission-hidden properties and beta descriptions. Unclassified omissions can still be hidden by lenient refresh. Provider-refresh characterization tests are offline evidence, not proof of Graph behavior. Before offering strict read-back or changing the selection default, live independent GETs and repeated no-op plans must pass on users, groups, applications and servicePrincipals, including nested credentials and relationship cases.

## Timeouts and replication retries

The optional `timeouts` input (`create`, `read`, `update`, `delete`) is passed to the `msgraph_resource`. Every value defaults to null, which keeps the provider defaults and sends no timeouts block, so adding it changes no existing plan. Durations are whole hours, minutes or seconds greater than zero, such as `30m` or `1h30m`, and `create`, `update` and `delete` must be at least `15s`. Setting `read` plans an in-place update of every deployed object, because the provider's default read timeout is then replaced. The provider already retries 408, 429, 500, 502, 503 and 504 by itself.

A request that references another object can fail until Microsoft Graph has replicated that object. For the reviewed cases below the module sets the provider retry to one reviewed message anchored to the Graph error envelope, with the error code each pattern below names, and to nothing otherwise. The message cannot occur in a Graph-generated success body, and a plan-time precondition rejects any request body that contains it, so a value echoed back by Graph cannot turn a successful create into a retry loop. Retries count against the `timeouts`: a request that keeps failing, such as one with a genuinely wrong object id, fails only when the create or update timeout runs out (30 minutes by default), so set a shorter `timeouts.create` and `timeouts.update` for faster feedback. There is no input to supply a retry expression, because the provider matches such expressions against successful responses as well.

- When `conditions.locations` is set: `1040: NamedLocation with id [0-9A-Fa-f-]+ does not exist in the directory` (GB-consistency-and-errors-500).

## Inputs

**On change** says what changing an input does to the Graph object; [declaration.json](declaration.json) declares the same for tools, with the outputs. A nested object attribute behaves like the input that holds it.

| Input | Graph property | Type | Required | Sensitive | On change |
| --- | --- | --- | --- | --- | --- |
| `conditions` | `conditions` | `object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessConditionSet")       applications = optional(object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessApplications")       applicationFilter = optional(object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessFilter")       mode = optional(string)       rule = optional(string)     }))       excludeApplications = optional(list(string))       includeApplications = optional(list(string))       includeAuthenticationContextClassReferences = optional(list(string))       includeUserActions = optional(list(string))     }))       authenticationFlows = optional(object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessAuthenticationFlows")       transferMethods = optional(string)     }))       clientAppTypes = optional(list(string))       clientApplications = optional(object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessClientApplications")       excludeServicePrincipals = optional(list(string))       includeServicePrincipals = optional(list(string))       servicePrincipalFilter = optional(object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessFilter")       mode = optional(string)       rule = optional(string)     }))     }))       devices = optional(object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessDevices")       deviceFilter = optional(object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessFilter")       mode = optional(string)       rule = optional(string)     }))     }))       insiderRiskLevels = optional(string)       locations = optional(object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessLocations")       excludeLocations = optional(list(string))       includeLocations = optional(list(string))     }))       platforms = optional(object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessPlatforms")       excludePlatforms = optional(list(string))       includePlatforms = optional(list(string))     }))       servicePrincipalRiskLevels = optional(list(string))       signInRiskLevels = optional(list(string))       userRiskLevels = optional(list(string))       users = optional(object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessUsers")       excludeGroups = optional(list(string))       excludeGuestsOrExternalUsers = optional(object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessGuestsOrExternalUsers")       externalTenants = optional(any)       guestOrExternalUserTypes = optional(string)     }))       excludeRoles = optional(list(string))       excludeUsers = optional(list(string))       includeGroups = optional(list(string))       includeGuestsOrExternalUsers = optional(object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessGuestsOrExternalUsers")       externalTenants = optional(any)       guestOrExternalUserTypes = optional(string)     }))       includeRoles = optional(list(string))       includeUsers = optional(list(string))     }))     })` | no | no | in place |
| `deleted_date_time` | `deletedDateTime` | `string` | no | no | in place |
| `description` | `description` | `string` | no | no | in place |
| `display_name` | `displayName` | `string` | no | no | in place |
| `grant_controls` | `grantControls` | `object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessGrantControls")       authenticationStrength = optional(any)       builtInControls = optional(list(string))       customAuthenticationFactors = optional(list(string))       operator = optional(string)       termsOfUse = optional(list(string))     })` | no | no | in place |
| `odata_type` | `@odata.type` | `string` | no | no | in place |
| `session_controls` | `sessionControls` | `object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessSessionControls")       applicationEnforcedRestrictions = optional(object({       odata_type = optional(string, "#microsoft.graph.applicationEnforcedRestrictionsSessionControl")       isEnabled = optional(bool)     }))       cloudAppSecurity = optional(object({       odata_type = optional(string, "#microsoft.graph.cloudAppSecuritySessionControl")       cloudAppSecurityType = optional(string)       isEnabled = optional(bool)     }))       disableResilienceDefaults = optional(bool)       persistentBrowser = optional(object({       odata_type = optional(string, "#microsoft.graph.persistentBrowserSessionControl")       isEnabled = optional(bool)       mode = optional(string)     }))       secureSignInSession = optional(object({       odata_type = optional(string, "#microsoft.graph.secureSignInSessionControl")       isEnabled = optional(bool)     }))       signInFrequency = optional(object({       odata_type = optional(string, "#microsoft.graph.signInFrequencySessionControl")       authenticationType = optional(string)       frequencyInterval = optional(string)       isEnabled = optional(bool)       type = optional(string)       value = optional(number)     }))     })` | no | no | in place |
| `state` | `state` | `string` | no | no | in place |
| `template_id` | `templateId` | `string` | no | no | in place |
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

Server-assigned properties in `response`: `createdDateTime`, `id`, `modifiedDateTime`.

Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

## Per-operation permissions

Source: [Graph DevX map](https://raw.githubusercontent.com/microsoftgraph/microsoft-graph-devx-content/56e1917fe45fb7c52c2d9845f569c2ffdb39e4d9/permissions/new/permissions.json) (SHA-256 `4d7dee52659b1d6424bce0b26603302081d39ef9e149bc5fb50de4273b3d3514`).
The map is shared by v1.0 and beta; it does not certify API-version support. Rows show the source's least-privilege annotations, not live-tested consent. Choose an alternative for your authentication type; do not grant every listed scope. AlsoRequires lists additional scope alternatives attached to that row. Missing annotations are unknown, not evidence that an operation needs no permission. Keep the module's documented role, property-specific and tenant restrictions.

| Operation | Authentication | Least-privilege alternative | AlsoRequires |
| --- | --- | --- | --- |
| `POST /identity/conditionalAccess/policies` | DelegatedWork | `Application.Read.All` | — |
| `POST /identity/conditionalAccess/policies` | DelegatedWork | `Policy.Read.All` | — |
| `POST /identity/conditionalAccess/policies` | DelegatedPersonal | Unknown / not annotated | — |
| `POST /identity/conditionalAccess/policies` | Application | `Policy.Read.All` | — |
| `GET /identity/conditionalAccess/policies/{conditionalAccessPolicy-id}` | DelegatedWork | `Policy.Read.All` | — |
| `GET /identity/conditionalAccess/policies/{conditionalAccessPolicy-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `GET /identity/conditionalAccess/policies/{conditionalAccessPolicy-id}` | Application | `Policy.Read.All` | — |
| `PATCH /identity/conditionalAccess/policies/{conditionalAccessPolicy-id}` | DelegatedWork | `Application.Read.All` | — |
| `PATCH /identity/conditionalAccess/policies/{conditionalAccessPolicy-id}` | DelegatedWork | `Policy.Read.All` | — |
| `PATCH /identity/conditionalAccess/policies/{conditionalAccessPolicy-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `PATCH /identity/conditionalAccess/policies/{conditionalAccessPolicy-id}` | Application | `Policy.Read.All` | — |
| `DELETE /identity/conditionalAccess/policies/{conditionalAccessPolicy-id}` | DelegatedWork | `Policy.Read.All` | — |
| `DELETE /identity/conditionalAccess/policies/{conditionalAccessPolicy-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `DELETE /identity/conditionalAccess/policies/{conditionalAccessPolicy-id}` | Application | `Policy.Read.All` | — |

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- conditions.platforms.excludePlatforms[]: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: linux; excluded from typed input validation
- conditions.platforms.includePlatforms[]: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: linux; excluded from typed input validation
- conditions.users.excludeGuestsOrExternalUsers.externalTenants: polymorphic schema; accepts an untyped value
- conditions.users.includeGuestsOrExternalUsers.externalTenants: polymorphic schema; accepts an untyped value
- grantControls.authenticationStrength: navigation property; accepts an untyped value
- grantControls.builtInControls[]: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: riskRemediation; excluded from typed input validation

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
