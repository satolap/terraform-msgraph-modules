# applications

<!-- uses-beta:start -->
Uses beta: **optional**. Beta is an optional api_version selection for compatibility; no beta-only capability is required by this module's contract. Prefer v1.0. Beta is preview and may change without notice. Pin module and provider versions; read `interface-changes.json` before upgrading.
<!-- uses-beta:end -->

<!-- live-status:start -->
Assurance: **verified live-accepted** (2026-10-24, commit `344ecc7e`). Acceptance covers the recorded run and configuration.

![live Dev: passed 2026-10-24](https://img.shields.io/badge/live%20Dev-passed%202026--10--24-brightgreen)
<!-- live-status:end -->

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

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one.

```hcl
module "internal_app" {
  source  = "satolap/modules/msgraph//verified/applications"
  version = "<version>"

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
  source  = "satolap/modules/msgraph//verified/service-principals"
  version = "<version>"

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
| terraform | >= 1.11.0 |
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

| Name | Description | Type | Default | Required | On change |
|------|-------------|------|---------|----------| --- |
| display_name | Display name (1-120 characters) | `string` | n/a | yes | in place |
| name_pattern | Regular expression (RE2, not anchored unless it says so) that display_name must match, or the plan fails; null accepts any name | `string` | `null` | no | no object change (validation or timing only) |
| sign_in_audience | Supported account types | `string` | `"AzureADMyOrg"` | no | in place |
| description | Free-text description | `string` | `null` | no | in place |
| notes | Management notes | `string` | `null` | no | in place |
| tags | Categorization tags | `list(string)` | `null` | no | in place |
| web_redirect_uris | Web platform redirect URIs | `list(string)` | `null` | no | in place |
| spa_redirect_uris | SPA platform redirect URIs | `list(string)` | `null` | no | in place |
| public_client_redirect_uris | Mobile/desktop redirect URIs | `list(string)` | `null` | no | in place |
| app_roles | App roles exposed by the app (each `id` is a GUID → `role_origin_id`) | `list(object)` | `null` | no | in place |
| api_version | Graph API version (`v1.0` or `beta`) | `string` | `"v1.0"` | no | in place |

## Outputs

| Name | Description | Known in plan after an update |
|------|-------------| --- |
| id | The object ID of the application registration | yes |
| app_id | The application (client) ID — feed to `service-principals` | yes |
| display_name | The display name of the application | no |
| app_role_ids | Map of app role `value` → `id` (GUID), for `role_origin_id` | yes |

`app_id` is pinned at creation in `terraform_data.app_id`, so it stays known when an
in-place update, such as a rename, plans the provider's read-back as unknown. A
`service-principals` module fed from it is therefore not replaced by a rename. The
value is refreshed whenever the application's object ID changes: when it is
replaced, and when it is created afresh after leaving the state. Upgrading adds that
one Terraform-only resource to the plan and changes nothing in Entra ID, provided the
upgrade apply carries no other change to the application. In the same plan as a rename
or drift, the new resource still reads an unknown `app_id`, and a fed service principal
is replaced as before. Apply the upgrade on its own, or check that the plan replaces
no service principal.
