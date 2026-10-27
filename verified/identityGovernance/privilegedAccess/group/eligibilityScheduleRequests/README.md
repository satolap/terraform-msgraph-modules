# PIM for Groups eligibility schedule request

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

Submit one reviewed administrative request that makes a principal eligible for membership or ownership of a group (eligibility is not activation), at the Microsoft
Graph v1.0 `/identityGovernance/privilegedAccess/group/eligibilityScheduleRequests`
endpoint, and read the resulting schedule and instance back for correlation.
Inputs and folder names keep Graph's original case. This is PIM for Groups
(`accessId` is `member` or `owner`), distinct from PIM for Microsoft Entra roles
([`role-schedules`](../../../../role-management/directory/role-schedules/README.md))
and from ordinary group membership or ownership resources.

For a published release containing this module, replace `<version>` with that
release version. The [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry)
explains registry installation. Availability in this source tree does not mean
that an existing release already includes the module.

```hcl
module "group_eligibility" {
  source  = "satolap/modules/msgraph//verified/identityGovernance/privilegedAccess/group/eligibilityScheduleRequests"
  version = "<version>"

  principal_id    = "00000000-0000-0000-0000-000000000001"
  group_id        = "00000000-0000-0000-0000-000000000002"
  access_id       = "member"
  justification   = "Reviewed change CHG-1001"
  start_date_time = "2026-11-01T00:00:00Z"
  end_date_time   = "2026-11-01T08:00:00Z"
}
```

## Contract

The module sends exactly one `POST` with `action = "adminAssign"`, the explicit
`principalId`, `groupId` and `accessId`, a `justification`, and a `scheduleInfo`
with one `startDateTime` and an `expiration` of type `afterDateTime`. Nothing
else is offered, even though the resource metadata lists more:

- No `adminUpdate`, `adminExtend`, `adminRenew`, `adminRemove`, `selfActivate` or
  `selfDeactivate`, no `ticketInfo`, `customData` or `isValidationOnly`.
- No recurrence, no permanent grant, no duration-based window. The window is
  always explicit and at most 24 hours: a conservative limit of this module, not
  a Graph rule.
- No default for `access_id`: ownership is never granted by omission.
- Eligibility never silently becomes active membership or ownership. Activation is
  the principal's own `selfActivate` request and is not modelled here.

Self-activation, MFA and approval decisions, and automatic approval, are not
persistent configuration and are outside this module. It never changes a role
management policy (`/policies/roleManagementPolicies`): a policy that requires
approval, MFA or a different maximum duration can reject or hold the request,
and that is Graph's answer, surfaced unchanged.

`assignmentApprovals`, `resources` and the schedule and schedule-instance
collections are workflow, discovery and result surfaces. This module only reads
the schedule and instance collections; it invents no CRUD under that prefix.

## Lifecycle

A schedule request supports neither PATCH nor DELETE, so the request is a
one-shot `msgraph_resource_action`, forgotten on destroy.

| Situation | Behavior |
| --- | --- |
| First apply | Submits one `adminAssign` (the action runs only on create; `ignore_changes = all` means no in-place update can resend it). A rejected POST fails the apply and records nothing. |
| No-op | An unchanged configuration submits nothing. |
| Reworded `justification` | Not part of the grant identity; submits nothing and the stored request is left as it was. |
| Changed principal, group, access or window | **Refused, fail closed.** The module records the submitted identity and window once (`terraform_data.grant`, `ignore_changes = [input]`) and the gate fails the plan if the configuration no longer matches. It never replaces a running grant on its own: a second `adminAssign` for an existing grant is expected to be refused by PIM (as the directory-role module records), and replacing the request would drop the running grant from state. To change a grant, let it expire or remove it in PIM, then deliberately run `terraform apply -replace=terraform_data.grant`, which replaces the record and the request and submits a new `adminAssign`. The old grant is never removed by this module. |
| Expiry | The grant ends at `end_date_time`. After that time `state` is `expired`, the verification gate no longer fails later plans, and a configuration change is still refused until the deliberate replace above. |
| Destroy or removing the module block | Sends nothing to Graph. It never deletes or alters the group, the principal, any other membership or ownership, or a policy, and it does not revoke a grant that is still running. |
| Revocation before expiry | Not automated. Documented `adminRemove` selecting a schedule is unverified for this module; an owner removes the grant in PIM or runs a separately reviewed, owner-dispatched probe. No confirmed cleanup is claimed. |
| Import or adoption | Not supported: a schedule that was not created by this module's request is never adopted, and an identity-only match never counts. |
| Lost response | If the POST succeeded but its response was lost, the state has no request. Do not apply again: look for the request and schedule in PIM first, because a second `adminAssign` for the same grant may be rejected or duplicate it. This module offers no local ledger or cross-process deduplication. |

