# identityGovernance/accessReviews/definitions

<!-- state-protection:start -->
## State and plan protection

This module's state and saved plans retain these declared values:

Potential personal-data inputs: `description_for_reviewers`, `fallback_reviewer_user_ids`, `reviewer_user_ids`.

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

Manages one Microsoft Entra
[access review definition](https://learn.microsoft.com/en-us/graph/api/resources/accessreviewscheduledefinition?view=graph-rest-1.0)
(`/identityGovernance/accessReviews/definitions`) that reviews the members of **one existing static
group**, with the `microsoft/msgraph` provider's `msgraph_resource` and its native `PUT` update.

This is a deliberately narrow first admission (#258). The module:

- reviews one owned group through the documented query scope
  `/groups/{id}/transitiveMembers` (nested groups flattened) or `/groups/{id}/members`;
- requires at least one **individually named reviewer user**; an empty reviewer list means
  self-review in Microsoft Graph, and the module refuses that mode;
- takes an **explicit** start date and recurrence and never reads the clock, so a plan never moves
  the schedule by itself;
- **always sends** `autoApplyDecisionsEnabled`, `defaultDecisionEnabled`,
  `mailNotificationsEnabled`, `reminderNotificationsEnabled` and
  `decisionHistoriesForReviewersEnabled` as `false`. They are not inputs;
- sends no `applyActions`, `defaultDecision`, `stageSettings` or `instanceEnumerationScope`. It
  exposes no stage, tenant-wide, guest, application or role scope and no destructive apply action.

It never records, applies, resets, stops or exports decisions. Those operations act on instances and
are outside the definition.

## Usage

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one.

```hcl
module "team_access_review" {
  source  = "satolap/modules/msgraph//verified/identityGovernance/accessReviews/definitions"
  version = "<version>"

  display_name              = "Quarterly review of the Fabrikam team group"
  description_for_admins    = "Quarterly membership review of the Fabrikam team group"
  description_for_reviewers = "Confirm who still needs to be in the group"

  group_id          = var.team_group_id
  reviewer_user_ids = [var.team_lead_user_id]

  start_date = "2027-01-15" # explicit, chosen by you; the module never derives it
  recurrence = {
    type                  = "absoluteMonthly"
    interval              = 3
    day_of_month          = 15
    number_of_occurrences = null # never ends
  }
  instance_duration_in_days = 14
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.11.0 |
| msgraph | >= 0.6.0, < 0.7.0 |

Microsoft Graph documents `AccessReview.ReadWrite.All` for create, update and delete, and
`AccessReview.Read.All` additionally for reads, as delegated and application permissions. A
delegated caller also needs a directory role that permits creating access reviews. Which role and
which permission is the least privileged for each case is not verified here.

## How updates work

Microsoft Learn documents the update as `PUT /identityGovernance/accessReviews/definitions/{id}`
with the **full object**, "all writable properties, not just the properties being updated", and a
`204 No Content` response. The module therefore sends every property it manages on create and on
update. Learn also states:

- Updates apply only to **future instances**; a running instance is not changed.
- `reviewers` is updatable only when individual users are assigned. Within stages only reviewers and
  fallback reviewers are updatable (the module has no stages).
- `scope` and `instanceEnumerationScope` are not in the update table. The module does not claim they
  are immutable. As a conservative policy, **a change of `group_id` or `membership_scope` replaces the
  definition**: Terraform deletes the old series and creates a new one (`replace_triggered_by` on a
  scope trigger) instead of sending a PUT that Graph may ignore or refuse. A replacement deletes the
  old series first, so a failed create leaves no definition until the next apply; see the deletion
  limit below.

**A PUT can clear properties the module does not manage.** Anything set on the definition outside
Terraform that is not in the module's body, such as additional notification recipients, stage
settings, apply actions or insight settings, may be dropped by the next update. Whether Graph
preserves unowned properties on a PUT is not established.

## Limits and lifecycle

- **No import or adoption.** The provider's import does not acquire a complete body, and an
  ordinary read only reconciles keys already in the body. A successful import or refresh therefore
  does not show that adopting an existing definition is safe (PL-012 in #265). Do not import a
  definition created elsewhere; the module is for definitions it creates.
- **Destroy sends DELETE on the definition.** Learn documents the delete; it does not establish what
  becomes of instances, decisions or history, or whether any access is changed. Do not assume deletion
  revokes access, and inspect instances and history independently.
- **Defaults not resolved.** The resource table lists `defaultDecision` as
  `Approve`, `Deny` or `Recommendation`, but examples use `None` when it is disabled. The module
  sends only `defaultDecisionEnabled = false` and omits `defaultDecision`. `applyActions` is omitted
  too: omission does not prove removal is disabled, because `removeAccessApplyAction` is the
  documented default. The module's safety rests on `autoApplyDecisionsEnabled = false`, so denied
  decisions are never applied by the service; an administrator who applies decisions manually still
  removes access.
- **Reviewers are not notified.** Mail and reminder notifications are always off, so reviewers receive
  no email when an instance starts. Tell them out of band. The 256-character
  limit on `description_for_reviewers` is the limit Learn gives for reviewer email notifications and is
  enforced although no email is sent.
- **Empty reviewers.** An empty reviewer list is self-review; the module rejects it. Fallback reviewers
  default to none. Removing a fallback reviewer is not proven (Learn says fallback reviewers added in
  the portal are not removable by design).
- **Create requirements disagree.** The create table marks `descriptionForAdmins`,
  `descriptionForReviewers`, `displayName` and `scope` required, while the resource page says
  reviewers are required. The module always supplies all of them.
- **Duration versus recurrence.** `instance_duration_in_days` must not exceed one recurrence (7 days per
  weekly interval, 28 per monthly interval); this applies Learn's rule that the recurrence is at least as
  long as the duration conservatively.
- **Schedule.** Only `weekly` and `absoluteMonthly` with `interval` and `dayOfMonth` are listed as
  supported. `dayOfMonth` is limited to 1 to 28. The start time of day can vary by a few hours after the
  start date. Whether the service rejects a start date in the past is not verified; the module cannot
  check it without reading the clock.
- **Population.** A group review covers the group's members at the start of each instance and flattens
  nested groups. A membership change after an instance starts is seen only by the next instance. The module
  does not read the group, so it cannot tell whether the group is static, role-assignable or
  restricted-management; use it for a static, non-role-assignable group you own. Groups in a restricted
  management administrative unit cannot be reviewed.
- **Property normalization.** `ignore_missing_property = true` keeps a key that Graph does not return
  from showing as a permanent change. Reviewer and scope queries may be normalized by the service;
  the service wire behavior is not verified, and offline tests use a mock provider only.

## Offline tests

```shell
terraform -chdir=modules/verified/identityGovernance/accessReviews/definitions init -backend=false
terraform -chdir=modules/verified/identityGovernance/accessReviews/definitions test
```

The mock tests assert the full-object PUT body, the fixed safety switches, recurrence shapes, the
absence of unmanaged properties and every validation. The repository tests
`tests/test_access_review_group_membership_module.py` bind the module to the pinned access-review
contract fixtures (`tests/fixtures/access-review-contracts` and
`tests/fixtures/access-review-safety-contracts`). No Graph call, tenant write or live run is involved.

## Not verified

Live create, read-back, PUT preservation of unowned properties, the second-reviewer update, scope
edits, normalization of queries, import, `defaultDecision` semantics, deletion effects on instances and
history, effective-access effects, feature and cloud capacity, and the least privileged permission
and role. Live acceptance stays open under #258.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | AR-GROUP-REVIEWS | The stricter reading is applied: Microsoft Entra ID Governance or Microsoft Entra Suite. The prerequisites page for access reviews of groups and applications names those licenses, while the features-by-license table lists the access review capabilities previously generally available in Microsoft Entra ID P2 under P2 as well, so P2 alone may suffice for basic group reviews. This rule applies to the basic review of one owned static group's members; it is separate from EM-ACCESS-REVIEWS, and inactive-user, PIM for Groups, catalog and machine-learning reviews are not modelled. Any of: Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Every member user who reviews and every member user whose group membership is reviewed | group_based / per_user | inferred |

Notes:

- Microsoft Learn disagrees: the prerequisites for access reviews of groups and applications name Microsoft Entra ID Governance or Microsoft Entra Suite, while the licensing fundamentals table lists the capabilities previously generally available in Microsoft Entra ID P2 under P2 too. The stricter Governance or Suite rule is used. The EM-ACCESS-REVIEWS rule describes reviews of access package assignment policies and is not reused here. Reviewed against Microsoft Learn on 2026-10-22.
- A successful API call does not establish entitlement. The reviewed group's membership and the named reviewers define the population; the module reads neither. Actual feature and cloud capacity are not verified (see #37 and #42).
- Creating and updating a definition needs AccessReview.ReadWrite.All, with AccessReview.Read.All also for reads, plus a directory role that permits creating access reviews for a delegated caller.

Sources: [Create an access review of groups and applications: prerequisites](https://learn.microsoft.com/en-us/entra/id-governance/create-access-review#prerequisites), [Create accessReviewScheduleDefinition](https://learn.microsoft.com/en-us/graph/api/accessreviewset-post-definitions?view=graph-rest-1.0), [Microsoft Entra ID Governance licensing fundamentals: features by license](https://learn.microsoft.com/en-us/entra/id-governance/licensing-fundamentals#features-by-license).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required | On change |
|------|-------------|------|---------|----------| --- |
| display_name | Name of the review series | `string` | n/a | yes | in place |
| name_pattern | Optional RE2 pattern that display_name must match | `string` | `null` | no | no object change (validation or timing only) |
| description_for_admins | Context for administrators; required on create | `string` | n/a | yes | in place |
| description_for_reviewers | Context for reviewers; required on create | `string` | n/a | yes | in place |
| group_id | Object ID of the existing static group to review | `string` | n/a | yes | replaces `msgraph_resource.this` when its effect on `local.scope_query` changes |
| membership_scope | `transitive` (`transitiveMembers`) or `direct` (`members`) | `string` | `"transitive"` | no | replaces `msgraph_resource.this` when its effect on `local.scope_query` changes |
| reviewer_user_ids | Individual reviewer user IDs; at least one, no self-review | `list(string)` | n/a | yes | in place |
| fallback_reviewer_user_ids | Individual fallback reviewer user IDs | `list(string)` | `[]` | no | in place |
| start_date | Explicit first day, `YYYY-MM-DD` | `string` | n/a | yes | in place |
| recurrence | `type` (`weekly` or `absoluteMonthly`), `interval`, `day_of_month`, `number_of_occurrences` | `object` | n/a | yes | in place |
| instance_duration_in_days | Days each instance is open | `number` | n/a | yes | in place |
| recommendations_enabled | Show decision recommendations | `bool` | `false` | no | in place |
| justification_required_on_approval | Require a justification with a decision | `bool` | `false` | no | in place |
| timeouts | Create, read, update and delete timeouts | `object` | `{}` | no | no object change (validation or timing only) |

## Outputs

| Name | Description | Known in plan after an update |
|------|-------------| --- |
| id | The definition ID | yes |
| group_id | The reviewed group's ID, in lower case | yes |
| scope_query | The scope query sent | yes |
| reviewer_user_ids | The primary reviewer IDs sent, in lower case | yes |
| status | The definition's status as read back, or null | no |
