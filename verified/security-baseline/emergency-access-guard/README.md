# emergency-access-guard

<!-- state-protection:start -->
## State and plan protection

This module's state and saved plans retain these declared values:

Sensitive outputs: `conditional_access_users_exclusions`, `emergency_access_user_ids`, `exclude_groups`, `exclude_users`, `warnings`.
Potential personal-data inputs: `expected_group_member_ids`.

Protect these values with an encrypted remote backend and least-privilege access to state, plans and backups. `sensitive` is presentation redaction, not encryption; provider resource values can still appear in plan/show output. Do not publish plan output in CI logs or PR comments for secret-bearing roots; keep saved plans short-lived and rotate credentials after exposure.

See [Terraform sensitive state guidance](https://developer.hashicorp.com/terraform/language/state/sensitive-data). These are exposure indicators, not a complete data classification; unmarked fields and provider responses also need protection.
<!-- state-protection:end -->

<!-- uses-beta:start -->
Uses beta: **conditional**. When groups are configured, the guard reads members through beta because v1.0 omits service principals and cannot prove that all direct members are users (GB-security-baseline-509). Beta is preview and may change without notice. Pin module and provider versions; read `interface-changes.json` before upgrading.
<!-- uses-beta:end -->

<!-- live-status:start -->
Assurance: **verified offline-only**. No current live acceptance is recorded for this module.

![live: offline only](https://img.shields.io/badge/live-offline%20only-lightgrey)
<!-- live-status:end -->

Read-only checks of the emergency access (break-glass) accounts of the
[security baseline](../README.md). The guard takes the object IDs of existing break-glass
users and groups, fails the plan unless they exist and follow Microsoft's
[emergency access guidance](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/security-emergency-access),
and exposes them as outputs for the Conditional Access baseline and the other baseline
modules.

The module never creates, changes or deletes users, groups, role assignments, credentials or
Conditional Access policies. It uses only `msgraph_resource` data sources and a
`terraform_data` gate, and sends no Graph writes. The [`verify`](verify/README.md) submodule
reads the baseline policies back and fails when one of them does not exclude the break-glass
IDs. The split keeps the dependency graph acyclic: the guard's outputs feed the baseline, and
the baseline's policy IDs feed `verify`.

## Usage

Install a release using the [Terraform Registry instructions](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry); replace `<version>` with that release version.

```hcl
module "emergency_access" {
  source  = "satolap/modules/msgraph//verified/security-baseline/emergency-access-guard"
  version = "<version>"

  tier                  = "p1"
  break_glass_user_ids  = var.break_glass_user_ids  # existing cloud-only accounts
  break_glass_group_ids = var.break_glass_group_ids # optional
}

module "emergency_access_verify" {
  source  = "satolap/modules/msgraph//verified/security-baseline/emergency-access-guard/verify"
  version = "<version>"

  tier                = module.emergency_access.tier
  exclusions          = module.emergency_access.conditional_access_users_exclusions
  baseline_policy_ids = var.existing_baseline_policy_ids
}
```

Pass existing user and group IDs known at plan time. Create them in a separate root or
an earlier apply. Unknown IDs fail during planning because the guard must establish
its read keys before dependent changes. Do not add `depends_on` to the guard's module
call: deferring its reads can also make the group-member keys unknown.

The example verifies existing policies. It does not provision or enforce a Conditional
Access baseline; that module is planned separately. A configuration that changes policies
must pass this guard's gate-bound exclusion outputs to those writes, and pass the resulting
policy IDs to `verify` afterwards. Add `depends_on = [module.policy_writer]` to the **verifier**
module call when the root creates or updates policies; known IDs alone do not order the
read after those writes. Read-back detects configured exclusions, not effective sign-in access.

## Checks

Failures identify the control and affected objects using masked stable ID labels, such as `0000...0010`, with the reason. They omit full object IDs, UPNs and display names. Labels can collide; compare them privately with the caller's known IDs.

1. `break_glass_user_ids` lists at least one lowercase GUID. A group alone is not enough,
   because its membership can change outside Terraform; groups are optional and additional.
2. Every user exists, `accountEnabled` is true, `onPremisesSyncEnabled` is `false` or `null`, `userType`
   is `Member`, and, while `require_onmicrosoft_upn` is true, `userPrincipalName` ends in
   `.onmicrosoft.com` (case-insensitive).
3. Every group exists, `securityEnabled` is true and `groupTypes` does not contain
   `DynamicMembership`. Every direct member is a user (no nested groups, devices or service
   principals), and each of those users passes check 2. When `expected_group_member_ids` is
   set, the direct members of the groups, taken together, must equal it. A group that is not
   role-assignable fails when `require_role_assignable_group` is true, and otherwise adds an
   entry to `warnings`.
4. The resolved users, the direct users plus the user members of the groups without
   duplicates, number at least `minimum_accounts` (default 2).
5. For `p1` and `p2`, the shared [licence guard](../licence-guard/README.md) passes.

Users and groups are read as filtered collections (`$filter=id in (...)`) rather than by ID. A
deleted object is then missing from the result and check 2 or 3 names it, instead of a 404
from `GET /users/{id}`. Members are read only for groups that exist. The `in` operator on `id`
works without advanced query headers
([advanced queries](https://learn.microsoft.com/en-us/graph/aad-advanced-queries#support-for-filter-by-properties-of-microsoft-entra-id-directory-objects)).

Group members are read from the beta endpoint, because the v1.0 endpoint omits service
principal members
([known issue](https://learn.microsoft.com/en-us/graph/known-issues#get-groupsidmembers-doesnt-return-service-principals-in-v10)).
Each member's `@odata.type` and `id` are returned even without permission to read its type
([limited information](https://learn.microsoft.com/en-us/graph/permissions-overview#limited-information-returned-for-inaccessible-member-objects)).
The other reads use v1.0.

## Exclusion snapshots and group membership

Groups are discovery inputs, never Conditional Access exclusion outputs. Both `exclude_users`
and `conditional_access_users_exclusions.excludeUsers` contain the validated resolved user
IDs (direct users plus user members). `exclude_groups` and `.excludeGroups` are always empty
lists of strings. A group owner adding another member after a policy is applied therefore
cannot inherit a live group-based policy exclusion. This rule also applies to role-assignable
groups, because their owners can be delegated membership management
([role-assignable group protections](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/groups-concept)).

These are snapshots, not continuing membership enforcement. A later guard refresh can discover
new users and propose a changed user-exclusion list. Use a reviewed `expected_group_member_ids`
set to reject those membership changes, or a separately trusted/reviewed discovery source;
review the resulting plan before updating exclusions. The role-assignable warning/failure
toggle is an additional discovery control and never allows group IDs into CA outputs.
The guard does not prove that group owners, credentials or an applied policy remain safe.

## Tiers and licences

| Tier | Licence check | Conditional Access |
| --- | --- | --- |
| `free` | None; no licence is read | None. Security defaults stay on and exclude only principals with the Directory Synchronization Accounts role ([security defaults](https://learn.microsoft.com/en-us/entra/fundamentals/security-defaults#enforced-security-policies)), so break-glass accounts cannot be excluded. The guard still checks the accounts and exposes its outputs. |
| `p1` | An Enabled SKU with enabled prepaid units lists `AAD_PREMIUM` | The Conditional Access baseline consumes the outputs |
| `p2` | An Enabled SKU with enabled prepaid units lists `AAD_PREMIUM_P2` | As `p1`; the later risk policy and Privileged Identity Management modules consume the outputs too |

`tier` is required and has no `auto` value. The licence guard reads
[`GET /subscribedSkus`](https://learn.microsoft.com/en-us/graph/api/subscribedsku-list?view=graph-rest-1.0)
for `p1` and `p2` and fails the plan unless a SKU with `capabilityStatus` `Enabled` and
`prepaidUnits.enabled` greater than zero lists the tier's service plan. A SKU in the `Warning`,
`Suspended`, `Deleted` or `LockedOut` state never counts, and the error names each SKU with its
state. No `count` or `for_each` depends on licence data.

| Tier | Registry plan | Service plan | Service plan ID |
| --- | --- | --- | --- |
| `p1` | `ENTRA_ID_P1` | `AAD_PREMIUM` | `41781fb2-bc02-4b7c-bd55-b576c07bb09d` |
| `p2` | `ENTRA_ID_P2` | `AAD_PREMIUM_P2` | `eec0eb4f-6444-4f95-aba0-50c24d67f998` |

The licence guard's `plans.tf` is generated from the licensing registry; this module contains
no plan IDs. Conditional Access requires Microsoft Entra ID P1
([licence requirements](https://learn.microsoft.com/en-us/entra/identity/conditional-access/overview#license-requirements)).
That requirement belongs to the Conditional Access baseline; this module applies the same tier
guard so the two cannot disagree.

## Microsoft's emergency access guidance

[Manage emergency access accounts](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/security-emergency-access)
recommends, among other things:

- Keep two or more emergency access accounts. Make them cloud-only accounts that use the
  `*.onmicrosoft.com` domain and are neither federated nor synchronized from on-premises.
- Use a passkey (FIDO2), which Microsoft recommends, or certificate-based authentication. Both
  satisfy mandatory multifactor authentication. Use methods that differ from your normal
  administrator accounts.
- In Privileged Identity Management, make the Global Administrator assignment active and
  permanent, not eligible.
- Exclude the accounts from Conditional Access policies that block or restrict sign-in, using
  a dedicated security group. Report-only policies need no exclusion.
- Do not tie the accounts to a person or a personal device, and store their credentials in
  separate secure locations.
- Alert on every sign-in and audit event of the accounts, and review each use afterwards.
- Validate the accounts at least every 90 days, and test sign-in against the current
  Conditional Access configuration, for example every quarter.

Related guidance:
[mandatory MFA for Azure and admin portals](https://learn.microsoft.com/en-us/entra/identity/authentication/concept-mandatory-multifactor-authentication)
applies to break-glass accounts too;
[Microsoft-managed policies](https://learn.microsoft.com/en-us/entra/identity/conditional-access/managed-policies)
should exclude them as well; and
[security defaults](https://learn.microsoft.com/en-us/entra/fundamentals/security-defaults#disabling-security-defaults)
and [Plan a Conditional Access deployment](https://learn.microsoft.com/en-us/entra/identity/conditional-access/plan-conditional-access)
recommend these accounts and exclusions.

The guard checks directory properties. It does not prove permanent Global Administrator
assignment, credential custody, registered authentication methods, mandatory MFA, monitoring,
or a successful emergency sign-in. Those operational checks remain required independently.
Keep the default minimum of two accounts to follow the guidance. The explicit
`minimum_accounts = 1` override is retained for compatibility and does not establish that
recommended redundancy.

## Safety

- **Lock-out risk.** An enforced baseline policy that lacks the break-glass exclusion can lock
  every administrator out of the tenant. That is why `break_glass_user_ids` is mandatory and
  why `verify` reads the policies back. An excluded account without a working passkey or
  certificate still cannot sign in, and the guard cannot see registered credentials: test
  sign-in regularly.
- **Report-only and enforced policies.** This module sets no policy state. Microsoft says
  report-only policies need no exclusion
  ([Conditional Access considerations](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/security-emergency-access#conditional-access-considerations)).
  `verify` still checks baseline policies in every state, because one input change moves a
  report-only baseline policy to enforced. Run `verify` before the baseline's enforce apply.
- **First apply and new accounts.** The baseline's policy IDs are unknown at the first plan,
  so `verify` reads the policies during apply, after they exist in report-only state. When a
  break-glass user or group is added or removed, `verify` also reads during apply, after the
  policy writer has updated the exclusions, provided the verifier explicitly depends on
  that writer. Without that caller dependency the local gate cannot sequence policy updates.
  Plans with unchanged policy IDs/exclusions and no writer changes read at plan time, so drift
  fails the plan.
- **Rollback and destroy.** The module stores read responses and gate inputs in Terraform state. Destroy removes only its
  `terraform_data` gates and sends no Graph request. Within one configuration, Terraform
  destroys the Conditional Access baseline before the guard, because the baseline references
  the guard's outputs.
- **Deleted accounts.** A deleted break-glass user or group fails the next plan with a message
  that uses a masked label; the filtered reads do not return a 404. Whether a failing precondition blocks
  `terraform destroy` is not yet verified against a tenant.
- **Blast radius.** The module only reads. Run it against a non-production tenant first.

## Secure Score actions

The guard changes no configuration and completes no recommended action by itself; the
expected Secure Score change is zero. It is a precondition for the Conditional Access
baseline, which replaces the actions that security defaults cover. The titles as the two
Microsoft pages word them:

| Page | Actions |
| --- | --- |
| [Microsoft Secure Score, security defaults](https://learn.microsoft.com/en-us/defender-xdr/microsoft-secure-score#security-defaults) | "Ensure all users can complete multifactor authentication for secure access", "Require MFA for administrative roles", "Enable policy to block legacy authentication" |
| [Identity Secure Score](https://learn.microsoft.com/en-us/entra/identity/monitoring-health/concept-identity-secure-score) | "Ensure all users can complete MFA", "Require multifactor authentication (MFA) for administrative roles", "Enable policy to block legacy authentication" |

The risk policy modules that consume `exclude_users`, `exclude_groups` and
`emergency_access_user_ids` address "Protect all users with a sign-in risk policy" and
"Protect all users with a user risk policy". "Designate more than one Global Administrator"
is related but not addressed, because the guard does not check role assignments. Control IDs
come from
[`GET /security/secureScoreControlProfiles`](https://learn.microsoft.com/en-us/graph/api/security-list-securescorecontrolprofiles?view=graph-rest-1.0)
in a test tenant and are not listed here yet. CIS Microsoft 365 Foundations Benchmark and
CISA SCuBA mappings have not been reviewed.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.11.0 |
| msgraph | >= 0.6.0, < 0.7.0 |

Terraform 1.11 or later is required, including for the offline mock suites.

All calls are reads. The table lists application permissions.

| Call | Purpose | Least privileged (Learn) | Grant |
| --- | --- | --- | --- |
| `GET /users?$filter=id in (...)&$select=id,userPrincipalName,accountEnabled,onPremisesSyncEnabled,userType` ([List users](https://learn.microsoft.com/en-us/graph/api/user-list?view=graph-rest-1.0)) | Checks 2 and 4 | `User.Read.All` | `User.Read.All` |
| `GET /groups?$filter=id in (...)&$select=id,displayName,securityEnabled,groupTypes,isAssignableToRole` ([List groups](https://learn.microsoft.com/en-us/graph/api/group-list?view=graph-rest-1.0)) | Check 3 | See note | `GroupMember.Read.All` |
| `GET /groups/{id}/members?$select=id`, beta ([List group members](https://learn.microsoft.com/en-us/graph/api/group-list-members?view=graph-rest-beta)) | Check 3, direct members | `GroupMember.ReadBasic.All` | `GroupMember.Read.All` |
| `GET /subscribedSkus?$select=skuId,skuPartNumber,capabilityStatus,prepaidUnits,servicePlans` ([List subscribedSkus](https://learn.microsoft.com/en-us/graph/api/subscribedsku-list?view=graph-rest-1.0)) | Check 5, `p1` and `p2` only | `LicenseAssignment.Read.All` | `LicenseAssignment.Read.All` |

The List groups table currently names `Group-NestingSupport.ReadWrite.All` as least
privileged, which is a write permission. `GroupMember.Read.All` is read-only and is listed for
List groups and List group members, so the guard needs only that permission for groups. The
`verify` submodule also needs `Policy.Read.All`. The `free` tier needs no licence permission.

## Limits

- The `msgraph_resource` data source follows `@odata.nextLink` on collection reads in provider
  version 0.6.0 according to source inspection. The guard rejects a missing paging export or a non-null remaining marker. Offline mocks cannot prove real HTTP pagination, complete permissions or provider diagnostics; those remain tenant acceptance checks.
- An `in` filter takes at most 15 values
  ([query parameter limits](https://learn.microsoft.com/en-us/graph/known-issues#query-parameters)).
  Each ID input accepts at most 15 IDs, and the plan fails before the users read when the
  direct users and the user members of the groups number more than 15.
- Only offline mocked tests cover the module; tenant acceptance remains outstanding. No fixture, grant or live workflow is created by this change.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | DIRECTORY-BASIC | The reviewed create APIs for users, assigned security groups, applications and service principals specify no additional premium license. This covers the object operation only; features built on these objects can require licenses. No additional license specified. | No per-user entitlement for the object operation itself | direct / per_tenant | documented |

Notes:

- The guard only reads users, groups, group members and subscribed SKUs and uses no premium feature itself. Its tier input states the baseline's requirement; the Conditional Access baseline whose exclusions the guard supplies must separately declare the Conditional Access feature requirement when implemented.

Sources: [Create user](https://learn.microsoft.com/en-us/graph/api/user-post-users?view=graph-rest-1.0), [Create group](https://learn.microsoft.com/en-us/graph/api/group-post-groups?view=graph-rest-1.0), [Create application](https://learn.microsoft.com/en-us/graph/api/application-post-applications?view=graph-rest-1.0), [Create servicePrincipal](https://learn.microsoft.com/en-us/graph/api/serviceprincipal-post-serviceprincipals?view=graph-rest-1.0).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required | On change |
|------|-------------|------|---------|----------| --- |
| tier | `free`, `p1` or `p2` | `string` | n/a | yes | changes `module.licence_guard`; see the module notes |
| break_glass_user_ids | Object IDs of existing emergency access users; 1 to 15 lowercase GUIDs | `set(string)` | n/a | yes | no object change (validation or timing only) |
| break_glass_group_ids | Discovery-only group IDs; at most 15, never emitted as group exclusions | `set(string)` | `[]` | no | no object change (validation or timing only) |
| minimum_accounts | Minimum number of resolved users, at least 1 | `number` | `2` | no | no object change (validation or timing only) |
| require_onmicrosoft_upn | Require UPNs that end in `.onmicrosoft.com` | `bool` | `true` | no | no object change (validation or timing only) |
| expected_group_member_ids | When set, the direct members of the groups, taken together, must equal it | `set(string)` | `null` | no | no object change (validation or timing only) |
| require_role_assignable_group | Fail, instead of warn, when a group is not role-assignable | `bool` | `false` | no | no object change (validation or timing only) |

## Outputs

| Name | Description | Known in plan after an update |
|------|-------------| --- |
| exclude_users | Sorted snapshot of all validated resolved users, including discovery-group members, for `conditions.users.excludeUsers` | no |
| exclude_groups | Always an empty `list(string)`; no mutable group ID is emitted for Conditional Access exclusion | yes |
| conditional_access_users_exclusions | `{ excludeUsers = validated resolved users, excludeGroups = [] }` for a policy and `verify` | no |
| emergency_access_user_ids | The resolved user IDs: direct users plus group members, without duplicates | no |
| tier | The tier, once the licence guard passes | no |
| checks | Each check with its result: `passed`, `failed`, `warning` or `not_applicable` | no |
| warnings | Findings that do not fail the plan | no |

All outputs depend on the gate so their consumers wait for the checks. Identity and
warning outputs are sensitive; `checks` exposes only fixed status labels. Inputs may come
from sensitive caller values. Only masked diagnostic text, fixed status labels, counts and SHA-256 address keys are declassified to let
Terraform enumerate reads; raw IDs stay out of resource addresses. Hashes are stable
pseudonyms, not an anonymization guarantee.

Terraform state, saved plans and JSON output contain private directory data despite output
sensitivity. Store them privately. Provider errors and debug logging can also disclose URLs
and IDs; do not paste raw diagnostics into public issues. Collection exports must be present,
well-shaped and complete, including an explicit null paging marker. Missing exports,
unknown member kinds and malformed required property values fail closed.
