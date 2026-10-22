# role-management/directory/role-schedules

Assigns a Microsoft Entra role (built-in or custom) to a user, role-assignable group or
service principal through Privileged Identity Management (PIM), via the `microsoft/msgraph`
Terraform provider. `assignment_type = "eligible"` makes the principal eligible to activate
the role; `assignment_type = "active"` assigns it as active, time-bound or permanent. The
folder mirrors the Graph collection it manages: `roleManagement/directory`. Service principals
are supported only for time-limited active assignments; eligible and permanent service-principal
assignments are outside this module's contract.

## Why this module looks different from the others

PIM has no CRUD object for an assignment. An administrator submits a **schedule request**
(`POST roleManagement/directory/roleEligibilityScheduleRequests` for eligible assignments,
`POST roleManagement/directory/roleAssignmentScheduleRequests` for active ones) with
`action: "adminAssign"` to create the assignment and `action: "adminRemove"` to end it. The request
object supports neither PATCH nor DELETE, so this module:

1. Submits the `adminAssign` request as a one-shot **action**
   (`msgraph_resource_action.assign`), with the principal, the role definition, the scope, the
   justification and a `scheduleInfo` of an optional `startDateTime` and an `expiration` of type
   `noExpiration`, `afterDateTime` (with `endDateTime`) or `afterDuration` (with an ISO 8601
   `duration`) ([Create roleEligibilityScheduleRequest](https://learn.microsoft.com/en-us/graph/api/rbacapplication-post-roleeligibilityschedulerequests?view=graph-rest-1.0),
   [Create roleAssignmentScheduleRequests](https://learn.microsoft.com/en-us/graph/api/rbacapplication-post-roleassignmentschedulerequests?view=graph-rest-1.0),
   [requestSchedule](https://learn.microsoft.com/en-us/graph/api/resources/requestschedule?view=graph-rest-1.0),
   [expirationPattern](https://learn.microsoft.com/en-us/graph/api/resources/expirationpattern?view=graph-rest-1.0)).
   The action is forgotten on destroy.
2. Records the destroy cleanup holder after the confirmed `adminAssign`, then waits
   `verification_delay_seconds` (`time_sleep.wait_for_delivery`). A subsequent read or gate
   failure leaves that holder in state so a later destroy still runs `adminRemove`. A rejected
   POST never registers a removal hook. An accepted request whose response is lost remains
   an uncertain result requiring operator reconciliation; no live retry guarantee is claimed.
3. Reads the schedule back (`roleEligibilitySchedules` or `roleAssignmentSchedules`), filtered on
   `principalId`, `roleDefinitionId` and `directoryScopeId`, which Learn lists as `$filter`-capable on
   both collections, and matches them again case-insensitively. For an active assignment it
   ignores a schedule that is an activation of an eligibility (`assignmentType` other than
   `Assigned`), and for both it ignores one inherited through a group (`memberType` other than
   `Direct`). The schedule's `id` becomes the `schedule_id` output.
4. Gates `apply` on that read (`fail_on_verification_mismatch`). A `start_date_time` in the future
   never fails the gate, because Learn does not say whether a schedule that has not started is
   listed; `verified` is then simply false if it is not.
   The read and the gate also run in later plans, not only in the apply that created the
   assignment. Microsoft Learn does not document whether PIM keeps listing a time-bound
   schedule after it expires, and this has not been checked against a tenant. If an expired
   schedule is no longer listed, later plans fail the gate for an assignment that has ended; set
   `fail_on_verification_mismatch = false` (then inspect `verified`). Deleting the module block from
   the configuration does not run step 5, because a destroy-time provisioner runs only while its
   block is still configured, so it sends no `adminRemove` and leaves any assignment in place. To
   remove the assignment with the module, run a targeted destroy of the module while its block is
   still configured, and only when nobody has assigned the same principal, role and scope again in
   PIM: that `adminRemove` removes any assignment of this `assignment_type` for them.
5. On destroy, submits an `adminRemove` request from a destroy-time `local-exec` provisioner.
   `adminRemove` needs only the principal, role definition and scope.

**Because of step 5, the machine running the destroy needs Bash, the Azure CLI (`az`) logged in
with `az login`, `curl`, and `ARM_TENANT_ID` set to the tenant ID the `msgraph` provider uses.**
The hook targets the public cloud (`graph.microsoft.com`). Before it requests a token, it
compares `ARM_TENANT_ID` with `az account show --query tenantId` and stops if the variable is
unset or the tenants differ, so the request cannot reach another tenant. The token reaches `curl`
through a config on stdin, never on the command line. Destroy cleanup is unsupported on Windows.

An assignment that has already expired or was removed outside Terraform makes Graph answer that
it does not exist. The hook counts HTTP 404, and HTTP 400 whose error text contains "does not exist",
"DoesNotExist" or "NotFound", as removed. Learn documents no error code for `adminRemove` of an
absent assignment, so this match is on the wording and is **not verified live**. HTTP 409, 429 and
5xx answers are retried six times, 20 seconds apart; any other refusal, such as a PIM role
setting or the rule that keeps the last Global Administrator, stops the destroy and prints
Graph's error body, so state is retained for a retry.

## Any change replaces the assignment

A principal can hold one assignment of a kind for a role at a scope, so an `adminAssign` for one that
exists fails. Every input that shapes the request (including the justification and the schedule) is
recorded in `terraform_data.assignment`; a change replaces the request, the sleep and the destroy
hook, so Terraform removes the old assignment first (`adminRemove`) and then assigns again.
The module deliberately does **not** use `create_before_destroy`: the new `adminAssign` would fail
because the assignment exists, and the old assignment's destroy-time `adminRemove` would then
remove the new one. Destroy-then-create leaves a short gap with no assignment. Graph may process `adminRemove` asynchronously, so the replacement's `adminAssign` can briefly be refused as a duplicate; applying again resolves it. With
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

- **Role:** set exactly one of `role_definition_id` (a GUID, for a built-in or custom role) or
  `role_display_name`. The display name is resolved with a read-only lookup on
  `roleManagement/directory/roleDefinitions` and must match exactly one role; zero or several matches stop the
  plan.
- **Scope:** `directory_scope_id` is `/` (tenant-wide), `/administrativeUnits/<ID>` or `/<directory object ID>`
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

The input names `principal_id`, `role_definition_id`, `role_display_name` and `directory_scope_id` are the
names that a future module for permanent active directory role assignments (tracked separately) is meant to reuse.

## Usage

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one.

```hcl
module "security_reader_eligibility" {
  source  = "satolap/modules/msgraph//verified/role-management/directory/role-schedules"
  version = "<version>"

  assignment_type   = "eligible"
  principal_id      = module.secops_group.id
  role_display_name = "Security Reader"

  expiration_type = "afterDateTime"
  end_date_time   = "2027-12-31T00:00:00Z"
  justification   = "SecOps on-call rota"
}

module "helpdesk_temporary_access" {
  source  = "satolap/modules/msgraph//verified/role-management/directory/role-schedules"
  version = "<version>"

  assignment_type    = "active"
  principal_id       = module.helpdesk_user.id
  role_definition_id = "dddddddd-dddd-4ddd-8ddd-dddddddddddd" # the ID of a built-in or custom role
  directory_scope_id = "/administrativeUnits/${module.emea_unit.id}"

  start_date_time = "2026-11-01T00:00:00Z"
  expiration_type = "afterDuration"
  duration        = "P30D"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.11.0 |
| msgraph | >= 0.3.0 |
| time | >= 0.9.0 |
| null | >= 3.2.0 |
| Bash, Azure CLI (`az`), `curl` and `ARM_TENANT_ID` | Required on the machine running the destroy; Windows is unsupported for destroy cleanup |

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

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | PIM-ENTRA-ROLES | Using Privileged Identity Management requires Microsoft Entra ID P2 or Microsoft Entra ID Governance (Microsoft Entra Suite includes it). Learn lists the users who need a license: users with eligible or time-bound assignments to Microsoft Entra roles managed with PIM, users who can approve or reject activation requests in PIM, and users assigned to or performing access reviews. When the license expires, eligible assignments are removed and time-bound active assignments become permanent. Any of: Microsoft Entra ID P2 (`AAD_PREMIUM_P2`); Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Each principal with an eligible or time-bound assignment to a Microsoft Entra role, and each user who approves or rejects activation requests for the role | direct / per_user | documented |

Notes:

- Role settings in PIM (maximum eligibility or assignment duration, required justification, approval, permanent assignments) can reject a request; they are configuration, not licensing. See [Configure Microsoft Entra role settings in Privileged Identity Management](https://learn.microsoft.com/en-us/entra/id-governance/privileged-identity-management/pim-how-to-change-default-settings).
- A successful adminAssign call does not establish entitlement; the license rule above applies to the principals and approvers of the roles that this module assigns.
- The PIM rule was reviewed against Microsoft Learn on 2026-10-16, which is later than the review date stated above.
- When `directory_scope_id` is not `"/"`: A directory_scope_id of /administrativeUnits/<ID> assigns a Microsoft Entra role at administrative unit scope; Microsoft Entra ID P1 for each administrator who holds such a role is covered by the PIM license above only when that administrator has an eligible or time-bound assignment; a permanent active assignment at this scope is outside the PIM population above and still needs the ADMIN-UNITS rule, which this registry cannot switch on for this scope form alone. A scope of /<object ID> targets a directory object such as an application registration, with no further license rule reviewed.

Sources: [Microsoft Entra ID Governance licensing fundamentals: Privileged Identity Management](https://learn.microsoft.com/en-us/entra/id-governance/licensing-fundamentals#privileged-identity-management), [What is Microsoft Entra Privileged Identity Management? License requirements](https://learn.microsoft.com/en-us/entra/id-governance/privileged-identity-management/pim-configure#license-requirements).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| assignment_type | `eligible` or `active` | `string` | n/a | yes |
| principal_id | Object ID of the user or role-assignable group; service principals only for time-limited active assignments (see above) | `string` | n/a | yes |
| role_definition_id | Role definition ID (GUID); set exactly one of this and `role_display_name` | `string` | `null` | no |
| role_display_name | Role display name resolved by a read-only lookup that must match one role | `string` | `null` | no |
| directory_scope_id | `/`, `/administrativeUnits/<ID>` or `/<directory object ID>` | `string` | `"/"` | no |
| justification | Justification sent with the request; must not be empty | `string` | `"Managed by Terraform"` | no |
| start_date_time | RFC 3339 start; null starts when Graph processes the request | `string` | `null` | no |
| expiration_type | `noExpiration`, `afterDateTime` or `afterDuration` | `string` | `"noExpiration"` | no |
| end_date_time | RFC 3339 end; required with `afterDateTime`, refused otherwise | `string` | `null` | no |
| duration | ISO 8601 duration such as `PT8H` or `P30D`; required with `afterDuration`, refused otherwise | `string` | `null` | no |
| verification_delay_seconds | Seconds to wait before reading the schedule back | `number` | `15` | no |
| fail_on_verification_mismatch | Fail apply if the read-back finds no single matching schedule; a future `start_date_time` never fails | `bool` | `true` | no |
| enable_destroy_cleanup | Create the Azure CLI removal hook; disable only before first apply for tests or externally managed cleanup | `bool` | `true` | no |
| api_version | Graph API version (`v1.0` or `beta`) | `string` | `"v1.0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| request_id | The ID of the adminAssign schedule request |
| status | The status Graph returned for the request |
| role_definition_id | The assigned role definition ID, as given or resolved from the display name |
| directory_scope_id | The scope of the assignment |
| schedule_id | The ID of the schedule found by the read-back; null if not found |
| verified | Whether the read-back found exactly one matching schedule |

## Tests

`terraform test` runs offline unit tests (`tests/role_schedules.tftest.hcl`) that mock the
providers and disable the destroy hook. They assert the request URL and body of both assignment types, every
expiration type and each refusal, the optional start time, the scope forms, the display-name
lookup with no, one and several matches, the rule that exactly one role reference is set, the
verification read and its gate (including a future start), and that every input replaces the
request. `tests/test_destroy_cleanup.py` runs the hook with stub `az` and `curl`. Terraform
mocking does not suppress provisioners by itself. Tests require Terraform 1.11 or later. Nothing
here has been run against a tenant.
