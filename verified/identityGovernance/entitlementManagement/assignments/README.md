# identityGovernance/entitlementManagement/assignments

<!-- uses-beta:start -->
Uses beta: **no**. This module and its local child modules do not select beta.
<!-- uses-beta:end -->

<!-- live-status:start -->
Assurance: **verified offline-only**. No current live acceptance is recorded for this module.

![live: not yet run](https://img.shields.io/badge/live-not%20yet%20run-lightgrey)
<!-- live-status:end -->

Grants one user an access package and revokes it again, through the `microsoft/msgraph`
Terraform provider. An administrator submits an assignment request
(`POST /identityGovernance/entitlementManagement/assignmentRequests`) with `requestType`
`adminAdd`, `adminUpdate` or `adminRemove`; this module sends `adminAdd` and `adminUpdate`, and
revokes with `adminRemove` when it is destroyed. The folder mirrors the Graph path it manages, in
Graph's own casing (`identityGovernance`, not `identity-governance`; existing module paths are not
renamed here).

Catalogs, access packages and assignment policies configure an entitlement. They do not show that a
person received or lost access. This module closes that gap: it reports whether the **request**
was delivered, resolves the **assignment** it produced, and removes only that assignment. It does not
create the package or the policy; take their IDs from the
[access-packages](../../../identityGovernance/entitlementManagement/accessPackages/README.md)
and [assignment-policies](../../../identityGovernance/entitlementManagement/assignmentPolicies/README.md)
modules.

