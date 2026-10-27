# authentication-methods

<!-- state-protection:start -->
## State and plan protection

This module's state and saved plans retain these declared values:

Sensitive outputs: `previous_state`.
Potential personal-data inputs: `phone_methods`, `phone_methods_group_id`.

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

Baseline for the tenant authentication methods policy of the
[security baseline](../README.md). After it runs, a new tenant offers strong methods and prompts
users to register them:

- Microsoft Authenticator and passkeys (FIDO2) are enabled for all users;
- a registration campaign runs, with the break-glass accounts excluded;
- SMS and voice are left untouched, or restricted to one group with `phone_methods = "restrict"`.

The module only updates objects that always exist, with `msgraph_update_resource` (`PATCH`).
It creates and deletes nothing, creates no accounts, groups or Conditional Access policies, and
does not change security defaults. Scope is deliberately **bounded** (a baseline): Microsoft
Authenticator, passkeys (FIDO2), SMS, voice and the registration campaign. Temporary Access
Pass, OATH, email OTP, certificate-based authentication, external methods, passkey profiles
beyond the default one, system-preferred MFA, report suspicious activity, `policyMigrationState`
writes, SSPR enablement and authentication strengths are out of scope.

## Usage

Install a release using the [Terraform Registry instructions](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry); replace `<version>` with that release version.

```hcl
module "authentication_methods" {
  source  = "satolap/modules/msgraph//verified/security-baseline/authentication-methods"
  version = "<version>"

  tier                 = "free"
  break_glass_user_ids = var.break_glass_user_ids # existing emergency access users
}
```

## Objects and permissions

