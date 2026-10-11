# identity-governance/entitlement-management/catalogs

Manages a Microsoft Entra ID Governance Entitlement Management **catalog**
(`identityGovernance/entitlementManagement/catalogs`) via the `microsoft/msgraph`
Terraform provider.

A catalog is a container of resources (groups, applications, SharePoint Online sites) and
access packages that are grouped together, typically by department or function.

## Usage

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-github) explains how to choose one.

```hcl
module "engineering_catalog" {
  source = "git::https://github.com/satolap/terraform-msgraph-modules.git//modules/curated/identity-governance/entitlement-management/catalogs?ref=<release-tag>"

  display_name = "Engineering"
  description  = "Resources and access packages for the Engineering department"
  state        = "published"
  catalog_type = "userManaged"
}
```

## External users

`is_externally_visible` sets the catalog's **Enabled for external users** setting
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

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.0 |
| msgraph | >= 0.3.0 |

The configuring identity/application needs the `EntitlementManagement.ReadWrite.All`
Microsoft Graph permission.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | EM-CORE | Catalogs, access packages with group, application and SharePoint resources, standard approval stages, requestor questions and expiration are included in Microsoft Entra ID P2, Microsoft Entra ID Governance and Microsoft Entra Suite. Evaluate the exact feature combination; not every accepted policy option is core. Any of: Microsoft Entra ID P2 (`AAD_PREMIUM_P2`); Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Every user who can request or receive an access package assignment, including everyone covered by an all-member policy scope; guest scenarios can involve billing | direct / per_user | documented |

Notes:

- Creating an empty catalog does not prove that the tenant or its request population is licensed for the scenarios built on it.

Sources: [Entitlement management license requirements](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-overview#license-requirements), [Microsoft Entra features by license](https://learn.microsoft.com/en-us/entra/fundamentals/licensing#features-by-license).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| display_name | Display name of the catalog (1-90 characters) | `string` | n/a | yes |
| description | Description of the catalog | `string` | `null` | no |
| is_externally_visible | Whether users of connected organizations can request the catalog's access packages; `null` leaves it to Microsoft Graph | `bool` | `null` | no |
| state | `unpublished` or `published` | `string` | `"unpublished"` | no |
| catalog_type | `userManaged` or `serviceDefault` | `string` | `"userManaged"` | no |
| api_version | Graph API version (`v1.0` or `beta`) | `string` | `"v1.0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the catalog |
| display_name | The display name of the catalog |
| state | The published state of the catalog |
| catalog_type | The type of the catalog |
| is_externally_visible | The configured `is_externally_visible`, or `null` when not set |
