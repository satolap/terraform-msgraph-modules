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

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one.

```hcl
module "internal_app" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/curated/applications?ref=<release-tag>"

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
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/curated/service-principals?ref=<release-tag>"

  app_id = module.internal_app.app_id
}
```

## Collection updates and migration

For `tags`, `app_roles`, `web_redirect_uris`, `spa_redirect_uris` and
`public_client_redirect_uris`, an omitted input or `null` leaves the property out
of the request. An explicit `[]` includes an empty collection, expressing the
intent to clear it. Populated lists remain in the body. Redirect URI inputs only
write `redirectUris` within the corresponding platform object.

These inputs now default to `null`. Previously, `[]` was also omitted. Callers
that passed `[]` to mean "leave unchanged" must switch to `null` or omit the
input before upgrading. Review the Terraform plan before applying. Omission
does not promise import/drift behavior; provider-backed verification remains
pending. Microsoft describes PATCH omission in [Update application](https://learn.microsoft.com/en-us/graph/api/application-update?view=graph-rest-1.0).

Remove app roles in two stages: first keep the role IDs and set `is_enabled = false`,
then apply; in a subsequent apply, remove those disabled roles from `app_roles`
(or use `[]` to request removal of all roles). Retain any roles that should remain.
One apply does not automatically disable and remove roles. See Microsoft's
[appRole deletion requirement](https://learn.microsoft.com/en-us/graph/api/resources/approle?view=graph-rest-1.0).

Offline mocks verify omitted, populated and empty request bodies, null-safe
validation/output handling, and disabled-role serialization. They do not prove
Graph accepts every transition or that provider refresh preserves unchanged
plans. Live clear/read-back/no-op/stable-ID checks remain pending for each API
and provider version.

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

- Registering an application and defining app roles is separate from group assignment, premium provisioning or workload access. Compositions that assign groups to the application fall under APP-GROUP-ASSIGNMENT.

Sources: [Create user](https://learn.microsoft.com/en-us/graph/api/user-post-users?view=graph-rest-1.0), [Create group](https://learn.microsoft.com/en-us/graph/api/group-post-groups?view=graph-rest-1.0), [Create application](https://learn.microsoft.com/en-us/graph/api/application-post-applications?view=graph-rest-1.0), [Create servicePrincipal](https://learn.microsoft.com/en-us/graph/api/serviceprincipal-post-serviceprincipals?view=graph-rest-1.0).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| display_name | Display name (1-120 characters) | `string` | n/a | yes |
| sign_in_audience | Supported account types | `string` | `"AzureADMyOrg"` | no |
| description | Free-text description | `string` | `null` | no |
| notes | Management notes | `string` | `null` | no |
| tags | Categorization tags | `list(string)` | `null` | no |
| web_redirect_uris | Web platform redirect URIs | `list(string)` | `null` | no |
| spa_redirect_uris | SPA platform redirect URIs | `list(string)` | `null` | no |
| public_client_redirect_uris | Mobile/desktop redirect URIs | `list(string)` | `null` | no |
| app_roles | App roles exposed by the app (each `id` is a GUID → `role_origin_id`) | `list(object)` | `null` | no |
| api_version | Graph API version (`v1.0` or `beta`) | `string` | `"v1.0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The object ID of the application registration |
| app_id | The application (client) ID — feed to `service-principals` |
| display_name | The display name of the application |
| app_role_ids | Map of app role `value` → `id` (GUID), for `role_origin_id` |
