# identity-governance/entitlement-management/catalogs

Manages a Microsoft Entra ID Governance Entitlement Management **catalog**
(`identityGovernance/entitlementManagement/catalogs`) via the `microsoft/msgraph`
Terraform provider.

A catalog is a container of resources (groups, applications, SharePoint Online sites) and
access packages that are grouped together, typically by department or function.

## Usage

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one.

```hcl
module "engineering_catalog" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/curated/identity-governance/entitlement-management/catalogs?ref=<release-tag>"

  display_name = "Engineering"
  description  = "Resources and access packages for the Engineering department"
  state        = "published"
  catalog_type = "userManaged"
}
```

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
