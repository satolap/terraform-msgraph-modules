# roleManagement/directory/roleSchedules

<!-- state-protection:start -->
## State and plan protection

This module's state and saved plans retain these declared values:

Potential personal-data inputs: `principalId`.

Protect these values with an encrypted remote backend and least-privilege access to state, plans and backups. `sensitive` is presentation redaction, not encryption; provider resource values can still appear in plan/show output. Do not publish plan output in CI logs or PR comments for secret-bearing roots; keep saved plans short-lived and rotate credentials after exposure.

See [Terraform sensitive state guidance](https://developer.hashicorp.com/terraform/language/state/sensitive-data). These are exposure indicators, not a complete data classification; unmarked fields and provider responses also need protection.
<!-- state-protection:end -->

<!-- uses-beta:start -->
Uses beta: **optional**. Beta is an optional api_version selection for compatibility; no beta-only capability is required by this module's contract. Prefer v1.0. Beta is preview and may change without notice. Pin module and provider versions; read `interface-changes.json` before upgrading.
<!-- uses-beta:end -->

<!-- live-status:start -->
Assurance: **verified offline-only**. No current live acceptance is recorded for this module.

![live: offline only](https://img.shields.io/badge/live-offline%20only-lightgrey)
<!-- live-status:end -->

Assigns a Microsoft Entra role (built-in or custom) to a user, role-assignable group or
service principal through Privileged Identity Management (PIM), via the `microsoft/msgraph`
Terraform provider. `assignment_type = "eligible"` makes the principal eligible to activate
the role; `assignment_type = "active"` assigns it as active, time-bound or permanent. The
folder mirrors the Graph collection it manages: `roleManagement/directory`. Service principals
are supported only for time-limited active assignments; eligible and permanent service-principal
assignments are outside this module's contract.

## Native request lifecycle

PIM uses adminAssign/adminRemove POSTs to roleEligibilityScheduleRequests or
roleAssignmentScheduleRequests; never DELETE the request itself. The creation
action ignores all in-place changes and replaces destroy-first through the
existing assignment input record. An independent GET of its exact saved request
ID requires matching principal, role and directory scope, adminAssign action,
no app scope, isValidationOnly=false and a completed status (Provisioned,
ScheduleCreated or Granted). This allowlist is module policy; pending, denied,
unknown or missing status fails closed. Future starts can register removal from
a verified ScheduleCreated request without requiring a listed schedule.
The GET alone retries 404 / NotFound / Request_ResourceNotFound for at most two
minutes. No POST is retried for replication.

The legacy `null_resource.remove_on_destroy[0]` keeps its exact triggers as an
inert identity record. `msgraph_resource_action.remove[0]` registers after that
independent request verification, before the delay and fallible schedule gate.
It sends adminRemove only at destroy/replacement, using saved principal, role,
scope, assignment type and API version with provider credentials. Registration
sends no write. Bash, Azure CLI and curl are no longer needed. Changing an input
removes the old assignment before requesting its replacement; no
create_before_destroy is enabled. Cleanup survives a subsequent schedule-gate
failure, but a failed independent request GET leaves it unregistered.

Accepted limitation: adminRemove addresses a type/principal/role/scope tuple,
not a unique schedule generation. Another writer's identical re-assignment
cannot be distinguished and would be removed. Coordinate a single writer and
reconcile intervention before cleanup. No destroy-time identity re-check or
removal-delivery polling is performed. Native errors retain state for retry; the
old shell's absent-message suppression and broad retry loop are not reproduced.
In particular, after natural expiry with afterDateTime or afterDuration, Graph
can answer 404 or 400 DoesNotExist / NotFound to adminRemove; the native action
fails destroy where the old script treated that as removed. The pinned schema
has no safe successful-error override. This migration limitation requires owner
acceptance: independently confirm the original owned schedule has ended/expired
or is absent, exclude another writer's replacement, then use the state-rm
recovery below. A merely past configured expiry or a 400 message alone is not
proof of revocation. Independently confirm removal; acceptance is not delivery
proof.

Verification remains a data source, not a one-time check. Every refresh-enabled
plan or apply runs the verification GET again, even after removal registration.
A later 404, missing or mismatched identity, or a request status outside the
completed allowlist can therefore fail routine plans. Failure does not revoke
access or unregister an existing remove action. Reconcile the saved identity;
never taint or replay the successful POST to repair a read. For cleanup after
independently confirmed absence, use the state-rm recovery below and finish
`terraform destroy -refresh=false`; this skips failing refresh reads and does
not establish ownership or revoke access by itself.

## Upgrade and recovery

Back up state privately and run an **unchanged apply before destroy, input
changes or replacement**. Confirm the adminAssign and legacy null record IDs
are unchanged and native removal holds the old type/principal/role/scope.
Merely updating configuration does not register removal: destroy can orphan
privileged access with nothing in state to delete it. This sequencing is not
enforced by a state-presence check.

After POST succeeds but independent verification fails, **re-run apply with
unchanged inputs; never use destroy as recovery**. Keep the successful request
state; pending approval needs owner reconciliation and later unchanged apply,
never a second adminAssign. Do not bypass verification or force replacement.
An ambiguous POST or a denied/revoked/expired legacy request needs private
owner investigation before proceeding.

For manual recovery, read the exact captured adminAssign request in the provider
tenant and prove its ID and original tuple. Independently inspect schedules for
that type and tuple, refuse ambiguous ownership, and only then submit adminRemove
for the captured tuple. Poll until the exact owned schedule is gone/ended and
check no replacement by another writer exists. Never select a substitute role
or principal. If a registered removal fails because the owned schedule is
already absent or independently proven ended/expired, confirm the exact
absence or ended state with independent schedule/instance evidence and
exclude an external replacement before using
`terraform state rm 'module.schedule.msgraph_resource_action.remove[0]'` and
finish `terraform destroy -refresh=false`. Do not re-apply between state removal
and completing destroy. Denied/incomplete reads and a just-created replica 404
do not prove absence. State removal revokes no access.

Saved identity and URL guards protect registration; this is not a destroy-time
state integrity check. Do not edit saved action bodies/URLs. Disable cleanup
only before first apply for externally owned removal; disabling an already
registered action runs adminRemove.

Owner-dispatched live acceptance: verify destroy-only capability per platform;
create disposable eligible and time-limited active requests; independently GET
their saved IDs and tuple; test future starts, completed status casing, pending
approval/denial and replication/permission failures; retry unchanged apply
without POST replay. Prove legacy unchanged upgrade and schedule-gate failure
retain registered cleanup. Replace each input destroy-first, confirm adminRemove
uses the old collection and tuple before new adminAssign, poll removal delivery
and verify unrelated schedules unchanged. Probe expired/absent errors and
confirmed-absence recovery. Keep only sanitized evidence; no live run is claimed.

## Any change replaces the assignment

A principal can hold one assignment of a kind for a role at a scope, so an `adminAssign` for one that
exists fails. Every input that shapes the request (including the justification and the schedule) is
recorded in `terraform_data.assignment`; a change replaces the request, the sleep and the destroy
hook, so Terraform removes the old assignment first (`adminRemove`) and then assigns again.
The module deliberately does **not** use `create_before_destroy`: the new `adminAssign` would fail
because the assignment exists, and the old assignment's destroy-time `adminRemove` would then
remove the new one. Destroy-then-create leaves a short gap with no assignment. Graph may process `adminRemove` asynchronously, so the replacement's `adminAssign` can briefly be refused as a duplicate; independently confirm old removal before retrying a refused create, and reconcile ambiguous outcomes first. With
`enable_destroy_cleanup = false` nothing removes the old assignment, so remove it yourself before
you change an input. Changing `assignment_type` removes the assignment of the old kind and creates one of
the new kind.

## PIM role settings can reject the request

Each role has PIM role settings, the rules of its management policy: whether permanent
eligible or active assignments are allowed, the maximum duration of an assignment, whether a
justification, ticket information or approval is required. Graph evaluates the request against
them, so a permanent assignment (`expiration_type = "noExpiration"`) for a role whose settings forbid
it, or an end date past the maximum, is rejected with an error that the module surfaces unchanged.
Change the request, or the role settings, which this module does not manage; see
[Rules in PIM](https://learn.microsoft.com/en-us/graph/identity-governance-pim-rules-overview) and
[Update rules in PIM](https://learn.microsoft.com/en-us/graph/how-to-pim-update-rules).
Learn does not say whether `adminAssign` can end in a pending approval status; the request's `status`
is exported, and a status that leaves no schedule makes the read-back fail the gate.

## Choosing the role and the scope

- **Role:** set exactly one of `roleDefinitionId` (a GUID, for a built-in or custom role) or
  `role_display_name`. The display name is resolved with a read-only lookup on
  `roleManagement/directory/roleDefinitions` and must match exactly one role; zero or several matches stop the
  plan.
- **Scope:** `directoryScopeId` is `/` (tenant-wide), `/administrativeUnits/<ID>` or `/<directory object ID>`
  (for example an application registration). Whether a role can be assigned at a given scope depends
  on the role; Graph refuses an unsupported combination.
- **Principal:** a user or a role-assignable group. A service principal is supported only with
  `assignment_type = "active"` and `expiration_type = "afterDateTime"` or `"afterDuration"`.
  [Microsoft's PIM deployment guidance](https://learn.microsoft.com/en-us/entra/id-governance/privileged-identity-management/pim-deployment-plan)
  excludes service principals from eligible assignments and documents time-limited active
  assignments. The caller must establish the principal type; this module performs no type
  lookup and its GUID validation cannot establish that a principal is supported.
- **Schedule:** `start_date_time` is optional. `duration` accepts days and time only (`P30D`, `PT8H`),
  not years, months or weeks.

The input names `principalId`, `roleDefinitionId`, `role_display_name` and `directoryScopeId` are the
names that a future module for permanent active directory role assignments (tracked separately) is meant to reuse.

## Usage

Replace `<version>` with a release version, such as `0.5.0`; the [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one.

```hcl
module "security_reader_eligibility" {
  source  = "satolap/modules/msgraph//verified/roleManagement/directory/roleSchedules"
  version = "<version>"

  assignment_type   = "eligible"
  principalId       = module.secops_group.id
  role_display_name = "Security Reader"

  expiration_type = "afterDateTime"
  end_date_time   = "2027-12-31T00:00:00Z"
  justification   = "SecOps on-call rota"
}

module "helpdesk_temporary_access" {
  source  = "satolap/modules/msgraph//verified/roleManagement/directory/roleSchedules"
  version = "<version>"

  assignment_type  = "active"
  principalId      = module.helpdesk_user.id
  roleDefinitionId = "dddddddd-dddd-4ddd-8ddd-dddddddddddd" # the ID of a built-in or custom role
  directoryScopeId = "/administrativeUnits/${module.emea_unit.id}"

  start_date_time = "2026-11-01T00:00:00Z"
  expiration_type = "afterDuration"
  duration        = "P30D"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.11.0 |
| msgraph | >= 0.6.0, < 0.7.0 |
| time | >= 0.9.0 |
| null | >= 3.2.0 |

Microsoft Graph permissions (application or delegated). Learn lists these as the least privileged
permissions for the create calls; `RoleManagement.ReadWrite.Directory` also works but grants more.

| assignment_type | Permission to assign and remove | Permission to read back the schedule |
|-----------------|----------------------------------|---------------------------------------|
| eligible | `RoleEligibilitySchedule.ReadWrite.Directory` | `RoleEligibilitySchedule.Read.Directory` (included in the ReadWrite permission) |
| active | `RoleAssignmentSchedule.ReadWrite.Directory` | `RoleAssignmentSchedule.Read.Directory` (included in the ReadWrite permission) |

`role_display_name` also needs read access to role definitions, for example `RoleManagement.Read.Directory`
(included in `RoleManagement.ReadWrite.Directory`). The Create pages list `RoleAssignmentSchedule.Remove.Directory` and
`RoleEligibilitySchedule.Remove.Directory` as higher privileged alternatives; Learn does not say whether
`adminRemove` needs more than the ReadWrite permission, and this is not verified live. A delegated caller needs the
Privileged Role Administrator role or a custom role with the same rights.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

Before deployment, check the requirements of the features you enable and the users who benefit. You can inspect tenant subscriptions with `GET /subscribedSkus`; this requires `Organization.Read.All` or `LicenseAssignment.Read.All` ([List subscribedSkus](https://learn.microsoft.com/en-us/graph/api/subscribedsku-list?view=graph-rest-1.0)).

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | PIM-ENTRA-ROLES | Using Privileged Identity Management requires Microsoft Entra ID P2 or Microsoft Entra ID Governance (Microsoft Entra Suite includes it). Learn lists the users who need a license: users with eligible or time-bound assignments to Microsoft Entra roles managed with PIM, users who can approve or reject activation requests in PIM, and users assigned to or performing access reviews. When the license expires, eligible assignments are removed and time-bound active assignments become permanent. Any of: Microsoft Entra ID P2 (`AAD_PREMIUM_P2`); Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Each principal with an eligible or time-bound assignment to a Microsoft Entra role, and each user who approves or rejects activation requests for the role | direct / per_user | documented |

Notes:

- Role settings in PIM (maximum eligibility or assignment duration, required justification, approval, permanent assignments) can reject a request; they are configuration, not licensing. See [Configure Microsoft Entra role settings in Privileged Identity Management](https://learn.microsoft.com/en-us/entra/id-governance/privileged-identity-management/pim-how-to-change-default-settings).
- A successful adminAssign call does not establish entitlement; the license rule above applies to the principals and approvers of the roles that this module assigns.
- The PIM rule was reviewed against Microsoft Learn on 2026-10-16, which is later than the review date stated above.
- When `directoryScopeId` is not `"/"`: A directory_scope_id of /administrativeUnits/<ID> assigns a Microsoft Entra role at administrative unit scope; Microsoft Entra ID P1 for each administrator who holds such a role is covered by the PIM license above only when that administrator has an eligible or time-bound assignment; a permanent active assignment at this scope is outside the PIM population above and still needs the ADMIN-UNITS rule, which this registry cannot switch on for this scope form alone. A scope of /<object ID> targets a directory object such as an application registration, with no further license rule reviewed.

Sources: [Microsoft Entra ID Governance licensing fundamentals: Privileged Identity Management](https://learn.microsoft.com/en-us/entra/id-governance/licensing-fundamentals#privileged-identity-management), [What is Microsoft Entra Privileged Identity Management? License requirements](https://learn.microsoft.com/en-us/entra/id-governance/privileged-identity-management/pim-configure#license-requirements).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required | On change |
|------|-------------|------|---------|----------| --- |
| assignment_type | `eligible` or `active` | `string` | n/a | yes | replaces `msgraph_resource_action.assign`; changes `null_resource.remove_on_destroy`; see the module notes |
| principalId | Object ID of the user or role-assignable group; service principals only for time-limited active assignments (see above) | `string` | n/a | yes | replaces `msgraph_resource_action.assign`; changes `null_resource.remove_on_destroy`; see the module notes |
| roleDefinitionId | Role definition ID (GUID); set exactly one of this and `role_display_name` | `string` | `null` | no | replaces `msgraph_resource_action.assign` when its effect on `local.role_definition_id` changes; changes `null_resource.remove_on_destroy`; see the module notes |
| role_display_name | Role display name resolved by a read-only lookup that must match one role | `string` | `null` | no | replaces `msgraph_resource_action.assign` when its effect on `local.role_definition_id` changes; changes `null_resource.remove_on_destroy`; see the module notes |
| directoryScopeId | `/`, `/administrativeUnits/<ID>` or `/<directory object ID>` | `string` | `"/"` | no | replaces `msgraph_resource_action.assign`; changes `null_resource.remove_on_destroy`; see the module notes |
| justification | Justification sent with the request; must not be empty | `string` | `"Managed by Terraform"` | no | replaces `msgraph_resource_action.assign`; changes `null_resource.remove_on_destroy`; see the module notes |
| start_date_time | RFC 3339 start; null starts when Graph processes the request | `string` | `null` | no | replaces `msgraph_resource_action.assign`; changes `null_resource.remove_on_destroy`; see the module notes |
| expiration_type | `noExpiration`, `afterDateTime` or `afterDuration` | `string` | `"noExpiration"` | no | replaces `msgraph_resource_action.assign`; changes `null_resource.remove_on_destroy`; see the module notes |
| end_date_time | RFC 3339 end; required with `afterDateTime`, refused otherwise | `string` | `null` | no | replaces `msgraph_resource_action.assign`; changes `null_resource.remove_on_destroy`; see the module notes |
| duration | ISO 8601 duration such as `PT8H` or `P30D`; required with `afterDuration`, refused otherwise | `string` | `null` | no | replaces `msgraph_resource_action.assign`; changes `null_resource.remove_on_destroy`; see the module notes |
| verification_delay_seconds | Seconds to wait before reading the schedule back | `number` | `15` | no | no object change (validation or timing only) |
| fail_on_verification_mismatch | Fail apply if the read-back finds no single matching schedule; a future `start_date_time` never fails | `bool` | `true` | no | no object change (validation or timing only) |
| enable_destroy_cleanup | Register provider-native removal after independent verification; disable only before first apply for externally owned cleanup | `bool` | `true` | no | changes `null_resource.remove_on_destroy`; see the module notes; creates or deletes `msgraph_resource_action.remove` instances |
| api_version | Graph API version (`v1.0` or `beta`) | `string` | `"v1.0"` | no | replaces `msgraph_resource_action.assign`; changes `null_resource.remove_on_destroy`; see the module notes |

## Outputs

| Name | Description | Known in plan after an update |
|------|-------------| --- |
| request_id | The ID of the adminAssign schedule request | no |
| status | The status Graph returned for the request | no |
| role_definition_id | The assigned role definition ID, as given or resolved from the display name | no |
| directory_scope_id | The scope of the assignment | yes |
| schedule_id | The ID of the schedule found by the read-back; null if not found | no |
| verified | Whether the read-back found exactly one matching schedule | no |

## Tests

`terraform test` runs offline unit tests (`tests/role_schedules.tftest.hcl`) that mock the
providers and disable the destroy hook. They assert the request URL and body of both assignment types, every
expiration type and each refusal, the optional start time, the scope forms, the display-name
lookup with no, one and several matches, the rule that exactly one role reference is set, the
verification read and its gate (including a future start), and that every input replaces the
request. `tests/native_cleanup.tftest.hcl` verifies native registration, failed request
proof, active/eligible counter-request routing and cleanup before a failed
schedule gate. `tests/upgrade.tftest.hcl` proves unchanged legacy-state upgrade. Tests require Terraform 1.11 or later. Nothing
here has been run against a tenant.

<!-- drift:start -->
## Drift and out-of-band changes

Terraform plans compare configuration and refreshed provider state. A plan that changes one of these inputs proposes its declared effect; review the plan before applying. The consumer guide explains refresh limits and emergency reconciliation.

- `enable_destroy_cleanup`: changes `null_resource.remove_on_destroy`; see the module notes; creates or deletes `msgraph_resource_action.remove` instances.
- `assignment_type`: replaces `msgraph_resource_action.assign`; changes `null_resource.remove_on_destroy`; see the module notes.
- `principalId`: replaces `msgraph_resource_action.assign`; changes `null_resource.remove_on_destroy`; see the module notes.
- `roleDefinitionId`: replaces `msgraph_resource_action.assign` when its effect on `local.role_definition_id` changes; changes `null_resource.remove_on_destroy`; see the module notes.
- `role_display_name`: replaces `msgraph_resource_action.assign` when its effect on `local.role_definition_id` changes; changes `null_resource.remove_on_destroy`; see the module notes.
- `directoryScopeId`: replaces `msgraph_resource_action.assign`; changes `null_resource.remove_on_destroy`; see the module notes.
- `justification`: replaces `msgraph_resource_action.assign`; changes `null_resource.remove_on_destroy`; see the module notes.
- `start_date_time`: replaces `msgraph_resource_action.assign`; changes `null_resource.remove_on_destroy`; see the module notes.
- `expiration_type`: replaces `msgraph_resource_action.assign`; changes `null_resource.remove_on_destroy`; see the module notes.
- `end_date_time`: replaces `msgraph_resource_action.assign`; changes `null_resource.remove_on_destroy`; see the module notes.
- `duration`: replaces `msgraph_resource_action.assign`; changes `null_resource.remove_on_destroy`; see the module notes.
- `verification_delay_seconds`: no object change (validation or timing only).
- `fail_on_verification_mismatch`: no object change (validation or timing only).
- `api_version`: replaces `msgraph_resource_action.assign`; changes `null_resource.remove_on_destroy`; see the module notes.
<!-- drift:end -->

<!-- permissions:begin -->
## Per-operation permissions

Source: [Graph DevX map](https://raw.githubusercontent.com/microsoftgraph/microsoft-graph-devx-content/56e1917fe45fb7c52c2d9845f569c2ffdb39e4d9/permissions/new/permissions.json) (SHA-256 `4d7dee52659b1d6424bce0b26603302081d39ef9e149bc5fb50de4273b3d3514`).
The map is shared by v1.0 and beta; it does not certify API-version support. Rows show the source's least-privilege annotations, not live-tested consent. Choose an alternative for your authentication type; do not grant every listed scope. AlsoRequires lists additional scope alternatives attached to that row. Missing annotations are unknown, not evidence that an operation needs no permission. Keep the module's documented role, property-specific and tenant restrictions.

Derived from this module's Terraform sources, including optional guards, destroy actions and local child modules. The checked inventory is `docs/permissions/verified-operations.json`. These are potential requests, not a preflight scope list. A provider primitive may expose an update that Graph does not support. Source paths and conditions are retained in the inventory.

| Operation | Authentication | Least-privilege alternative | AlsoRequires | Unknown reason |
| --- | --- | --- | --- | --- |
| `POST /roleManagement/directory/roleAssignmentScheduleRequests` | DelegatedWork | `RoleAssignmentSchedule.ReadWrite.Directory` | - | - |
| `POST /roleManagement/directory/roleAssignmentScheduleRequests` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `POST /roleManagement/directory/roleAssignmentScheduleRequests` | Application | `RoleAssignmentSchedule.ReadWrite.Directory` | - | - |
| `POST /roleManagement/directory/roleAssignmentScheduleRequests` | Application | `RoleManagement.ReadWrite.Directory` | - | - |
| `POST /roleManagement/directory/roleEligibilityScheduleRequests` | DelegatedWork | `RoleEligibilitySchedule.ReadWrite.Directory` | - | - |
| `POST /roleManagement/directory/roleEligibilityScheduleRequests` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `POST /roleManagement/directory/roleEligibilityScheduleRequests` | Application | `RoleEligibilitySchedule.ReadWrite.Directory` | - | - |
| `POST /roleManagement/directory/roleEligibilityScheduleRequests` | Application | `RoleManagement.ReadWrite.Directory` | - | - |
| `GET /roleManagement/directory/roleDefinitions` | DelegatedWork | `RoleManagement.Read.Directory` | - | - |
| `GET /roleManagement/directory/roleDefinitions` | DelegatedWork | `RoleManagement.ReadWrite.Directory` | - | - |
| `GET /roleManagement/directory/roleDefinitions` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /roleManagement/directory/roleDefinitions` | Application | `RoleManagement.Read.Directory` | - | - |
| `GET /roleManagement/directory/roleDefinitions` | Application | `RoleManagement.ReadWrite.Directory` | - | - |
| `GET /roleManagement/directory/roleAssignmentSchedules` | DelegatedWork | `RoleAssignmentSchedule.Read.Directory` | - | - |
| `GET /roleManagement/directory/roleAssignmentSchedules` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /roleManagement/directory/roleAssignmentSchedules` | Application | `RoleAssignmentSchedule.Read.Directory` | - | - |
| `GET /roleManagement/directory/roleEligibilitySchedules` | DelegatedWork | `RoleEligibilitySchedule.Read.Directory` | - | - |
| `GET /roleManagement/directory/roleEligibilitySchedules` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /roleManagement/directory/roleEligibilitySchedules` | Application | `RoleEligibilitySchedule.Read.Directory` | - | - |
| `GET /roleManagement/directory/roleAssignmentScheduleRequests/missing-created-request-id` | DelegatedWork | Unknown / not annotated | - | The verification fallback contains a literal missing-request sentinel, not a proven object ID. The pin annotates the parameterized item path, not this concrete failure-path URI; do not silently substitute an ID or infer a permission grant. |
| `GET /roleManagement/directory/roleAssignmentScheduleRequests/missing-created-request-id` | DelegatedPersonal | Unknown / not annotated | - | The verification fallback contains a literal missing-request sentinel, not a proven object ID. The pin annotates the parameterized item path, not this concrete failure-path URI; do not silently substitute an ID or infer a permission grant. |
| `GET /roleManagement/directory/roleAssignmentScheduleRequests/missing-created-request-id` | Application | Unknown / not annotated | - | The verification fallback contains a literal missing-request sentinel, not a proven object ID. The pin annotates the parameterized item path, not this concrete failure-path URI; do not silently substitute an ID or infer a permission grant. |
| `GET /roleManagement/directory/roleAssignmentScheduleRequests/{id}` | DelegatedWork | `RoleAssignmentSchedule.ReadWrite.Directory` | - | - |
| `GET /roleManagement/directory/roleAssignmentScheduleRequests/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /roleManagement/directory/roleAssignmentScheduleRequests/{id}` | Application | `RoleAssignmentSchedule.ReadWrite.Directory` | - | - |
| `GET /roleManagement/directory/roleEligibilityScheduleRequests/missing-created-request-id` | DelegatedWork | Unknown / not annotated | - | The verification fallback contains a literal missing-request sentinel, not a proven object ID. The pin annotates the parameterized item path, not this concrete failure-path URI; do not silently substitute an ID or infer a permission grant. |
| `GET /roleManagement/directory/roleEligibilityScheduleRequests/missing-created-request-id` | DelegatedPersonal | Unknown / not annotated | - | The verification fallback contains a literal missing-request sentinel, not a proven object ID. The pin annotates the parameterized item path, not this concrete failure-path URI; do not silently substitute an ID or infer a permission grant. |
| `GET /roleManagement/directory/roleEligibilityScheduleRequests/missing-created-request-id` | Application | Unknown / not annotated | - | The verification fallback contains a literal missing-request sentinel, not a proven object ID. The pin annotates the parameterized item path, not this concrete failure-path URI; do not silently substitute an ID or infer a permission grant. |
| `GET /roleManagement/directory/roleEligibilityScheduleRequests/{id}` | DelegatedWork | `RoleEligibilitySchedule.ReadWrite.Directory` | - | - |
| `GET /roleManagement/directory/roleEligibilityScheduleRequests/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /roleManagement/directory/roleEligibilityScheduleRequests/{id}` | Application | `RoleEligibilitySchedule.ReadWrite.Directory` | - | - |

### Property-specific coverage

Route annotations do not establish that the listed scopes cover every selected or writable property. Dynamic bodies, additional properties and default responses remain unbounded. Keep the reviewed permission guidance above; in particular, a group-nesting scope is not general group-property access. The pin's method/path entries do not distinguish property grants from navigation or sub-resource operations; property coverage stays unknown.

| Operation | Properties | Source evidence |
| --- | --- | --- |
| `POST /roleManagement/directory/roleAssignmentScheduleRequests` | `action`, `directoryScopeId`, `justification`, `principalId`, `roleDefinitionId`, `scheduleInfo` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `POST /roleManagement/directory/roleEligibilityScheduleRequests` | `action`, `directoryScopeId`, `justification`, `principalId`, `roleDefinitionId`, `scheduleInfo` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
<!-- permissions:end -->
