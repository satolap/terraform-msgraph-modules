# identity-governance/entitlement-management/access-packages

Manages a Microsoft Entra ID Governance Entitlement Management **access package**
(`identityGovernance/entitlementManagement/accessPackages`) via the `microsoft/msgraph`
Terraform provider.

An access package is a bundle of resource roles (groups, applications, SharePoint sites)
that users can request access to, governed by one or more assignment policies.

## Usage

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one.

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

- Eligibility, resource types, assignment behavior and the recipient population determine additional rules. Start with an explicitly selected test-user group.

Sources: [Entitlement management license requirements](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-overview#license-requirements), [Microsoft Entra features by license](https://learn.microsoft.com/en-us/entra/fundamentals/licensing#features-by-license).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| catalog_id | ID of the catalog this access package belongs to; a change replaces the access package | `string` | n/a | yes |
| display_name | Display name of the access package (1-90 characters) | `string` | n/a | yes |
| description | Description of the access package | `string` | `null` | no |
| is_hidden | Whether the access package is hidden from requestors | `bool` | `false` | no |
| api_version | Graph API version (`v1.0` or `beta`) | `string` | `"v1.0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the access package |
| display_name | The display name of the access package |
| catalog_id | The ID of the parent catalog |
