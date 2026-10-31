# entitlementManagement/settings

<!-- uses-beta:start -->
Uses beta: **no**. This module and its local child modules do not select beta.
<!-- uses-beta:end -->

<!-- live-status:start -->
Assurance: **verified offline-only**. No current live acceptance is recorded for this module.

![live: not yet run](https://img.shields.io/badge/live-not%20yet%20run-lightgrey)
<!-- live-status:end -->

Manages the tenant-wide
[`entitlementManagementSettings`](https://learn.microsoft.com/en-us/graph/api/resources/entitlementmanagementsettings?view=graph-rest-1.0)
singleton of Microsoft Entra entitlement management: what the service does to an external user
(guest) when their last access package assignment is removed. The module adopts the existing
singleton and updates only the settings you name. It creates nothing and **never deletes
anything**: Microsoft documents a
[PATCH](https://learn.microsoft.com/en-us/graph/api/entitlementmanagementsettings-update?view=graph-rest-1.0)
for the object and no delete, and the module has no resource that could send one.

This is the first module under the Graph-cased `identityGovernance/entitlementManagement` path
(#247). The older entitlement modules keep their published `identity-governance/...` paths until
the path migration (#119) moves them.

The catalog creators setting is not part of this resource. Microsoft assigns it through the
entitlement management role assignments, see the
[role assignments module](../../../roleManagement/entitlementManagement/roleAssignments/README.md).

## Usage

Install a release using the [Terraform Registry instructions](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry); replace `<version>` with that release version.

```hcl
module "entitlement_management_settings" {
  source  = "satolap/modules/msgraph//verified/identityGovernance/entitlementManagement/settings"
  version = "<version>"

  # Block guests when their last assignment ends, keep the account.
  externalUserLifecycleAction = "blockSignIn"
}
```

Deleting guests is a separate, explicit decision:

```hcl
module "entitlement_management_settings" {
  source  = "satolap/modules/msgraph//verified/identityGovernance/entitlementManagement/settings"
  version = "<version>"

  externalUserLifecycleAction                  = "blockSignInAndDelete"
  durationUntilExternalUserDeletedAfterBlocked = "P30D"
  allow_external_user_deletion                 = true
}
```

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

Before deployment, check the requirements of the features you enable and the users who benefit. You can inspect tenant subscriptions with `GET /subscribedSkus`; this requires `Organization.Read.All` or `LicenseAssignment.Read.All` ([List subscribedSkus](https://learn.microsoft.com/en-us/graph/api/subscribedsku-list?view=graph-rest-1.0)).

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | EM-CORE | Catalogs, access packages with group, application and SharePoint resources, standard approval stages, requestor questions and expiration are included in Microsoft Entra ID P2, Microsoft Entra ID Governance and Microsoft Entra Suite. Evaluate the exact feature combination; not every accepted policy option is core. Any of: Microsoft Entra ID P2 (`AAD_PREMIUM_P2`); Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Every user who can request or receive an access package assignment, including everyone covered by an all-member policy scope; guest scenarios can involve billing | direct / per_user | documented |

Notes:

- Microsoft Learn states no license requirement for the entitlement management settings object itself, so the EM-CORE rule of the entitlement management deployment is applied by inference. The setting acts on every external user in the tenant when their last access package assignment is removed; deleting guests may interact with the Microsoft Entra ID Governance guest billing rules, which is unverified. See [Update entitlementManagementSettings](https://learn.microsoft.com/en-us/graph/api/entitlementmanagementsettings-update?view=graph-rest-1.0).

Sources: [Entitlement management license requirements](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-overview#license-requirements), [Microsoft Entra features by license](https://learn.microsoft.com/en-us/entra/fundamentals/licensing#features-by-license).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required | On change |
|------|-------------|------|---------|----------| --- |
| externalUserLifecycleAction | `externalUserLifecycleAction`: `none`, `blockSignIn` or `blockSignInAndDelete`. Null leaves it unmanaged | `string` | `null` | no | in place |
| durationUntilExternalUserDeletedAfterBlocked | `durationUntilExternalUserDeletedAfterBlocked`, whole days as an ISO 8601 duration such as `P30D`, no leading zeros; only with `blockSignInAndDelete`. Null leaves it unmanaged | `string` | `null` | no | in place |
| allow_external_user_deletion | Required `true` to apply `blockSignInAndDelete`, and to restore a snapshot that holds it; changes nothing else | `bool` | `false` | no | no object change (validation or timing only) |
| restore_previous_state | PATCH the owned settings back to the values captured at the first apply | `bool` | `false` | no | in place |
| restore_over_changes | Let a restore overwrite a value that someone changed since the module last wrote it | `bool` | `false` | no | no object change (validation or timing only) |

At least one of the two settings must be set. `unknownFutureValue` is not accepted.

## Outputs

| Name | Description | Known in plan after an update |
|------|-------------| --- |
| settings | The settings as read back after the apply | no |
| previous_state | Both settings as read before the module first wrote them | no |
| owned_properties | The Graph property names the module owns (inputs that are not null) | yes |
| drifted_properties | Owned properties whose value at plan time differs from the input, compared exactly like the provider; empty means no change unless the service returns another spelling of the enum | no |

## Contract

| Graph property | Type | Writable | Module input |
| --- | --- | --- | --- |
| `externalUserLifecycleAction` | `accessPackageExternalUserLifecycleAction`: `none`, `blockSignIn`, `blockSignInAndDelete`, `unknownFutureValue` | yes | `external_user_lifecycle_action` |
| `durationUntilExternalUserDeletedAfterBlocked` | Duration | yes; documented for `blockSignInAndDelete` | `duration_until_external_user_deleted_after_blocked` |
| `id` | String, a constant | no, read-only | none; never sent |

- The update returns `204 No Content` and accepts "one or more" properties, so the module sends a
  partial `PATCH` of only the owned properties.
- **Omission, null, empty and false.** An input left null is omitted from the request, the
  snapshot restore and the drift comparison; the tenant value stays as it is. An empty string is
  rejected by validation, never sent. There is no boolean property. Whether the service accepts a
  JSON `null` for the duration, or returns it as `null` when it is unset, is unverified, so the
  module neither sends nor relies on `null` and cannot clear the duration.
- **Enum casing.** The reference lists `none`; its Update example sends `"None"`. The module sends
  the listed lowerCamel values and compares tenant values to the inputs exactly, as the provider
  does. If the service returns another spelling than the input, `drifted_properties` and the
  plan show an update on every run; set the input to the spelling that the service returns (runbook
  step 3 records it). Unverified until a live read-back.
- **Strict read.** The read fails the plan when the tenant holds an `externalUserLifecycleAction`
  other than the three documented values, for example a future enum member, so that nothing is
  snapshotted or written blind. That also blocks a restore and a refresh-based destroy until
  the module is updated for the new value.
- **Unverified.** The permitted range and the portal default of the duration, and whether
  the service rejects a duration while the action is not `blockSignInAndDelete`.

## Graph requests and permissions

| Operation | Permission (application and delegated) | Delegated roles |
| --- | --- | --- |
| [`GET /identityGovernance/entitlementManagement/settings`](https://learn.microsoft.com/en-us/graph/api/entitlementmanagementsettings-get?view=graph-rest-1.0) | `EntitlementManagement.Read.All`; `EntitlementManagement.ReadWrite.All` also covers it | Identity Governance Administrator is the documented least privileged Microsoft Entra role |
| [`PATCH /identityGovernance/entitlementManagement/settings`](https://learn.microsoft.com/en-us/graph/api/entitlementmanagementsettings-update?view=graph-rest-1.0) | `EntitlementManagement.ReadWrite.All` (no higher permission is listed) | Identity Governance Administrator |

- Microsoft documents the Update for the global cloud and the US Government L4, US Government L5
  (DOD) and China operated by 21Vianet national clouds.
- App-only callers can hold the Identity Governance Administrator role instead of the application
  permission, which is the less privileged option for the update. The Get page does not state
  that for reads; whether a read-only role suffices is unverified.
- The module uses `v1.0` only.

## Ownership and concurrent management

- **Owned settings.** Exactly the settings whose input is not null, listed in `owned_properties`.
  Everything else is preserved: it is never in a request body, a restore or the drift output.
- **One manager per setting.** The settings are tenant singletons, with no etag or version
  property. Two module instances, or a module and the portal or a script, that own the same
  property overwrite each other. Use one instance per tenant. Entitlement management has no
  documented concurrency control for this object, so a write between the plan-time read and the
  apply is not detected.
- **Relinquishing ownership.** Remove the module, or run `terraform destroy`: nothing is sent
  and both settings keep their last value. To stop managing only one setting while keeping the
  other, set its input to null and apply: that setting is no longer written and keeps its last
  value, but the apply still sends a PATCH of the setting that is still owned, which changes
  nothing if it already holds the input. Setting both inputs to null fails the plan, because there
  would be nothing to own. None of this restores anything.
- **Adoption.** There is nothing to import. The first plan reads the live object; `drifted_properties`
  shows what the apply will change, and a plan that changes nothing proves the inputs already match.

## Guest lifecycle implications

The setting applies to **every** external user in the tenant whose last access package assignment
is removed, including guests added by other catalogs and by teams that you do not manage, and
including users who become guests through a connected organization.

- `none`: nothing happens to the guest.
- `blockSignIn`: the guest's sign-in is blocked; the account and its data stay and the guest can
  be unblocked.
- `blockSignInAndDelete`: after the duration, the service deletes the guest account. The module
  requires `allow_external_user_deletion = true` for it, and a duration with it. Recovery of a
  deleted guest, the interplay with the soft-delete retention and reinvitation are documented by
  Microsoft for deleted users generally and are not verified here for this path.

Changing the action does not change existing assignments or guests that are already blocked: the
documentation describes only the automatic action on removal of the last assignment.

## Restore

On the first apply the module reads the settings and keeps both values in
`terraform_data.previous_state` with `ignore_changes = [input]`; later reads never overwrite it.
It is the `previous_state` output.

Destroying the module sends no request. To put the owned settings back:

1. Set `restore_previous_state = true` and apply, with the other inputs unchanged. The module
   PATCHes the snapshot value of each setting that is owned now and was owned at the first
   apply. A restore writes back the value captured before the module first applied, which can be
   `blockSignInAndDelete`: it then fails closed unless `allow_external_user_deletion = true`.
2. Remove the module or destroy it.

A restore fails, rather than overwriting, when a setting holds neither the value the inputs
apply nor the snapshot value, which means someone changed it since the module last wrote it.
`restore_over_changes = true` restores the snapshot over such a change.

Caveats:

- Settings whose input is null are not restored: they were never owned. A setting that became
  owned only after the first apply is not restored either, because the snapshot holds only a read
  taken before the module managed it; reset it by hand if needed.
- The snapshot lives in Terraform state. If the module's resources are replaced or removed from
  state, the next apply captures the settings as they are then, not the original.
- A snapshot whose duration is null cannot clear a duration that was set afterwards. Reset it in the
  portal or accept the value.
- Restoring in a first apply, before any snapshot exists, sends the settings as just read.

`terraform destroy` therefore neither deletes nor restores. This is stated so nobody expects
destroy to undo the change.

## Live acceptance

Offline tests do not prove these settings. The bounded read/update/restore runbook for a
disposable tenant, and the review of the other entitlement management configuration paths, are in
[entitlement management settings admission](../../../../../docs/entitlement-management-settings-admission.md).
No live run has been dispatched; every item marked unverified above stays so until one succeeds.

## Testing

Mocked `terraform test` suites cover the read and write requests, the partial body, null
omission, drift and no-op results, each input and its validation, the response validation, the
snapshot, the restore, its owned-only scope, the fail-closed deletion acknowledgement and the
guard against overwriting outside changes. They pass with Terraform 1.16.2. Python contract tests assert that the module has
no resource or provisioner that can delete the singleton.

## Prepared governance suite

The optional `tests/integration` suite has not been run against a tenant. See
[governance live acceptance](../../../../../docs/governance-live-acceptance.md) for its
prerequisites, bounded assertions and the acceptance that remains outstanding.

<!-- drift:start -->
## Drift and out-of-band changes

Terraform plans compare configuration and refreshed provider state. A plan that changes one of these inputs proposes its declared effect; review the plan before applying. The consumer guide explains refresh limits and emergency reconciliation.

- `externalUserLifecycleAction`: in place.
- `durationUntilExternalUserDeletedAfterBlocked`: in place.
- `allow_external_user_deletion`: no object change (validation or timing only).
- `restore_previous_state`: in place.
- `restore_over_changes`: no object change (validation or timing only).
<!-- drift:end -->

<!-- permissions:begin -->
## Per-operation permissions

Source: [Graph DevX map](https://raw.githubusercontent.com/microsoftgraph/microsoft-graph-devx-content/56e1917fe45fb7c52c2d9845f569c2ffdb39e4d9/permissions/new/permissions.json) (SHA-256 `4d7dee52659b1d6424bce0b26603302081d39ef9e149bc5fb50de4273b3d3514`).
The map is shared by v1.0 and beta; it does not certify API-version support. Rows show the source's least-privilege annotations, not live-tested consent. Choose an alternative for your authentication type; do not grant every listed scope. AlsoRequires lists additional scope alternatives attached to that row. Missing annotations are unknown, not evidence that an operation needs no permission. Keep the module's documented role, property-specific and tenant restrictions.

Derived from this module's Terraform sources, including optional guards, destroy actions and local child modules. The checked inventory is `docs/permissions/verified-operations.json`. These are potential requests, not a preflight scope list. A provider primitive may expose an update that Graph does not support. Source paths and conditions are retained in the inventory.

| Operation | Authentication | Least-privilege alternative | AlsoRequires | Unknown reason |
| --- | --- | --- | --- | --- |
| `PATCH /identityGovernance/entitlementManagement/settings` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `PATCH /identityGovernance/entitlementManagement/settings` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `PATCH /identityGovernance/entitlementManagement/settings` | Application | `EntitlementManagement.ReadWrite.All` | - | - |
| `GET /identityGovernance/entitlementManagement/settings` | DelegatedWork | `EntitlementManagement.Read.All` | - | - |
| `GET /identityGovernance/entitlementManagement/settings` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `GET /identityGovernance/entitlementManagement/settings` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /identityGovernance/entitlementManagement/settings` | Application | `EntitlementManagement.Read.All` | - | - |
| `GET /identityGovernance/entitlementManagement/settings` | Application | `EntitlementManagement.ReadWrite.All` | - | - |
<!-- permissions:end -->
