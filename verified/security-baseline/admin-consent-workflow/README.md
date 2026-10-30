# admin-consent-workflow

<!-- state-protection:start -->
## State and plan protection

This module's state and saved plans retain these declared values:

Potential personal-data inputs: `reviewer_group_ids`, `reviewer_user_ids`.

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

Turns on the Microsoft Entra admin consent workflow by managing the
[`adminConsentRequestPolicy`](https://learn.microsoft.com/en-us/graph/api/resources/adminconsentrequestpolicy?view=graph-rest-1.0)
tenant singleton of the [security baseline](../README.md). The module enables the workflow, names
the reviewers (users or groups) and sets the notification, reminder and expiry options. Users who
cannot consent to an app then get a way to ask for approval instead of hitting a dead end
([admin consent workflow overview](https://learn.microsoft.com/en-us/entra/identity/enterprise-apps/admin-consent-workflow-overview)).
It is the companion of the planned authorization policy baseline, which restricts user consent.

The policy is one object per tenant, so use one instance of this module per tenant. The module
creates nothing: it updates the singleton with `msgraph_update_resource`, as a `PUT` with the full
body, and keeps a snapshot of the policy as it found it.

## Usage

Install a release using the [Terraform Registry instructions](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry); replace `<version>` with that release version.

```hcl
module "admin_consent_workflow" {
  source  = "satolap/modules/msgraph//verified/security-baseline/admin-consent-workflow"
  version = "<version>"

  tier               = "free"
  reviewer_user_ids  = var.consent_reviewer_user_ids  # lowercase object IDs
  reviewer_group_ids = var.consent_reviewer_group_ids # optional

  notify_reviewers         = true
  reminders_enabled        = true
  request_duration_in_days = 30
}
```

## Inputs

| Name | Description | Type | Default | Required | On change |
|------|-------------|------|---------|----------| --- |
| tier | `free`, `p1` or `p2`. Changes no setting; `free` reads no licences, `p1` and `p2` run the shared [licence guard](../licence-guard/README.md) | `string` | n/a | yes | changes `module.licence_guard`; see the module notes |
| enabled | Turn the workflow on (`isEnabled`) | `bool` | `true` | no | in place |
| reviewer_user_ids | Reviewer user object IDs, lowercase GUIDs without duplicates | `list(string)` | `[]` | no | in place |
| reviewer_group_ids | Reviewer group object IDs, lowercase GUIDs without duplicates; the members of each group review | `list(string)` | `[]` | no | in place |
| notify_reviewers | Email reviewers about new requests (`notifyReviewers`) | `bool` | `true` | no | in place |
| reminders_enabled | Email reviewers reminders (`remindersEnabled`) | `bool` | `true` | no | in place |
| request_duration_in_days | Days before an undecided request expires (`requestDurationInDays`), a whole number from 1 to 30 | `number` | `30` | no | in place |
| restore_previous_state | PUT the snapshot taken at the first apply instead of the other inputs | `bool` | `false` | no | in place |

- When `enabled` is true, at least one reviewer is required across `reviewer_user_ids` and
  `reviewer_group_ids`, unless `restore_previous_state` is true. There are no default reviewers.
- **Unverified.** Microsoft Learn documents neither the 1 to 30 range of the duration nor its
  portal default. The module accepts 1 to 30 and defaults to 30 until a live run confirms both.
- **No role reviewers yet.** `reviewer_role_ids` is left out. No Microsoft Learn page documents the
  query that makes a directory role a reviewer of this policy, and the module ships no query shape
  that has not been read back from a live policy. Adding the input later is not a breaking change.

## Outputs

| Name | Description | Known in plan after an update |
|------|-------------| --- |
| policy | The policy as read back after the apply, including the read-only `version` | no |
| previous_state | The snapshot: the policy before the module first wrote it, reduced to the five writable properties | no |
| reviewers | The reviewer objects rendered from the inputs | yes |
| tier | The tier, once the licence guard passes | no |

## Graph requests and permissions

| Operation | Permission (application and delegated) | Delegated roles |
| --- | --- | --- |
| [`GET /policies/adminConsentRequestPolicy`](https://learn.microsoft.com/en-us/graph/api/adminconsentrequestpolicy-get?view=graph-rest-1.0) | `Policy.Read.All`; `Policy.ReadWrite.ConsentRequest` also covers it | Global Reader, Cloud Application Administrator, Application Administrator |
| [`PUT /policies/adminConsentRequestPolicy`](https://learn.microsoft.com/en-us/graph/api/adminconsentrequestpolicy-update?view=graph-rest-1.0) | `Policy.ReadWrite.ConsentRequest` | Cloud Application Administrator, Application Administrator |

- `Policy.ReadWrite.ConsentRequest` is the only permission the module needs for the policy itself,
  on every tier. `Directory.ReadWrite.All` is not needed.
- For `p1` and `p2` the licence guard also reads `GET /subscribedSkus`, which needs
  `LicenseAssignment.Read.All`; the `free` tier reads no licences and does not need it.
- The [configuration guide](https://learn.microsoft.com/en-us/entra/identity/enterprise-apps/configure-admin-consent-workflow)
  says a Global Administrator turns the workflow on in the portal, while the Graph reference lists
  lower roles and an application permission. **Unverified:** whether an app-only `PUT` with
  `Policy.ReadWrite.ConsentRequest` is enough, until a live run.
- The update returns `204 No Content` and lists all five writable properties as required, so the
  module always sends the full body, never a partial `PATCH`. The body never includes `version`.

### Reviewer queries

| Reviewer | Rendered as | Basis |
| --- | --- | --- |
| User | `{ query = "/users/<id>", queryType = "MicrosoftGraph" }` | The Update example |
| Group | `{ query = "/groups/<id>/transitiveMembers", queryType = "MicrosoftGraph" }` | Documented for [access review reviewers](https://learn.microsoft.com/en-us/graph/accessreviews-reviewers-concept); **unverified** for this policy until a live read-back |

## Safety

- **Reviewers gain no privileges.** Being a reviewer grants no rights, and the module assigns no
  roles. Approving a request needs a role that can grant the requested permissions, and only
  Global Administrators can approve requests for Microsoft Graph application permissions
  ([configuration guide](https://learn.microsoft.com/en-us/entra/identity/enterprise-apps/configure-admin-consent-workflow)).
- **No lock-out risk.** The policy controls no sign-in and blocks no one, so there is no break-glass
  input. It has no report-only state either: enabling it only gives users who already cannot consent
  a way to ask. The decision to restrict consent lives in the authorization policy module.
- **Enablement delay.** The workflow can take up to an hour to take effect.
- **Notifications.** Turning `notify_reviewers` off also stops the emails that tell requesters about
  decisions.
- **Removed reviewers.** A removed reviewer can still review the requests made while they were a
  reviewer, and keeps getting reminders for them. The module cannot change requests already made
  (the historical-request limitation).
- **Validated responses.** The policy read must return the five properties with the right types, or
  the plan fails and nothing is written.

## Order with the authorization policy module

Enable this workflow before user consent is restricted, or in the same apply, so users always have a
way to request an app. Make the restricting module depend on this one:

```hcl
# In the module call that restricts user consent (the authorization policy baseline, once
# it is available):
depends_on = [module.admin_consent_workflow]
```

## Snapshot and restore

On the first apply the module reads the current policy and stores a cleaned copy, without `version`
and OData annotations, in `terraform_data.previous_state` with `ignore_changes = [input]`. Later
reads never overwrite it. It is the `previous_state` output.

Destroying `msgraph_update_resource` sends no request, so destroying the module alone leaves the
settings in place. To put the policy back:

1. Set `restore_previous_state = true` and apply. The module PUTs the snapshot, and the reviewer
   inputs are not needed.
2. Destroy the module.

There is no destroy-time provisioner. If you set `restore_previous_state = true` on the very first
apply, no earlier snapshot exists; the module snapshots the policy as it is and sends the same state
back. **Unverified:** whether the `PUT` accepts a snapshot with `isEnabled = false` and no reviewers,
the likely state of a new tenant. If it does not, restore by turning the workflow off in the portal.

Caveats:

- The snapshot lives in Terraform state. If the module's resources are replaced or removed from
  state (`terraform state rm`), the next apply captures the policy as it is then, not the original.
- The snapshot stores reviewer queries, not the reviewers' objects. A reviewer user or group deleted
  since the snapshot is restored as a query that no longer resolves.
- A policy response with `reviewers: null` is snapshotted as an empty list. Whether Graph returns
  null there is unverified.

## Tiers and licences

The workflow is a tenant setting that Microsoft documents without a premium licence. `tier` is
required for consistency with the other baseline modules and changes no setting: `free` reads no
licences, and `p1` or `p2` fail the plan unless the tenant has a usable subscription for that tier.
No reviewed Microsoft page says outright that the feature is included in Microsoft Entra ID Free, so
the free tier is inferred.

## Secure Score

Microsoft lists the action "Ensure the admin consent workflow is enabled" for tenants with an active
Microsoft Defender for Cloud Apps licence and the Office 365 connector turned on
([What's new in Microsoft Secure Score](https://learn.microsoft.com/en-us/defender-xdr/microsoft-secure-score-whats-new)).
Without them the module still works, but the action may not appear in the score. Whether a given
tenant shows it is unverified.

## Testing

Mocked `terraform test` suites cover the body, the reviewers, every input and its validation, the
response validation, the snapshot and the restore. Live acceptance in a disposable tenant is
outstanding and no fixture, grant or live workflow is created by this change.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

Before deployment, check the requirements of the features you enable and the users who benefit. You can inspect tenant subscriptions with `GET /subscribedSkus`; this requires `Organization.Read.All` or `LicenseAssignment.Read.All` ([List subscribedSkus](https://learn.microsoft.com/en-us/graph/api/subscribedsku-list?view=graph-rest-1.0)).

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | ADMIN-CONSENT-WORKFLOW | The Microsoft Graph Get and Update references for the admin consent request policy and the configuration guide for the admin consent workflow name no premium license. No Microsoft Learn page found states outright that the feature is included in Microsoft Entra ID Free, so the free tier is inferred from the absence of a license requirement. The Secure Score action that measures it is listed for tenants with an active Microsoft Defender for Cloud Apps license and the Office 365 connector turned on; that affects measurement only, not the workflow. No additional license specified. | No per-user entitlement named for the workflow itself | direct / per_tenant | inferred |

Notes:

- The module configures only the admin consent request policy and uses no premium feature itself. Its tier input states the baseline's requirement and changes no setting; the free tier reads no subscribed SKUs. The free tier is inferred, because no reviewed Microsoft page says outright that the workflow is included in Microsoft Entra ID Free.

Sources: [Get adminConsentRequestPolicy](https://learn.microsoft.com/en-us/graph/api/adminconsentrequestpolicy-get?view=graph-rest-1.0), [Update adminConsentRequestPolicy](https://learn.microsoft.com/en-us/graph/api/adminconsentrequestpolicy-update?view=graph-rest-1.0), [Configure the admin consent workflow](https://learn.microsoft.com/en-us/entra/identity/enterprise-apps/configure-admin-consent-workflow).
<!-- licensing:end -->

<!-- drift:start -->
## Drift and out-of-band changes

Terraform plans compare configuration and refreshed provider state. A plan that changes one of these inputs proposes its declared effect; review the plan before applying. The consumer guide explains refresh limits and emergency reconciliation.

- `tier`: changes `module.licence_guard`; see the module notes.
- `enabled`: in place.
- `reviewer_user_ids`: in place.
- `reviewer_group_ids`: in place.
- `notify_reviewers`: in place.
- `reminders_enabled`: in place.
- `request_duration_in_days`: in place.
- `restore_previous_state`: in place.
<!-- drift:end -->
