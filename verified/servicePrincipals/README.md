# service-principals

<!-- uses-beta:start -->
Uses beta: **optional**. Beta is an optional api_version selection for compatibility; no beta-only capability is required by this module's contract. Prefer v1.0. Beta is preview and may change without notice. Pin module and provider versions; read `interface-changes.json` before upgrading.
<!-- uses-beta:end -->

<!-- live-status:start -->
Assurance: **verified live-accepted** (2026-10-24, commit `344ecc7e`). Acceptance covers the recorded run and configuration.

![live Dev: passed 2026-10-24](https://img.shields.io/badge/live%20Dev-passed%202026--10--24-brightgreen)
<!-- live-status:end -->

Creates a Microsoft Entra ID service principal (`servicePrincipals`) for an existing
application, via the `microsoft/msgraph` Terraform provider.

A service principal is the local representation of an application in a tenant. It's what
entitlement management actually references when you add an application to a catalog as a
resource — the catalog resource's `resource_origin_id` for `AadApplication` is the service
principal's **object ID** (this module's `id` output).

Pair this with the `applications` module: create the application, then pass its `appId`
output here.

## Usage

Replace `<version>` with a release version, such as `0.5.0`; the [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one.

```hcl
module "internal_app" {
  source      = "satolap/modules/msgraph//verified/applications"
  version     = "<version>"
  displayName = "Internal Tool"
  app_roles   = [/* ... */]
}

module "internal_app_sp" {
  source  = "satolap/modules/msgraph//verified/servicePrincipals"
  version = "<version>"

  appId                     = module.internal_app.app_id
  appRoleAssignmentRequired = true
  tags                      = ["WindowsAzureActiveDirectoryIntegratedApp"]
}

# Then add it to a catalog:
module "app_catalog_resource" {
  source  = "satolap/modules/msgraph//verified/identityGovernance/entitlementManagement/catalogs/resources"
  version = "<version>"

  accessPackageCatalog-id = module.catalog.id
  resource_origin_system  = "AadApplication"
  resource_origin_id      = module.internal_app_sp.id
}
```

## Tags and migration

Omit `tags` or set it to `null` to leave it out of the request. Set `tags = []` to
send an explicit empty collection, or supply a list to send those tags. The
default is now `null`; previously an explicit `[]` was omitted too. Callers that
used `[]` to mean "leave unchanged" must switch to `null` or omit the input.
Review the plan before applying because tags can affect enterprise-application
visibility and other behavior. See [Update servicePrincipal](https://learn.microsoft.com/en-us/graph/api/serviceprincipal-update?view=graph-rest-1.0).

Offline mocks check the three request shapes. Live clear/read-back/no-op and
stable-ID checks remain pending; omission is not a verified import/drift
contract. Application app roles have their own staged deletion requirements;
this module's tags change does not implement role or relationship removal.

## Replacement

A service principal belongs to one application: Microsoft Learn's
[Update servicePrincipal](https://learn.microsoft.com/en-us/graph/api/serviceprincipal-update?view=graph-rest-1.0)
page does not list `appId`. A change of `appId` therefore replaces the service principal:
Terraform plans a destroy and a create of `msgraph_resource.service_principal`, and the old
one is deleted before the new one is created. The new service principal has a new object ID,
and app role assignments, permission grants, catalog resources and anything else that holds
the old ID must follow it. A change of only the case of `appId` keeps the service principal
and sends nothing: the module ignores `appId` in an in-place update, and sends it only when it
creates the service principal.

`terraform_data.immutable` holds the application ID and makes no API call. Upgrading from a
release without it plans only its creation and no change to the service principal. Terraform
does not replace in the apply that creates it, so change `appId` in a later apply.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.11.0 |
| msgraph | >= 0.3.0 |

Requires the `Application.ReadWrite.All` Microsoft Graph permission.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

Before deployment, check the requirements of the features you enable and the users who benefit. You can inspect tenant subscriptions with `GET /subscribedSkus`; this requires `Organization.Read.All` or `LicenseAssignment.Read.All` ([List subscribedSkus](https://learn.microsoft.com/en-us/graph/api/subscribedsku-list?view=graph-rest-1.0)).

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | DIRECTORY-BASIC | The reviewed create APIs for users, assigned security groups, applications and service principals specify no additional premium license. This covers the object operation only; features built on these objects can require licenses. No additional license specified. | No per-user entitlement for the object operation itself | direct / per_tenant | documented |

Notes:

- Creating the enterprise application object does not license its users or a third-party SaaS service. Evaluate group assignment and premium sign-in or provisioning features independently.

Sources: [Create user](https://learn.microsoft.com/en-us/graph/api/user-post-users?view=graph-rest-1.0), [Create group](https://learn.microsoft.com/en-us/graph/api/group-post-groups?view=graph-rest-1.0), [Create application](https://learn.microsoft.com/en-us/graph/api/application-post-applications?view=graph-rest-1.0), [Create servicePrincipal](https://learn.microsoft.com/en-us/graph/api/serviceprincipal-post-serviceprincipals?view=graph-rest-1.0).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required | On change |
|------|-------------|------|---------|----------| --- |
| appId | Application (client) ID (GUID); a change replaces the service principal | `string` | n/a | yes | replaces `msgraph_resource.service_principal` |
| accountEnabled | Whether the service principal is enabled | `bool` | `true` | no | in place |
| appRoleAssignmentRequired | Require app role assignment before sign-in/token | `bool` | `false` | no | in place |
| description | Free-text description | `string` | `null` | no | in place |
| notes | Management notes | `string` | `null` | no | in place |
| tags | Categorization tags | `list(string)` | `null` | no | in place |
| loginUrl | SSO landing page URL | `string` | `null` | no | in place |
| preferredSingleSignOnMode | `password`/`saml`/`notSupported`/`oidc` | `string` | `null` | no | in place |
| api_version | Graph API version (`v1.0` or `beta`) | `string` | `"v1.0"` | no | in place |

Unique values, inferred from the pinned metadata (declaration.json gives each source): `appId` within `/servicePrincipals`. Graph refuses a value already used in that scope.

## Outputs

| Name | Description | Known in plan after an update |
|------|-------------| --- |
| id | The object ID of the service principal (use as `resource_origin_id` for `AadApplication`) | yes |
| app_id | The application (client) ID | no |
| display_name | The display name exposed by the associated application | no |

<!-- drift:start -->
## Drift and out-of-band changes

Terraform plans compare configuration and refreshed provider state. A plan that changes one of these inputs proposes its declared effect; review the plan before applying. The consumer guide explains refresh limits and emergency reconciliation.

- `appId`: replaces `msgraph_resource.service_principal`.
- `accountEnabled`: in place.
- `appRoleAssignmentRequired`: in place.
- `description`: in place.
- `notes`: in place.
- `tags`: in place.
- `loginUrl`: in place.
- `preferredSingleSignOnMode`: in place.
- `api_version`: in place.
<!-- drift:end -->

<!-- permissions:begin -->
## Per-operation permissions

Source: [Graph DevX map](https://raw.githubusercontent.com/microsoftgraph/microsoft-graph-devx-content/56e1917fe45fb7c52c2d9845f569c2ffdb39e4d9/permissions/new/permissions.json) (SHA-256 `4d7dee52659b1d6424bce0b26603302081d39ef9e149bc5fb50de4273b3d3514`).
The map is shared by v1.0 and beta; it does not certify API-version support. Rows show the source's least-privilege annotations, not live-tested consent. Choose an alternative for your authentication type; do not grant every listed scope. AlsoRequires lists additional scope alternatives attached to that row. Missing annotations are unknown, not evidence that an operation needs no permission. Keep the module's documented role, property-specific and tenant restrictions.

Derived from this module's Terraform sources, including optional guards, destroy actions and local child modules. The checked inventory is `docs/permissions/verified-operations.json`. These are potential requests, not a preflight scope list. A provider primitive may expose an update that Graph does not support. Source paths and conditions are retained in the inventory.

| Operation | Authentication | Least-privilege alternative | AlsoRequires | Unknown reason |
| --- | --- | --- | --- | --- |
| `POST /servicePrincipals` | DelegatedWork | `Application.ReadWrite.All` | - | - |
| `POST /servicePrincipals` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `POST /servicePrincipals` | Application | `Application.ReadWrite.OwnedBy` | - | - |
| `GET /servicePrincipals/{id}` | DelegatedWork | `Application.Read.All` | - | - |
| `GET /servicePrincipals/{id}` | DelegatedWork | `Application.ReadWrite.All` | - | - |
| `GET /servicePrincipals/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /servicePrincipals/{id}` | Application | `Application.Read.All` | - | - |
| `GET /servicePrincipals/{id}` | Application | `Application.ReadWrite.OwnedBy` | - | - |
| `DELETE /servicePrincipals/{id}` | DelegatedWork | `Application.ReadWrite.All` | - | - |
| `DELETE /servicePrincipals/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `DELETE /servicePrincipals/{id}` | Application | `Application.ReadWrite.OwnedBy` | - | - |
| `PATCH /servicePrincipals/{id}` | DelegatedWork | `Application.ReadWrite.All` | - | - |
| `PATCH /servicePrincipals/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `PATCH /servicePrincipals/{id}` | Application | `Application.ReadWrite.OwnedBy` | - | - |

### Property-specific coverage

Route annotations do not establish that the listed scopes cover every selected or writable property. Dynamic bodies, additional properties and default responses remain unbounded. Keep the reviewed permission guidance above; in particular, a group-nesting scope is not general group-property access. The pin's method/path entries do not distinguish property grants from navigation or sub-resource operations; property coverage stays unknown.

| Operation | Properties | Source evidence |
| --- | --- | --- |
| `POST /servicePrincipals` | `accountEnabled`, `appId`, `appRoleAssignmentRequired`, `description`, `loginUrl`, `notes`, `preferredSingleSignOnMode`, `tags` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `PATCH /servicePrincipals/{id}` | `accountEnabled`, `appId`, `appRoleAssignmentRequired`, `description`, `loginUrl`, `notes`, `preferredSingleSignOnMode`, `tags` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
<!-- permissions:end -->
