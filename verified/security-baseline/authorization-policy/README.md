# authorization-policy

<!-- uses-beta:start -->
Uses beta: **no**. This module and its local child modules do not select beta.
<!-- uses-beta:end -->

<!-- live-status:start -->
Assurance: **verified offline-only**. No current live acceptance is recorded for this module.

![live: offline only](https://img.shields.io/badge/live-offline%20only-lightgrey)
<!-- live-status:end -->

Free-tier tenant settings of the [security baseline](../README.md), applied to the tenant
[authorizationPolicy](https://learn.microsoft.com/en-us/graph/api/resources/authorizationpolicy?view=graph-rest-1.0)
singleton:

- **User consent:** limited to one app consent policy. The default, `microsoft-user-default-low`,
  allows delegated permissions classified low for apps from verified publishers or registered in
  this tenant.
- **Guests:** who can invite guests (`allowInvitesFrom`) and the guest user access level
  (`guestUserRoleId`).
- **Optional:** whether member users can register applications or create tenants.

The policy always exists, so the module creates and deletes nothing. It reads the policy, PATCHes
only the properties it manages through `msgraph_update_resource`, and can PATCH back the values
that it captured before its first apply. It does not touch security defaults, Conditional Access,
role assignments, cross-tenant access settings or access reviews.

## Usage

Install a release using the [Terraform Registry instructions](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry); replace `<version>` with that release version.

```hcl
module "authorization_policy" {
  source  = "satolap/modules/msgraph//verified/security-baseline/authorization-policy"
  version = "<version>"

  tier = "free"

  # Defaults: microsoft-user-default-low, adminsAndGuestInviters, restricted guest access.
  # Leave the two optional inputs null to keep the tenant's current values.
  allow_users_to_create_apps    = null
  allow_users_to_create_tenants = null
}
```

Review the `planned_changes` output before you apply: it lists each property, the current tenant
value and the target value, as JSON text. There is no report-only mode for this resource; every
change takes effect on apply.

Enable the admin consent request workflow before restricting user consent, or in the same apply,
so that users have a way to request the apps they can no longer consent to. Use `depends_on` on
this module call to order the two.

## What the module sends

The PATCH body holds only these properties, and `allowUserConsentForRiskyApps` is always `false`:

| Property | Input |
| --- | --- |
| `allowInvitesFrom` | `allow_invites_from` |
| `guestUserRoleId` | `guest_access`: `restricted` is Restricted Guest User, `limited` is Guest User |
| `allowUserConsentForRiskyApps` | always `false`, Microsoft's recommendation |
| `defaultUserRolePermissions.permissionGrantPoliciesAssigned` | `user_consent_policy_id` |
| `defaultUserRolePermissions.allowedToCreateApps` | `allow_users_to_create_apps`, only when not null |
| `defaultUserRolePermissions.allowedToCreateTenants` | `allow_users_to_create_tenants`, only when not null |

It never sends any other property. In particular it never sends
`defaultUserRolePermissions.allowedToReadOtherUsers` (Microsoft Learn: do not set it to `false`),
`blockMsolPowerShell`, `allowedToUseSSPR`, `allowEmailVerifiedUsersToJoinOrganization` or
`allowedToSignUpEmailBasedSubscriptions`.

**Consent entries.** The module replaces only the `managePermissionGrantsForSelf.*` entries of
`permissionGrantPoliciesAssigned`. Every other entry, such as
`ManagePermissionGrantsForOwnedResource.DeveloperConsent`, is kept. The entry for the chosen
policy is appended after them, unless the tenant already holds it in any casing: that entry keeps
its spelling and position, so the second plan has nothing to change. A response without the
consent list fails the plan, because a missing list must not read as empty: the PATCH would then
delete every owned-resource entry. An empty list is a real value and is accepted. The prefix is
matched without regard to case, because the Learn GET example returns
`ManagePermissionGrantsForSelf.*` while its PATCH examples send `managePermissionGrantsForSelf.*`.
`user_consent_policy_id = null` removes the self entries and so disables user consent.

**Consent policy ID.** Pass the bare ID, without the prefix. The module rejects
`microsoft-user-default-legacy`, which lets users consent to any permission that does not need
admin consent, for any app. `microsoft-user-default-recommended`, a Microsoft-managed policy,
is allowed. The plan fails unless the tenant's permission grant policies list the ID; the module
lists `GET /policies/permissionGrantPolicies` and matches the ID, so a missing policy fails with a
message that names it, not with a 404.

## Permissions

| Identity | Needs |
| --- | --- |
| Apply | `Policy.ReadWrite.Authorization` and `Policy.Read.PermissionGrant` |
| Plan only | `Policy.Read.All` and `Policy.Read.PermissionGrant` |

`Policy.ReadWrite.Authorization` lets its holder change the tenant consent policy, so grant it
only to the identity that applies this module, and only in a tenant where you intend that. For
delegated calls the signed-in user needs a supported Microsoft Entra role; Privileged Role
Administrator is the least privileged role for
[Update authorizationPolicy](https://learn.microsoft.com/en-us/graph/api/authorizationpolicy-update?view=graph-rest-1.0).
Updating returns `204 No Content`. With `tier = "free"` the module reads no `subscribedSkus` and
needs no `LicenseAssignment.Read.All`; with `p1` or `p2` the shared
[licence guard](../licence-guard/README.md) needs it.

## User impact

- **`user_consent_policy_id`.** Users can consent only as the chosen policy allows. With the
  default, delegated permissions classified low are allowed for verified-publisher apps and
  apps registered in the tenant; every other request needs an administrator. The classification
  that `microsoft-user-default-low` relies on is the set of permissions an administrator has
  [classified as low impact](https://learn.microsoft.com/en-us/entra/identity/enterprise-apps/configure-permission-classifications)
  in the tenant; review those classifications before you apply. With `null`, users cannot
  consent at all.
  **Changing this setting does not revoke consent that users have already granted.**
- **`allow_invites_from`.** `none` also stops administrators from inviting guests.
- **`guest_access`.** Changes can take up to 15 minutes to take effect.
  `restricted` is not supported in Forms, Project Online, Viva Engage and Planner in
  SharePoint; guests in those workloads can lose access. See
  [Restrict guest access](https://learn.microsoft.com/en-us/entra/identity/users/users-restrict-guest-permissions).
- **`allow_users_to_create_apps = false`.** Users cannot register applications; the Application
  Developer role grants the ability back.
- **`allow_users_to_create_tenants = false`.** Only users with the Tenant Creator role can
  create tenants.

Break-glass accounts do not apply to this module: the policy has no user or group targeting and
does not control sign-in, and the module changes no role assignments.

## Snapshot, restore and removal

On the first apply a `terraform_data` snapshot stores the six managed properties read from
`GET /policies/authorizationPolicy`. It uses `ignore_changes`, so later plans keep the original
values. The `prior_values` output shows them. **If the tenant already carries baseline values
when the snapshot is taken, for example after lost state, the snapshot captures those.**

Removal takes two steps:

1. Apply with `restore_prior_values = true`. This PATCHes the snapshot back for every property
   whose snapshot value was not null. Properties that were null in the snapshot are **not
   restored** (the GET example returns `allowUserConsentForRiskyApps: null`, which the module
   cannot send back).
2. Run `terraform destroy`. This removes state and sends no Graph request.

**A plain `terraform destroy` leaves the baseline settings in the tenant.** The provider
documentation and source for `msgraph_update_resource` say that deleting it sends no request;
this is **unverified for provider 0.6.x** at run time, so confirm with a live destroy. A
destroy-time `local-exec` hook is deliberately not used. If destroy alone must restore the
settings, that needs a provider-native mechanism.

A restore touches only what the module manages. The consent list becomes the current non-self
entries plus the snapshot's self entries, so an owned-resource entry added in the meantime is
kept. An optional property (`allowedToCreateApps`, `allowedToCreateTenants`) is restored and
checked only when its input is set. A restore fails when a property it restores holds neither
the value that the current inputs would apply nor the snapshot value: someone changed it after
the apply, or the inputs changed. **Keep the inputs unchanged while restoring**; only
`restore_prior_values` should change. Review the tenant, or set `restore_over_changes = true` to
restore the snapshot over those changes.

A snapshot value is the one read before the first apply. If you set an optional input later, a
restore writes back that first-apply value, which can differ from the tenant's value when you
set the input.

**Plan-to-apply window.** The tenant is read at plan time and the PATCH is sent at apply. A
change made in between is not detected, and the consent list sent is the one read at plan
time. Apply a saved plan promptly.

## Secure Score actions addressed

| Action (title as on Microsoft Learn) | Module setting | Status |
| --- | --- | --- |
| Do not allow users to grant consent to unreliable applications | `user_consent_policy_id` | Unverified: whether `microsoft-user-default-low` earns full points, or only `null` does |
| Ensure third party integrated applications aren't allowed. | `allow_users_to_create_apps = false` | Unverified mapping; not addressed with default inputs |

The cited pages show no Secure Score action for guest invites, guest access or tenant creation;
those settings are baseline hygiene. "Ensure the admin consent workflow is enabled." belongs to
the admin consent request module. Control IDs are read from `secureScoreControlProfiles` in a
test tenant, and CIS Microsoft 365 Foundations and CISA SCuBA references are not verified here.

## Limits

- Offline mocked tests cover the module; it has not run against a tenant. Live acceptance is
  tracked separately.
- **Unverified, and a gate for live use: partial nested PATCH.** The update page says omitted
  properties keep their values, and the Learn examples send partial `defaultUserRolePermissions`
  objects, but neither states the nested behaviour. Until a live run shows that the unmanaged
  `defaultUserRolePermissions` sub-fields (for example `allowedToReadOtherUsers`) are unchanged
  after an apply, do not apply this module outside a disposable tenant.
- **Unverified: a second plan after apply is a no-op.** It depends on the casing and order that
  Graph returns for the consent entries. The module compares consent entries without regard to
  case when it checks a restore, but `msgraph_update_resource` compares the body it sent.
- **Unverified: null prior values.** Whether `msgraph_update_resource` can send JSON `null` is
  open, so a restore omits null properties.
- The singleton is read at plan time and `msgraph_update_resource` is not replaced: the
  module needs no import or adoption. Use the v1.0 path `/policies/authorizationPolicy`, not the
  `/policies/authorizationPolicy/authorizationPolicy` form shown in some Learn how-to pages.
- Whether provider 0.6.x follows collection next links is unverified here (source inspection
  only), and real HTTP pagination is not proved by the mock suite. The consent policy list fails closed on a missing paging export or a
  remaining next link.
- Another configuration that also updates `authorizationPolicy` can fight with this one.
  Only one configuration per tenant should own these properties.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

Before deployment, check the requirements of the features you enable and the users who benefit. You can inspect tenant subscriptions with `GET /subscribedSkus`; this requires `Organization.Read.All` or `LicenseAssignment.Read.All` ([List subscribedSkus](https://learn.microsoft.com/en-us/graph/api/subscribedsku-list?view=graph-rest-1.0)).

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | AUTHORIZATION-POLICY | The reviewed pages list no license requirement for the user consent, guest access and default user permission settings of the tenant authorization policy: restricted guest access states no new licensing requirements, and the consent pages list roles only. The module reads and updates only the authorizationPolicy singleton and the app consent policy list. No additional license specified. | No per-user entitlement; Privileged Role Administrator is the least privileged role for delegated updates | direct / per_tenant | inferred |

Notes:

- The module requires no service plan: with tier free it reads no subscribedSkus and needs no license permission. The tier input only states the baseline's tier; p1 and p2 run the shared licence guard and change no setting.
- The module changes the tenant authorizationPolicy singleton. Restricted guest access is not supported in Forms, Project Online, Viva Engage and Planner in SharePoint; check those workloads before setting guest_access = restricted.

Sources: [Restrict guest access permissions](https://learn.microsoft.com/en-us/entra/identity/users/users-restrict-guest-permissions), [Configure user consent](https://learn.microsoft.com/en-us/entra/identity/enterprise-apps/configure-user-consent), [Manage app consent policies](https://learn.microsoft.com/en-us/entra/identity/enterprise-apps/manage-app-consent-policies), [Update authorizationPolicy](https://learn.microsoft.com/en-us/graph/api/authorizationpolicy-update?view=graph-rest-1.0).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required | On change |
|------|-------------|------|---------|----------| --- |
| tier | `free`, `p1` or `p2`; `free` plans no licence read, the tier changes no setting | `string` | n/a | yes | changes `module.licence_guard`; see the module notes |
| user_consent_policy_id | Bare ID of the one app consent policy; `null` disables user consent; the legacy policy is rejected | `string` | `"microsoft-user-default-low"` | no | in place |
| allow_invites_from | `none`, `adminsAndGuestInviters`, `adminsGuestInvitersAndAllMembers` or `everyone` | `string` | `"adminsAndGuestInviters"` | no | in place |
| guest_access | `restricted` or `limited` | `string` | `"restricted"` | no | in place |
| allow_users_to_create_apps | Whether users can register applications; `null` leaves it unchanged | `bool` | `null` | no | in place |
| allow_users_to_create_tenants | Whether non-admin users can create tenants; `null` leaves it unchanged | `bool` | `null` | no | in place |
| restore_prior_values | PATCH the snapshot back; step 1 of removal | `bool` | `false` | no | in place |
| restore_over_changes | Restore even over values changed after the apply | `bool` | `false` | no | no object change (validation or timing only) |

## Outputs

| Name | Description | Known in plan after an update |
|------|-------------| --- |
| prior_values | The snapshot captured before the first apply, keyed by Graph property path | no |
| target_values | The values the module sets: the baseline, or the snapshot when restoring | no |
| planned_changes | Each property whose current value differs from the target: `property`, `current`, `target` as JSON text | no |
| tier | The tier once the licence guard passed and the policy update is done | no |

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.11.0 |
| msgraph | >= 0.6.0, < 0.7.0 |

<!-- drift:start -->
## Drift and out-of-band changes

Terraform plans compare configuration and refreshed provider state. A plan that changes one of these inputs proposes its declared effect; review the plan before applying. The consumer guide explains refresh limits and emergency reconciliation.

- `tier`: changes `module.licence_guard`; see the module notes.
- `user_consent_policy_id`: in place.
- `allow_invites_from`: in place.
- `guest_access`: in place.
- `allow_users_to_create_apps`: in place.
- `allow_users_to_create_tenants`: in place.
- `restore_prior_values`: in place.
- `restore_over_changes`: no object change (validation or timing only).
<!-- drift:end -->

<!-- permissions:begin -->
## Per-operation permissions

Source: [Graph DevX map](https://raw.githubusercontent.com/microsoftgraph/microsoft-graph-devx-content/56e1917fe45fb7c52c2d9845f569c2ffdb39e4d9/permissions/new/permissions.json) (SHA-256 `4d7dee52659b1d6424bce0b26603302081d39ef9e149bc5fb50de4273b3d3514`).
The map is shared by v1.0 and beta; it does not certify API-version support. Rows show the source's least-privilege annotations, not live-tested consent. Choose an alternative for your authentication type; do not grant every listed scope. AlsoRequires lists additional scope alternatives attached to that row. Missing annotations are unknown, not evidence that an operation needs no permission. Keep the module's documented role, property-specific and tenant restrictions.

Derived from this module's Terraform sources, including optional guards, destroy actions and local child modules. The checked inventory is `docs/permissions/verified-operations.json`. These are potential requests, not a preflight scope list. A provider primitive may expose an update that Graph does not support. Source paths and conditions are retained in the inventory.

| Operation | Authentication | Least-privilege alternative | AlsoRequires | Unknown reason |
| --- | --- | --- | --- | --- |
| `PATCH /policies/authorizationPolicy` | DelegatedWork | `Policy.ReadWrite.Authorization` | - | - |
| `PATCH /policies/authorizationPolicy` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `PATCH /policies/authorizationPolicy` | Application | `Policy.ReadWrite.Authorization` | - | - |
| `GET /policies/authorizationPolicy` | DelegatedWork | `Policy.Read.All` | - | - |
| `GET /policies/authorizationPolicy` | DelegatedWork | `Policy.ReadWrite.Authorization` | - | - |
| `GET /policies/authorizationPolicy` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /policies/authorizationPolicy` | Application | `Policy.Read.All` | - | - |
| `GET /policies/authorizationPolicy` | Application | `Policy.ReadWrite.Authorization` | - | - |
| `GET /policies/permissionGrantPolicies` | DelegatedWork | `Policy.Read.PermissionGrant` | - | - |
| `GET /policies/permissionGrantPolicies` | DelegatedWork | `Policy.ReadWrite.PermissionGrant` | - | - |
| `GET /policies/permissionGrantPolicies` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /policies/permissionGrantPolicies` | Application | `Policy.Read.PermissionGrant` | - | - |
| `GET /policies/permissionGrantPolicies` | Application | `Policy.ReadWrite.PermissionGrant` | - | - |
| `GET /subscribedSkus` | DelegatedWork | `LicenseAssignment.Read.All` | - | - |
| `GET /subscribedSkus` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /subscribedSkus` | Application | `LicenseAssignment.Read.All` | - | - |

### Property-specific coverage

Route annotations do not establish that the listed scopes cover every selected or writable property. Dynamic bodies, additional properties and default responses remain unbounded. Keep the reviewed permission guidance above; in particular, a group-nesting scope is not general group-property access. The pin's method/path entries do not distinguish property grants from navigation or sub-resource operations; property coverage stays unknown.

| Operation | Properties | Source evidence |
| --- | --- | --- |
| `GET /policies/authorizationPolicy` | `allowInvitesFrom`, `allowUserConsentForRiskyApps`, `defaultUserRolePermissions`, `guestUserRoleId` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `GET /policies/permissionGrantPolicies` | `id` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `GET /subscribedSkus` | `capabilityStatus`, `prepaidUnits`, `servicePlans`, `skuId`, `skuPartNumber` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
<!-- permissions:end -->
