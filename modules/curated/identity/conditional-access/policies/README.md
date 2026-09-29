# Conditional Access policies

Creates one Microsoft Entra Conditional Access policy (`identity/conditionalAccess/policies`)
via the `microsoft/msgraph` Terraform provider. Compose several module instances for a policy
set.

Safety defaults:

- **Report-only by default.** `state` defaults to `enabledForReportingButNotEnforced`.
  Enforcement needs an explicit `state = "enabled"`.
- **Break-glass exclusion, always.** `break_glass_user_ids` (at least one) and
  `break_glass_group_ids` are merged into `excludeUsers` and `excludeGroups` in every state,
  with no opt-out. The plan fails if a break-glass ID also appears in any include list
  (users, groups or roles).
- **Every managed key is in the configured body.** Lists are `[]` when unset and an optional
  part that is not configured is `null`, so a change made outside Terraform shows up in the
  next plan. An update sends each changed top-level key in full.
- **No silent removals from configuration changes.** Adding or removing an optional part
  (locations, platforms, device_filter, grant_controls, the authentication strength, or any
  session control) replaces the policy, creating the new one before deleting the old one.
  The provider never sends a removed key, and Microsoft Graph keeps omitted properties on
  update, so an in-place removal would report success while the old value stayed. This
  holds for applies that succeed; see [Limits and lifecycle](#limits-and-lifecycle) for a
  failed replacement and for parts added outside Terraform, which an apply cannot remove.

## Usage

```hcl
module "office_egress" {
  source = "../../modules/curated/identity/conditional-access/named-locations/ip-ranges"

  display_name = "Office egress"
  ip_ranges    = ["192.0.2.0/24"]
}

module "require_mfa_pilot" {
  source = "../../modules/curated/identity/conditional-access/policies"

  display_name          = "Require MFA outside the office for the pilot group"
  break_glass_user_ids  = var.break_glass_user_ids
  break_glass_group_ids = var.break_glass_group_ids

  users        = { include_groups = [module.pilot_group.id] }
  applications = { include_applications = ["All"] }
  locations    = { include_locations = ["All"], exclude_locations = [module.office_egress.id] }

  grant_controls = { operator = "OR", built_in_controls = ["mfa"] }
  # state stays report-only until you set state = "enabled".
}
```

Set `var.break_glass_user_ids` to your emergency access users' object IDs in lowercase. A
planned emergency access guard module (not yet released) is meant to supply them later. The
module checks the ID format, not that the accounts exist, so a copied placeholder would
exclude nobody.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.0 |
| msgraph | >= 0.5.0 |

`microsoft/msgraph` 0.5.0 is the first release that sends a changed nested object, such as
`conditions`, in full on update; with earlier releases an update could send only the changed
part. Earlier releases are not supported by this module.

| Operation | Least privileged application permissions | Least privileged delegated roles |
| --- | --- | --- |
| [Create](https://learn.microsoft.com/en-us/graph/api/conditionalaccessroot-post-policies?view=graph-rest-1.0) | `Policy.Read.All` and `Policy.ReadWrite.ConditionalAccess` | Conditional Access Administrator or Security Administrator |
| [Update](https://learn.microsoft.com/en-us/graph/api/conditionalaccesspolicy-update?view=graph-rest-1.0) | `Policy.Read.All` and `Policy.ReadWrite.ConditionalAccess` | Conditional Access Administrator or Security Administrator |
| [Delete](https://learn.microsoft.com/en-us/graph/api/conditionalaccesspolicy-delete?view=graph-rest-1.0) | `Policy.Read.All` and `Policy.ReadWrite.ConditionalAccess` | Conditional Access Administrator or Security Administrator |
| [Read](https://learn.microsoft.com/en-us/graph/api/conditionalaccesspolicy-get?view=graph-rest-1.0) (refresh) | `Policy.Read.All` | Conditional Access Administrator, Security Administrator, Security Reader or Global Reader |

- A [known issue](https://learn.microsoft.com/en-us/graph/known-issues#conditional-access-policy-requires-consent-to-additional-permission)
  means that create and update need consent to `Policy.Read.All` in addition to
  `Policy.ReadWrite.ConditionalAccess`. Grant both.
- Delegated callers need the same two scopes in their token and one of the roles above.
- Conditional Access policies scoped to users do not block calls made by service principals
  ([Sign-in risk-based policy](https://learn.microsoft.com/en-us/entra/identity/conditional-access/policy-risk-based-sign-in)),
  so a service principal that runs Terraform is not blocked by the user-scoped policies it
  manages. A user who runs Terraform can be.

## Rollout

1. Create the policy in report-only mode (the default) and review the results in the sign-in
   logs. Microsoft recommends to "enable each policy in report-only mode for at least one week
   before enforcement"
   ([Plan a Conditional Access deployment](https://learn.microsoft.com/en-us/entra/identity/conditional-access/plan-conditional-access#deploy-conditional-access-policies)).
2. Start with a pilot group, not All users.
3. Set `state = "enabled"` in a reviewed change. To roll back, set `state = "disabled"` or
   back to report-only; switching an enforced policy to report-only stops enforcement
   ([Conditional Access insights and reporting](https://learn.microsoft.com/en-us/entra/identity/conditional-access/howto-conditional-access-insights-reporting)).
4. Security defaults: "If security defaults are turned on, you can create new Conditional
   Access policies, but you can't turn them on", and a policy in any state, report-only and
   off included, prevents turning security defaults back on
   ([Set up multifactor authentication for Microsoft 365](https://learn.microsoft.com/en-us/microsoft-365/admin/security-and-compliance/set-up-multi-factor-authentication#manage-conditional-access-policies)).
   Turn security defaults off only when the policies that replace them already exist and
   have been reviewed in report-only mode, so the tenant is never left with neither.

## Emergency access (break-glass)

- Keep two or more cloud-only emergency access accounts and exclude them, ideally through a
  dedicated group, from Conditional Access policies that block or restrict sign-in; test them
  regularly and validate them at least every 90 days
  ([Manage emergency access accounts](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/security-emergency-access)).
- Microsoft says report-only policies don't need the exclusion. This module requires it in
  every state on purpose, because one input change moves a report-only policy to enforced.
- A group alone is not enough: `break_glass_user_ids` needs at least one user, because group
  membership can change outside Terraform. Use lowercase object IDs, as Microsoft Graph returns
  them.
- The module does not check that the IDs exist or that the accounts can sign in. A planned
  emergency access guard module (not yet released) is meant to check that.
- "Be careful when using block and all resources in a single policy. This combination could
  lock out admins, and exclusions can't be configured for important endpoints such as Microsoft
  Graph"
  ([Plan a Conditional Access deployment](https://learn.microsoft.com/en-us/entra/identity/conditional-access/plan-conditional-access#recommendations)).

## Report-only side effects

Report-only policies don't block users or prompt for MFA, but they are not free of effects
([Report-only mode](https://learn.microsoft.com/en-us/entra/identity/conditional-access/concept-conditional-access-report-only)):

- Policies that require a compliant device can prompt users on macOS, iOS and Android to
  select a device certificate.
- Policies with GPS-based country locations prompt users to share their location, and not
  sharing it can block them.
- User actions (`applications.include_user_actions`) can't be evaluated in report-only mode,
  so the plan fails for that combination; use `disabled` or `enabled`.

## Composition rules checked at plan time

- Sign-in risk and user risk are not combined in one policy
  ([Configure risk policies](https://learn.microsoft.com/en-us/entra/id-protection/howto-identity-protection-configure-risk-policies)).
- `mfa` and an authentication strength are not combined
  ([Authentication strengths](https://learn.microsoft.com/en-us/graph/api/resources/authenticationstrengths-overview?view=graph-rest-1.0)).
- `passwordChange` needs operator `AND` with the `mfa` built-in control, not an
  authentication strength, and no other grant control or terms of use, `user_risk_levels`,
  `include_applications = ["All"]` with no excluded applications, and no other condition
  ("`passwordChange` must be accompanied by `mfa` using an `AND` operator":
  [conditionalAccessGrantControls](https://learn.microsoft.com/en-us/graph/api/resources/conditionalaccessgrantcontrols?view=graph-rest-1.0#special-considerations-when-using-passwordchange-as-a-control);
  "Require password change can't be used with other controls, such as requiring a compliant
  device": [Grant](https://learn.microsoft.com/en-us/entra/identity/conditional-access/concept-conditional-access-grant#require-password-change)).
  An authentication strength cannot stand in for `mfa` here.
- `block` is the only grant control: no other built-in control, no `terms_of_use` and no
  authentication strength. The Graph resource page does not state this rule. It follows the
  admin center, which offers "Block access" and "Grant access" as separate choices
  ([Build a Conditional Access policy, Grant](https://learn.microsoft.com/en-us/entra/identity/conditional-access/concept-conditional-access-policies#grant)),
  so it is an inference from that model.
- The target selectors are mutually exclusive: exactly one of
  `applications.include_applications`, `include_user_actions` and
  `include_authentication_context_class_references` is non-empty. The admin center's "Select
  what this policy applies to" menu offers Resources, User actions or Authentication context
  ([Target resources, Authentication context](https://learn.microsoft.com/en-us/entra/identity/conditional-access/concept-conditional-access-cloud-apps#authentication-context)).
  Graph does not state the rule on the resource page, so it follows the admin center model
  (inference).
- Time-based sign-in frequency is 1 to 23 for type `hours` and 1 to 365 for type `days`.
  These are the admin center limits; Microsoft Learn does not state them, so they are an
  inference, and a value outside them is rejected at plan.
- The `urn:user:registerdevice` user action allows only `mfa` or an authentication strength
  as grant controls, no terms of use, no `device_filter` and `client_app_types = ["all"]`
  ("Require multifactor authentication and Require auth strength are the only access
  controls available with this user action"; client apps and filters for devices "aren't
  available":
  [Target resources, User actions](https://learn.microsoft.com/en-us/entra/identity/conditional-access/concept-conditional-access-cloud-apps#user-actions)).
- A policy sets `grant_controls`, `session_controls` or both
  ([Build a Conditional Access policy](https://learn.microsoft.com/en-us/entra/identity/conditional-access/concept-conditional-access-policies#simple-policies)).
- `persistent_browser_mode` needs `include_applications = ["All"]`
  ([conditionalAccessSessionControls](https://learn.microsoft.com/en-us/graph/api/resources/conditionalaccesssessioncontrols?view=graph-rest-1.0)).
- Not checked, apply fails or the control has no effect: `applicationEnforcedRestrictions`
  works only for Exchange Online and SharePoint Online; sign-in frequency `everyTime` is
  available for risky users, risky sign-ins and Intune enrollment only; session controls
  with `urn:user:registerdevice` (the page says all other access controls are disabled);
  and a macOS platform condition, which "isn't supported when you select Require approved
  client app or Require app protection policy as the only grant controls, or when you
  select Require all the selected controls"
  ([Conditions, Device platforms](https://learn.microsoft.com/en-us/entra/identity/conditional-access/concept-conditional-access-conditions#device-platforms)).
- Rejected by validation: the `approvedApplication` grant control. Since June 30, 2026
  "Admins can no longer create new policies or edit existing ones that use this control";
  use `compliantApplication` (Require app protection policy)
  ([Migrate approved client app](https://learn.microsoft.com/en-us/entra/identity/conditional-access/migrate-approved-client-app)).
- Rejected by validation for now: the `linux` platform. The pinned Microsoft Graph contract
  lists it after the `unknownFutureValue` sentinel of an evolvable enum, and a read without
  the `Prefer: include-unknown-enum-members` header returns only known members
  ([Handle responses effectively](https://learn.microsoft.com/en-us/graph/best-practices-concept#handle-responses-effectively)),
  so a policy with `linux` could read back as `unknownFutureValue` and never converge. The
  provider sends no such header on refresh. Allowing it later loosens validation.

## Limits and lifecycle

- A tenant can hold at most 240 Conditional Access policies in any state, report-only and off
  included. Long GUID lists can exceed the policy's size limit; prefer groups
  ([Plan a Conditional Access deployment](https://learn.microsoft.com/en-us/entra/identity/conditional-access/plan-conditional-access#recommendations)).
- Deleted policies are soft-deleted with all properties kept and can be restored for 30 days;
  Microsoft recommends restoring in report-only mode first
  ([Recover from deletions](https://learn.microsoft.com/en-us/entra/architecture/recover-from-deletions)).
- A replacement (an optional part added or removed) creates the new policy first, so for a
  moment both exist, and the policy `id` changes. The new policy is created from the
  configuration only, so values set outside Terraform for the properties this module does
  not manage (below) are lost.
- **An authentication strength id that is unknown at plan time replaces the policy.** The
  module tells whether the strength is present by comparing `authentication_strength_id`
  with `null`, and the id of a strength that the same apply creates or replaces is unknown
  until apply. The presence signature is then unknown, so the plan replaces an existing
  policy even though the strength stays set, with the consequences above. Apply in two
  steps (create or change the strength first), or pass an id that is known at plan, such as
  a literal or an input variable. A known id that changes from one strength to another
  updates the policy in place.
- **Parts added outside Terraform stay.** If an optional part, for example a location or
  platform condition or a session control, is added to the policy outside Terraform while
  the configuration leaves it unset, the next plan shows the drift, but the apply sends no
  request (the provider never sends a value changed to `null`), reports success, and the
  part stays in force. `optional_parts_not_in_configuration` lists such parts after each
  read. To remove them, recreate the policy from the configuration:
  `terraform apply -replace='<module address>.msgraph_resource.policy'`.
- **After a failed replacement, do not rerun a plain apply.** When an apply that planned a
  replacement fails, Terraform has already recorded the new presence signature, so the
  retry plans an in-place update that cannot remove a part, and the old part stays in
  force. If the new policy was created but could not be read back, it also exists outside
  the state. First look for a policy with the same display name and delete the one that is
  not in state, then run `terraform apply -replace='<module address>.msgraph_resource.policy'`.
- When the licences lapse, existing policies stay in place and can be read and deleted, but
  not updated
  ([License requirements](https://learn.microsoft.com/en-us/entra/identity/conditional-access/overview#license-requirements)).
- Lists are sent canonicalised (GUIDs lower-cased, duplicates removed, sorted). The provider
  compares lists by position on refresh, so if Microsoft Graph returned a list in a different
  order, every plan would show a change.
- Not managed by this module: `clientApplications` and `servicePrincipalRiskLevels` (Workload
  Identities Premium), `insiderRiskLevels`, `authenticationFlows`, the
  `includeGuestsOrExternalUsers` and `excludeGuestsOrExternalUsers` objects, `templateId`,
  `description`, `disableResilienceDefaults` and the `riskRemediation` grant control.
  Values set outside Terraform for these properties are kept on in-place updates, lost when
  the module replaces the policy, and never reported. Losing an
  `excludeGuestsOrExternalUsers` value widens the policy's scope.
- Locations: `AllTrusted` in `include_locations` or `exclude_locations` means every location
  marked as trusted. Terraform cannot see that dependency, so untrusting or deleting a
  trusted location changes these policies without a plan diff here; see the IP named
  location module's README.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | CONDITIONAL-ACCESS | Conditional Access requires Microsoft Entra ID P1. Risk-based policies (sign-in risk and user risk) also need Microsoft Entra ID Protection, a Microsoft Entra ID P2 feature, which is a separate rule. When the licenses expire, existing policies are not disabled or deleted; they can be viewed and deleted but no longer updated. Any of: Microsoft Entra ID P1 (`AAD_PREMIUM`). | Users in scope of the policies; the reviewed pages state the tenant requirement without a per-user counting rule, so review coverage against the product terms | direct / per_tenant | documented |
| `sign_in_risk_levels` is set | CONDITIONAL-ACCESS-RISK | Sign-in risk and user risk conditions in Conditional Access require Microsoft Entra ID Protection, a Microsoft Entra ID P2 feature, in addition to the Conditional Access requirement. Any of: Microsoft Entra ID P2 (`AAD_PREMIUM_P2`). | Users in scope of the risk-based policies; the reviewed pages state the tenant requirement without a per-user counting rule, so review coverage against the product terms | direct / per_tenant | documented |
| `user_risk_levels` is set | CONDITIONAL-ACCESS-RISK | Sign-in risk and user risk conditions in Conditional Access require Microsoft Entra ID Protection, a Microsoft Entra ID P2 feature, in addition to the Conditional Access requirement. Any of: Microsoft Entra ID P2 (`AAD_PREMIUM_P2`). | Users in scope of the risk-based policies; the reviewed pages state the tenant requirement without a per-user counting rule, so review coverage against the product terms | direct / per_tenant | documented |

Notes:

- Grant and session controls that depend on other products, such as Microsoft Intune device compliance or Microsoft Defender for Cloud Apps, need those products' own licence review; the module does not check them.
- The Conditional Access rules were reviewed against Microsoft Learn on 2026-09-29, which is later than the review date stated above.

Sources: [Conditional Access license requirements](https://learn.microsoft.com/en-us/entra/identity/conditional-access/overview#license-requirements), [Microsoft Entra Conditional Access licensing](https://learn.microsoft.com/en-us/entra/fundamentals/licensing#microsoft-entra-conditional-access).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| display_name | Display name of the policy | `string` | n/a | yes |
| state | `disabled`, `enabledForReportingButNotEnforced` or `enabled` | `string` | `"enabledForReportingButNotEnforced"` | no |
| break_glass_user_ids | Emergency access user IDs (lowercase GUIDs), always excluded | `set(string)` | n/a | yes |
| break_glass_group_ids | Emergency access group IDs (lowercase GUIDs), always excluded | `set(string)` | `[]` | no |
| users | include/exclude users, groups and roles | `object` | n/a | yes |
| applications | include/exclude applications, user actions, authentication contexts | `object` | n/a | yes |
| client_app_types | Client app types | `set(string)` | `["all"]` | no |
| sign_in_risk_levels | Sign-in risk levels (P2) | `set(string)` | `[]` | no |
| user_risk_levels | User risk levels (P2) | `set(string)` | `[]` | no |
| locations | include/exclude named locations, `All` or `AllTrusted` | `object` | `null` | no |
| platforms | include/exclude device platforms | `object` | `null` | no |
| device_filter | Filter for devices (`mode`, `rule`) | `object` | `null` | no |
| grant_controls | operator, built-in controls, authentication strength, terms of use | `object` | `null` | no |
| session_controls | sign-in frequency, persistent browser, app enforced restrictions, Defender for Cloud Apps | `object` | `null` | no |
| api_version | Graph API version (`v1.0` or `beta`) | `string` | `"v1.0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The policy ID; it changes when an optional part is added or removed, or when the authentication strength id is unknown at plan time |
| display_name | The display name Microsoft Graph returned on the last read |
| state | The state Microsoft Graph returned on the last read |
| excluded_user_ids | `excludeUsers` as returned on the last read, including the break-glass users |
| excluded_group_ids | `excludeGroups` as returned on the last read, including the break-glass groups |
| optional_parts_not_in_configuration | Optional parts Microsoft Graph returned on the last read that the configuration does not set; an apply cannot remove them |