## Evidence ladder

`state` never claims more than was observed:

| `state` | Meaning |
| --- | --- |
| `rejected` | Graph reported `Canceled`, `Denied`, `Failed` or `Revoked` when the request was submitted. The apply and every later plan fail until the grant record is replaced. |
| `withdrawn` | The request now reports `Canceled`, `Denied`, `Failed` or `Revoked`, having been accepted when it was submitted (a grant that ended or was removed, or a request denied while it waited). Reported, never an error; with `fail_on_verification_mismatch` the open-window check still applies. |
| `request_unreadable` | The request could be read back before and is no longer listed. Reported, never an error. |
| `request_accepted_only` | Graph accepted the request (HTTP 201 and a request ID). This is not effective access: it may await approval or provisioning. Also the state of an upcoming window with nothing visible yet. |
| `expired` | The window has ended, whatever was or is still listed. Proves no cleanup. |
| `schedule_only` | Exactly one direct schedule matches the identity, the requested window (each time within 60 seconds: how PIM stores times is unverified), and this request (by `createdUsing`, and by the `targetScheduleId` the response reports when present). |
| `instance_observed` | Additionally, exactly one direct instance links to that schedule through `eligibilityScheduleId`. Still Graph data, not a check of the group's actual membership or ownership. |

Correlation requires the exact principal, group and access, a known request ID,
and a non-recurring schedule whose window equals the requested one within 60
seconds. Group-derived results, a `memberType` that is missing or not `direct`,
multiple matches, a different window and a missing group ID are all refused. For
the assignment module an `assignmentType` other than `assigned` is refused too.
`activatedUsing` is a navigation property that Graph returns only with `$expand`,
and this module does not expand it, so it does not rely on it. A schedule that
was activated from an eligibility is excluded only through `assignmentType`.
This strict subset can refuse a legitimate service representation.

The read-back waits `verification_delay_seconds` once; there is no polling loop.
While the window is open and `fail_on_verification_mismatch` is true, apply
fails unless exactly one correlated schedule and instance are visible. A future
start or a past end never fails it.

## Requirements

| Name | Version |
| --- | --- |
| Terraform configuration and mocked tests | >= 1.11.0 |
| microsoft/msgraph | >= 0.6.0, < 0.7.0 |
| hashicorp/time | >= 0.9.0 |

A calling root must commit its own provider lock file.

Permissions, from Microsoft Learn's PIM for Groups documentation (the
permission and role includes were not pinned offline; confirm them for your
cloud before use): application or delegated `PrivilegedEligibilitySchedule.ReadWrite.AzureADGroup` to create the
request, and `PrivilegedEligibilitySchedule.Read.AzureADGroup`
to read the schedules and instances (the write permission is documented as including the matching read
permission; confirm). Which administrator role or group ownership a delegated
caller needs, and national-cloud support, are **unknown** and must be resolved
before any live use. Mock tests do not establish live verification.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | PIM-GROUPS | Microsoft Graph documents PIM for Groups as part of Microsoft Entra ID Governance. This registry applies the same P2, ID Governance or Entra Suite coverage as PIM for Microsoft Entra roles; the group-specific population and product list were not independently confirmed from a pinned page. Any of: Microsoft Entra ID P2 (`AAD_PREMIUM_P2`); Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Each principal with an eligible or time-bound membership or ownership of a PIM-governed group, and each user who approves activation requests for it; confirm the exact bounded population before any live use | direct / per_user | inferred |

