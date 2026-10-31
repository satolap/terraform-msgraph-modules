# conditional-access-p1

<!-- state-protection:start -->
## State and plan protection

This module's state and saved plans retain these declared values:

Sensitive outputs: `licensed_skus`.

Protect these values with an encrypted remote backend and least-privilege access to state, plans and backups. `sensitive` is presentation redaction, not encryption; provider resource values can still appear in plan/show output. Do not publish plan output in CI logs or PR comments for secret-bearing roots; keep saved plans short-lived and rotate credentials after exposure.

See [Terraform sensitive state guidance](https://developer.hashicorp.com/terraform/language/state/sensitive-data). These are exposure indicators, not a complete data classification; unmarked fields and provider responses also need protection.
<!-- state-protection:end -->

<!-- uses-beta:start -->
Uses beta: **conditional**. Local module `../emergency-access-guard`: When groups are configured, the guard reads members through beta because v1.0 omits service principals and cannot prove that all direct members are users (GB-security-baseline-509). Beta is preview and may change without notice. Pin module and provider versions; read `interface-changes.json` before upgrading.
<!-- uses-beta:end -->

<!-- live-status:start -->
Assurance: **verified offline-only**. No current live acceptance is recorded for this module.

![live: offline only](https://img.shields.io/badge/live-offline%20only-lightgrey)
<!-- live-status:end -->

Four Microsoft Entra Conditional Access policies that replace
[security defaults](https://learn.microsoft.com/entra/fundamentals/security-defaults) on a
Microsoft Entra ID P1 or P2 tenant, as part of the [security baseline](../README.md). They are the four
policies Microsoft lists for
[upgrading from security defaults](https://learn.microsoft.com/entra/identity/conditional-access/managed-policies#upgrade-from-security-defaults):

| Key | Policy (after the display name prefix) | Grant |
| --- | --- | --- |
| `admins` | Require multifactor authentication for admins | MFA |
| `legacy_auth` | Block legacy authentication | Block |
| `all_users` | Require multifactor authentication for all users | MFA |
| `azure_management` | Require multifactor authentication for Azure management | MFA |

The policies start in **report-only** mode. Security defaults are turned off only in the apply
that enforces the policies, and a **decommission** apply deletes the policies and restores the
recorded security defaults state. **These policies apply to every user of the tenant. Read
[Lock-out risk](#lock-out-risk) before enforcing.**

## Usage

Install a release using the [Terraform Registry instructions](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry); replace `<version>` with that release version.

```hcl
module "conditional_access_baseline" {
  source  = "satolap/modules/msgraph//verified/security-baseline/conditional-access-p1"
  version = "<version>"

  tier                 = "p1"
  break_glass_user_ids = var.break_glass_user_ids # at least one, preferably two existing accounts
}
```

The first apply creates the policies in report-only mode and changes nothing else. Review the
sign-in logs, then set `enforce = true` and apply again.

## Inputs

| Input | Type | Default | Notes | On change |
| --- | --- | --- | --- | --- |
| `tier` | `string` | required | `p1` or `p2`. `free` fails validation and points to the free-tier modules, which keep security defaults on. There is no `auto`. | changes `module.licence_guard`; see the module notes; changes `module.emergency_access`; see the module notes |
| `break_glass_user_ids` | `set(string)` | required | At least one lowercase GUID, at most 15, each must exist. A `check` warns when fewer than two accounts are excluded. A group alone is not enough, because its membership can change outside Terraform. | changes `module.emergency_access`; see the module notes |
| `break_glass_group_ids` | `set(string)` | `[]` | Optional emergency access security groups. They are validated by the emergency access guard and their direct user members are added to the exclusions as users. The group IDs are never sent as `excludeGroups` (see below). | changes `module.emergency_access`; see the module notes |
| `enforce` | `bool` | `false` | `false` is report-only (`enabledForReportingButNotEnforced`). `true` sets `enabled`, after turning security defaults off if they were on. | creates or deletes `msgraph_update_resource.security_defaults_off` instances |
| `decommission` | `bool` | `false` | Deletes the four policies, then restores security defaults if they were on before the module. Run before `terraform destroy`. | creates or deletes `msgraph_update_resource.security_defaults_off` instances; creates or deletes `msgraph_resource.policy` instances; creates or deletes `msgraph_update_resource.security_defaults_restore` instances; changes `module.licence_guard`; see the module notes; changes `module.emergency_access`; see the module notes |
| `display_name_prefix` | `string` | `"Security baseline - "` | Prefixed to the policy names. The enforce check finds the existing baseline by these names. | in place |
| `additional_admin_role_template_ids` | `list(string)` | `[]` | Add-only. The 16 default roles cannot be removed. | in place |
| `exclude_directory_sync_accounts` | `bool` | `true` | Excludes the Directory Synchronization Accounts role from the all-users policy, as Microsoft advises for hybrid tenants. Security defaults exclude it too. | in place |

## Outputs

| Output | Description | Known in plan after an update |
| --- | --- | --- |
| `policy_ids` | Policy object IDs by key | no |
| `policy_states` | Policy `state` by key as Graph returned it | no |
| `security_defaults_prior_enabled` | Whether security defaults were on when the module first applied; never overwritten | yes |
| `security_defaults_turned_off_by_module` | Whether this module turned security defaults off and has not restored them | no |
| `licensed_skus` | Sensitive; SKUs that license the tier (empty during decommission) | no |
| `tier` | The tier after the licence guard and the plan-time checks passed | no |

## Policy bodies

All policies send `conditions.users.excludeUsers` with the break-glass users (sorted), and
`excludeGroups = []`. Property names follow
[conditionalAccessPolicy](https://learn.microsoft.com/graph/api/resources/conditionalaccesspolicy?view=graph-rest-1.0).

| Key | Users | Applications | `clientAppTypes` | Grant | Learn guidance |
| --- | --- | --- | --- | --- | --- |
| `admins` | `includeRoles`: 16 role template IDs, plus the additional ones | `All` | `all` | `mfa` | [Require MFA for administrators](https://learn.microsoft.com/entra/identity/conditional-access/policy-old-require-mfa-admin) |
| `legacy_auth` | `includeUsers: All` | `All` | `exchangeActiveSync`, `other` | `block` | [Block legacy authentication](https://learn.microsoft.com/entra/identity/conditional-access/policy-block-legacy-authentication) |
| `all_users` | `includeUsers: All`; `excludeRoles`: Directory Synchronization Accounts (default) | `All` | `all` | `mfa` | [Require MFA for all users](https://learn.microsoft.com/entra/identity/conditional-access/policy-all-users-mfa-strength) |
| `azure_management` | `includeUsers: All` | Windows Azure Service Management API | `all` | `mfa` | [Require MFA for Azure management](https://learn.microsoft.com/entra/identity/conditional-access/policy-old-require-mfa-azure-mgmt) |

- **Built-in roles only.** The 14 roles of Microsoft's administrator MFA policy, plus
  Authentication Policy Administrator and Identity Governance Administrator, which security
  defaults also cover so that replacing them drops no coverage. Conditional Access is
  enforced for built-in roles only, not for administrative-unit-scoped or custom roles
  ([Require MFA for administrators](https://learn.microsoft.com/entra/identity/conditional-access/policy-old-require-mfa-admin)).
- **Global cloud only.** The Azure management policy targets the Windows Azure Service Management
  API app ID of the global cloud ([target resources](https://learn.microsoft.com/entra/identity/conditional-access/concept-conditional-access-cloud-apps#windows-azure-service-management-api)).
  Azure Government needs a different app.
- **`mfa` control, not an authentication strength.** Learn prefers the built-in Multifactor
  authentication strength for all users but warns that external authentication methods are
  incompatible with strengths. Authentication strengths and phishing-resistant MFA for admins are a
  follow-up.
- **The policies are declared with `msgraph_resource`**, not through the generated module, because the
  safety checks are lifecycle postconditions on each policy that a caller cannot add to a called module.
  An offline test checks that every property sent is an input of the generated v1.0 module.
- **Break-glass groups are discovery only.** The emergency access guard snapshots the user members
  of `break_glass_group_ids` into `excludeUsers`; the group IDs are never sent as exclusions, so a later
  membership change cannot exempt anyone from MFA without a plan (the family rule in the
  [security baseline README](../README.md)). Re-apply to refresh the snapshot after a membership change.

## Objects and permissions

Application permissions. The first column is every operation the module (and the shared guards it calls) performs.

| Operation | Endpoint | Least-privileged permission | Learn |
| --- | --- | --- | --- |
| Create policy | `POST /identity/conditionalAccess/policies` | `Policy.Read.All` and `Policy.ReadWrite.ConditionalAccess` | [Create](https://learn.microsoft.com/graph/api/conditionalaccessroot-post-policies?view=graph-rest-1.0), [known issue](https://learn.microsoft.com/graph/known-issues#identity-and-access) |
| Read policy | `GET /identity/conditionalAccess/policies/{id}` | `Policy.Read.All` | [Get](https://learn.microsoft.com/graph/api/conditionalaccesspolicy-get?view=graph-rest-1.0) |
| List policies (enforce precondition) | `GET /identity/conditionalAccess/policies` | `Policy.Read.All` | [List](https://learn.microsoft.com/graph/api/conditionalaccessroot-list-policies?view=graph-rest-1.0) |
| Update policy | `PATCH /identity/conditionalAccess/policies/{id}` | `Policy.Read.All` and `Policy.ReadWrite.ConditionalAccess` | [Update](https://learn.microsoft.com/graph/api/conditionalaccesspolicy-update?view=graph-rest-1.0) |
| Delete policy | `DELETE /identity/conditionalAccess/policies/{id}` | `Policy.Read.All` and `Policy.ReadWrite.ConditionalAccess` | [Delete](https://learn.microsoft.com/graph/api/conditionalaccesspolicy-delete?view=graph-rest-1.0) |
| Read security defaults | `GET /policies/identitySecurityDefaultsEnforcementPolicy` | `Policy.Read.All` | [Get](https://learn.microsoft.com/graph/api/identitysecuritydefaultsenforcementpolicy-get?view=graph-rest-1.0) |
| Set security defaults (`isEnabled`) | `PATCH /policies/identitySecurityDefaultsEnforcementPolicy` | Learn lists `Policy.Read.All` as least privileged and `Policy.Read.All` with `Policy.ReadWrite.ConditionalAccess` as higher. A write under a read-only permission looks like a documentation error (unverified). The module holds both. | [Update](https://learn.microsoft.com/graph/api/identitysecuritydefaultsenforcementpolicy-update?view=graph-rest-1.0) |
| Licence guard (not during decommission) | `GET /subscribedSkus` | `LicenseAssignment.Read.All` | [List](https://learn.microsoft.com/graph/api/subscribedsku-list?view=graph-rest-1.0) |
| Break-glass users exist (not during decommission) | `GET /users?$filter=id in (...)` | `User.Read.All` | [List users](https://learn.microsoft.com/graph/api/user-list?view=graph-rest-1.0) |
| Break-glass groups and members (only with `break_glass_group_ids`) | `GET /groups`, `GET /groups/{id}/members` (beta) | Read permissions of the [emergency access guard](../emergency-access-guard/README.md) | [Get group](https://learn.microsoft.com/graph/api/group-get?view=graph-rest-1.0) |

Delegated callers need at least Security Administrator or Conditional Access Administrator for policy
writes ([Create](https://learn.microsoft.com/graph/api/conditionalaccessroot-post-policies?view=graph-rest-1.0)),
and at least Conditional Access Administrator for security defaults
([Security defaults](https://learn.microsoft.com/entra/fundamentals/security-defaults)).

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

Before deployment, check the requirements of the features you enable and the users who benefit. You can inspect tenant subscriptions with `GET /subscribedSkus`; this requires `Organization.Read.All` or `LicenseAssignment.Read.All` ([List subscribedSkus](https://learn.microsoft.com/en-us/graph/api/subscribedsku-list?view=graph-rest-1.0)).

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | CONDITIONAL-ACCESS | Conditional Access requires Microsoft Entra ID P1. Risk-based policies (sign-in risk and user risk) also need Microsoft Entra ID Protection, a Microsoft Entra ID P2 feature, which is a separate rule. When the licenses expire, existing policies are not disabled or deleted; they can be viewed and deleted but no longer updated. Any of: Microsoft Entra ID P1 (`AAD_PREMIUM`). | Users in scope of the policies; the reviewed pages state the tenant requirement without a per-user counting rule, so review coverage against the product terms | direct / per_tenant | documented |

Notes:

- The tier input is required and accepts p1 or p2 only; free is rejected. p1 and p2 read subscribedSkus through the shared licence guard, and a tenant with only Microsoft Entra ID P2 passes tier p1 because the P2 product row also lists AAD_PREMIUM. A decommission apply reads no licences, because policies can be read and deleted but not updated after the licence lapses.
- The policies use the mfa grant control. They use no authentication strength and no risk condition, so Microsoft Entra ID Protection (P2) is not needed; risk-based policies belong to the Phase 2 baseline.
- Conditional Access applies to built-in administrator roles only, not to administrative-unit-scoped or custom roles. The module targets the global cloud only (Windows Azure Service Management API app ID).
- Existing Microsoft-managed Conditional Access policies are not managed here; review them and exclude the break-glass accounts there as well.

Sources: [Conditional Access license requirements](https://learn.microsoft.com/en-us/entra/identity/conditional-access/overview#license-requirements), [Microsoft Entra Conditional Access licensing](https://learn.microsoft.com/en-us/entra/fundamentals/licensing#microsoft-entra-conditional-access).
<!-- licensing:end -->

## Licence tier and guard

- Conditional Access requires Microsoft Entra ID P1
  ([License requirements](https://learn.microsoft.com/entra/identity/conditional-access/overview#license-requirements)).
- `tier` has no default. `p1` and `p2` run the shared [licence guard](../licence-guard/README.md) with
  `allowed_tiers = ["p1", "p2"]`: a SKU with `capabilityStatus` `Enabled` and enabled prepaid units
  must list the tier's plan. The plan IDs are generated from the licensing registry: `p1` is
  `AAD_PREMIUM` `41781fb2-bc02-4b7c-bd55-b576c07bb09d`, `p2` is `AAD_PREMIUM_P2`
  `eec0eb4f-6444-4f95-aba0-50c24d67f998`. The Microsoft Entra ID P2 product also lists `AAD_PREMIUM`,
  so a P2-only tenant passes `tier = "p1"`.
- A SKU that lists the plan but is `Warning`, `Suspended`, `Deleted` or `LockedOut` fails, and the
  error names the SKU and its state.
- Licence data never switches resources on or off: no `count` or `for_each` depends on it. A static test checks this.
- If the licence lapses, existing policies are not disabled, but they can be read and deleted, not updated
  ([License requirements](https://learn.microsoft.com/entra/identity/conditional-access/overview#license-requirements)).
  A decommission apply therefore reads no licences and checks no break-glass accounts, and still works;
  changing `enforce` does not.

## Report-only and enforce

- The default state is `enabledForReportingButNotEnforced`. While the policies are report-only the
  module leaves security defaults alone: report-only policies enforce nothing, so turning security
  defaults off then would leave the tenant unprotected.
- `enforce = true` fails at plan time unless all four baseline policies already exist. The module lists
  `GET /identity/conditionalAccess/policies` and matches the display names on the client, so no `$filter`
  operator is relied on. The first apply is therefore always report-only.
- The enforce apply sets security defaults to `isEnabled = false` first (only if they were on before the
  module), then changes the policies to `enabled`: the policies depend on the security defaults write.
  Learn says Conditional Access policies can be created but not turned on while security defaults are
  enabled
  ([Set up multifactor authentication](https://learn.microsoft.com/microsoft-365/admin/security-and-compliance/set-up-multi-factor-authentication#manage-conditional-access-policies)).
- The prior security defaults state is recorded on the first apply and never overwritten
  (`security_defaults_prior_enabled`). The mode of the first apply is recorded too: `enforce = true` on a fresh state
  is refused even if policies with the baseline names exist.
- If an enforce apply fails after the security defaults write and before every policy is enabled, the tenant has
  report-only policies and security defaults off until the next apply: re-apply with `enforce = true` straight away.
  Going back to `enforce = false` is refused (see below).
- Going back to `enforce = false` without `decommission` after security defaults were turned off fails at
  plan time, because the tenant would be left with report-only policies and no security defaults.

## Lock-out risk

Enforcing these policies can lock every administrator out of the tenant, in particular when MFA is not
registered for them, when a legacy client still signs in, or when an emergency account is not excluded.

- At least one break-glass user is mandatory and must exist, even in report-only mode: Learn says report-only
  policies need no exclusion
  ([Conditional Access considerations](https://learn.microsoft.com/entra/identity/role-based-access-control/security-emergency-access#conditional-access-considerations)),
  but `enforce = true` changes only `state`, so the exclusion must already be in place.
- Each policy has a postcondition on the Graph read-back of `excludeUsers`; it fails if a break-glass user is missing.
- The module never creates or changes the emergency access accounts. Keep two or more
  ([Emergency access accounts](https://learn.microsoft.com/entra/identity/role-based-access-control/security-emergency-access#create-emergency-access-accounts)),
  cloud-only, with credentials stored offline, and test the sign-in before enforcing.
- Review the report-only results in the sign-in logs and the Conditional Access insights workbook first.
- Use a non-production tenant for live acceptance first. The policies are tenant-wide.

## Decommission and destroy

Deleting an `msgraph_update_resource` sends no request in the `microsoft/msgraph` provider (documented
by the provider; confirm in #39). A plain `terraform destroy` therefore deletes the policies and
**leaves security defaults off**. To roll back:

1. Set `enforce = false` and `decommission = true`, then apply. The four policies are deleted, then security
   defaults are set to `isEnabled = true` if they were on before the module. Learn says security defaults
   cannot be enabled while Conditional Access policies exist, so the policies go first
   ([Plan a Conditional Access deployment](https://learn.microsoft.com/entra/identity/conditional-access/plan-conditional-access#overview)).
   If this apply fails after the policies were deleted, re-apply with `decommission = true` before anything else,
   otherwise the tenant has no policies and security defaults off.
2. Then run `terraform destroy`. It removes the remaining state and sends no security defaults request.

Between the deletes and the restore the tenant has neither in force for a short time. That a single apply
orders the restore after the deletes, that security defaults can be re-enabled while Microsoft-managed
policies remain, and the exact window are unverified (#39, #37).

## Microsoft-managed policies

Microsoft may already have created overlapping
[Microsoft-managed policies](https://learn.microsoft.com/entra/identity/conditional-access/managed-policies#how-microsoft-managed-policies-work)
in report-only mode. Microsoft turns them on no less than 30 days after introduction if they stay in
report-only mode, and they cannot be deleted. This module does not manage them: review them, and exclude the
break-glass accounts there as well.

## Secure Score

Microsoft Secure Score actions for the policies, per the
[Defender XDR page](https://learn.microsoft.com/defender-xdr/microsoft-secure-score#security-defaults) and
[Identity Secure Score](https://learn.microsoft.com/entra/identity/monitoring-health/concept-identity-secure-score):
`admins` addresses Require MFA for administrative roles (10 points), `legacy_auth` addresses Enable policy to
block legacy authentication (7 points), and `all_users` addresses Ensure all users can complete multifactor
authentication for secure access (9 points). `azure_management` is listed on neither page. These are the actions security
defaults already earn in full, so the expected net change after enforcement is zero, and report-only earns
nothing while security defaults keep the points. Identity Secure Score recalculates every 24 hours. Whether the
all-users policy alone earns the full points (it appears to depend on registered MFA methods, see
[authentication-methods](../authentication-methods/README.md)), and whether any control covers Azure management, are
unverified; the control profile IDs come from `GET /security/secureScoreControlProfiles` in a test tenant (#78).
Marking the sign-in-risk and user-risk actions as resolved through an alternative mitigation depends on security defaults being on; that
basis ends when enforcement turns them off. Risk policies belong to Phase 2 (P2).

## Tests

Mocked `msgraph` provider, no tenant: `tests/baseline.tftest.hcl`, `tests/security_defaults_off.tftest.hcl`,
`tests/validation.tftest.hcl` and the two `tests/read_back_*.tftest.hcl` files (a failed apply taints
the resource, so each read-back case has its own file). The licence failure cases (the error naming the SKU and its state is asserted in the licence guard's own tests) run the shared licence guard, and the
break-glass lookup case runs the emergency access guard, as the root module with the arguments this module passes, because
`expect_failures` cannot name an object of a called module; `tests/test_conditional_access_baseline.py` checks the
wiring. Not covered, and tracked in #37 and #39: whether Graph accepts report-only policies while security defaults are
on and rejects `enabled` while they are on, apply ordering of the restore, and the Secure Score deltas. Only mocked
tests cover the module; it has not run against a licensed tenant.

<!-- drift:start -->
## Drift and out-of-band changes

Terraform plans compare configuration and refreshed provider state. A plan that changes one of these inputs proposes its declared effect; review the plan before applying. The consumer guide explains refresh limits and emergency reconciliation.

- `tier`: changes `module.licence_guard`; see the module notes; changes `module.emergency_access`; see the module notes.
- `break_glass_user_ids`: changes `module.emergency_access`; see the module notes.
- `break_glass_group_ids`: changes `module.emergency_access`; see the module notes.
- `enforce`: creates or deletes `msgraph_update_resource.security_defaults_off` instances.
- `decommission`: creates or deletes `msgraph_update_resource.security_defaults_off` instances; creates or deletes `msgraph_resource.policy` instances; creates or deletes `msgraph_update_resource.security_defaults_restore` instances; changes `module.licence_guard`; see the module notes; changes `module.emergency_access`; see the module notes.
- `display_name_prefix`: in place.
- `additional_admin_role_template_ids`: in place.
- `exclude_directory_sync_accounts`: in place.
<!-- drift:end -->

<!-- permissions:begin -->
## Per-operation permissions

Source: [Graph DevX map](https://raw.githubusercontent.com/microsoftgraph/microsoft-graph-devx-content/56e1917fe45fb7c52c2d9845f569c2ffdb39e4d9/permissions/new/permissions.json) (SHA-256 `4d7dee52659b1d6424bce0b26603302081d39ef9e149bc5fb50de4273b3d3514`).
The map is shared by v1.0 and beta; it does not certify API-version support. Rows show the source's least-privilege annotations, not live-tested consent. Choose an alternative for your authentication type; do not grant every listed scope. AlsoRequires lists additional scope alternatives attached to that row. Missing annotations are unknown, not evidence that an operation needs no permission. Keep the module's documented role, property-specific and tenant restrictions.

Derived from this module's Terraform sources, including optional guards, destroy actions and local child modules. The checked inventory is `docs/permissions/verified-operations.json`. These are potential requests, not a preflight scope list. A provider primitive may expose an update that Graph does not support. Source paths and conditions are retained in the inventory.

| Operation | Authentication | Least-privilege alternative | AlsoRequires | Unknown reason |
| --- | --- | --- | --- | --- |
| `PATCH /policies/identitySecurityDefaultsEnforcementPolicy` | DelegatedWork | `Policy.Read.All` | - | - |
| `PATCH /policies/identitySecurityDefaultsEnforcementPolicy` | DelegatedWork | `Policy.ReadWrite.SecurityDefaults` | `Policy.Read.All` | - |
| `PATCH /policies/identitySecurityDefaultsEnforcementPolicy` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `PATCH /policies/identitySecurityDefaultsEnforcementPolicy` | Application | `Policy.Read.All` | - | - |
| `PATCH /policies/identitySecurityDefaultsEnforcementPolicy` | Application | `Policy.ReadWrite.SecurityDefaults` | `Policy.Read.All` | - |
| `GET /policies/identitySecurityDefaultsEnforcementPolicy` | DelegatedWork | `Policy.Read.All` | - | - |
| `GET /policies/identitySecurityDefaultsEnforcementPolicy` | DelegatedWork | `Policy.ReadWrite.SecurityDefaults` | `Policy.Read.All` | - |
| `GET /policies/identitySecurityDefaultsEnforcementPolicy` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /policies/identitySecurityDefaultsEnforcementPolicy` | Application | `Policy.Read.All` | - | - |
| `GET /policies/identitySecurityDefaultsEnforcementPolicy` | Application | `Policy.ReadWrite.SecurityDefaults` | `Policy.Read.All` | - |
| `POST /identity/conditionalAccess/policies` | DelegatedWork | `Application.Read.All` | - | - |
| `POST /identity/conditionalAccess/policies` | DelegatedWork | `Policy.Read.All` | - | - |
| `POST /identity/conditionalAccess/policies` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `POST /identity/conditionalAccess/policies` | Application | `Policy.Read.All` | - | - |
| `GET /identity/conditionalAccess/policies/{id}` | DelegatedWork | `Policy.Read.All` | - | - |
| `GET /identity/conditionalAccess/policies/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /identity/conditionalAccess/policies/{id}` | Application | `Policy.Read.All` | - | - |
| `DELETE /identity/conditionalAccess/policies/{id}` | DelegatedWork | `Policy.Read.All` | - | - |
| `DELETE /identity/conditionalAccess/policies/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `DELETE /identity/conditionalAccess/policies/{id}` | Application | `Policy.Read.All` | - | - |
| `PATCH /identity/conditionalAccess/policies/{id}` | DelegatedWork | `Application.Read.All` | - | - |
| `PATCH /identity/conditionalAccess/policies/{id}` | DelegatedWork | `Policy.Read.All` | - | - |
| `PATCH /identity/conditionalAccess/policies/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `PATCH /identity/conditionalAccess/policies/{id}` | Application | `Policy.Read.All` | - | - |
| `GET /identity/conditionalAccess/policies` | DelegatedWork | `Policy.Read.All` | - | - |
| `GET /identity/conditionalAccess/policies` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /identity/conditionalAccess/policies` | Application | `Policy.Read.All` | - | - |
| `GET /subscribedSkus` | DelegatedWork | `LicenseAssignment.Read.All` | - | - |
| `GET /subscribedSkus` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /subscribedSkus` | Application | `LicenseAssignment.Read.All` | - | - |
| `GET /users` | DelegatedWork | `User.ReadBasic.All` | - | - |
| `GET /users` | DelegatedWork | `User.ReadWrite.All` | - | - |
| `GET /users` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /users` | Application | `User.ReadBasic.All` | - | - |
| `GET /users` | Application | `User.ReadWrite.All` | - | - |
| `GET /groups` | DelegatedWork | `Group-NestingSupport.ReadWrite.All` | - | - |
| `GET /groups` | DelegatedWork | `Group.ReadBasic.All` | - | - |
| `GET /groups` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /groups` | Application | `Group-NestingSupport.ReadWrite.All` | - | - |
| `GET /groups` | Application | `Group.ReadBasic.All` | - | - |
| `GET /groups/{id}/members` | DelegatedWork | `GroupMember.ReadBasic.All` | - | - |
| `GET /groups/{id}/members` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /groups/{id}/members` | Application | `GroupMember.ReadBasic.All` | - | - |

### Property-specific coverage

Route annotations do not establish that the listed scopes cover every selected or writable property. Dynamic bodies, additional properties and default responses remain unbounded. Keep the reviewed permission guidance above; in particular, a group-nesting scope is not general group-property access. The pin's method/path entries do not distinguish property grants from navigation or sub-resource operations; property coverage stays unknown.

| Operation | Properties | Source evidence |
| --- | --- | --- |
| `PATCH /policies/identitySecurityDefaultsEnforcementPolicy` | `isEnabled` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `GET /subscribedSkus` | `capabilityStatus`, `prepaidUnits`, `servicePlans`, `skuId`, `skuPartNumber` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `GET /users` | `accountEnabled`, `id`, `onPremisesSyncEnabled`, `userPrincipalName`, `userType` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `GET /groups` | `displayName`, `groupTypes`, `id`, `isAssignableToRole`, `securityEnabled` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `GET /groups/{id}/members` | `id` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
<!-- permissions:end -->
