# service-principals

Creates a Microsoft Entra ID service principal (`servicePrincipals`) for an existing
application, via the `microsoft/msgraph` Terraform provider.

A service principal is the local representation of an application in a tenant. It's what
entitlement management actually references when you add an application to a catalog as a
resource — the catalog resource's `resource_origin_id` for `AadApplication` is the service
principal's **object ID** (this module's `id` output).

Pair this with the `applications` module: create the application, then pass its `app_id`
output here.

## Usage

```hcl
module "internal_app" {
  source       = "../../modules/curated/applications"
  display_name = "Internal Tool"
  app_roles    = [/* ... */]
}

module "internal_app_sp" {
  source = "../../modules/curated/service-principals"

  app_id                       = module.internal_app.app_id
  app_role_assignment_required = true
  tags                         = ["WindowsAzureActiveDirectoryIntegratedApp"]
}

# Then add it to a catalog:
module "app_catalog_resource" {
  source = "../../modules/curated/identity-governance/entitlement-management/catalogs/resources"

  catalog_id             = module.catalog.id
  resource_origin_system = "AadApplication"
  resource_origin_id     = module.internal_app_sp.id
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.0 |
| msgraph | >= 0.3.0 |

Requires the `Application.ReadWrite.All` Microsoft Graph permission.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| app_id | Application (client) ID (GUID) | `string` | n/a | yes |
| account_enabled | Whether the service principal is enabled | `bool` | `true` | no |
| app_role_assignment_required | Require app role assignment before sign-in/token | `bool` | `false` | no |
| description | Free-text description | `string` | `null` | no |
| notes | Management notes | `string` | `null` | no |
| tags | Categorization tags | `list(string)` | `[]` | no |
| login_url | SSO landing page URL | `string` | `null` | no |
| preferred_single_sign_on_mode | `password`/`saml`/`notSupported`/`oidc` | `string` | `null` | no |
| api_version | Graph API version (`v1.0` or `beta`) | `string` | `"v1.0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The object ID of the service principal (use as `resource_origin_id` for `AadApplication`) |
| app_id | The application (client) ID |
| display_name | The display name exposed by the associated application |