Notes:

- The request is a one-shot administrative adminAssign for one bounded window; a 201 response or an accepted status is not effective access and establishes no entitlement. PIM role-management policy rules (approval, MFA, maximum duration) are configuration, not licensing, and this module never changes them.
- Application and delegated permissions, the administrator or group-owner roles a delegated caller needs, national-cloud support and the exact PIM-for-Groups licensing product were not pinned offline and are unresolved. Mark them unknown until an owner-dispatched review resolves them.
- The PIM-for-Groups rule was reviewed against the retained Microsoft Graph documentation prefixes captured 2026-10-18. Mock tests do not establish licensed-tenant lifecycle behavior.

Sources: [PIM for Groups APIs in Microsoft Graph overview](https://learn.microsoft.com/en-us/graph/api/resources/privilegedidentitymanagement-for-groups-api-overview), [Create assignmentScheduleRequest (PIM for Groups)](https://learn.microsoft.com/en-us/graph/api/privilegedaccessgroup-post-assignmentschedulerequests), [Create eligibilityScheduleRequest (PIM for Groups)](https://learn.microsoft.com/en-us/graph/api/privilegedaccessgroup-post-eligibilityschedulerequests), [Microsoft Entra ID Governance licensing fundamentals: Privileged Identity Management](https://learn.microsoft.com/en-us/entra/id-governance/licensing-fundamentals#privileged-identity-management).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | On change |
| --- | --- | --- | --- | --- |
| principal_id | Lowercase object ID of the user or group receiving the access | `string` | required | kept from creation: a change is refused or ignored (see notes) |
| group_id | Lowercase object ID of the PIM-governed group | `string` | required | kept from creation: a change is refused or ignored (see notes) |
| access_id | `member` or `owner` | `string` | required | kept from creation: a change is refused or ignored (see notes) |
| justification | Nonempty justification sent with the request | `string` | required | kept from creation: a change is refused or ignored (see notes) |
| start_date_time | RFC 3339 start | `string` | required | kept from creation: a change is refused or ignored (see notes) |
| end_date_time | RFC 3339 end, at least five minutes after the start and at most 24 hours later | `string` | required | kept from creation: a change is refused or ignored (see notes) |
| verification_delay_seconds | Seconds to wait before the read-back | `number` | `15` | no object change (validation or timing only) |
| fail_on_verification_mismatch | Fail apply while the window is open unless a correlated schedule and instance are found | `bool` | `true` | no object change (validation or timing only) |

## Outputs

| Name | Description | Known in plan after an update |
| --- | --- | --- |
| request_id | ID of the adminAssign request; not effective access | no |
| request_status | Status of the request, read back by id after the delay (the status of the POST response when the read-back has none) | no |
| target_schedule_id | Schedule ID reported by the request response, or null | no |
| schedule_id | Correlated schedule ID, or null | no |
| instance_id | Correlated schedule instance ID, or null | no |
| state | `rejected`, `request_accepted_only`, `schedule_only`, `instance_observed` or `expired` | no |
| expires_at | End of the requested window | yes |

## Tests

`tests/eligibility_schedule_request.tftest.hcl` and
`tests/eligibility_rejected_request.tftest.hcl` run offline against mocked
providers: both `member` and `owner` access, the exact request body, request to
schedule to instance correlation, refusal of foreign, group-derived, recurring,
wrong-window and ambiguous schedules, rejection, expiry, input validation and
the identity of a replaceable grant. They prove the contract against supplied
snapshots only. Later owner-dispatched live probes must separately establish
effective access, expiry and narrow revocation with PIM-for-Groups-specific
permissions, licensing and an explicit, bounded principal and group population.
