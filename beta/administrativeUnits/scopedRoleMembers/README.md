# /administrativeUnits/{administrativeUnit-id}/scopedRoleMembers

Add a scopedRoleMember

[Catalog](../../README.md) Â· [Identity and access](../../README.md#identity-and-access) Â· [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/identity-network-access-overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /administrativeUnits/{administrativeUnit-id}/scopedRoleMembers`, `GET/PATCH/DELETE /administrativeUnits/{administrativeUnit-id}/scopedRoleMembers/{scopedRoleMembership-id}`.

Assurance: **generated (offline contract)**. Schema-derived request construction and mock tests do not prove live service behavior.

> **Beta preview:** Microsoft Graph beta APIs may change without notice. Pin the module release version and provider version, and read `interface-changes.json` in the release before upgrading. Offline tests and live acceptance do not make a beta API production-supported.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//beta/administrativeUnits/scopedRoleMembers"
  version = "<version>"

  administrativeUnit-id = "parent-object-id"
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

A request that references another object can fail until Microsoft Graph has replicated that object. For the reviewed cases below the module sets the provider retry to one reviewed message anchored to the Graph error envelope, with the error code each pattern below names, and to nothing otherwise. The message cannot occur in a Graph-generated success body, and a plan-time precondition rejects any request body that contains it, so a value echoed back by Graph cannot turn a successful create into a retry loop. Retries count against the `timeouts`: a request that keeps failing, such as one with a genuinely wrong object id, fails only when the create or update timeout runs out (30 minutes by default), so set a shorter `timeouts.create` and `timeouts.update` for faster feedback. There is no input to supply a retry expression, because the provider matches such expressions against successful responses as well.

- When `roleMemberInfo` is set: `The source resource object or one of the objects being referenced don't exist` (GB-consistency-and-errors-502); reviewed-unverified (not confirmed by a live run).

## Inputs

**On change** says what changing an input does to the Graph object; [declaration.json](declaration.json) declares the same for tools, with the outputs. A nested object attribute behaves like the input that holds it.

| Input | Graph property | Type | Required | Sensitive | On change |
| --- | --- | --- | --- | --- | --- |
| `administrativeUnit-id` | URL parameter `administrativeUnit-id` | `string` | yes | no | not replaced or moved: the update targets the existing object; recreate it to move it |
| `administrativeUnitId` | `administrativeUnitId` | `string` | no | no | in place |
| `odata_type` | `@odata.type` | `string` | no | no | in place |
| `roleId` | `roleId` | `string` | no | no | in place |
| `roleMemberInfo` | `roleMemberInfo` | `any` | no | no | in place |
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
| `POST /administrativeUnits/{administrativeUnit-id}/scopedRoleMembers` | DelegatedWork | `RoleManagement.ReadWrite.Directory` | — |
| `POST /administrativeUnits/{administrativeUnit-id}/scopedRoleMembers` | DelegatedPersonal | Unknown / not annotated | — |
| `POST /administrativeUnits/{administrativeUnit-id}/scopedRoleMembers` | Application | `RoleManagement.ReadWrite.Directory` | — |
| `GET /administrativeUnits/{administrativeUnit-id}/scopedRoleMembers/{scopedRoleMembership-id}` | DelegatedWork | `RoleManagement.Read.Directory` | — |
| `GET /administrativeUnits/{administrativeUnit-id}/scopedRoleMembers/{scopedRoleMembership-id}` | DelegatedWork | `RoleManagement.ReadWrite.Directory` | — |
| `GET /administrativeUnits/{administrativeUnit-id}/scopedRoleMembers/{scopedRoleMembership-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `GET /administrativeUnits/{administrativeUnit-id}/scopedRoleMembers/{scopedRoleMembership-id}` | Application | `RoleManagement.Read.Directory` | — |
| `GET /administrativeUnits/{administrativeUnit-id}/scopedRoleMembers/{scopedRoleMembership-id}` | Application | `RoleManagement.ReadWrite.Directory` | — |
| `PATCH /administrativeUnits/{administrativeUnit-id}/scopedRoleMembers/{scopedRoleMembership-id}` | DelegatedWork | Unknown / not annotated | — |
| `PATCH /administrativeUnits/{administrativeUnit-id}/scopedRoleMembers/{scopedRoleMembership-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `PATCH /administrativeUnits/{administrativeUnit-id}/scopedRoleMembers/{scopedRoleMembership-id}` | Application | Unknown / not annotated | — |
| `DELETE /administrativeUnits/{administrativeUnit-id}/scopedRoleMembers/{scopedRoleMembership-id}` | DelegatedWork | `RoleManagement.ReadWrite.Directory` | — |
| `DELETE /administrativeUnits/{administrativeUnit-id}/scopedRoleMembers/{scopedRoleMembership-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `DELETE /administrativeUnits/{administrativeUnit-id}/scopedRoleMembers/{scopedRoleMembership-id}` | Application | `RoleManagement.ReadWrite.Directory` | — |

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- roleMemberInfo: polymorphic schema; accepts an untyped value

## Licensing and prerequisites

Feature rules reviewed on 2026-10-19 for the Microsoft Entra feature this endpoint belongs to (confidence: inferred). Input-dependent rules were not verified against this module's inputs.

A scoped role member assigns a Microsoft Entra role at the scope of the administrative unit, so the ADMIN-UNITS rule applies to each such administrator.

- **ADMIN-UNITS**: Creating administrative units is available with Microsoft Entra ID Free, and their members need only Microsoft Entra ID Free. Each administrator who is assigned a Microsoft Entra role at the scope of an administrative unit, including a restricted management administrative unit, needs Microsoft Entra ID P1. Any of: Microsoft Entra ID P1 (`AAD_PREMIUM`). Coverage: Each administrator assigned a Microsoft Entra role scoped to the administrative unit; the members of the unit need only Microsoft Entra ID Free. Assignment: direct; capacity: per_user. Sources: [Administrative units license requirements](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/administrative-units#license-requirements), [Restricted management administrative units license requirements](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/admin-units-restricted-management#license-requirements).

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
