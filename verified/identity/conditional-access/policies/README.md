# Conditional Access policies

<!-- uses-beta:start -->
Uses beta: **no**. This module and its local child modules do not select beta.
<!-- uses-beta:end -->

<!-- live-status:start -->
Assurance: **verified live-accepted** (2026-10-24, commit `344ecc7e`). Acceptance covers the recorded run and configuration.

![live Dev: passed 2026-10-24](https://img.shields.io/badge/live%20Dev-passed%202026--10--24-brightgreen)
<!-- live-status:end -->

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

Replace `<version>` with a release version, such as `1.0.0`; the [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one.

```hcl
module "office_egress" {
  source  = "satolap/modules/msgraph//verified/identity/conditional-access/named-locations/ip-ranges"
  version = "<version>"

  display_name = "Office egress"
  ip_ranges    = ["192.0.2.0/24"]
}

module "require_mfa_pilot" {
  source  = "satolap/modules/msgraph//verified/identity/conditional-access/policies"
  version = "<version>"

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
| terraform | >= 1.11.0 |
| msgraph | >= 0.5.0 |

`microsoft/msgraph` 0.5.0 is the first release that sends a changed nested object, such as
`conditions`, in full on update; with earlier releases an update could send only the changed
part. Earlier releases are not supported by this module.

The module sets minimum versions only. Azure Verified Modules also require a maximum major
version (TFNFR25, TFNFR26); this module follows HashiCorp's guidance for reusable modules
instead, which is to "constrain only their minimum allowed versions of Terraform and
providers"
([Version constraints](https://developer.hashicorp.com/terraform/language/expressions/version-constraints)).
The provider is 0.x, so a minor release can break the module; the release manifest records
the provider version it was tested with. Set upper bounds in your root module.

Only the Microsoft Graph v1.0 API is supported: `api_version = "beta"` fails at plan, because
Microsoft does not support beta APIs in production applications. Switching an existing
policy from `"beta"` to `"v1.0"` plans one in-place update; it sends no PATCH request and
reads the policy back through v1.0, so the apply fails if v1.0 cannot read it (not
verified).

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

## Independent checks

[Maester](https://maester.dev/) is a read-only posture scanner that can confirm, from outside
Terraform, what this module wrote. The checks below read what the module manages; the IDs are
Maester's and the claims are this project's words. Maester reads policies through the beta
endpoint while the module uses v1.0, so a disagreement over a beta-only property is a finding
to investigate, not a module failure.

| Check | What it reads | How this module relates |
| --- | --- | --- |
| [MT.1005](https://maester.dev/docs/tests/MT.1005/) | Every policy Maester considers excludes every configured break-glass user and group; authentication-context and service-principal scoped policies are left out. | The module merges `break_glass_user_ids` and `break_glass_group_ids` into every policy in every state. Configure the same IDs as Maester's `EmergencyAccessAccounts`, as typed user and group entries; without that configuration Maester only infers the single most common exclusion. |
| [MT.1038](https://maester.dev/docs/tests/MT.1038/), [MT.1066](https://maester.dev/docs/tests/MT.1066/) | No policy includes or excludes a deleted group, user or role. | The module validates ID format only, so these catch an ID that stopped existing after apply. MT.1066 needs `RoleManagement.Read.Directory` or `Directory.Read.All` to resolve roles. |
| [MT.1003](https://maester.dev/docs/tests/MT.1003/), [MT.1004](https://maester.dev/docs/tests/MT.1004/), [MT.1006](https://maester.dev/docs/tests/MT.1006/), [MT.1007](https://maester.dev/docs/tests/MT.1007/), [MT.1009](https://maester.dev/docs/tests/MT.1009/), [MT.1010](https://maester.dev/docs/tests/MT.1010/); [CISA.MS.AAD.1.1](https://maester.dev/docs/tests/CISA.MS.AAD.1.1/), [3.1](https://maester.dev/docs/tests/CISA.MS.AAD.3.1/), [3.2](https://maester.dev/docs/tests/CISA.MS.AAD.3.2/), [3.6](https://maester.dev/docs/tests/CISA.MS.AAD.3.6/) | Whether an enabled policy targets all applications and all users, requires MFA for administrators and for all users, blocks legacy authentication, or requires phishing-resistant MFA. | Only `state = "enabled"` counts. A report-only policy, this module's default, never satisfies them, so they measure enforcement, not configuration. |

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
- **Unmanaged properties are reported, not carried over.** `unmanaged_properties_set` lists
  the properties from the "Not managed" list below that Microsoft Graph returned set on the
  last read, and the `unmanaged_properties` check warns while the list is not empty. A plan
  or apply still succeeds, but `terraform test` counts the warning as a failure. On a plan
  that creates, updates or replaces the policy the read-back is not known yet, so Terraform
  warns that the check result is known after apply instead. Before a change that replaces
  the policy, run `terraform plan -refresh-only` (after at least one apply with this
  release): its `unmanaged_properties` warning lists them, while the plan that replaces the
  policy only warns that the result is known after apply. Upgrading from a release without
  `unmanaged_properties_set` plans one in-place update of each policy for the new read-back
  key; it sends no PATCH request to Microsoft Graph.
- **Tests that call this module.** In `terraform test`, a run with `command = plan` that
  creates or replaces a policy through this module fails with "Check block assertion known
  after apply", and a calling test cannot name a check inside a module in
  `expect_failures`. With a mock provider, a plan that updates the policy in place keeps the
  last read-back and passes; with the real provider it fails the same way (inference). Use
  `command = apply` for such runs or an `override_resource`
  block for `module.<name>.msgraph_resource.policy` with `override_during = plan` and an
  `output` value.
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
- Not managed by this module, and reported in `unmanaged_properties_set`: `description`,
  `templateId`, `conditions.applications.applicationFilter`,
  `conditions.users.includeGuestsOrExternalUsers`,
  `conditions.users.excludeGuestsOrExternalUsers`, `conditions.clientApplications` and
  `conditions.servicePrincipalRiskLevels` (Workload Identities Premium),
  `conditions.insiderRiskLevels` (Microsoft Purview Insider Risk Management),
  `conditions.authenticationFlows.transferMethods` (a value other than `none`),
  `grantControls.customAuthenticationFactors` (custom controls, which Microsoft has
  deprecated), `sessionControls.disableResilienceDefaults` (only `true`; `false` is the
  default behaviour) and `sessionControls.secureSignInSession` (listed in the v1.0 metadata,
  not on the v1.0 reference page). Values set outside Terraform for these properties are
  lost when the module replaces the policy. Losing `excludeGuestsOrExternalUsers`,
  `insiderRiskLevels`, `servicePrincipalRiskLevels`, `authenticationFlows.transferMethods`
  or an `applicationFilter` in `exclude` mode widens the policy's scope; losing
  `disableResilienceDefaults = true` or `secureSignInSession` weakens its session controls;
  losing `customAuthenticationFactors` from a policy whose grant `operator` is `AND` weakens
  its grant controls, because the custom control is no longer required.
  Whether an in-place update keeps them is not verified: an update sends a changed
  `conditions`, `grantControls` or `sessionControls` object in full, without them.
  Properties that only the beta API has, such as the conditions `agents`,
  `agentIdRiskLevels` and `applications.globalSecureAccess` or the session control
  `continuousAccessEvaluation`, cannot be read through v1.0 and are not reported. A
  replacement loses them too, and losing one that narrows the scope, such as
  `agentIdRiskLevels`, widens the policy's scope.
- The `riskRemediation` grant control cannot be configured: `grant_controls.built_in_controls`
  rejects it. A value added outside Terraform shows as drift, possibly as
  `unknownFutureValue`. When `grant_controls` is set, the next apply sends `grantControls` in
  full without it, which removes it. On a policy without `grant_controls`, the added
  `grantControls` is a part added outside Terraform (above): the apply sends no request,
  `optional_parts_not_in_configuration` lists `grantControls`, and only a replacement removes
  it (inference from the provider code, not run live).
- Locations: `AllTrusted` in `include_locations` or `exclude_locations` means every location
  marked as trusted. Terraform cannot see that dependency, so untrusting or deleting a
  trusted location changes these policies without a plan diff here; see the IP named
  location module's README.
- **Named location replication delay.** A location created moments before can be missing
  from the replica that serves the policy request, and Graph answers `400 BadRequest`,
  error 1040, "NamedLocation with id ... does not exist in the directory." With `locations` set,
  the module anchors the provider's `retry` to the `BadRequest` error envelope, code 1040
  and a complete location GUID. A successful response echoing that text in a display name
  does not match. The create or update is retried
  until `timeouts.create` or `timeouts.update` (10 minutes by default) runs out; shorten or
  extend the wait there. Without `locations` no retry is set, and nothing sleeps unless Graph
  returns the error. Adding the `retry` argument to an existing policy may show as an in-place
  change without a change to the request body (not checked). Not run live yet: the live `conditional-access`
  profile has to pass for the fix to count as verified.
- **Create, update and delete timeouts of at least `15s`.** After each request the provider
  waits for three consistent reads 5 seconds apart, within the same timeout, so a value
  under 10 seconds always fails after the request was sent, and the module rejects values
  under `15s`. A create that fails this way leaves the policy in Microsoft Graph but not in
  the state (inference from the provider code). The provider already retries status codes
  408, 429, 500, 502, 503 and 504 by itself, and those retries count against the timeouts.

## Licence check (opt-in)

`licence_check` is `false` by default. Then the module reads nothing extra and needs no
extra permission. Set it to `true` to make the plan fail early when the tenant has no
usable Microsoft Entra ID P1 subscription (a P2 subscription also lists the P1 service
plan). The shared [licence guard](../../../security-baseline/licence-guard/README.md) reads `GET /subscribedSkus` and fails the plan
unless a subscribed SKU in the `Enabled` state with enabled prepaid units lists the
registry's P1 service plan. The plan IDs come from the licensing registry, not from this
module. The error names the SKUs that list the plan but do not qualify.

- Permission, only while the check is on: `Organization.Read.All` or
  `LicenseAssignment.Read.All` ([List subscribedSkus](https://learn.microsoft.com/en-us/graph/api/subscribedsku-list?view=graph-rest-1.0)).
- The check compares tenant subscriptions and their enabled units. It does not count
  per-user assignments or consumed units, and it is not a licence-compliance assessment.
- No resource depends on licence data, so the check can fail a plan but never adds or
  removes resources. The check is a precondition of the `licence_guard` module output, which
  the `licence_tier` output re-exports, so every plan evaluates it.
- Turn it off again to apply after a licence lapse, for example to delete objects.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

Before deployment, check the requirements of the features you enable and the users who benefit. You can inspect tenant subscriptions with `GET /subscribedSkus`; this requires `Organization.Read.All` or `LicenseAssignment.Read.All` ([List subscribedSkus](https://learn.microsoft.com/en-us/graph/api/subscribedsku-list?view=graph-rest-1.0)).

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | CONDITIONAL-ACCESS | Conditional Access requires Microsoft Entra ID P1. Risk-based policies (sign-in risk and user risk) also need Microsoft Entra ID Protection, a Microsoft Entra ID P2 feature, which is a separate rule. When the licenses expire, existing policies are not disabled or deleted; they can be viewed and deleted but no longer updated. Any of: Microsoft Entra ID P1 (`AAD_PREMIUM`). | Users in scope of the policies; the reviewed pages state the tenant requirement without a per-user counting rule, so review coverage against the product terms | direct / per_tenant | documented |
| `sign_in_risk_levels` is set | CONDITIONAL-ACCESS-RISK | Sign-in risk and user risk conditions in Conditional Access require Microsoft Entra ID Protection, a Microsoft Entra ID P2 feature, in addition to the Conditional Access requirement. Any of: Microsoft Entra ID P2 (`AAD_PREMIUM_P2`). | Users in scope of the risk-based policies; the reviewed pages state the tenant requirement without a per-user counting rule, so review coverage against the product terms | direct / per_tenant | documented |
| `user_risk_levels` is set | CONDITIONAL-ACCESS-RISK | Sign-in risk and user risk conditions in Conditional Access require Microsoft Entra ID Protection, a Microsoft Entra ID P2 feature, in addition to the Conditional Access requirement. Any of: Microsoft Entra ID P2 (`AAD_PREMIUM_P2`). | Users in scope of the risk-based policies; the reviewed pages state the tenant requirement without a per-user counting rule, so review coverage against the product terms | direct / per_tenant | documented |

Notes:

- Grant and session controls that depend on other products, such as Microsoft Intune device compliance or Microsoft Defender for Cloud Apps, need those products' own licence review; the module does not check them.
- The Conditional Access rules were reviewed against Microsoft Learn on 2026-09-29, which is later than the review date stated above.
- The opt-in `licence_check` input (default false) fails the plan unless a usable Microsoft Entra ID P1 subscription exists; it reads GET /subscribedSkus only when true and then needs Organization.Read.All or LicenseAssignment.Read.All. It checks tenant subscriptions and enabled units, not per-user assignments.

Sources: [Conditional Access license requirements](https://learn.microsoft.com/en-us/entra/identity/conditional-access/overview#license-requirements), [Microsoft Entra Conditional Access licensing](https://learn.microsoft.com/en-us/entra/fundamentals/licensing#microsoft-entra-conditional-access).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required | On change |
|------|-------------|------|---------|----------| --- |
| display_name | Display name of the policy | `string` | n/a | yes | in place |
| name_pattern | Regular expression (RE2, not anchored unless it says so) that display_name must match, or the plan fails; null accepts any name | `string` | `null` | no | no object change (validation or timing only) |
| licence_check | Opt-in plan-time check that a usable Microsoft Entra ID P1 subscription exists; reads `GET /subscribedSkus` only when `true` | `bool` | `false` | no | changes `module.licence_guard`; see the module notes |
| state | `disabled`, `enabledForReportingButNotEnforced` or `enabled` | `string` | `"enabledForReportingButNotEnforced"` | no | in place |
| break_glass_user_ids | Emergency access user IDs (lowercase GUIDs), always excluded | `set(string)` | n/a | yes | in place |
| break_glass_group_ids | Emergency access group IDs (lowercase GUIDs), always excluded | `set(string)` | `[]` | no | in place |
| users | include/exclude users, groups and roles | `object` | n/a | yes | in place |
| applications | include/exclude applications, user actions, authentication contexts | `object` | n/a | yes | in place |
| client_app_types | Client app types | `set(string)` | `["all"]` | no | in place |
| sign_in_risk_levels | Sign-in risk levels (P2) | `set(string)` | `[]` | no | in place |
| user_risk_levels | User risk levels (P2) | `set(string)` | `[]` | no | in place |
| locations | include/exclude named locations, `All` or `AllTrusted` | `object` | `null` | no | replaces `msgraph_resource.policy` when its effect on `local.presence` changes |
| platforms | include/exclude device platforms | `object` | `null` | no | replaces `msgraph_resource.policy` when its effect on `local.presence` changes |
| device_filter | Filter for devices (`mode`, `rule`) | `object` | `null` | no | replaces `msgraph_resource.policy` when its effect on `local.presence` changes |
| grant_controls | operator, built-in controls, authentication strength, terms of use | `object` | `null` | no | replaces `msgraph_resource.policy` when its effect on `local.presence` changes |
| session_controls | sign-in frequency, persistent browser, app enforced restrictions, Defender for Cloud Apps | `object` | `null` | no | replaces `msgraph_resource.policy` when its effect on `local.presence` changes |
| api_version | Graph API version; only `v1.0` is supported | `string` | `"v1.0"` | no | in place |
| timeouts | `create`, `read`, `update` and `delete` timeouts, such as `30m`; create, update and delete at least `15s`; retries count against them | `object` | `{}` (`10m` for create, update and delete; the provider default for read) | no | no object change (validation or timing only) |

## Outputs

| Name | Description | Known in plan after an update |
|------|-------------| --- |
| id | The policy ID; it changes when an optional part is added or removed, or when the authentication strength id is unknown at plan time | yes |
| display_name | The display name Microsoft Graph returned on the last read | no |
| state | The state Microsoft Graph returned on the last read | no |
| excluded_user_ids | `excludeUsers` as returned on the last read, including the break-glass users | no |
| excluded_group_ids | `excludeGroups` as returned on the last read, including the break-glass groups | no |
| optional_parts_not_in_configuration | Optional parts Microsoft Graph returned on the last read that the configuration does not set; an apply cannot remove them | no |
| unmanaged_properties_set | Properties the module does not manage that Microsoft Graph returned set on the last read; a replacement loses them | no |
| licence_tier | The licence tier that was checked: `p1` when `licence_check` is true, otherwise `free` | no |

<!-- drift:start -->
## Drift and out-of-band changes

Terraform plans compare configuration and refreshed provider state. A plan that changes one of these inputs proposes its declared effect; review the plan before applying. The consumer guide explains refresh limits and emergency reconciliation.

- `display_name`: in place.
- `state`: in place.
- `break_glass_user_ids`: in place.
- `break_glass_group_ids`: in place.
- `users`: in place.
- `applications`: in place.
- `client_app_types`: in place.
- `sign_in_risk_levels`: in place.
- `user_risk_levels`: in place.
- `locations`: replaces `msgraph_resource.policy` when its effect on `local.presence` changes.
- `platforms`: replaces `msgraph_resource.policy` when its effect on `local.presence` changes.
- `device_filter`: replaces `msgraph_resource.policy` when its effect on `local.presence` changes.
- `grant_controls`: replaces `msgraph_resource.policy` when its effect on `local.presence` changes.
- `session_controls`: replaces `msgraph_resource.policy` when its effect on `local.presence` changes.
- `api_version`: in place.
- `timeouts`: no object change (validation or timing only).
- `name_pattern`: no object change (validation or timing only).
- `licence_check`: changes `module.licence_guard`; see the module notes.
<!-- drift:end -->
