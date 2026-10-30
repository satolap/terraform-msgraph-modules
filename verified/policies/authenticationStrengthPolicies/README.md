# policies/authenticationStrengthPolicies

<!-- uses-beta:start -->
Uses beta: **no**. This module and its local child modules do not select beta.
<!-- uses-beta:end -->

<!-- live-status:start -->
Assurance: **verified offline-only**. No current live acceptance is recorded for this module.

![live: not yet run](https://img.shields.io/badge/live-not%20yet%20run-lightgrey)
<!-- live-status:end -->

Creates one **custom authentication strength policy** using Microsoft Graph v1.0
`/policies/authenticationStrengthPolicies`. Built-in strengths remain read-only:
there is no existing-policy ID input, import/adoption mode or built-in selector.
Both the POST response and an independent GET must identify the created policy
as `custom` before metadata updates or deletion registration can proceed.
No Conditional Access policy or authentication method policy is changed here.

For a release containing this module, replace `<version>` with its version. The
[terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry)
explains registry installation; presence in this tree does not establish that a
published release contains it.

```hcl
module "strength" {
  source  = "satolap/modules/msgraph//verified/policies/authenticationStrengthPolicies"
  version = "<version>"

  # Initial restriction creation / detached maintenance only. Set false and apply
  # before attaching to CA, then keep false for referenced no-op plans.
  detached_maintenance = true
  displayName         = "Restricted passkeys and certificates"
  description         = "Reviewed authentication methods"
  allowedCombinations = ["fido2", "x509CertificateMultiFactor"]
  allowedAAGUIDs       = var.reviewed_authenticator_aaguids
  x509CertificateCombinationConfigurations = {
    x509CertificateMultiFactor = {
      allowedIssuerSkis = var.reviewed_certificate_issuer_skis
      allowedPolicyOIDs = ["1.2.3.4"]
    }
  }
}
```

## Contract and lifecycle

`allowedCombinations` is a nonempty set of canonical strings, including compound
values such as `password,sms`. The module accepts the 22 combinations in the
pinned Learn combinations example and checks their flags against pinned CSDL.
It refuses arbitrary flag combinations, whitespace variants, null elements and
`unknownFutureValue`. This is an intentionally bounded contract: the live
combinations endpoint can add values (the pinned CSDL already has `qrCodePin`
which the older Learn combinations example does not include). Such values need
a reviewed contract extension before they are accepted here.

Learn explicitly forbids changing `allowedCombinations` through PATCH. Metadata
uses PATCH with only `displayName` and a non-null `description`. Changing the
combination set replaces a provider action that POSTs the complete set to
`updateAllowedCombinations`, retaining the policy ID. The initial apply also
executes this setter once. Each POST action uses `ignore_changes = all`, so an
ordinary in-place update cannot resubmit it. The setter has no destroy request.
`combinationUpdateResult` exposes Graph's `conditionalAccessReferences` and
`additionalInformation` warning: adding a weaker combination can reduce security
for every referencing Conditional Access policy. Review those policies before
changing the strength; this module does not approve that security decision.

`allowedAAGUIDs = null` creates no FIDO2 configuration. Otherwise it must be a
nonempty GUID set, lower-cased, de-duplicated and sorted before sending. Each
certificate map key is `x509CertificateSingleFactor` or
`x509CertificateMultiFactor`; its nonempty restriction sets use only
`allowedIssuerSkis` and/or `allowedPolicyOIDs`. Certificate values are checked
for nonblank strings, not certificate existence or OID/SKI validity. Every
configured method must appear in `allowedCombinations`. Nonempty restrictions
are a conservative module requirement, not a documented Graph minimum.
Issuer SKIs are lower-cased, de-duplicated and sorted in both the request body
and the response comparison; a case-only change does not replace a child.
This is the module's normalization rule. Graph's SKI case handling is unverified.
Policy OID values retain their spelling.

Children use the canonical
`policies/authenticationStrengthPolicies/{id}/combinationConfigurations` route,
with a concrete `@odata.type` discriminator for each derived type. The pinned
child-operation pages spell the `identity/conditionalAccess/authenticationStrength/policies`
alias; the reviewed canonical parent applies to its descendants as well. The
generic PATCH table lists only `appliesToCombinations`; it does not establish
that changing restrictions is supported. Therefore a restriction change replaces
only that child (delete first, then create) and changes its ID. A response
postcondition verifies its returned ID, discriminator and configured restrictions;
out-of-band drift fails closed rather than being silently ignored. Removing a child
also deletes it. The transition gate below refuses changes while referenced so
that the temporary unrestricted state cannot be used by an attached CA policy.
No automatic access policy edits or create-before-destroy behavior are implemented.

## Mandatory transition gate

The pinned contracts do not establish that Graph accepts a configuration before
its combination is allowed, permits two configurations for the same combination,
or PATCHes restriction properties. The module therefore retains its documented
setter-before-child and delete-before-create operations **only while detached**.
Detachment is mandatory before adding, changing or removing any restriction,
or changing the combination set, on an existing referenced strength.

`transition.tf` reads `GET /policies/authenticationStrengthPolicies/{id}/usage`,
the policy's current combinations, and the combination configuration collection.
Both `mfa` and `none` usage collections must be empty for a transition. If either
contains a reference, a retained precondition requires the desired combinations
and normalized restriction bodies to match the live snapshot and the persisted
configuration inputs exactly. Live state matching a changed desired body is not
enough: the saved signature can still trigger a DELETE/POST replacement. This also
guards removal of the last configuration, whose own resource no longer exists
in the desired configuration. No-op plans and metadata-only updates remain
allowed while referenced. Blocking every combination-set change is deliberately
conservative, including changes that might be safe in isolation.

Use `detached_maintenance = true` for initial restriction creation and any child
creation or replacement while detached. This mode explicitly requires both usage
collections to be empty; it cannot override a CA reference. After completing the
apply, set it to `false` (the default) and apply once to record the stable plan
keys without changing Graph. Require a clean fresh plan, then reattach.
Keep it false for referenced no-op plans and metadata-only updates.

The saved signature is read through `terraform_data.configuration.output`.
Terraform exposes a new planned value through `.input`, so comparing that value
would not prove that the saved input stayed unchanged. A changed signature makes
its persisted output unknown during planning. With maintenance mode off, the
`stable_configuration_plan` helper requires known child IDs and saved-output
hashes as instance keys. Replacement or signature-update plans therefore fail
before apply, including when portal drift already matches the desired body.
Terraform reports this deliberate refusal as **Invalid for_each argument** at
`stable_configuration_plan`; detach every reference and use maintenance mode
instead of bypassing the error. The helper makes no Graph request. It also
prevents a forced replacement of a referenced child with an unchanged body.

Missing, malformed or paginated evidence fails closed. For an existing policy,
these independent reads occur during normal planning, before any mutation or
child deletion; for a newly created policy, they occur at apply after ownership
verification and before its writers. The existing write permission is listed as
a higher permission on the pinned usage page; least-privileged usage reading is
`Policy.Read.AuthenticationMethod`.

Detach the strength reference from **every** referencing CA policy, including
disabled policies, independently confirm both usage collections are empty, then
set `detached_maintenance = true`, and make a fresh normal plan and apply. Verify
the completed restrictions, set maintenance mode back to false and apply the
helper-only change, then require a clean plan before reattaching. Merely disabling
a referencing policy is insufficient.
Keep references detached throughout the apply and coordinate other state files
and operators: the usage check is not an atomic lock. Do not apply a saved plan
after usage changes, bypass refresh, or target resources to skip this gate. The
module does not coordinate concurrent external CA writes. A failed or partial
apply must be repaired and independently verified before any reference is restored.

Null `description` omits the property and does not clear an existing description.
There are no secret inputs or outputs; configuration and action responses still
live in Terraform state and need appropriate state access controls.

## Destroy, failures and recovery

The provider registers a destroy-only DELETE of the independently verified,
captured policy GUID. There is no local-exec, external helper, collection-wide
delete, `$ref` delete, or lookup by display name. On full destroy the policy
DELETE **precedes child configuration deletion**. A Conditional Access reference
must make Graph refuse policy deletion; Terraform must report the provider error
and retain the removal resource and restrictions. No error suppression or custom
retry turns this refusal into success. Remove the referencing CA policies, or
change their strength reference, then retry normal destroy. Never remove the
ownership/removal resources from state to bypass a failed delete.

**Never destroy after a failed first apply; repair and re-apply first.** DELETE
registration is the last managed resource created, after the metadata,
combinations action and child configurations succeed. If any of those steps
fails, the policy can exist in state and in Graph while
`msgraph_resource_action.remove` is absent. A following destroy cannot issue
the policy DELETE and can orphan the policy while forgetting its creation
record. Reversing the dependency would register cleanup earlier but would also
delete restrictions before the parent, so a refused parent DELETE could weaken
a referenced strength. This module retains the safer full-destroy order and
does not claim automatic cleanup of an incomplete first apply.

Preserve the failed state and verify the captured policy ID and custom type.
If the policy POST and ownership GET succeeded and only a later writer failed,
fix the rejected value or transient error and re-apply with that same state.
Confirm the existing policy ID is retained and `msgraph_resource_action.remove`
is present before attempting destroy. Do not re-apply a failed or tainted policy
POST blindly; if that POST/ownership verification failed, or repair cannot
complete, arrange owner cleanup of the independently verified exact custom
policy instead. Do not discard its state before that cleanup is verified.

After policy deletion, child cleanup may encounter already-deleted children;
provider handling of that 404 and Graph's child cascade behavior remain live
acceptance items. The output dependency orders a CA module using `id` before the
policy's deletion in a shared Terraform graph. References managed in other state
files need explicit coordination. This module cannot make external references
disappear, re-read identity at destroy time, or prove absence after DELETE.

Import, manual state adoption, `terraform destroy -refresh=false`, targeted
operations, taint and forced replacement of individual helper/action resources
are unsupported. Postconditions are after-operation checks, not an import
authorization boundary. A failed create/GET may leave a captured POST response
without deletion registered: preserve state, independently verify that exact
returned ID and custom type, then arrange owner cleanup of that object only.
Never retry a tainted create blindly: it can create a second policy. Replacing
the whole module changes its policy ID and requires detaching CA references.

## Conditional Access wiring

Graph stores the reference as `grantControls.authenticationStrength.id`.
The existing verified `identity/conditional-access/policies` module accepts it
as `grant_controls.authentication_strength_id`:

```hcl
module "pilot_ca" {
  source  = "satolap/modules/msgraph//verified/identity/conditional-access/policies"
  version = "<version>"

  display_name = "Pilot authentication strength"
  state        = "disabled"
  users        = var.reviewed_pilot_users
  applications = var.reviewed_pilot_applications
  break_glass_user_ids = var.emergency_access_user_ids
  grant_controls = {
    operator                   = "OR"
    authentication_strength_id = module.strength.id
  }
}
```

Supply that module's other required inputs and its emergency access exclusions
as documented in its README. Do not combine a strength with `mfa`. Adding or
removing the strength replaces the CA policy. An ID unknown at plan time (a new
or replaced strength in the same apply) can also replace an existing CA policy;
use two applies and a known ID when retaining that policy ID matters. This PR
does not change the Conditional Access modules or enable any policy.

## Requirements, inputs and outputs

Terraform >= 1.11.0; `microsoft/msgraph >= 0.6.0, < 0.7.0`. Offline execution uses
0.6.0 on Terraform 1.11.4 and 1.16.2, installed from a local provider mirror.
The calling root must maintain its own lock file. The pinned create permission
table lists `Policy.ReadWrite.ConditionalAccess` for applications and delegated
work/school accounts, with `Policy.ReadWrite.AuthenticationMethod` as higher
privilege. Delegated callers additionally need Conditional Access administrator,
Security Administrator or an appropriate custom role. Personal accounts are
unsupported. Authorization does not establish license entitlement.

## Licence check (opt-in)

`licence_check` is `false` by default. Then the module reads nothing extra and needs no
extra permission. Set it to `true` to make the plan fail early when the tenant has no
usable Microsoft Entra ID P1 subscription (a P2 subscription also lists the P1 service
plan). The shared [licence guard](../../security-baseline/licence-guard/README.md) reads `GET /subscribedSkus` and fails the plan
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

Notes:

- Authentication strength use through Conditional Access requires the Conditional Access P1 entitlement for each covered user; this configuration-only module creates no CA policy and does not establish a separate license counting rule for an unused definition.
- Policy.ReadWrite.ConditionalAccess (or the documented higher Policy.ReadWrite.AuthenticationMethod) and an appropriate administrator role for delegated access are authorization requirements, not license entitlement.
- Pinned Graph API contracts and offline mock tests do not establish licensed-tenant acceptance. Creation, action updates, CA reference deletion refusal and child cascade/404 handling remain owner-dispatched live acceptance items.
- The opt-in `licence_check` input (default false) fails the plan unless a usable Microsoft Entra ID P1 subscription exists; it reads GET /subscribedSkus only when true and then needs Organization.Read.All or LicenseAssignment.Read.All. It checks tenant subscriptions and enabled units, not per-user assignments.

Sources: [Conditional Access license requirements](https://learn.microsoft.com/en-us/entra/identity/conditional-access/overview#license-requirements), [Microsoft Entra Conditional Access licensing](https://learn.microsoft.com/en-us/entra/fundamentals/licensing#microsoft-entra-conditional-access).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required | On change |
| --- | --- | --- | --- | --- | --- |
| displayName | New custom strength name | `string` | n/a | yes | kept from creation in `msgraph_resource_action.policy`; updates `msgraph_update_resource.metadata` in place |
| name_pattern | Regular expression (RE2, not anchored unless it says so) that displayName must match, or the plan fails; null accepts any name | `string` | `null` | no | no object change (validation or timing only) |
| licence_check | Opt-in plan-time check that a usable Microsoft Entra ID P1 subscription exists; reads `GET /subscribedSkus` only when `true` | `bool` | `false` | no | changes `module.licence_guard`; see the module notes |
| detached_maintenance | Initial restriction creation or detached maintenance; true requires empty CA usage; false rejects planned child/signature replacement | `bool` | `false` | no | no object change (validation or timing only) |
| description | Non-null description; null does not clear | `string` | `null` | no | kept from creation in `msgraph_resource_action.policy`; updates `msgraph_update_resource.metadata` in place |
| allowedCombinations | Complete canonical combination set | `set(string)` | n/a | yes | replaces `msgraph_resource_action.combinations` when its effect on `local.combinations` changes; ignored in `msgraph_resource_action.policy` |
| allowedAAGUIDs | FIDO2 authenticator restrictions | `set(string)` | `null` | no | replaces `msgraph_resource.configuration` when `each.value` changes; creates or deletes `msgraph_resource.configuration` instances |
| x509CertificateCombinationConfigurations | Certificate restrictions by combination | `map(map(set(string)))` | `{}` | no | replaces `msgraph_resource.configuration` when `each.value` changes; creates or deletes `msgraph_resource.configuration` instances |

## Outputs

| Name | Description | Known in plan after an update |
| --- | --- | --- |
| id | Verified created custom policy ID | yes |
| combinationConfigurationIds | Child IDs by combination | no |
| combinationUpdateResult | Graph setter result and impact warnings | no |
| licence_tier | The licence tier that was checked: `p1` when `licence_check` is true, otherwise `free` | no |

## Live status and acceptance runbook

No live run has been made. Offline mocks verify construction, validation,
ownership failure and lifecycle dependencies; they do not simulate an HTTP
deletion error or prove service behavior. The owner dispatches acceptance in a
licensed disposable tenant with approved credentials and a pilot CA policy:

1. Create a custom strength, independently GET its type, ID and combinations,
   then verify a clean plan and no duplicated policy after a second apply.
2. Change name/description, then combinations through the documented action;
   confirm unchanged policy ID, fresh GET equality, impact warnings and no
   repeated POST on a no-op apply. Probe replication and ordering failures.
3. Add FIDO2 AAGUID and both certificate configuration types; independently GET
   discriminators and restrictions. Change and remove restrictions while
   detached from CA; confirm child replacement and unchanged parent ID.
4. Reference the strength from a disabled pilot CA policy in separate state.
   Attempt to add a restricted method, replace restrictions and remove the last
   restriction: confirm each plan refuses before any setter or child deletion,
   for references returned in both `mfa` and `none`. Confirm metadata-only/no-op
   plans still work and the original restrictions remain intact. Detach, repeat
   the changes successfully, verify them, then reattach for the deletion probe.
   Attempt full strength destroy: confirm Graph refuses policy deletion, the
   error reaches Terraform, state retains the removal action, and independent
   reads prove all restrictions remain intact. Record the actual status/message.
5. Detach/delete the pilot CA reference and retry destroy. Verify policy absence,
   cascade/child DELETE 404 handling, no unrelated policy deleted, and complete
   state cleanup. Repeat a shared-state dependency teardown. Record sanitized
   evidence and update the catalog confidence after owner review.

Pinned contract provenance is in `tests/fixtures/auth-strength-contracts`;
behavior entries are GB-conditional-access-570 through 574. Docker matrix,
review and licensed-tenant acceptance remain orchestrator/owner steps.

An independent read after writers checks custom identity and the desired
combination set, normalizing whitespace around comma-separated flags. It fails
closed on mismatch, including drift hidden by the action's ignored body. First
distinguish replication from a real out-of-band change. After reviewing confirmed
combination drift, the single supported targeted recovery is replacing the
idempotent `module.strength.msgraph_resource_action.combinations` setter with
`terraform apply -replace=module.strength.msgraph_resource_action.combinations`.
Never target/replace the policy POST or ownership/deletion helpers. This recovery
retains the policy ID; read back and require a clean plan afterwards.

<!-- drift:start -->
## Drift and out-of-band changes

Terraform plans compare configuration and refreshed provider state. A plan that changes one of these inputs proposes its declared effect; review the plan before applying. The consumer guide explains refresh limits and emergency reconciliation.

- `displayName`: kept from creation in `msgraph_resource_action.policy`; updates `msgraph_update_resource.metadata` in place.
- `name_pattern`: no object change (validation or timing only).
- `detached_maintenance`: no object change (validation or timing only).
- `description`: kept from creation in `msgraph_resource_action.policy`; updates `msgraph_update_resource.metadata` in place.
- `allowedCombinations`: replaces `msgraph_resource_action.combinations` when its effect on `local.combinations` changes; ignored in `msgraph_resource_action.policy`.
- `allowedAAGUIDs`: replaces `msgraph_resource.configuration` when `each.value` changes; creates or deletes `msgraph_resource.configuration` instances.
- `x509CertificateCombinationConfigurations`: replaces `msgraph_resource.configuration` when `each.value` changes; creates or deletes `msgraph_resource.configuration` instances.
- `licence_check`: changes `module.licence_guard`; see the module notes.
<!-- drift:end -->