| Operation | Endpoint | Least-privileged permission | Learn |
| --- | --- | --- | --- |
| Read policy, method configurations (expanded), `policyMigrationState` | `GET /policies/authenticationMethodsPolicy` | Policy.Read.AuthenticationMethod | [Get](https://learn.microsoft.com/graph/api/authenticationmethodspolicy-get?view=graph-rest-1.0) |
| Registration campaign (only `registrationEnforcement` is updatable) | `PATCH /policies/authenticationMethodsPolicy` (returns 200) | Policy.ReadWrite.AuthenticationMethod | [Update](https://learn.microsoft.com/graph/api/authenticationmethodspolicy-update?view=graph-rest-1.0) |
| Microsoft Authenticator | `PATCH .../authenticationMethodConfigurations/microsoftAuthenticator` (204) | Policy.ReadWrite.AuthenticationMethod | [Update](https://learn.microsoft.com/graph/api/microsoftauthenticatorauthenticationmethodconfiguration-update?view=graph-rest-1.0) |
| Passkeys (FIDO2) | `PATCH .../authenticationMethodConfigurations/fido2` (204) | Policy.ReadWrite.AuthenticationMethod | [Update](https://learn.microsoft.com/graph/api/fido2authenticationmethodconfiguration-update?view=graph-rest-1.0) |
| SMS (`phone_methods = "restrict"`, or a restore) | `PATCH .../authenticationMethodConfigurations/sms` | Policy.ReadWrite.AuthenticationMethod | [Update](https://learn.microsoft.com/graph/api/smsauthenticationmethodconfiguration-update?view=graph-rest-1.0) |
| Voice (`phone_methods = "restrict"`, or a restore) | `PATCH .../authenticationMethodConfigurations/voice` | Policy.ReadWrite.AuthenticationMethod | [Update](https://learn.microsoft.com/graph/api/voiceauthenticationmethodconfiguration-update?view=graph-rest-1.0) |
| Security defaults state (read only) | `GET /policies/identitySecurityDefaultsEnforcementPolicy` | Policy.Read.All | [Get](https://learn.microsoft.com/graph/api/identitysecuritydefaultsenforcementpolicy-get?view=graph-rest-1.0) |
| Licence guard (`p1` and `p2` only) | `GET /subscribedSkus` | LicenseAssignment.Read.All | [List](https://learn.microsoft.com/graph/api/subscribedsku-list?view=graph-rest-1.0) |

The permissions are application permissions; the delegated ones are the same. For updates, the
Authentication Policy Administrator role is the least privileged. The policy and method
configurations are singletons: the module never creates or deletes them. `DELETE` on a method
configuration reverts it to Microsoft's default configuration, not to the previous state; it is
a manual fallback only.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | AUTHN-METHODS-POLICY | No Microsoft Entra ID P1 or P2 licence is required for the settings the authentication methods baseline manages. Microsoft Authenticator (mobile app as a second factor) is included in every edition, passkeys (FIDO2) are available in all editions including Microsoft Entra ID Free, and the SMS and voice settings are free as settings (the second-factor methods themselves are included for Office 365, P1 and P2, and for Free with SMS limited to Global Administrators). A registration campaign states no licence requirement. Voice custom greeting and caller ID need P1 and are not managed. No additional license specified. | No per-user entitlement stated for the managed settings; Microsoft Authenticator, SMS and voice sign-in availability per edition follows the Microsoft Entra licensing table | direct / per_tenant | inferred |

Notes:

- The tier input is required and switches no setting: it only makes a composed baseline fail early and consistently, and p1 and p2 read subscribedSkus through the shared licence guard.
- The licensing table does not tick Admin control over verification methods in the Free - Security defaults column; whether this limits policy changes in a free tenant with security defaults on is unverified.
- The Intune passwordless page lists FIDO2 as needing Microsoft Entra ID P1, apparently for Conditional Access enforcement; the Microsoft Entra page is treated as authoritative.
- No licence requirement is stated for the registration campaign; an explicit statement is unverified. Updating the policy needs the Authentication Policy Administrator role.

Sources: [Microsoft Entra licensing, authentication](https://learn.microsoft.com/en-us/entra/fundamentals/licensing#authentication), [Enable passkeys (FIDO2)](https://learn.microsoft.com/en-us/entra/identity/authentication/how-to-authentication-passkeys-fido2), [Registration campaign](https://learn.microsoft.com/en-us/entra/identity/authentication/how-to-mfa-registration-campaign).
<!-- licensing:end -->

## Licence tier and guard

No setting this module manages needs Microsoft Entra ID P1; the minimum tier is `free`.

| Setting | Tier | Basis |
| --- | --- | --- |
| Microsoft Authenticator | free | "Mobile app as a second factor" is included in every edition ([Entra licensing](https://learn.microsoft.com/entra/fundamentals/licensing#authentication)) |
| App name and location in notifications | free | No licence requirement found (unverified) |
| Passkeys (FIDO2) | free | Available in all editions ([Enable passkeys](https://learn.microsoft.com/entra/identity/authentication/how-to-authentication-passkeys-fido2)) |
| Registration campaign | free | No licence requirement stated (explicit statement unverified) |
| SMS, voice | free (the setting) | Second-factor availability depends on the edition ([Entra licensing](https://learn.microsoft.com/entra/fundamentals/licensing#authentication)) |
| Voice custom greeting and caller ID | P1 | Not managed |

`tier` is required (`free`, `p1`, `p2`) with no default and no sticky `auto`. It switches no
setting. `free` plans no `GET /subscribedSkus`; `p1` and `p2` use the shared
[licence guard](../licence-guard/README.md), which passes only for a SKU with
`capabilityStatus` `Enabled` and enabled prepaid units that lists the plan (the plan IDs are
generated from the licensing registry) and names the SKU and its state otherwise. No `count` or
`for_each` depends on licence data. A `check` warns when `tier = "free"` and security defaults
are off, because the free tier assumes they stay on.

## Break-glass and safety

- `break_glass_user_ids` is required, at least one lowercase GUID. `break_glass_group_ids` is
  optional. Every user and group ID is added to the campaign `excludeTargets`
  (`targetType` `user` or `group`), and a precondition on the computed body confirms it, so
  break-glass accounts are never prompted or forced to register.
- Passkeys must reach the break-glass accounts: the plan fails when `fido2_include_group_id` is
  neither `all_users` nor a break-glass group, or when a break-glass group is in
  `fido2_exclude_group_ids` (excluded users are blocked from passkeys entirely, and passkeys are
  Microsoft's recommended method for emergency access accounts).
- While security defaults are on, `authenticator_include_group_id` must be `all_users`.
- The module never creates, changes or deletes accounts or groups.

## Enforcement inputs

The module follows a report-only principle: by default it only adds methods and a campaign users
can skip. Restrictive changes need explicit inputs: `campaign_require_after_snoozes = true`
(forces registration after the snoozes) and `phone_methods = "restrict"`.

### SMS and voice (`phone_methods`)

Owner decision, 2026-10-22: "Unmanaged or restrict".

1. `unmanaged` (default): `sms` and `voice` are not touched, so there is no lock-out risk.
2. `restrict`: both stay enabled only for `phone_methods_group_id`, with SMS
   `isUsableForSignIn = false` and voice `isOfficePhoneAllowed = false`. Users outside the group
   lose SMS and voice.

A `disable` option is not offered; it can be added later without breaking callers. `restrict`
is refused for `tier = "free"`. Restricting a method here does not stop users enabled in the
legacy MFA or SSPR policy unless `policyMigrationState` is `migrationComplete`; a `check` warns
otherwise ([How policies work together](https://learn.microsoft.com/entra/identity/authentication/concept-authentication-methods-manage#how-policies-work-together)).
Microsoft warns against restricting methods while security defaults are on.

### Existing settings are overwritten

The module sends complete `includeTargets` and `excludeTargets` collections for the campaign,
Authenticator and passkeys. Existing exclusions or a narrower include scope are replaced (for
example "all users" widens a pilot group). A `check` warns when the snapshot shows non-empty
exclusions or a non-`all_users` include on these objects; review `previous_state` before the
first apply. The campaign group must equal the method's include group, or the method must be
enabled for `all_users`, so that the campaign never targets users for a disabled method.
The campaign group guard does not apply while the `policy` object is restored; restore the
`policy` together with the method whose group the campaign targets. A `check` also warns when
`phone_methods` is `unmanaged` but SMS or voice no longer match their snapshot.
When `fido2_include_group_id` is a break-glass group, every `break_glass_user_ids` entry must
be a member of that group; the module cannot check membership.

## Rollback and destroy order

Destroying an `msgraph_update_resource` sends no request, so the settings stay as last applied
([provider docs](https://raw.githubusercontent.com/microsoft/terraform-provider-msgraph/v0.6.0/docs/resources/update_resource.md)).
On every first apply the module stores the prior writable properties of **all five** objects
(policy, Authenticator, passkeys, SMS, voice) in `terraform_data` snapshots with
`ignore_changes = [input]`, whatever `phone_methods` says, so an input change never destroys a
snapshot. Later plans keep the original values (output `previous_state`, sensitive). Read-only
properties (`id`, `displayName`, `description`, `lastModifiedDateTime`, `policyVersion`) and
unmanaged properties are not stored, and a restored method always carries its constant
`@odata.type`, not the one read.

`restore_previous_state` is a set of object keys (`policy`, `microsoftAuthenticator`, `fido2`,
`sms`, `voice`). Listed objects are PATCHed with their snapshot instead of the baseline, also
SMS and voice when `phone_methods` is `unmanaged`. For example, to go from `restrict` back to
`unmanaged`: set `phone_methods = "unmanaged"` and `restore_previous_state = ["sms", "voice"]`,
apply, verify, then clear the set.

1. Apply with every object in `restore_previous_state`: every PATCH body equals its snapshot.
2. Verify by an independent `GET /policies/authenticationMethodsPolicy` read-back.
3. Destroy.

How collections are restored depends on the PATCH semantics of `includeTargets` and
`excludeTargets` (replace or merge), which is unproven (limitation 3).

## Secure Score

The module has no direct Secure Score toggle. It **supports** "Ensure all users can complete
multifactor authentication for secure access" (security defaults already award full points; the
campaign only prompts users who already complete MFA, so no direct score change is expected) and
**addresses** the recommendation "Migrate to Microsoft Authenticator" (`useAuthenticatorApp`,
not scored). "Enable self-service password reset" is not addressed. Control profile IDs are read
from `secureScoreControlProfiles` in the test tenant during live acceptance.

## Inputs

| Name | Description | Type | Default | Required | On change |
|------|-------------|------|---------|----------| --- |
| tier | `free`, `p1` or `p2` | `string` | n/a | yes | changes `module.licence_guard`; see the module notes |
| break_glass_user_ids | Existing emergency access users, at least one, lowercase GUIDs | `set(string)` | n/a | yes | in place |
| break_glass_group_ids | Emergency access groups, lowercase GUIDs | `set(string)` | `[]` | no | in place |
| authenticator_include_group_id | `all_users` or a group ID | `string` | `"all_users"` | no | in place |
| authenticator_mode | `any` or `push` (`deviceBasedPush` refused) | `string` | `"any"` | no | in place |
| authenticator_show_app_name | `enabled`, `disabled` or `default` | `string` | `"enabled"` | no | in place |
| authenticator_show_location | `enabled`, `disabled` or `default` | `string` | `"enabled"` | no | in place |
| fido2_include_group_id | `all_users` or a break-glass group | `string` | `"all_users"` | no | in place |
| fido2_exclude_group_ids | Groups excluded from passkeys; never a break-glass group | `set(string)` | `[]` | no | in place |
| fido2_self_service_registration | Allow self-service passkey registration | `bool` | `true` | no | in place |
| campaign_state | `enabled`, `disabled` or `default` | `string` | `"enabled"` | no | in place |
| campaign_method | `microsoftAuthenticator` or `fido2` | `string` | `"microsoftAuthenticator"` | no | in place |
| campaign_include_group_id | `all_users` or a group ID | `string` | `"all_users"` | no | in place |
| campaign_snooze_days | 0 to 14 | `number` | `1` | no | in place |
| campaign_require_after_snoozes | Force registration after the snoozes | `bool` | `false` | no | in place |
| phone_methods | `unmanaged` or `restrict` | `string` | `"unmanaged"` | no | creates or deletes `msgraph_update_resource.object` instances; not replaced or moved: the update targets the existing object; recreate it to move it |
| phone_methods_group_id | Group that keeps SMS and voice for `restrict` | `string` | `null` | no | in place |
| restore_previous_state | Objects whose snapshot is sent back instead of the baseline | `set(string)` | `[]` | no | creates or deletes `msgraph_update_resource.object` instances; not replaced or moved: the update targets the existing object; recreate it to move it |

## Outputs

| Name | Description | Known in plan after an update |
|------|-------------| --- |
| tier | The tier, once the licence guard and the plan-time checks passed | no |
| managed_urls | Item URLs the module PATCHes, by object | yes |
| previous_state | Sensitive snapshot of the prior writable properties of all five objects | no |
| policy_migration_state | `policyMigrationState` as read at plan time (never written) | no |

## Limitations and unverified items

Only offline mocked tests cover the module; live acceptance (read-back, no-change plan, Secure
Score delta, restore) is tracked in issue #93. The Terraform test framework cannot expect a
failure of the shared licence guard's output, so the guard's licence failures (no premium SKU,
P1 only for `p2`, `Suspended` or `Warning` SKUs) are tested in
[licence-guard](../licence-guard/README.md); this module's tests prove it passes the guard.

1. `enforceRegistrationAfterAllowedSnoozes` is in the registration campaign how-to and the v1.0
   GET example, but not in the v1.0 resource table. The module always sends it.
2. `targetedAuthenticationMethod` casing: the resource page says `Fido2`, the how-to `fido2`.
   The module sends `microsoftAuthenticator` or `fido2`.
3. Whether a PATCH of `includeTargets` or `excludeTargets` replaces or merges the collection.
   The module sends full collections.
4. Whether FIDO2 `includeTargets` without `allowedPasskeyProfiles` is accepted when passkey
   profiles are not enabled. The module sends `[]`, as in the GET example.
5. `policyMigrationState` is read only; the update table lists only `registrationEnforcement`.
6. Authenticator properties seen in the v1.0 GET example but not the resource tables
   (`isSoftwareOathEnabled`, `numberMatchingRequiredState`, `companionAppAllowedState`) are not
   managed. Deprecated FIDO2 `isAttestationEnforced` and `keyRestrictions` are not set.
7. Method configuration ids are returned with a leading capital (for example `Fido2`); the
   module compares them case-insensitively.
8. Whether a partial `featureSettings` PATCH (only the two display states) leaves the other
   Authenticator feature settings unchanged, and whether restoring only those two is faithful.
9. Passkey profiles: whether FIDO2 `includeTargets` need `allowedPasskeyProfiles` in tenants that
   enabled passkey profiles; the module neither reads nor restores profiles.
