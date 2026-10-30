# identity-governance/entitlement-management/access-packages

<!-- uses-beta:start -->
Uses beta: **optional**. Beta is an optional api_version selection for compatibility; no beta-only capability is required by this module's contract. Prefer v1.0. Beta is preview and may change without notice. Pin module and provider versions; read `interface-changes.json` before upgrading.
<!-- uses-beta:end -->

<!-- live-status:start -->
Assurance: **verified live-accepted** (2026-10-24, commit `344ecc7e`). Acceptance covers the recorded run and configuration.

![live Dev: passed 2026-10-24](https://img.shields.io/badge/live%20Dev-passed%202026--10--24-brightgreen)
<!-- live-status:end -->

Manages a Microsoft Entra ID Governance Entitlement Management **access package**
(`identityGovernance/entitlementManagement/accessPackages`) via the `microsoft/msgraph`
Terraform provider.

An access package is a bundle of resource roles (groups, applications, SharePoint sites)
that users can request access to, governed by one or more assignment policies.

## Usage

Replace `<version>` with a release version, such as `1.0.0`; the [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one.

```hcl
module "catalog" {
  source  = "satolap/modules/msgraph//verified/identity-governance/entitlement-management/catalogs"
  version = "<version>"

  display_name = "Engineering"
  state        = "published"
}

module "engineering_access" {
  source  = "satolap/modules/msgraph//verified/identity-governance/entitlement-management/access-packages"
  version = "<version>"

  catalog_id   = module.catalog.id
  display_name = "Engineering Team Access"
  description  = "Standard access bundle for engineering team members"
  is_hidden    = false
}
```

## Changing the catalog

Microsoft Learn documents the access package's `catalog` relationship as
[required on create and read-only](https://learn.microsoft.com/en-us/graph/api/resources/accesspackage?view=graph-rest-1.0#relationships),
and the [update](https://learn.microsoft.com/en-us/graph/api/accesspackage-update?view=graph-rest-1.0)
accepts only `displayName`, `description` and `isHidden`. A change of `catalog_id` therefore
replaces the access package (`terraform_data.immutable` and `replace_triggered_by`). The new
package is created in the new catalog before the old one is deleted, and it has a new `id`:
assignment policies, resource role scopes and anything else that references the old `id` must
follow it, and existing assignments are not moved. Microsoft Graph may refuse to delete the old
package while it still has assignments or policies. `catalog_id` is compared as written, so a
change of letter case alone also replaces the package.

The first apply of a module version that adds `terraform_data.immutable` only creates it and
does not replace the access package. Change `catalog_id` in a later apply.

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

- Eligibility, resource types, assignment behavior and the recipient population determine additional rules. Start with an explicitly selected test-user group.

Sources: [Entitlement management license requirements](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-overview#license-requirements), [Microsoft Entra features by license](https://learn.microsoft.com/en-us/entra/fundamentals/licensing#features-by-license).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required | On change |
|------|-------------|------|---------|----------| --- |
| catalog_id | ID of the catalog this access package belongs to; a change replaces the access package | `string` | n/a | yes | replaces `msgraph_resource.access_package` |
| display_name | Display name of the access package (1-90 characters) | `string` | n/a | yes | in place |
| name_pattern | Regular expression (RE2, not anchored unless it says so) that display_name must match, or the plan fails; null accepts any name | `string` | `null` | no | no object change (validation or timing only) |
| description | Description of the access package | `string` | `null` | no | in place |
| is_hidden | Whether the access package is hidden from requestors | `bool` | `false` | no | in place |
| api_version | Graph API version (`v1.0` or `beta`) | `string` | `"v1.0"` | no | in place |

## Outputs

| Name | Description | Known in plan after an update |
|------|-------------| --- |
| id | The ID of the access package | yes |
| display_name | The display name of the access package | no |
| catalog_id | The ID of the parent catalog | yes |

<!-- drift:start -->
## Drift and out-of-band changes

Terraform plans compare configuration and refreshed provider state. A plan that changes one of these inputs proposes its declared effect; review the plan before applying. The consumer guide explains refresh limits and emergency reconciliation.

- `catalog_id`: replaces `msgraph_resource.access_package`.
- `display_name`: in place.
- `description`: in place.
- `is_hidden`: in place.
- `api_version`: in place.
- `name_pattern`: no object change (validation or timing only).
<!-- drift:end -->
