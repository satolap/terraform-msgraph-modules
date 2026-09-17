# identity-governance/entitlement-management/catalogs

Manages a Microsoft Entra ID Governance Entitlement Management **catalog**
(`identityGovernance/entitlementManagement/catalogs`) via the `microsoft/msgraph`
Terraform provider.

A catalog is a container of resources (groups, applications, SharePoint Online sites) and
access packages that are grouped together, typically by department or function.

## Usage

```hcl
module "engineering_catalog" {
  source = "../../modules/curated/identity-governance/entitlement-management/catalogs"

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
