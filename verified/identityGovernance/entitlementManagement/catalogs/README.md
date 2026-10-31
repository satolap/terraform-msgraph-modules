# identityGovernance/entitlementManagement/catalogs

<!-- uses-beta:start -->
Uses beta: **optional**. Beta is an optional api_version selection for compatibility; no beta-only capability is required by this module's contract. Prefer v1.0. Beta is preview and may change without notice. Pin module and provider versions; read `interface-changes.json` before upgrading.
<!-- uses-beta:end -->

<!-- live-status:start -->
Assurance: **verified live-accepted** (2026-10-24, commit `344ecc7e`). Acceptance covers the recorded run and configuration.

![live Dev: passed 2026-10-24](https://img.shields.io/badge/live%20Dev-passed%202026--10--24-brightgreen)
<!-- live-status:end -->

Manages a Microsoft Entra ID Governance Entitlement Management **catalog**
(`identityGovernance/entitlementManagement/catalogs`) via the `microsoft/msgraph`
Terraform provider.

A catalog is a container of resources (groups, applications, SharePoint Online sites) and
access packages that are grouped together, typically by department or function.

## Usage

Replace `<version>` with a release version, such as `0.5.0`; the [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one.

```hcl
module "engineering_catalog" {
  source  = "satolap/modules/msgraph//verified/identityGovernance/entitlementManagement/catalogs"
  version = "<version>"

  displayName = "Engineering"
  description = "Resources and access packages for the Engineering department"
  state       = "published"
}
```

## External users

`isExternallyVisible` sets the catalog's **Enabled for external users** setting
(`isExternallyVisible`). Users of a connected organization can request an access package
only when its catalog is enabled for external users and the access package has a policy
for them ([Share link to request an access package](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-access-package-settings)).
The setting does not limit administrators who assign external users directly
([Create and manage a catalog](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-catalog-create)).

- `null`, the default, leaves the property out of the request body, so existing callers send
  the same body as before. The [create](https://learn.microsoft.com/en-us/graph/api/entitlementmanagement-post-catalogs?view=graph-rest-1.0)
  page documents no default; the admin center enables the setting for a new catalog.
- `true` or `false` is sent on create and, when it changes, in a `PATCH`, which
  [documents](https://learn.microsoft.com/en-us/graph/api/accesspackagecatalog-update?view=graph-rest-1.0)
  `isExternallyVisible` as updatable.
- Changing `true` or `false` back to `null` sends nothing, so the catalog keeps its last
  value. Set `false` to turn the setting off.
- With `true` or `false`, the property is part of the configured body, which the provider
  refreshes from Microsoft Graph like the other body keys. A change made in the admin center
  therefore shows as drift in the next plan, and the next apply sets the configured value
  again. With `null` the module does not manage the property, and a change made outside
  Terraform stays. Whether Graph returns the value it applied when the request leaves it out
  is not verified.

## Catalog type

The [create request](https://learn.microsoft.com/en-us/graph/api/entitlementmanagement-post-catalogs?view=graph-rest-1.0)
documents only `displayName`, `description`, `state` and `isExternallyVisible`, so the module
does not send `catalogType`. Microsoft Learn describes `catalogType` as whether a user or
entitlement management created the catalog, and the create example returns `userManaged`. The
`catalog_type` output reads the value back.

`catalog_type` is deprecated and ignored. It still accepts `"userManaged"`, its former default,
so existing callers keep working; remove it. `"serviceDefault"` is rejected. A catalog created by
an earlier module version, whose request body held `catalogType`, plans one in-place update
after upgrading. Its `PATCH` sends no property, because the provider sends only the properties
that changed or were added, so the catalog keeps its type.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.11.0 |
| msgraph | >= 0.3.0 |

The configuring identity/application needs the `EntitlementManagement.ReadWrite.All`
Microsoft Graph permission.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

Before deployment, check the requirements of the features you enable and the users who benefit. You can inspect tenant subscriptions with `GET /subscribedSkus`; this requires `Organization.Read.All` or `LicenseAssignment.Read.All` ([List subscribedSkus](https://learn.microsoft.com/en-us/graph/api/subscribedsku-list?view=graph-rest-1.0)).

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | EM-CORE | Catalogs, access packages with group, application and SharePoint resources, standard approval stages, requestor questions and expiration are included in Microsoft Entra ID P2, Microsoft Entra ID Governance and Microsoft Entra Suite. Evaluate the exact feature combination; not every accepted policy option is core. Any of: Microsoft Entra ID P2 (`AAD_PREMIUM_P2`); Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Every user who can request or receive an access package assignment, including everyone covered by an all-member policy scope; guest scenarios can involve billing | direct / per_user | documented |

Notes:

- Creating an empty catalog does not prove that the tenant or its request population is licensed for the scenarios built on it.

Sources: [Entitlement management license requirements](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-overview#license-requirements), [Microsoft Entra features by license](https://learn.microsoft.com/en-us/entra/fundamentals/licensing#features-by-license).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required | On change |
|------|-------------|------|---------|----------| --- |
| displayName | Display name of the catalog (1-90 characters) | `string` | n/a | yes | in place |
| name_pattern | Regular expression (RE2, not anchored unless it says so) that displayName must match, or the plan fails; null accepts any name | `string` | `null` | no | no object change (validation or timing only) |
| description | Description of the catalog | `string` | `null` | no | in place |
| isExternallyVisible | Whether users of connected organizations can request the catalog's access packages; `null` leaves it to Microsoft Graph | `bool` | `null` | no | in place |
| state | `unpublished` or `published` | `string` | `"unpublished"` | no | in place |
| catalog_type | Deprecated and ignored; accepts only `userManaged`. Remove it | `string` | `"userManaged"` | no | no object change (validation or timing only) |
| api_version | Graph API version (`v1.0` or `beta`) | `string` | `"v1.0"` | no | in place |

## Outputs

| Name | Description | Known in plan after an update |
|------|-------------| --- |
| id | The ID of the catalog | yes |
| display_name | The display name of the catalog | no |
| state | The published state of the catalog | no |
| catalog_type | The type of the catalog, as Microsoft Graph returns it | no |
| is_externally_visible | The configured `isExternallyVisible`, or `null` when not set | yes |

<!-- drift:start -->
## Drift and out-of-band changes

Terraform plans compare configuration and refreshed provider state. A plan that changes one of these inputs proposes its declared effect; review the plan before applying. The consumer guide explains refresh limits and emergency reconciliation.

- `displayName`: in place.
- `description`: in place.
- `isExternallyVisible`: in place.
- `state`: in place.
- `catalog_type`: no object change (validation or timing only).
- `api_version`: in place.
- `name_pattern`: no object change (validation or timing only).
<!-- drift:end -->

<!-- permissions:begin -->
## Per-operation permissions

Source: [Graph DevX map](https://raw.githubusercontent.com/microsoftgraph/microsoft-graph-devx-content/56e1917fe45fb7c52c2d9845f569c2ffdb39e4d9/permissions/new/permissions.json) (SHA-256 `4d7dee52659b1d6424bce0b26603302081d39ef9e149bc5fb50de4273b3d3514`).
The map is shared by v1.0 and beta; it does not certify API-version support. Rows show the source's least-privilege annotations, not live-tested consent. Choose an alternative for your authentication type; do not grant every listed scope. AlsoRequires lists additional scope alternatives attached to that row. Missing annotations are unknown, not evidence that an operation needs no permission. Keep the module's documented role, property-specific and tenant restrictions.

Derived from this module's Terraform sources, including optional guards, destroy actions and local child modules. The checked inventory is `docs/permissions/verified-operations.json`. These are potential requests, not a preflight scope list. A provider primitive may expose an update that Graph does not support. Source paths and conditions are retained in the inventory.

| Operation | Authentication | Least-privilege alternative | AlsoRequires | Unknown reason |
| --- | --- | --- | --- | --- |
| `POST /identityGovernance/entitlementManagement/catalogs` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `POST /identityGovernance/entitlementManagement/catalogs` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `POST /identityGovernance/entitlementManagement/catalogs` | Application | `EntitlementManagement.ReadWrite.All` | - | - |
| `GET /identityGovernance/entitlementManagement/catalogs/{id}` | DelegatedWork | `EntitlementManagement.Read.All` | - | - |
| `GET /identityGovernance/entitlementManagement/catalogs/{id}` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `GET /identityGovernance/entitlementManagement/catalogs/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /identityGovernance/entitlementManagement/catalogs/{id}` | Application | `EntitlementManagement.Read.All` | - | - |
| `GET /identityGovernance/entitlementManagement/catalogs/{id}` | Application | `EntitlementManagement.ReadWrite.All` | - | - |
| `DELETE /identityGovernance/entitlementManagement/catalogs/{id}` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `DELETE /identityGovernance/entitlementManagement/catalogs/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `DELETE /identityGovernance/entitlementManagement/catalogs/{id}` | Application | `EntitlementManagement.ReadWrite.All` | - | - |
| `PATCH /identityGovernance/entitlementManagement/catalogs/{id}` | DelegatedWork | `EntitlementManagement.ReadWrite.All` | - | - |
| `PATCH /identityGovernance/entitlementManagement/catalogs/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `PATCH /identityGovernance/entitlementManagement/catalogs/{id}` | Application | `EntitlementManagement.ReadWrite.All` | - | - |

### Property-specific coverage

Route annotations do not establish that the listed scopes cover every selected or writable property. Dynamic bodies, additional properties and default responses remain unbounded. Keep the reviewed permission guidance above; in particular, a group-nesting scope is not general group-property access. The pin's method/path entries do not distinguish property grants from navigation or sub-resource operations; property coverage stays unknown.

| Operation | Properties | Source evidence |
| --- | --- | --- |
| `POST /identityGovernance/entitlementManagement/catalogs` | `description`, `displayName`, `isExternallyVisible`, `state` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `PATCH /identityGovernance/entitlementManagement/catalogs/{id}` | `description`, `displayName`, `isExternallyVisible`, `state` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
<!-- permissions:end -->
