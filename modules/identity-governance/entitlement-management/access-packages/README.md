# identity-governance/entitlement-management/access-packages

Manages a Microsoft Entra ID Governance Entitlement Management **access package**
(`identityGovernance/entitlementManagement/accessPackages`) via the `microsoft/msgraph`
Terraform provider.

An access package is a bundle of resource roles (groups, applications, SharePoint sites)
that users can request access to, governed by one or more assignment policies.

## Usage

```hcl
module "catalog" {
  source = "../../modules/identity-governance/entitlement-management/catalogs"

  display_name = "Engineering"
  state        = "published"
}

module "engineering_access" {
  source = "../../modules/identity-governance/entitlement-management/access-packages"

  catalog_id   = module.catalog.id
  display_name = "Engineering Team Access"
  description  = "Standard access bundle for engineering team members"
  is_hidden    = false
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.0 |
| msgraph | >= 0.3.0 |

The configuring identity/application needs the `EntitlementManagement.ReadWrite.All`
Microsoft Graph permission.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| catalog_id | ID of the catalog this access package belongs to | `string` | n/a | yes |
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