Status: **offline-verified only**. The behavior below is established by mocked Terraform tests and by
a stub-driven test of the destroy hook, against documentation pinned in
`tests/fixtures/access-package-assignment-contracts`. No tenant has run it (see
[Live acceptance](#live-acceptance-owner-dispatched), which is prepared and not executed).

## Why this module looks different from the others

An assignment request is not an assignment. The request can wait for approval, be denied or
canceled, or fail, and Graph returns no assignment ID with it. The pinned v1.0 documentation says to
locate the created assignment by listing assignments; it documents no link from the assignment back to
the request that created it. The request object supports no PATCH or DELETE. So the module:

1. Submits `adminAdd` once, as a one-shot action (`msgraph_resource_action.add`). The body names the
   subject (`assignment.targetId`), the policy (`assignment.assignmentPolicyId`) and the package
   (`assignment.accessPackageId`) explicitly, plus a justification and an optional schedule. Nothing
   else of the request is configurable: no answers, no requestor, no approval decision.
2. Waits `verification_delay_seconds` once (`time_sleep.wait_for_delivery`), then reads the request
   back **by the ID Graph returned** and buckets its `state`.
3. Lists the assignments of the package and the subject, expanded with `target`,
   `assignmentPolicy` and `accessPackage`, and matches **client-side** on all three identities
   (case-insensitive). The server filter only narrows the list. The first page is read; an
   unexpected number of matches is refused, never guessed.
4. Gates apply on the result (`terraform_data.verification_gate`), with a distinct message per outcome.
5. Optionally sends `adminUpdate` for the resolved assignment ID (`schedule_update`).
6. On destroy, cancels a request that still waits, or sends `adminRemove` for the delivered
   assignment, and confirms that it is gone.

Request phases, bucketed by this module from the v1.0 `accessPackageAssignmentRequest.state` values
(the bucketing is the module's, not Graph's):

| Graph `state` | `request_phase` | Gate |
| --- | --- | --- |
| `submitted`, `pendingApproval`, `scheduled`, `delivering` | `pending` | Fails only with `require_delivery = true`; otherwise reported |
| `delivered` | `delivered` | Needs exactly one matching assignment in state `delivered` |
| `denied` | `denied` | Always fails |
| `canceled` | `canceled` | Always fails |
| `deliveryFailed` | `failed` | Always fails |
| `partiallyDelivered` | `partial` | Always fails |
| anything else, including the beta spellings (`Delivered`, `Canceled`) and `unknownFutureValue` | `unknown` | Fails only with `require_delivery = true`; never read as delivered |
| (adoption, no request) | `adopted` | As `delivered` |

`delivered` (the output) means: request delivered or assignment adopted, **and** exactly one matching
assignment reports `delivered`. It is Graph's report about the assignment. It is not a measurement of
what the user can reach: resource-role provisioning can lag, and nothing here probes the resources.

Only **v1.0** is targeted. The pinned beta pages spell the states in PascalCase, omit `adminUpdate`
from the request-type enum and document a different cancel body, so beta is not an `api_version` option.

## Lifecycle semantics

- **Grant.** `adminAdd` is sent once, when the module is first applied. Later plans and applies never
  send it again, because the action's body is captured at creation (`ignore_changes = [body]`).
- **No-op.** An apply with unchanged inputs sends nothing and re-reads the request and the assignment.
- **Refresh and recovery of an accepted request.** A request that is still pending when apply ends
  (waiting for an approver, still delivering, or the assignment not listed yet) stays in state. Apply
  again once it settles: the module re-reads the same request and resolves the assignment, without
  sending a second `adminAdd`. `verification_delay_seconds` is one bounded wait, not a polling loop;
  Terraform has no loop, and the re-read by the next apply is the retry. With
  `require_delivery = false` a pending request does not fail the apply and is reported through
  `request_phase`.
- **Lost state.** If the state of a first apply is lost after Graph accepted the request, do not
  apply the module again as is: that sends a second `adminAdd`. List the assignments of the subject,
  policy and package, and re-run with `adopt_assignment_id` set to the one found (#208 tracks
  runner-loss recovery in general; nothing here claims it exists).
- **Adoption.** `adopt_assignment_id` sends no request. The module checks the assignment against
  `target_id`, `access_package_id` and `assignment_policy_id` and reports it. Destroying the module
  leaves an adopted assignment in place unless `revoke_adopted_assignment_on_destroy = true`.
- **Expiry.** An assignment in state `expired` is history. It never makes a live assignment ambiguous,
  and it never counts as a grant: when the request is delivered and the only match is expired, the gate
  fails. To grant again, change `replacement_token`.
- **Replacement ordering.** `target_id`, `access_package_id`, `assignment_policy_id`,
  `adopt_assignment_id` and `replacement_token` decide which assignment the module owns. A change
  replaces the request and the destroy hook, so the old assignment is revoked first (`adminRemove`
  and confirmation) and the new `adminAdd` follows. There is deliberately no
  `create_before_destroy`: the new request would meet the old assignment, and the old hook's
  `adminRemove` would then remove the new one. The schedule and the justification are not identity:
  they are captured when the request is sent, and changing them later changes nothing. Use
  `schedule_update` to change a delivered assignment's schedule.
- **Update.** `schedule_update` sends one `adminUpdate` for the resolved assignment ID, after the gate has
  confirmed a delivered assignment, and never for a pending or unresolved one. Changing it sends a new
  `adminUpdate`. The update is a request like any other: it goes through approval, is read back, and
  reports its own `update_request_phase`. The new schedule shows in `assignment_schedule_json` on the
  next read.
- **Eventual consistency.** Graph may list the assignment after the wait ends. The gate then fails with
  a message that says so; apply again or raise `verification_delay_seconds`.
- **Ambiguity.** Two live assignments (or two expired ones with no live one) for the same subject,
  policy and package resolve to nothing and always fail. The module refuses to guess which it owns.

## Approval, custom extensions and eligibility

The assignment policy decides how a request is processed, and this module does not weaken it:

- It never approves a request, skips an approval stage or sets a requestor. A policy that requires
  approval leaves the request in `pendingApproval`; the module reports `pending`.
- Custom-extension callouts configured on the policy (see the
  [assignment-policies](../../../identityGovernance/entitlementManagement/assignmentPolicies/README.md)
  `custom_extension_stage_settings` input and the catalog custom-extensions module) run as part of
  delivery. A request waiting on one is `pending`; one that the extension fails is
  `failed`. This module configures no callout and has no input for one.
- The inputs choose a subject, a package, a policy, a justification and a schedule. None of them
  chooses between eligible and active access, and none turns one into the other; what the subject
  receives is decided by the resource roles of the package.
- `adminAdd` is the administrator path, so the policy must allow administrator-directed
  assignments; Graph refuses the request otherwise and the error is surfaced unchanged.

## Revocation

Destroying the module runs `null_resource.remove_on_destroy`, a destroy-time `local-exec`. For the
module's own request and assignment it:

1. reads the request. `submitted`, `pendingApproval` and `scheduled` requests whose `status` is one of the
   statuses the v1.0 cancel page lists as cancelable (`accepted`, `pendingApproval`, `pendingNotBefore`,
   `pendingApprovalEscalated`) are canceled (no body, as v1.0 documents); the same states with any other status,
   and `delivering`, stop the destroy, because they can be neither canceled nor removed yet; `denied` and
   `canceled` need nothing and succeed. A request that is `deliveryFailed`, `partiallyDelivered`, unknown or no
   longer exists is **not** tied to any assignment: the hook refuses and prints the evidence rather than removing
   whichever live assignment happens to match, and an operator must revoke what was delivered by hand;
2. only for a **delivered** request, finds the assignment by listing those of the exact subject, policy and
   package (`$select=id,state`), parsed strictly from the top-level `value` array (nested ids such as custom
   extension callout instances are never read), or takes the adopted ID. It proceeds only when **exactly one**
   non-expired assignment matches. None counts as already removed; more than one stops the destroy and names
   the candidates;
3. reads that assignment itself (`$expand=target,assignmentPolicy,accessPackage`) and requires its subject,
   policy and package to equal `target_id`, `assignment_policy_id` and `access_package_id` (case-insensitive).
   Anything else, including a wrongly pasted `adopt_assignment_id`, is refused and never revoked; the listing
   filter is never trusted alone;
4. sends `adminRemove` for that assignment ID alone. Assignments of the same subject in other packages
   or policies, other subjects' assignments and access from other sources are never touched;
5. polls up to ten times for the assignment to report `expired` or disappear, and **fails when it does not**:
   an accepted `adminRemove` is not reported as a revoked grant.

The listing is trusted only with positive evidence: an empty `value` array is the single way to "nothing to
remove". A body that is not JSON, is truncated, has no `value` array, or carries `@odata.nextLink` stops the destroy
instead of being read as empty, and every assignment ID is checked to be a GUID before it enters a URL or the
`adminRemove` body. For a delivered request, an empty listing is not trusted either, because the assignment may not be listed yet: the hook lists up to six times, 20 seconds apart, then stops the destroy. An expired assignment is still listed, so a removed one is never mistaken for an empty listing.

**A destroy that stays blocked.** After a request that failed, was partially delivered, or no longer exists, or when the request was delivered but its assignment is no longer listed at all (for example because the service dropped an old expired assignment from the listing, which no source documents), the hook
refuses on purpose (it cannot tie any assignment to this module) and every retry fails the same way. The way out is
manual: find what was delivered for the subject, package and policy in the Entitlement Management portal or in Graph
and revoke it there (the printed ownership evidence names the three IDs and the request); then run
`terraform state rm 'module.<name>.null_resource.remove_on_destroy'` (with the module's address; `[0]` is part of the
resource address) and destroy again. Do not remove the hook from state before the access is gone: Terraform would then
forget the only automated revocation.

A failed hook leaves itself in state, so the next destroy retries. Each stop prints non-secret
ownership evidence (subject, package, policy and request IDs) so an operator can finish the revocation by
hand. This is the module's own evidence; it is not runner-loss recovery (#208).

Revocation confirms Graph's view of the **assignment**. Whether the user's effective access to each
resource has ended is a separate, later fact that the module does not measure; check the resources when it
matters.

**The machine running the destroy needs Bash, the Azure CLI (`az`) logged in with `az login`, `curl`, `awk`,
`grep`, `tr`, `head` and `ARM_TENANT_ID` set to the tenant ID the `msgraph` provider uses.** The hook targets the
public cloud (`graph.microsoft.com`). Before it requests a token it compares `ARM_TENANT_ID` with
`az account show --query tenantId` and stops if the variable is unset or the tenants differ. The token
reaches `curl` through a config on stdin, never on the command line. Destroy cleanup is unsupported on
Windows. HTTP 404 and error text with "not found" or "does not exist" count as removed; Learn documents no
error code for removing an assignment that is already gone, so that match is on the wording and is **not
verified live**. HTTP 409, 429 and 5xx answers are retried six times, 20 seconds apart.

Deleting the module block from the configuration does not run the hook, because a destroy-time provisioner
runs only while its block is configured. Run a targeted destroy of the module while the block is still
present. The hook revokes whatever assignment holds the module's exact subject, package and policy at that
moment; do not manage the same triple from two places.

`enable_destroy_cleanup = false` creates no hook, so destroy forgets the request and leaves the assignment in
place. Use it only when something else owns removal.

## Usage

Replace `<version>` with a release version, such as `0.5.0`; the [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one.

An employee, taking the package and policy from the modules that create them:

```hcl
module "engineering_access" {
  source  = "satolap/modules/msgraph//verified/identityGovernance/entitlementManagement/accessPackages"
  version = "<version>"
  # ...
}

module "engineering_policy" {
  source  = "satolap/modules/msgraph//verified/identityGovernance/entitlementManagement/assignmentPolicies"
  version = "<version>"
  # ...
}

module "alice_engineering_access" {
  source  = "satolap/modules/msgraph//verified/identityGovernance/entitlementManagement/assignments"
  version = "<version>"

  target_id            = module.alice.id
  access_package_id    = module.engineering_access.id
  assignment_policy_id = module.engineering_policy.id
  justification        = "Joined the platform team"

  schedule = {
    expiration = { type = "afterDuration", duration = "P180D" }
  }
}
```

An external user. The guest must already exist as a directory object; this module does not invite anyone.
The package's policy must allow the guest's organization (see the connected-organizations module):

```hcl
module "partner_access" {
  source  = "satolap/modules/msgraph//verified/identityGovernance/entitlementManagement/assignments"
  version = "<version>"

  target_id            = module.partner_guest.id
  access_package_id    = module.engineering_access.id
  assignment_policy_id = module.partner_policy.id

  # The partner policy needs an approver: report the pending request instead of failing the apply.
  require_delivery = false
}

output "partner_access" {
  value = {
    phase      = module.partner_access.request_phase
    assignment = module.partner_access.assignment_id
    delivered  = module.partner_access.delivered
  }
}
```

Extending a delivered assignment:

```hcl
  schedule_update = {
    expiration = { type = "afterDateTime", endDateTime = "2027-06-30T00:00:00Z" }
  }
```

Taking over access that already exists, without sending a request, and leaving it in place on destroy:

```hcl
  adopt_assignment_id = "<assignment id from the assignments listing>"
```

Granting again after an assignment expired or was removed outside Terraform:

```hcl
  replacement_token = "renewal-2027"
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.11.0 |
| msgraph | >= 0.3.0 |
| time | >= 0.9.0 |
| null | >= 3.2.0 |
| Bash, Azure CLI (`az`), `curl`, `awk`, `sed`, `grep` and `ARM_TENANT_ID` | Required on the machine running the destroy; Windows is unsupported for destroy cleanup |

Permissions, from the pinned Microsoft documentation and the registry, **not verified in a tenant**. The pinned
create page lists its permissions through an include file that is not part of the pinned excerpt, so the least
privileged application and delegated permissions are not established here: take them from the
[Create assignmentRequest](https://learn.microsoft.com/graph/api/entitlementmanagement-post-assignmentrequests?view=graph-rest-1.0)
page. Expect `EntitlementManagement.ReadWrite.All` for the requests and `EntitlementManagement.Read.All` for the
assignment read-back, and an entitlement-management role such as Identity Governance Administrator (or the
catalog owner or access package manager) for a delegated caller. The page marks the operation as available in all
national clouds; the destroy hook targets the public cloud only.

## Why cleanup retains a provisioner

The destroy protocol cannot be expressed by a single provider-native
`msgraph_resource_action` with `when = "destroy"`. It independently reads the
saved request at destroy, cancels only cancelable pending requests, refuses
requests still delivering or with unknown/failed ownership, resolves and checks
the assignment's subject/policy/package identity, and submits adminRemove only
for that exact assignment. After acceptance it polls the assignment up to ten
times until expired or absent; failure retains cleanup state for retry. An
adopted assignment is revoked only with the existing explicit opt-in.

The pinned provider action schema can send one saved request; it cannot branch
on a destroy-time GET or poll after removal before reporting successful destroy.
A saved create-time choice could become wrong while approval/delivery changes.
Replacing this protocol with a single POST would lose those ownership and
confirmed-revocation guarantees. This module therefore remains in the exact
publication provisioner allowlist. Bash, Azure CLI and the existing tenant
checks remain required; this is not a provider-native cleanup conversion.

The same saved request can be pending at apply and delivered at destroy. A
destroy-only cancel action registered during apply would then target a request
that needs assignment removal instead. Registering both cancel and adminRemove
does not solve this: neither action can choose its operation from a fresh GET
at destroy, and an accepted adminRemove still needs delivery confirmation.
Provider retries repeat a failed request; they do not poll a successful removal
request until the assignment is expired or absent.

The native modules' "apply once before destroy after upgrading" migration does
not apply here: no native remove action replaces `null_resource.remove_on_destroy`,
and this hook must remain active. Do not make it inert or remove its state as
part of upgrading the other modules. Inputs, provider requirements and destroy
semantics are unchanged by this exception assessment.

Owner-dispatched live acceptance remains: exercise pending cancellation,
delivering refusal, delivered removal and delivery polling, adopted opt-out,
identity mismatch and retry after a failed cleanup. Confirm exact assignment
expiry/absence and unchanged unrelated assignments, keeping only sanitized
evidence. Existing offline stubs verify protocol decisions, not live delivery.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

Before deployment, check the requirements of the features you enable and the users who benefit. You can inspect tenant subscriptions with `GET /subscribedSkus`; this requires `Organization.Read.All` or `LicenseAssignment.Read.All` ([List subscribedSkus](https://learn.microsoft.com/en-us/graph/api/subscribedsku-list?view=graph-rest-1.0)).

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | EM-CORE | Catalogs, access packages with group, application and SharePoint resources, standard approval stages, requestor questions and expiration are included in Microsoft Entra ID P2, Microsoft Entra ID Governance and Microsoft Entra Suite. Evaluate the exact feature combination; not every accepted policy option is core. Any of: Microsoft Entra ID P2 (`AAD_PREMIUM_P2`); Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Every user who can request or receive an access package assignment, including everyone covered by an all-member policy scope; guest scenarios can involve billing | direct / per_user | documented |

Notes:

- The module sends adminAdd and adminUpdate and revokes with adminRemove; the access package's resource roles, the policy's approval stages and the recipient's population (employees, guests) decide any further rule. A delivered request does not prove that the user holds a license for the scenarios built on the package.
- Permissions and directory roles come from the pinned Microsoft documentation, which lists them through an include file outside the pinned excerpt; the least-privilege permissions are not established. Nothing has run in a tenant.

Sources: [Entitlement management license requirements](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-overview#license-requirements), [Microsoft Entra features by license](https://learn.microsoft.com/en-us/entra/fundamentals/licensing#features-by-license).
<!-- licensing:end -->

## Live acceptance (owner dispatched)

Prepared, not executed. The governance profile now includes a bounded administrator-assignment and
revocation suite under `tests/integration`, using only a disabled disposable user and a disposable group.
See [governance live acceptance](../../../../../docs/governance-live-acceptance.md) for prerequisites and
the narrower coverage. The broader runbook below remains outstanding and needs feature-specific
readiness (#37) in a licensed test tenant and the composition from #141.

Preconditions, all explicit and disposable:

- a licensed test tenant with Microsoft Entra ID Governance or P2 for the test users (#37);
- a catalog, an access package with one low-risk resource role (a test group's member role) and an assignment
  policy that allows administrator assignment, composed with the access-packages, resource-role-scopes and
  assignment-policies modules (#141);
- two existing users named by object ID: an employee and an already-invited external user. Neither may hold
  other access that the test would mistake for the grant.

Scenario, one run per user. Record the request ID, the assignment ID and each answer in the run's evidence:

1. Apply with `require_delivery = true`. Expect `request_phase = "delivered"`, one `assignment_id` and
   `delivered = true`. Confirm in Graph that the user is a member of the test group.
2. Apply again unchanged. Expect no plan changes and the same IDs (no second request).
3. Set `schedule_update` to a later end. Expect `update_request_phase = "delivered"` and the new schedule in
   `assignment_schedule_json`.
4. Using a policy that requires an approver, apply with `require_delivery = false`. Expect `pending` and
   no `assignment_id`; approve it as the approver; apply again. Expect the same request ID and a resolved assignment,
   with no second request.
5. Destroy. Expect the hook to report a revoked assignment, the assignment state `expired`, and the user removed from
   the test group. Confirm that the user's other access and other subjects' assignments are untouched.
6. Record, for the module's open questions: whether Graph accepts the `$filter` and `$expand` combination on the
   assignments listing, how long delivery and removal took, which error Graph returns for a duplicate `adminAdd`
   and for removing a missing assignment, and the least-privilege permissions that actually worked.

Until a run succeeds, `runtime_evidence` stays `not_verified`.

## Inputs

| Name | Description | Type | Default | Required | On change |
|------|-------------|------|---------|----------| --- |
| enable_destroy_cleanup | Create the destroy hook that cancels a pending request or revokes the assignment | `bool` | `true` | no | changes `null_resource.remove_on_destroy`; see the module notes |
| target_id | Object ID of the existing user who receives the assignment | `string` | n/a | yes | replaces `msgraph_resource_action.update`; replaces `msgraph_resource_action.add`; changes `null_resource.remove_on_destroy`; see the module notes |
| access_package_id | ID of the access package | `string` | n/a | yes | replaces `msgraph_resource_action.update`; replaces `msgraph_resource_action.add`; changes `null_resource.remove_on_destroy`; see the module notes |
| assignment_policy_id | ID of the assignment policy, which must belong to the package | `string` | n/a | yes | replaces `msgraph_resource_action.update`; replaces `msgraph_resource_action.add`; changes `null_resource.remove_on_destroy`; see the module notes |
| justification | Justification sent with `adminAdd` and `adminUpdate` | `string` | `"Managed by Terraform"` | no | kept from creation: a change is refused or ignored (see notes) |
| schedule | Optional schedule sent with `adminAdd`: `startDateTime` and `expiration` (`noExpiration`, `afterDateTime` with `endDateTime`, `afterDuration` with `duration`); captured at send time | `object` | `null` | no | kept from creation: a change is refused or ignored (see notes) |
| schedule_update | Optional `adminUpdate` of the delivered assignment, same shape as `schedule` | `object` | `null` | no | replaces `msgraph_resource_action.update` when its effect on `local.stored_schedule_update` changes; creates or deletes `msgraph_resource_action.update` instances |
| adopt_assignment_id | Existing assignment to adopt instead of sending `adminAdd` | `string` | `null` | no | replaces `msgraph_resource_action.update`; replaces `msgraph_resource_action.add`; creates or deletes `msgraph_resource_action.add` instances; changes `null_resource.remove_on_destroy`; see the module notes |
| revoke_adopted_assignment_on_destroy | Whether destroy revokes an adopted assignment | `bool` | `false` | no | changes `null_resource.remove_on_destroy`; see the module notes |
| replacement_token | Changing it revokes the assignment and requests access again | `string` | `null` | no | replaces `msgraph_resource_action.update`; replaces `msgraph_resource_action.add`; changes `null_resource.remove_on_destroy`; see the module notes |
| verification_delay_seconds | One bounded wait before reading the request and assignment back | `number` | `15` | no | no object change (validation or timing only) |
| require_delivery | Fail unless the request is delivered and one assignment is delivered | `bool` | `true` | no | no object change (validation or timing only) |

## Outputs

| Name | Description | Known in plan after an update |
|------|-------------| --- |
| request_id | ID of the `adminAdd` request; null when adopting. Not the assignment ID | no |
| request_state | State Graph reported for the request | no |
| request_phase | `pending`, `delivered`, `denied`, `canceled`, `failed`, `partial`, `unknown` or `adopted` | no |
| assignment_id | Stable ID of the resolved assignment; null while pending, unmatched or ambiguous | no |
| assignment_state | `delivering`, `partiallyDelivered`, `delivered`, `deliveryFailed` or `expired` | no |
| assignment_schedule_json | The resolved assignment's schedule as Graph reported it | no |
| delivered | Request delivered (or adopted) and exactly one matching assignment delivered | no |
| ambiguous | More than one assignment matched | no |
| access_package_id | The package, as passed in | yes |
| assignment_policy_id | The policy, as passed in | yes |
| update_request_id | ID of the `adminUpdate` request; null without `schedule_update` | no |
| update_request_phase | Phase of the `adminUpdate` request; null without `schedule_update` | no |

## Tests

`terraform test` runs offline with mocked providers:

- `tests/request_shape.tftest.hcl`: the `adminAdd` body, v1.0, the schedule shapes, the listing filter and expand,
  and the request read by ID.
- `tests/lifecycle.tftest.hcl`: pending approval, timeout, recovery by re-reading the same request, a repeated
  apply, unrelated and expired assignments, and `adminUpdate` including its refusal.
- `tests/failures.tftest.hcl`: denied, canceled, failed, partial, unknown and beta-spelled states, ambiguity, expiry,
  an assignment still delivering, another policy's assignment and an unexpanded listing.
- `tests/adoption.tftest.hcl`, `tests/destroy_hook.tftest.hcl` and `tests/validation.tftest.hcl`.

`tests/test_access_package_assignments.py` in the repository root runs the destroy hook's shell against stub
`az`, `curl` and `sleep`, and binds the module to the pinned contract fixtures. The mocks and the stub scenarios
are this repository's own model of Graph's answers; they do not verify live behavior.

<!-- drift:start -->
## Drift and out-of-band changes

Terraform plans compare configuration and refreshed provider state. A plan that changes one of these inputs proposes its declared effect; review the plan before applying. The consumer guide explains refresh limits and emergency reconciliation.

- `enable_destroy_cleanup`: changes `null_resource.remove_on_destroy`; see the module notes.
- `target_id`: replaces `msgraph_resource_action.update`; replaces `msgraph_resource_action.add`; changes `null_resource.remove_on_destroy`; see the module notes.
- `access_package_id`: replaces `msgraph_resource_action.update`; replaces `msgraph_resource_action.add`; changes `null_resource.remove_on_destroy`; see the module notes.
- `assignment_policy_id`: replaces `msgraph_resource_action.update`; replaces `msgraph_resource_action.add`; changes `null_resource.remove_on_destroy`; see the module notes.
- `justification`: kept from creation: a change is refused or ignored (see notes).
- `schedule`: kept from creation: a change is refused or ignored (see notes).
- `schedule_update`: replaces `msgraph_resource_action.update` when its effect on `local.stored_schedule_update` changes; creates or deletes `msgraph_resource_action.update` instances.
- `adopt_assignment_id`: replaces `msgraph_resource_action.update`; replaces `msgraph_resource_action.add`; creates or deletes `msgraph_resource_action.add` instances; changes `null_resource.remove_on_destroy`; see the module notes.
- `revoke_adopted_assignment_on_destroy`: changes `null_resource.remove_on_destroy`; see the module notes.
- `replacement_token`: replaces `msgraph_resource_action.update`; replaces `msgraph_resource_action.add`; changes `null_resource.remove_on_destroy`; see the module notes.
- `verification_delay_seconds`: no object change (validation or timing only).
- `require_delivery`: no object change (validation or timing only).
<!-- drift:end -->

<!-- permissions:begin -->
## Per-operation permissions

Source: [Graph DevX map](https://raw.githubusercontent.com/microsoftgraph/microsoft-graph-devx-content/56e1917fe45fb7c52c2d9845f569c2ffdb39e4d9/permissions/new/permissions.json) (SHA-256 `4d7dee52659b1d6424bce0b26603302081d39ef9e149bc5fb50de4273b3d3514`).
The map is shared by v1.0 and beta; it does not certify API-version support. Rows show the source's least-privilege annotations, not live-tested consent. Choose an alternative for your authentication type; do not grant every listed scope. AlsoRequires lists additional scope alternatives attached to that row. Missing annotations are unknown, not evidence that an operation needs no permission. Keep the module's documented role, property-specific and tenant restrictions.

Derived from this module's Terraform sources, including optional guards, destroy actions and local child modules. The checked inventory is `docs/permissions/verified-operations.json`. These are potential requests, not a preflight scope list. A provider primitive may expose an update that Graph does not support. Source paths and conditions are retained in the inventory.

| Operation | Authentication | Least-privilege alternative | AlsoRequires | Unknown reason |
| --- | --- | --- | --- | --- |
| `POST /identityGovernance/entitlementManagement/assignmentRequests` | DelegatedWork | `EntitlementMgmt-SubjectAccess.ReadWrite` | - | - |
| `POST /identityGovernance/entitlementManagement/assignmentRequests` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `POST /identityGovernance/entitlementManagement/assignmentRequests` | Application | `EntitlementManagement.ReadWrite.All` | - | - |
| `GET /identityGovernance/entitlementManagement/assignmentRequests/{id}` | DelegatedWork | `EntitlementManagement.Read.All` | - | - |
| `GET /identityGovernance/entitlementManagement/assignmentRequests/{id}` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `GET /identityGovernance/entitlementManagement/assignmentRequests/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /identityGovernance/entitlementManagement/assignmentRequests/{id}` | Application | `EntitlementManagement.Read.All` | - | - |
| `GET /identityGovernance/entitlementManagement/assignmentRequests/{id}` | Application | `EntitlementManagement.ReadWrite.All` | - | - |
| `POST /identityGovernance/entitlementManagement/assignmentRequests/{id}/cancel` | DelegatedWork | `EntitlementMgmt-SubjectAccess.ReadWrite` | - | - |
| `POST /identityGovernance/entitlementManagement/assignmentRequests/{id}/cancel` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `POST /identityGovernance/entitlementManagement/assignmentRequests/{id}/cancel` | Application | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /identityGovernance/entitlementManagement/assignments` | DelegatedWork | `EntitlementManagement.Read.All` | - | - |
| `GET /identityGovernance/entitlementManagement/assignments` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /identityGovernance/entitlementManagement/assignments` | Application | `EntitlementManagement.Read.All` | - | - |
| `GET /identityGovernance/entitlementManagement/assignments/{id}` | DelegatedWork | `EntitlementManagement.Read.All` | - | - |
| `GET /identityGovernance/entitlementManagement/assignments/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /identityGovernance/entitlementManagement/assignments/{id}` | Application | `EntitlementManagement.Read.All` | - | - |
| `GET /identityGovernance/entitlementManagement/assignmentRequests/request-id-not-returned` | DelegatedWork | Unknown / not annotated | - | The readback fallback contains a literal missing-request sentinel, not a proven object ID. The pin annotates the parameterized item path, not this concrete failure-path URI; do not silently substitute an ID or infer a permission grant. |
| `GET /identityGovernance/entitlementManagement/assignmentRequests/request-id-not-returned` | DelegatedPersonal | Unknown / not annotated | - | The readback fallback contains a literal missing-request sentinel, not a proven object ID. The pin annotates the parameterized item path, not this concrete failure-path URI; do not silently substitute an ID or infer a permission grant. |
| `GET /identityGovernance/entitlementManagement/assignmentRequests/request-id-not-returned` | Application | Unknown / not annotated | - | The readback fallback contains a literal missing-request sentinel, not a proven object ID. The pin annotates the parameterized item path, not this concrete failure-path URI; do not silently substitute an ID or infer a permission grant. |

### Property-specific coverage

Route annotations do not establish that the listed scopes cover every selected or writable property. Dynamic bodies, additional properties and default responses remain unbounded. Keep the reviewed permission guidance above; in particular, a group-nesting scope is not general group-property access. The pin's method/path entries do not distinguish property grants from navigation or sub-resource operations; property coverage stays unknown.

| Operation | Properties | Source evidence |
| --- | --- | --- |
| `POST /identityGovernance/entitlementManagement/assignmentRequests` | `assignment`, `justification`, `requestType`, `schedule` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
<!-- permissions:end -->
