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

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one.

```hcl
module "internal_app" {
  source       = "git::https://github.com/benhaspalace/GraphModules.git//modules/curated/applications?ref=<release-tag>"
  display_name = "Internal Tool"
  app_roles    = [/* ... */]
}

module "internal_app_sp" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/curated/service-principals?ref=<release-tag>"

  app_id                       = module.internal_app.app_id
  app_role_assignment_required = true
  tags                         = ["WindowsAzureActiveDirectoryIntegratedApp"]
}

# Then add it to a catalog:
module "app_catalog_resource" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/curated/identity-governance/entitlement-management/catalogs/resources?ref=<release-tag>"

  catalog_id             = module.catalog.id
  resource_origin_system = "AadApplication"
  resource_origin_id     = module.internal_app_sp.id
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

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.0 |
| msgraph | >= 0.3.0 |

Requires the `Application.ReadWrite.All` Microsoft Graph permission.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | DIRECTORY-BASIC | The reviewed create APIs for users, assigned security groups, applications and service principals specify no additional premium license. This covers the object operation only; features built on these objects can require licenses. No additional license specified. | No per-user entitlement for the object operation itself | direct / per_tenant | documented |

Notes:

- Creating the enterprise application object does not license its users or a third-party SaaS service. Evaluate group assignment and premium sign-in or provisioning features independently.

Sources: [Create user](https://learn.microsoft.com/en-us/graph/api/user-post-users?view=graph-rest-1.0), [Create group](https://learn.microsoft.com/en-us/graph/api/group-post-groups?view=graph-rest-1.0), [Create application](https://learn.microsoft.com/en-us/graph/api/application-post-applications?view=graph-rest-1.0), [Create servicePrincipal](https://learn.microsoft.com/en-us/graph/api/serviceprincipal-post-serviceprincipals?view=graph-rest-1.0).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| app_id | Application (client) ID (GUID) | `string` | n/a | yes |
| account_enabled | Whether the service principal is enabled | `bool` | `true` | no |
| app_role_assignment_required | Require app role assignment before sign-in/token | `bool` | `false` | no |
| description | Free-text description | `string` | `null` | no |
| notes | Management notes | `string` | `null` | no |
| tags | Categorization tags | `list(string)` | `null` | no |
| login_url | SSO landing page URL | `string` | `null` | no |
| preferred_single_sign_on_mode | `password`/`saml`/`notSupported`/`oidc` | `string` | `null` | no |
| api_version | Graph API version (`v1.0` or `beta`) | `string` | `"v1.0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The object ID of the service principal (use as `resource_origin_id` for `AadApplication`) |
| app_id | The application (client) ID |
| display_name | The display name exposed by the associated application |
