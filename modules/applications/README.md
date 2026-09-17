# applications

Creates a Microsoft Entra ID application registration (`applications`) via the
`microsoft/msgraph` Terraform provider.

An application registration defines the app and its **app roles**. To make the app usable in a
tenant — and to add it to an entitlement management catalog as a resource
(`resource_origin_system = "AadApplication"`) — you also need a **service principal** for it:
create one with the `service-principals` module, passing this module's `app_id` output.

The app roles you define here are exactly the roles that can be granted through an access
package: each role's `id` (a GUID) is the `role_origin_id` consumed by the
`access-packages/resource-role-scopes` module.

## Usage

```hcl
module "internal_app" {
  source = "../../modules/applications"

  display_name     = "Internal Tool"
  sign_in_audience = "AzureADMyOrg"

  app_roles = [
    {
      id           = "8b3a0c4d-2f1e-4c9a-9b7e-1234567890ab" # generate a unique GUID
      display_name = "Contributor"
      description  = "Can contribute to the internal tool"
      value        = "Contributor"
    },
  ]
}

module "internal_app_sp" {
  source = "../../modules/service-principals"

  app_id = module.internal_app.app_id
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
| display_name | Display name (1-120 characters) | `string` | n/a | yes |
| sign_in_audience | Supported account types | `string` | `"AzureADMyOrg"` | no |
| description | Free-text description | `string` | `null` | no |
| notes | Management notes | `string` | `null` | no |
| tags | Categorization tags | `list(string)` | `[]` | no |
| web_redirect_uris | Web platform redirect URIs | `list(string)` | `[]` | no |
| spa_redirect_uris | SPA platform redirect URIs | `list(string)` | `[]` | no |
| public_client_redirect_uris | Mobile/desktop redirect URIs | `list(string)` | `[]` | no |
| app_roles | App roles exposed by the app (each `id` is a GUID → `role_origin_id`) | `list(object)` | `[]` | no |
| api_version | Graph API version (`v1.0` or `beta`) | `string` | `"v1.0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The object ID of the application registration |
| app_id | The application (client) ID — feed to `service-principals` |
| display_name | The display name of the application |
| app_role_ids | Map of app role `value` → `id` (GUID), for `role_origin_id` |
