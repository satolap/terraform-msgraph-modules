# Direct permanent Microsoft Entra directory role assignments

<!-- state-protection:start -->
## State and plan protection

This module's state and saved plans retain these declared values:

Potential personal-data inputs: `principal_id`.

Protect these values with an encrypted remote backend and least-privilege access to state, plans and backups. `sensitive` is presentation redaction, not encryption; provider resource values can still appear in plan/show output. Do not publish plan output in CI logs or PR comments for secret-bearing roots; keep saved plans short-lived and rotate credentials after exposure.

See [Terraform sensitive state guidance](https://developer.hashicorp.com/terraform/language/state/sensitive-data). These are exposure indicators, not a complete data classification; unmarked fields and provider responses also need protection.
<!-- state-protection:end -->

<!-- uses-beta:start -->
Uses beta: **no**. This module and its local child modules do not select beta.
<!-- uses-beta:end -->

<!-- live-status:start -->
Assurance: **verified offline-only**. No current live acceptance is recorded for this module.

![live: offline only](https://img.shields.io/badge/live-offline%20only-lightgrey)
<!-- live-status:end -->

Creates one **permanent active, direct** assignment through
`POST /roleManagement/directory/roleAssignments` (v1.0). This grants privileges
immediately. It is separate from [PIM role schedules](../../../role-management/directory/role-schedules/README.md),
which use schedule requests, eligibility, activation and PIM policy/licensing.
This module creates neither a principal nor a role definition and never writes
to either. Built-in definitions remain read-only references.

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one.
Availability in this source tree does not mean an existing release already
includes the module.

## Hybrid Identity Administrator example

```hcl
module "hybrid_identity_administrator" {
  source  = "satolap/modules/msgraph//verified/roleManagement/directory/roleAssignments"
  version = "<version>"

  tenant_id    = var.tenant_id
  principal_id = var.hybrid_identity_administrator_principal_id
  # Explicit tenant-wide access; neither scope input has a default.
  scope_type         = "tenant"
  directory_scope_id = "/"
  # Microsoft's service-wide built-in template, resolved through roleDefinitions;
  # this is not a tenant's directory-specific role definition or assignment ID.
  template_id = "8ac3fc64-6eca-42ea-9e69-59f4c7b60eb2"
}
```

The principal and tenant are caller inputs; configure the msgraph provider for
the same tenant. Microsoft Entra Connect Health permissions are **Azure RBAC** on
`Microsoft.ADHybridHealthService`, outside this Graph module. A Hybrid Identity
Administrator directory assignment does not provision those Azure permissions.

## Role and scope selection

Set exactly one of `role_definition_id`, `template_id` or `role_display_name`.
Template lookup reads the definition collection and matches `templateId` locally;
the pinned list contract does not document filtering that property. Display-name
lookup escapes OData quotes and requires an exact name. Zero, several, malformed
or incomplete results fail closed. The selected definition is read independently;
its ID, enabled flag and built-in classification must agree. No lookup creates,
activates, updates or deletes a definition. Use `role_type = "custom"` with the
ID returned by the [custom definition module](../roleDefinitions/README.md).
Changing a display-name selector can replace the assignment even if it resolves
to the same role; prefer a stable template or definition ID.

| scope_type | directory_scope_id | Meaning |
| --- | --- | --- |
| `tenant` | `/` | Tenant-wide; both values must be explicit |
| `administrative_unit` | `/administrativeUnits/{GUID}` | Administrative unit |
| `application` | `/{GUID}` | Application registration **object ID**, not client ID |

Both scope inputs are required and reject null; neither defaults to tenant-wide
access. State `scope_type = "tenant"` and `directory_scope_id = "/"` explicitly
for a tenant-wide assignment. This validates syntax and licensing selection,
not whether a particular role works at that scope. Graph's unsupported role/scope
refusal is surfaced unchanged; no role-to-scope allowlist is invented. `appScopeId`
and entitlement-management catalog roles are outside this directory-role module.

## Lifecycle, duplicate refusal and ownership

Every assignment input change replaces the assignment, deleting the old object
before creating the new one. A change only in GUID hexadecimal case does not.
`ignore_changes = all` prevents an unsupported in-place reassignment, while a
`terraform_data.preflight` replacement triggers resource replacement. Never add
`create_before_destroy`: the old privilege must be removed first, and a new
assignment with the same tuple can be a duplicate. Replacement temporarily
removes access; review the plan before changing privileged assignments.

Python 3 (`python` on PATH), Azure CLI, `ARM_TENANT_ID`, and an authenticated CLI
session for the same provider tenant are required for the **read-only** guards.
The CLI identity needs `RoleManagement.Read.Directory` (or a documented higher
permission). The provider needs `RoleManagement.ReadWrite.Directory`; delegated
callers must also hold an appropriate administrative role. The guards currently
support the public cloud only, `https://graph.microsoft.com`. They acquire a
Graph token without putting it in state, command arguments or Terraform output.
No module input or output contains a secret; assignment and tenant identifiers
and the cleanup tuple live in Terraform state. Protect that state.

Before create, the guard lists assignments for the principal, follows every
page and refuses an existing principal/role/scope tuple rather than importing it.
This check runs when the preflight resource is created or replaced; it does not
run again solely because refresh detects an out-of-band assignment deletion.
Graph remains the authority for tuple uniqueness, concurrent duplicate creates and
unsupported combinations. Errors and incomplete reads fail closed.

After provider create, `terraform_data.ownership` records the assignment ID and
tuple **before** a separate verification gate checks the provider readback.
Assignment IDs are opaque strings, not necessarily GUIDs. On destroy (including
replacement), the ownership dependent runs first and GETs **only the captured
ID**. It requires that ID, principal, definition and directory scope to match,
and refuses an app-scope assignment. An actual 404 at that exact ID means it is
already absent; every other failed or mismatched read blocks provider DELETE.
Only then does the provider delete the captured assignment ID, subject to the
ownership limits below. The guard itself
performs no write and never searches for an alternative assignment to remove.
Neither the principal nor the role definition is deleted.

Do not import/adopt assignments or manipulate state to claim somebody else's
assignment. Use ordinary refresh when planning; `-refresh=false`, targeted
operations and manual state edits can bypass Terraform dependencies and are not
supported ownership workflows. If verification fails, keep state and reconcile
the recorded identity; do not retry POST or delete by tuple. If the provider's
create fails after a remote side effect but before returning an ID, automatic
cleanup cannot identify that object: the owner must reconcile it before retrying.
Keep the CLI session, tenant and module files available through destroy.

## Why the read-only provisioners remain

This module already uses provider-native CRUD: `msgraph_resource.assignment`
performs both POST and exact-ID DELETE. Neither local provisioner deletes
anything. The create guard checks every page for duplicate tuples; the destroy
guard independently GETs the saved ID and compares its tenant, principal, role,
directory scope and app-scope namespace immediately before provider DELETE.
Denied, malformed or mismatched reads block deletion; only exact-ID 404 proves
absence. A create-time GET cannot preserve this destroy-time refusal contract.

The pinned provider's destroy-only action can send one saved request but cannot
perform that conditional independent GET before another resource's DELETE.
Adding a second native remove action while retaining CRUD would create two
deletion paths. Switching the CRUD resource to a create action also changes its
state type and needs a separately reviewed migration to avoid duplicate POST or
premature deletion. The read-only guards therefore remain in the exact
publication provisioner allowlist; no cleanup conversion or removal of the
existing Python/Azure CLI requirements is claimed for this module.

Owner-dispatched live acceptance still needs duplicate pagination, mismatched
tenant/identity refusal, exact-ID absence, destroy-first replacement and the
coordinated deterministic-ID re-creation probe described below. Verify that
unrelated assignments survive and retain only sanitized evidence.

## Ownership limits

**The guard verifies an ID and tuple, not a unique creation of that assignment.**
Directory assignment IDs are deterministic: the consistent pinned list/get
examples encode the role definition GUID followed by the principal GUID as
little-endian bytes, base64url without padding, plus `-1`. The application-scope
POST example also encodes the scope object GUID. The module treats these IDs as
opaque; they are not random ownership tokens, and this example-derived encoding
is not a service-wide codec guarantee.

If another administrator or process deletes the assignment out of band and then
re-creates the identical principal/role/scope tuple, the same ID can identify the
new creation. Terraform refresh will silently re-adopt that re-created assignment,
and its ID/tuple will pass the guard. **Destroy or replacement will then delete
the re-created assignment.** No mismatch can be detected from those values alone.
Use one coordinated writer for the tuple throughout its lifetime; if another
writer intervenes, reconcile ownership before refreshing, replacing or destroying.

The evaluated pinned direct assignment GET exposes no `createdDateTime`, version
or ETag to compare. The schedule-instance GET example has `startDateTime = null`
for a direct permanent assignment, and its `roleAssignmentOriginId` and
`roleAssignmentScheduleId` repeat the same deterministic ID. They provide no
independent creation marker in that example. The directory-audit GET has
`activityDateTime`, an event ID and `correlationId`; these may help manual
reconciliation, but the evaluated contract establishes no complete audit history
or immutable link from a particular assignment creation to this module's POST.
An audit event time is not an assignment creation identity. These responses are
shortened examples, so absence of a field does not prove the service has no such
field. **No reliable per-creation marker is established by the available pinned
contracts.** The guard therefore remains unchanged: it does not query schedule
instances or audit logs, request extra audit permissions, or invent a timestamp.
The owner must evaluate full live responses and audit correlation under #248
before any stronger ownership guarantee is claimed.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | DIRECTORY-BASIC | The reviewed create APIs for users, assigned security groups, applications and service principals specify no additional premium license. This covers the object operation only; features built on these objects can require licenses. No additional license specified. | No per-user entitlement for the object operation itself | direct / per_tenant | documented |
| `role_type` is `"custom"` | DIRECTORY-CUSTOM-ROLE-ASSIGNMENTS | Assigning custom directory roles requires Microsoft Entra ID P1 or P2 for each assigned user. Built-in permanent active roles use no PIM feature. Confirm non-user principal licensing with the owner; this rule does not establish service-principal entitlement. Any of: Microsoft Entra ID P1 (`AAD_PREMIUM`); Microsoft Entra ID P2 (`AAD_PREMIUM_P2`). | Each user assigned a custom directory role; confirm the entitlement model for non-user principals | direct / per_user | inferred |
| `scope_type` is `"administrative_unit"` | ADMIN-UNITS | Creating administrative units is available with Microsoft Entra ID Free, and their members need only Microsoft Entra ID Free. Each administrator who is assigned a Microsoft Entra role at the scope of an administrative unit, including a restricted management administrative unit, needs Microsoft Entra ID P1. Any of: Microsoft Entra ID P1 (`AAD_PREMIUM`). | Each administrator assigned a Microsoft Entra role scoped to the administrative unit; the members of the unit need only Microsoft Entra ID Free | direct / per_user | documented |

Notes:

- Direct permanent built-in tenant/application assignments use no PIM feature; their Free entitlement is inferred from the basic directory feature, not confirmed by a live run. Workload and principal-specific licensing may still apply.
- role_type and scope_type are validated against the role readback and scope shape so custom roles and AU administrators cannot silently select the free-only case. A custom role at AU scope needs both applicable rules.
- The provider requires RoleManagement.ReadWrite.Directory. The read-only Azure CLI guards require RoleManagement.Read.Directory or a documented higher permission in the same tenant. Authorization is separate from license entitlement.
- The custom-role assignee model is inferred from existing catalog sources and requires owner confirmation, especially for groups and service principals. No license is provisioned or probed by this module.
- When `role_type` is `"custom"`: role_type is checked against the read-only definition isBuiltIn property. This per-assignee rule is distinct from definition creation.
- When `scope_type` is `"administrative_unit"`: scope_type is checked against directory_scope_id. P1 is required for each administrator assigned at AU scope; members of the AU do not need P1 solely for membership.

Sources: [Create user](https://learn.microsoft.com/en-us/graph/api/user-post-users?view=graph-rest-1.0), [Create group](https://learn.microsoft.com/en-us/graph/api/group-post-groups?view=graph-rest-1.0), [Create application](https://learn.microsoft.com/en-us/graph/api/application-post-applications?view=graph-rest-1.0), [Create servicePrincipal](https://learn.microsoft.com/en-us/graph/api/serviceprincipal-post-serviceprincipals?view=graph-rest-1.0), [Custom role permissions and prerequisites](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/custom-available-permissions), [Create custom directory role definition](https://learn.microsoft.com/en-us/graph/api/rbacapplication-post-roledefinitions), [Administrative units license requirements](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/administrative-units#license-requirements), [Restricted management administrative units license requirements](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/admin-units-restricted-management#license-requirements).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required | On change |
| --- | --- | --- | --- | --- | --- |
| tenant_id | Provider and CLI tenant; captured for cleanup | `string` | n/a | yes | replaces `msgraph_resource.assignment` |
| principal_id | Assignee object GUID | `string` | n/a | yes | replaces `msgraph_resource.assignment` when its effect on `local.request_body` changes |
| role_definition_id | Directory-specific definition GUID; exactly one selector | `string` | `null` | no | replaces `msgraph_resource.assignment` when `local.request_body`, `var.role_definition_id == null ? null : lower(var.role_definition_id)` changes |
| template_id | Read-only template GUID lookup; exactly one selector | `string` | `null` | no | replaces `msgraph_resource.assignment` when `local.request_body`, `var.template_id == null ? null : lower(var.template_id)` changes |
| role_display_name | Exact, unique, read-only display-name lookup | `string` | `null` | no | replaces `msgraph_resource.assignment` |
| role_type | `built_in` or `custom`, verified against the definition | `string` | `"built_in"` | no | replaces `msgraph_resource.assignment` |
| directory_scope_id | Explicit tenant, administrative-unit or application object scope | `string` | n/a | yes | replaces `msgraph_resource.assignment` when its effect on `local.request_body` changes |
| scope_type | Explicit `tenant`, `administrative_unit` or `application`, matching the scope | `string` | n/a | yes | replaces `msgraph_resource.assignment` |

## Outputs

| Name | Description | Known in plan after an update |
| --- | --- | --- |
| id | The captured deterministic assignment ID; not proof of a unique creation | yes |
| role_definition_id | The resolved directory-specific definition GUID | no |
| request_body | The three-property direct assignment body; no credentials | no |

## Live status and acceptance runbook

No live run has been made. Terraform mock **plans** check construction and
refusals on the 1.11 floor; Python fake-response tests check duplicate pagination,
ownership and failure paths. Offline contract checks bind the request and scope
shapes to hash-pinned Microsoft Learn examples. These do not prove Graph
acceptance, replacement ordering or effective privilege. Live proof stays in #248.

The owner-dispatched sandbox run must:

1. Review the requested privilege, same-tenant provider/CLI identity, target and
   licensing: free built-in tenant assignment, P1/P2 custom role assignee, and P1
   for each AU-scoped administrator. Use disposable principals and preapproved roles.
2. Resolve a built-in template (including Hybrid Identity Administrator), a custom
   definition ID and an exact display name. Record zero/ambiguous lookup refusal.
   Confirm all definition lookups are read-only.
3. Create one assignment at each supported tenant/AU/application scope; independently
   GET its ID and tuple, check effective privilege, then refresh and confirm a clean
   plan. Record Graph refusals for an unsupported role/scope pair without generalizing
   from syntax-only mocks.
4. Attempt the same tuple again and confirm refusal without adopting the original.
   Change principal, role, scope and selector separately; confirm old-ID removal
   precedes new create. Confirm GUID casing alone produces no replacement or PATCH.
5. With an unrelated assignment present, exercise missing/mismatched identity and
   wrong-tenant guards using a safe sandbox harness; confirm no DELETE occurs.
   Exercise failed readback after create and show cleanup state was already recorded.
6. Destroy the module; independently prove absence of its exact assignment ID and
   continued existence of the unrelated assignment, principal and role definition.
   Check already-absent handling and retry after a transient read failure. Record
   outcomes without tenant data and update the catalog as confirmed-live evidence.
7. **Out-of-band identical re-creation (#248).** With explicit sandbox approval,
   create a disposable assignment, capture its ID, delete it outside Terraform,
   then re-create the identical tuple outside Terraform. Compare the IDs and full
   direct/schedule-instance responses, including any creation/version fields.
   Examine audit correlation if the owner has authorized the separate audit read
   permission; do not assume its completeness or event time proves creation identity.
   Confirm refresh re-adopts the identical assignment and that the guard cannot
   distinguish it. Only with approval to remove that re-created sandbox grant,
   demonstrate that destroy/replacement deletes it. Record the ownership limit
   and any usable marker evidence without committing tenant data.
