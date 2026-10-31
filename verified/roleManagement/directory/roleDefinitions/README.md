# Custom Microsoft Entra directory role definitions

<!-- uses-beta:start -->
Uses beta: **no**. This module and its local child modules do not select beta.
<!-- uses-beta:end -->

<!-- live-status:start -->
Assurance: **verified offline-only**. No current live acceptance is recorded for this module.

![live: not yet run](https://img.shields.io/badge/live-not%20yet%20run-lightgrey)
<!-- live-status:end -->

Create a new custom role definition at the Microsoft Graph v1.0
`/roleManagement/directory/roleDefinitions` endpoint. Inputs and folder names keep
Graph's original case. This module creates no role assignment and grants nobody
the permissions in the definition.

For a published release containing this module, replace `<version>` with that
release version. The [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry)
explains registry installation. Availability in this source tree does not mean
that an existing release already includes the module.

```hcl
module "application_reader_role" {
  source  = "satolap/modules/msgraph//verified/roleManagement/directory/roleDefinitions"
  version = "<version>"

  displayName = "Application metadata reader"
  description = "Read basic application-registration properties"
  rolePermissions = [{
    allowedResourceActions = ["microsoft.directory/applications/basic/read"]
  }]
}
```

Use the returned `id` only in a separately reviewed role assignment. Built-in
roles, including Hybrid Identity Administrator, remain read-only references;
this module has no existing-role selector or built-in-role management mode.
Resolve built-in identifiers through a separate read-only Graph lookup; the
existing entitlement-management catalog roles use a different role namespace.
Microsoft Entra Connect Health permissions
are Azure RBAC on `Microsoft.ADHybridHealthService`, outside this Graph module.
Permanent active assignments are a separate intentional choice from eligible
or time-bound PIM assignments; neither is implemented here.

## Permission choices

Every `rolePermissions` item must contain only `allowedResourceActions`, with at
least one action. The
[documented action syntax](https://learn.microsoft.com/en-us/graph/api/resources/unifiedrolepermission#allowedresourceactions-property)
is `microsoft.directory/Entity/Action` or
`microsoft.directory/Entity/PropertySet/Action`. Entity subtypes such as
`applications.myOrganization` and the documented
[group subtype](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/custom-group-permissions)
`groups.security.assignedMembership` are accepted. Dot-separated name components
must be nonempty; trailing or consecutive dots are refused. Syntax validation does not establish
that a permission is available for custom roles or effective at an eventual
assignment scope. Choose from Microsoft's
[supported custom-role permissions](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/custom-available-permissions).

The [documented app-consent permissions](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/custom-consent-permissions)
also include `microsoft.directory/servicePrincipals/managePermissionGrantsForSelf.{id}`
and `microsoft.directory/servicePrincipals/managePermissionGrantsForAll.{id}`.
Here `{id}` names an existing permission-grant policy, such as
`microsoft-user-default-low` or `low-risk-any-app`. The policy suffix is required;
the bare `managePermissionGrantsForSelf` and `managePermissionGrantsForAll`
consent actions are refused. Policy IDs may contain
letters, numbers, hyphens and underscores, as specified by
[permissionGrantPolicy](https://learn.microsoft.com/en-us/graph/api/resources/permissiongrantpolicy).
The module checks that syntax; it does not create the policy, verify its
existence or evaluate its include/exclude conditions. `ForSelf` delegates user
consent subject to that policy; `ForAll` delegates tenant-wide admin consent,
including application permissions. Review the referenced policy and eventual
assignees carefully before delegating consent. Creating this definition alone
grants nobody either capability.

Literal wildcard characters (`*`) are refused because this module has no
reviewed contract for them. `allTasks` and `allProperties` are broad named
permissions, not least-privilege defaults. Credential updates, owner updates,
application-wide updates and app-consent delegation can enable privilege
escalation. Review the exact actions and future assignment scope before
applying; there is no automatic
safe-permission classification or privilege approval. The example requests only
basic read access.

`condition`, `excludedResourceActions`, `resourceScopes`, `isBuiltIn` and other
unreviewed write properties are not exposed. Unknown permission keys are
rejected rather than silently dropped. Scope belongs on a separate assignment,
not the deprecated `resourceScopes` property of a definition.

## Lifecycle and evidence

The module uses `msgraph_resource` for the documented create, read, PATCH update
and delete operations. Normal destroy calls the active-definition endpoint and
**soft-deletes** the custom role. Microsoft's
[delete contract](https://learn.microsoft.com/en-us/graph/api/unifiedroledefinition-delete)
uses a separate `directory/deletedItems/roleDefinitions/{id}` route for permanent
deletion. This module does not restore or purge deleted definitions or manage
their retention. A `404` from the active-definition endpoint does not prove
permanent deletion or the absence of a restorable definition.

It supports **new custom definitions only**. Do not
import or adopt an existing definition, especially a built-in role. A response
postcondition detects an `isBuiltIn` value other than `false`; it is evaluated
after a provider operation and is not a pre-write adoption barrier.

The optional `templateId` must be a GUID, as documented in Microsoft's
[custom-role creation guidance](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/custom-create).
The module treats it as stable identity. A different GUID, including adding
or removing it, replaces `msgraph_resource.roleDefinition` through
`terraform_data.immutable`. The old definition is deleted before a new one is
created; its object `id` changes. The old definition remains soft-deleted rather
than permanently removed. Remove dependent assignments first and plan for an
access interruption and Graph deletion/recreation restrictions, including any
effect of a retained definition or reused template identifier. This is
a conservative **module policy**: the current
[update documentation](https://learn.microsoft.com/en-us/graph/api/unifiedroledefinition-update)
does list `templateId` for custom roles. Changing only a GUID's hexadecimal
letter case neither replaces the definition nor sends that property in an
update: comparison ignores case, while the original body value is retained.
Other supported inputs update in place.
Changing `description` to null omits it and does not clear the existing value.

Because the body's `templateId` is ignored for updates, a template that someone
changed remotely would not show as a plan difference. When `templateId` is set,
a postcondition therefore compares it, ignoring letter case, with the
`templateId` that Graph returned on the last create or refresh, and fails if the
two differ or Graph returned none. When `templateId` is omitted, Graph assigns
one and the module does not manage it. The module never adopts the returned
value. Find out why the definition changed before acting: changing `templateId`
replaces the definition, and removing it from state leaves the remote
definition in place. Like the built-in check, the postcondition runs after the
provider operation, so it reports the drift but does not prevent an earlier
write.

`terraform_data.immutable` makes no Graph request. Its first creation does not
replace an existing resource. Although imports are unsupported, recovery or
manual state editing that leaves a role without this helper requires an apply
with unchanged inputs before relying on replacement behavior. No automatic
upgrade from a generated module, existing role, or prior path is provided.

Terraform mocked tests cover request construction, validation, response
detection and replacement planning/state transitions. They do **not** prove
Graph permission enforcement, effective scopes, provider HTTP behavior,
delete/recreate semantics or cleanup in a licensed tenant. Live scope,
permission and removal acceptance remains unverified. In particular, active
collection absence, deleted-items read-back and the policy for retention,
restoration or permanent removal require separate evidence; no purge request is
implemented here. Permanent role assignments and PIM schedules are outside this
module's scope.

## Requirements

| Name | Version |
| --- | --- |
| Terraform configuration and mocked tests | >= 1.11.0 |
| microsoft/msgraph | >= 0.6.0, < 0.7.0 |

The provider range admits the reviewed 0.6 minor line. The offline execution
baseline is 0.6.0; no earlier provider or future minor is claimed tested. A
calling root must commit its own provider lock file; a reusable module's version
constraint does not lock a caller's dependency selection.

The automation identity needs `RoleManagement.ReadWrite.Directory` for the
[create](https://learn.microsoft.com/en-us/graph/api/rbacapplication-post-roledefinitions),
[update](https://learn.microsoft.com/en-us/graph/api/unifiedroledefinition-update)
and [delete](https://learn.microsoft.com/en-us/graph/api/unifiedroledefinition-delete)
operations. With delegated access the signed-in user also needs an appropriate
Microsoft Entra role, documented as Privileged Role Administrator or an
appropriately authorized custom role. A successful API call does not prove
least privilege or license entitlement.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

Before deployment, check the requirements of the features you enable and the users who benefit. You can inspect tenant subscriptions with `GET /subscribedSkus`; this requires `Organization.Read.All` or `LicenseAssignment.Read.All` ([List subscribedSkus](https://learn.microsoft.com/en-us/graph/api/subscribedsku-list?view=graph-rest-1.0)).

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | DIRECTORY-CUSTOM-ROLES | Microsoft Graph documents Microsoft Entra ID P1 or P2 for creating and updating custom directory roles. This module creates only a definition, with no assignments or license provisioning. Any of: Microsoft Entra ID P1 (`AAD_PREMIUM`); Microsoft Entra ID P2 (`AAD_PREMIUM_P2`). | Tenant using custom roles; confirm administrator and eventual assignee entitlements before making assignments | direct / per_tenant | inferred |

Notes:

- The P1/P2 prerequisite is documented; the per-tenant capacity model here covers definition creation only and does not establish licensing for eventual users or service principals assigned the role. Confirm the exact population and product before assignments.
- This module creates no assignment. RoleManagement.ReadWrite.Directory and, for delegated access, an appropriate Microsoft Entra administrator role are authorization requirements, not license entitlement.
- The custom-directory-role rules were reviewed against Microsoft Learn on 2026-10-18, later than the registry-wide review date. Mock tests do not establish licensed-tenant lifecycle behavior.

Sources: [Create custom role definition](https://learn.microsoft.com/en-us/graph/api/rbacapplication-post-roledefinitions), [Update custom role definition](https://learn.microsoft.com/en-us/graph/api/unifiedroledefinition-update), [Custom role permissions](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/custom-available-permissions).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | On change |
| --- | --- | --- | --- | --- |
| displayName | Nonempty custom-role display name | `string` | required | in place |
| name_pattern | Regular expression (RE2, not anchored unless it says so) that displayName must match, or the plan fails; null accepts any name | `string` | `null` | no object change (validation or timing only) |
| rolePermissions | Nonempty list of maps whose sole key is `allowedResourceActions`, with a nonempty list of action strings | `list(map(list(string)))` | required | in place |
| description | Description; null omits without clearing | `string` | `null` | in place |
| isEnabled | Whether the definition is available for assignment | `bool` | `true` | in place |
| templateId | Stable custom template GUID; a different GUID replaces the definition, a case-only change does not | `string` | `null` | replaces `msgraph_resource.roleDefinition` when `var.templateId == null ? null : lower(var.templateId)` changes |

## Outputs

| Name | Description | Known in plan after an update |
| --- | --- | --- |
| id | Custom definition object ID, for a separate assignment | yes |
| templateId | Template identifier read back from Graph | no |

<!-- drift:start -->
## Drift and out-of-band changes

Terraform plans compare configuration and refreshed provider state. A plan that changes one of these inputs proposes its declared effect; review the plan before applying. The consumer guide explains refresh limits and emergency reconciliation.

- `displayName`: in place.
- `name_pattern`: no object change (validation or timing only).
- `description`: in place.
- `isEnabled`: in place.
- `rolePermissions`: in place.
- `templateId`: replaces `msgraph_resource.roleDefinition` when `var.templateId == null ? null : lower(var.templateId)` changes.
<!-- drift:end -->

<!-- permissions:begin -->
## Per-operation permissions

Source: [Graph DevX map](https://raw.githubusercontent.com/microsoftgraph/microsoft-graph-devx-content/56e1917fe45fb7c52c2d9845f569c2ffdb39e4d9/permissions/new/permissions.json) (SHA-256 `4d7dee52659b1d6424bce0b26603302081d39ef9e149bc5fb50de4273b3d3514`).
The map is shared by v1.0 and beta; it does not certify API-version support. Rows show the source's least-privilege annotations, not live-tested consent. Choose an alternative for your authentication type; do not grant every listed scope. AlsoRequires lists additional scope alternatives attached to that row. Missing annotations are unknown, not evidence that an operation needs no permission. Keep the module's documented role, property-specific and tenant restrictions.

Derived from this module's Terraform sources, including optional guards, destroy actions and local child modules. The checked inventory is `docs/permissions/verified-operations.json`. These are potential requests, not a preflight scope list. A provider primitive may expose an update that Graph does not support. Source paths and conditions are retained in the inventory.

| Operation | Authentication | Least-privilege alternative | AlsoRequires | Unknown reason |
| --- | --- | --- | --- | --- |
| `POST /roleManagement/directory/roleDefinitions` | DelegatedWork | `RoleManagement.ReadWrite.Directory` | - | - |
| `POST /roleManagement/directory/roleDefinitions` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `POST /roleManagement/directory/roleDefinitions` | Application | `RoleManagement.ReadWrite.Directory` | - | - |
| `GET /roleManagement/directory/roleDefinitions/{id}` | DelegatedWork | `RoleManagement.Read.Directory` | - | - |
| `GET /roleManagement/directory/roleDefinitions/{id}` | DelegatedWork | `RoleManagement.ReadWrite.Directory` | - | - |
| `GET /roleManagement/directory/roleDefinitions/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /roleManagement/directory/roleDefinitions/{id}` | Application | `RoleManagement.Read.Directory` | - | - |
| `GET /roleManagement/directory/roleDefinitions/{id}` | Application | `RoleManagement.ReadWrite.Directory` | - | - |
| `DELETE /roleManagement/directory/roleDefinitions/{id}` | DelegatedWork | `RoleManagement.ReadWrite.Directory` | - | - |
| `DELETE /roleManagement/directory/roleDefinitions/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `DELETE /roleManagement/directory/roleDefinitions/{id}` | Application | `RoleManagement.ReadWrite.Directory` | - | - |
| `PATCH /roleManagement/directory/roleDefinitions/{id}` | DelegatedWork | `RoleManagement.ReadWrite.Directory` | - | - |
| `PATCH /roleManagement/directory/roleDefinitions/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `PATCH /roleManagement/directory/roleDefinitions/{id}` | Application | `RoleManagement.ReadWrite.Directory` | - | - |

### Property-specific coverage

Route annotations do not establish that the listed scopes cover every selected or writable property. Dynamic bodies, additional properties and default responses remain unbounded. Keep the reviewed permission guidance above; in particular, a group-nesting scope is not general group-property access. The pin's method/path entries do not distinguish property grants from navigation or sub-resource operations; property coverage stays unknown.

| Operation | Properties | Source evidence |
| --- | --- | --- |
| `POST /roleManagement/directory/roleDefinitions` | `description`, `displayName`, `isEnabled`, `rolePermissions`, `templateId` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `PATCH /roleManagement/directory/roleDefinitions/{id}` | `description`, `displayName`, `isEnabled`, `rolePermissions`, `templateId` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
<!-- permissions:end -->
