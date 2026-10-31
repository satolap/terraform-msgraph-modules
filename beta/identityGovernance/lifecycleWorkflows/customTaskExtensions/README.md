# /identityGovernance/lifecycleWorkflows/customTaskExtensions

Create customTaskExtensions

[Catalog](../../../README.md) Â· [Identity and access](../../../README.md#identity-and-access) Â· [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/identitygovernance-customtaskextension?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /identityGovernance/lifecycleWorkflows/customTaskExtensions`, `GET/PATCH/DELETE /identityGovernance/lifecycleWorkflows/customTaskExtensions/{customTaskExtension-id}`.

Assurance: **generated (offline contract)**. Schema-derived request construction and mock tests do not prove live service behavior.

> **Beta preview:** Microsoft Graph beta APIs may change without notice. Pin the module release version and provider version, and read `interface-changes.json` in the release before upgrading. Offline tests and live acceptance do not make a beta API production-supported.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//beta/identityGovernance/lifecycleWorkflows/customTaskExtensions"
  version = "<version>"

}
```

Replace `<version>` with a release version, such as `0.5.0`; the [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

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
| `authenticationConfiguration` | `authenticationConfiguration` | `any` | no | no | in place |
| `callbackConfiguration` | `callbackConfiguration` | `any` | no | no | in place |
| `clientConfiguration` | `clientConfiguration` | `object({       odata_type = optional(string, "#microsoft.graph.customExtensionClientConfiguration")       maximumRetries = optional(number)       timeoutInMilliseconds = optional(number)     })` | no | no | in place |
| `createdBy` | `createdBy` | `any` | no | no | in place |
| `createdDateTime` | `createdDateTime` | `string` | no | no | in place |
| `description` | `description` | `string` | no | no | in place |
| `displayName` | `displayName` | `string` | no | no | in place |
| `endpointConfiguration` | `endpointConfiguration` | `any` | no | no | in place |
| `lastModifiedBy` | `lastModifiedBy` | `any` | no | no | in place |
| `lastModifiedDateTime` | `lastModifiedDateTime` | `string` | no | no | in place |
| `odata_type` | `@odata.type` | `string` | no | no | in place |
| `replyMode` | `replyMode` | `string` | no | no | in place |
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

## Per-operation permissions

Source: [Graph DevX map](https://raw.githubusercontent.com/microsoftgraph/microsoft-graph-devx-content/56e1917fe45fb7c52c2d9845f569c2ffdb39e4d9/permissions/new/permissions.json) (SHA-256 `4d7dee52659b1d6424bce0b26603302081d39ef9e149bc5fb50de4273b3d3514`).
The map is shared by v1.0 and beta; it does not certify API-version support. Rows show the source's least-privilege annotations, not live-tested consent. Choose an alternative for your authentication type; do not grant every listed scope. AlsoRequires lists additional scope alternatives attached to that row. Missing annotations are unknown, not evidence that an operation needs no permission. Keep the module's documented role, property-specific and tenant restrictions.

| Operation | Authentication | Least-privilege alternative | AlsoRequires |
| --- | --- | --- | --- |
| `POST /identityGovernance/lifecycleWorkflows/customTaskExtensions` | DelegatedWork | `LifecycleWorkflows-CustomExt.ReadWrite.All` | — |
| `POST /identityGovernance/lifecycleWorkflows/customTaskExtensions` | DelegatedPersonal | Unknown / not annotated | — |
| `POST /identityGovernance/lifecycleWorkflows/customTaskExtensions` | Application | `LifecycleWorkflows-CustomExt.ReadWrite.All` | — |
| `GET /identityGovernance/lifecycleWorkflows/customTaskExtensions/{customTaskExtension-id}` | DelegatedWork | `LifecycleWorkflows-CustomExt.Read.All` | — |
| `GET /identityGovernance/lifecycleWorkflows/customTaskExtensions/{customTaskExtension-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `GET /identityGovernance/lifecycleWorkflows/customTaskExtensions/{customTaskExtension-id}` | Application | `LifecycleWorkflows-CustomExt.Read.All` | — |
| `PATCH /identityGovernance/lifecycleWorkflows/customTaskExtensions/{customTaskExtension-id}` | DelegatedWork | `LifecycleWorkflows-CustomExt.ReadWrite.All` | — |
| `PATCH /identityGovernance/lifecycleWorkflows/customTaskExtensions/{customTaskExtension-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `PATCH /identityGovernance/lifecycleWorkflows/customTaskExtensions/{customTaskExtension-id}` | Application | `LifecycleWorkflows-CustomExt.ReadWrite.All` | — |
| `DELETE /identityGovernance/lifecycleWorkflows/customTaskExtensions/{customTaskExtension-id}` | DelegatedWork | `LifecycleWorkflows-CustomExt.ReadWrite.All` | — |
| `DELETE /identityGovernance/lifecycleWorkflows/customTaskExtensions/{customTaskExtension-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `DELETE /identityGovernance/lifecycleWorkflows/customTaskExtensions/{customTaskExtension-id}` | Application | `LifecycleWorkflows-CustomExt.ReadWrite.All` | — |

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- authenticationConfiguration: polymorphic schema; accepts an untyped value
- callbackConfiguration: polymorphic schema; accepts an untyped value
- createdBy: polymorphic schema; accepts an untyped value
- endpointConfiguration: polymorphic schema; accepts an untyped value
- lastModifiedBy: polymorphic schema; accepts an untyped value

## Licensing and prerequisites

Feature rules reviewed on 2026-10-19 for the Microsoft Entra feature this endpoint belongs to (confidence: inferred). Input-dependent rules were not verified against this module's inputs.

- **LIFECYCLE-WORKFLOWS**: Lifecycle workflows, including their custom task extensions, require Microsoft Entra ID Governance or Microsoft Entra Suite for the organization's member users. Microsoft Entra ID P2 alone is not sufficient. Agent sponsorship tasks need Microsoft Agent 365, and some capabilities involve guest billing. Any of: Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). Coverage: Every member user a workflow processes, and the Lifecycle Workflows administrator. Assignment: direct; capacity: per_user. Sources: [Lifecycle workflows license requirements](https://learn.microsoft.com/en-us/entra/id-governance/what-are-lifecycle-workflows#license-requirements), [Microsoft Entra licensing: lifecycle workflows](https://learn.microsoft.com/en-us/entra/fundamentals/licensing#lifecycle-workflows), [Microsoft Entra ID Governance licensing fundamentals: licensing FAQs](https://learn.microsoft.com/en-us/entra/id-governance/licensing-fundamentals#licensing-faqs).

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
