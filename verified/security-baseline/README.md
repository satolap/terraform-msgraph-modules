# Security baseline

Modules supporting a Microsoft Entra tenant security baseline. The guard modules only read
directory configuration. The `authorization-policy` module updates the existing tenant
authorization policy. The admin consent workflow module writes one tenant setting, the
admin consent request policy, and earns a Secure Score improvement only where Microsoft
shows that action for the tenant; `authentication-methods` updates the existing
authentication methods policy singletons. `conditional-access-p1` creates and deletes four
Conditional Access policies and changes the security defaults setting; the others create or
delete no tenant objects. Each
module lives in its own folder,
`security-baseline/<module>`; a submodule lives under its module, for example
`emergency-access-guard/verify`. This folder groups the modules and is not a module
itself.

Use a non-production tenant for live acceptance first. The family name is conceptual; Graph
properties such as `excludeUsers` and `onPremisesSyncEnabled` retain their original names.
The existing family inputs remain compatible with the recorded baseline design.

## Modules

| Module | Tiers | Purpose | Status |
| --- | --- | --- | --- |
| [licence-guard](licence-guard/README.md) | shared | Plan-time licence check used by the other modules | available |
| [conditional-access-p1](conditional-access-p1/README.md) | `p1`, `p2` | Four Conditional Access policies that replace security defaults: MFA for administrators, block legacy authentication, MFA for all users, MFA for Azure management; report-only by default, with a decommission that restores security defaults | available |
| [emergency-access-guard](emergency-access-guard/README.md) | `free`, `p1`, `p2` | Read-only checks of the break-glass accounts, and a [`verify`](emergency-access-guard/verify/README.md) submodule that reads the baseline policies back | available |
| [authorization-policy](authorization-policy/README.md) | `free`, `p1`, `p2` | Free-tier tenant authorization policy settings: user consent policy, guest invitations and access level, optional app and tenant creation; restores the pre-apply values | available |
| [admin-consent-workflow](admin-consent-workflow/README.md) | `free`, `p1`, `p2` | Admin consent request policy with reviewers, snapshot and restore | available |
| [authentication-methods](authentication-methods/README.md) | `free`, `p1`, `p2` | Authentication methods policy: Authenticator, passkeys, registration campaign, optional SMS and voice restriction; updates existing singletons | available |

## Recorded baseline choices

1. **Tiers.** `free` keeps security defaults on and applies only tenant singleton
   settings. `p1` (Microsoft Entra ID P1, for example Microsoft 365 E3) adds the
   Conditional Access baseline. `p2` (Microsoft Entra ID P2, for example Microsoft 365 E5)
   adds risk policies and Privileged Identity Management.
2. **Guard mode.** Guard is the default: `tier` is an explicit, required input. A sticky
   `tier = "auto"` that resolves once from licences stays optional; it is not the default,
   and the current modules do not offer it. For `p1` and `p2`, a precondition fails the plan
   when the tenant has no usable subscription for the tier. Licence data never switches
   resources on or off: no `count` or `for_each` depends on it.
3. **Non-Enabled SKUs fail.** A SKU whose `capabilityStatus` is `Warning`, `Suspended`,
   `Deleted` or `LockedOut` does not satisfy the guard, and the error names the
   `skuPartNumber` and the state.
The following policy-writing choices are implemented by `conditional-access-p1`; the guards do not implement them.

4. **Report-only by default.** Conditional Access policies start as
   `enabledForReportingButNotEnforced`; enforcement is an explicit input.
5. **Security defaults.** The `p1` baseline turns security defaults off only after its
   replacement policies exist, and its removal restores the previous state.
6. **Reference baseline.** Microsoft Secure Score recommended actions are the primary
   reference, with titles and IDs read from `secureScoreControlProfiles` in a test tenant.
   CIS Microsoft 365 Foundations Benchmark and CISA SCuBA control IDs are secondary.

## Shared interface

Modules in this family use the same input names and types, so the outputs of one feed the
inputs of another without conversion.

| Input | Type | Default | Rule |
| --- | --- | --- | --- |
| `tier` | `string` | required | `free`, `p1` or `p2`. A module that supports fewer tiers rejects the others in its own validation and passes the same list to the licence guard's `allowed_tiers`. |
| `break_glass_user_ids` | `set(string)` | required | Object IDs of existing emergency access users. At least one, each a lowercase GUID as Microsoft Graph returns it. A group alone is not enough, because its membership can change outside Terraform. |
| `break_glass_group_ids` | `set(string)` | `[]` | Object IDs of emergency access security groups, each a lowercase GUID. |

- Both ID inputs are sets: order carries no meaning and duplicates collapse. The emergency
  access guard's user-only snapshots feed policy exclusions; discovery-group IDs are never
  forwarded as Conditional Access exclusions.
- Validate each ID with
  `can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", id))`.
  Lowercase input compares exactly with the IDs that modules read back from Microsoft
  Graph, so no module has to normalise case.
- A module that needs a licence calls `../licence-guard` with its `tier` and
  `allowed_tiers`, and uses the guard's `tier` output downstream so that dependent
  resources wait for the check. The guard fails every plan once the licence lapses; a
  module that must still apply afterwards, for example to remove its objects, handles that
  case explicitly and documents it.
- Objects that a module creates get display names with a prefix the caller can change. The
  default prefix is neutral, for example `Security baseline - `, and names no tool or
  project.
- No module creates, changes or deletes the emergency access accounts.
