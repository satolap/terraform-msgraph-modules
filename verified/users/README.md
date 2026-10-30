# users

<!-- state-protection:start -->
## State and plan protection

This module's state and saved plans retain these declared values:

Sensitive inputs: `password`.
Potential personal-data inputs: `given_name`, `surname`, `user_principal_name`.

Protect these values with an encrypted remote backend and least-privilege access to state, plans and backups. `sensitive` is presentation redaction, not encryption; provider resource values can still appear in plan/show output. Do not publish plan output in CI logs or PR comments for secret-bearing roots; keep saved plans short-lived and rotate credentials after exposure.

See [Terraform sensitive state guidance](https://developer.hashicorp.com/terraform/language/state/sensitive-data). These are exposure indicators, not a complete data classification; unmarked fields and provider responses also need protection.
<!-- state-protection:end -->

<!-- uses-beta:start -->
Uses beta: **optional**. Beta is an optional api_version selection for compatibility; no beta-only capability is required by this module's contract. Prefer v1.0. Beta is preview and may change without notice. Pin module and provider versions; read `interface-changes.json` before upgrading.
<!-- uses-beta:end -->

<!-- live-status:start -->
Assurance: **verified offline-only**. No current live acceptance is recorded for this module.

![live: offline only](https://img.shields.io/badge/live-offline%20only-lightgrey)
<!-- live-status:end -->

Creates a Microsoft Entra ID user (`users`) via the `microsoft/msgraph` Terraform provider.

## Users and entitlement management

Unlike groups, applications, and SharePoint sites, **a user is not a resource type that can be
added to an entitlement management catalog** — Graph only supports `AadGroup`, `AadApplication`,
and `SharePointOnline` as catalog resources. Users instead participate in entitlement
management as:

- **Group members/owners** — pass this module's `id` output to `groups`'s `member_ids` /
  `owner_ids`; the group is then the catalog resource.
- **Approvers / requestors / allowed targets** — pass the `id` output to the
  `assignment-policies` module's approver/requestor/target objects (with
  `type = "singleUser"`).

## Usage

Replace `<version>` with a release version, such as `1.0.0`; the [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one.

```hcl
module "developer" {
  source  = "satolap/modules/msgraph//verified/users"
  version = "<version>"

  user_principal_name = "jdoe@contoso.com"
  display_name        = "Jane Doe"
  mail_nickname       = "jdoe"
  password            = var.initial_password # sensitive; source from a vault, not hardcoded
  given_name          = "Jane"
  surname             = "Doe"
  job_title           = "Software Engineer"
  department          = "Engineering"
  usage_location      = "US"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.11.0 |
| msgraph | >= 0.3.0 |

Requires the `User.ReadWrite.All` Microsoft Graph permission (or `Directory.ReadWrite.All`).

> The `password` input is marked `sensitive`. Source it from a secrets manager or a
> `sensitive` variable — never commit a real password to version control.

Terraform state still contains the password; protect the state backend and access to plans.
`additional_properties` accepts mixed value types but cannot override explicit inputs such
as `passwordProfile` or `accountEnabled`. Set the corresponding module variable instead.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

Before deployment, check the requirements of the features you enable and the users who benefit. You can inspect tenant subscriptions with `GET /subscribedSkus`; this requires `Organization.Read.All` or `LicenseAssignment.Read.All` ([List subscribedSkus](https://learn.microsoft.com/en-us/graph/api/subscribedsku-list?view=graph-rest-1.0)).

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | DIRECTORY-BASIC | The reviewed create APIs for users, assigned security groups, applications and service principals specify no additional premium license. This covers the object operation only; features built on these objects can require licenses. No additional license specified. | No per-user entitlement for the object operation itself | direct / per_tenant | documented |

Notes:

- Creating a directory user does not provision a mailbox or license the user for premium features. License the fixture for the scenario in which it participates and verify service readiness separately.

Sources: [Create user](https://learn.microsoft.com/en-us/graph/api/user-post-users?view=graph-rest-1.0), [Create group](https://learn.microsoft.com/en-us/graph/api/group-post-groups?view=graph-rest-1.0), [Create application](https://learn.microsoft.com/en-us/graph/api/application-post-applications?view=graph-rest-1.0), [Create servicePrincipal](https://learn.microsoft.com/en-us/graph/api/serviceprincipal-post-serviceprincipals?view=graph-rest-1.0).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required | On change |
|------|-------------|------|---------|----------| --- |
| user_principal_name | UPN (alias@verified-domain) | `string` | n/a | yes | in place |
| display_name | Display name (1-256 characters) | `string` | n/a | yes | in place |
| name_pattern | Regular expression (RE2, not anchored unless it says so) that display_name must match, or the plan fails; null accepts any name | `string` | `null` | no | no object change (validation or timing only) |
| mail_nickname | Mail alias | `string` | n/a | yes | in place |
| mail_nickname_pattern | Regular expression (RE2, not anchored unless it says so) that mail_nickname must match, or the plan fails; null accepts any alias | `string` | `null` | no | no object change (validation or timing only) |
| password | Initial password (sensitive) | `string` | n/a | yes | in place |
| force_change_password_next_sign_in | Force password change on next sign-in | `bool` | `true` | no | in place |
| account_enabled | Whether the account is enabled | `bool` | `true` | no | in place |
| given_name | First name | `string` | `null` | no | in place |
| surname | Last name | `string` | `null` | no | in place |
| job_title | Job title | `string` | `null` | no | in place |
| department | Department | `string` | `null` | no | in place |
| usage_location | Two-letter ISO 3166 country code | `string` | `null` | no | in place |
| additional_properties | Other writable user properties; cannot override explicit module inputs | `any` (object) | `{}` | no | in place |
| api_version | Graph API version (`v1.0` or `beta`) | `string` | `"v1.0"` | no | in place |

Unique values, inferred from the pinned metadata (declaration.json gives each source): `user_principal_name` within `/users`. Graph refuses a value already used in that scope.

## Outputs

| Name | Description | Known in plan after an update |
|------|-------------| --- |
| id | The object ID of the user | yes |
| user_principal_name | The UPN of the user | no |
| display_name | The display name of the user | no |

<!-- drift:start -->
## Drift and out-of-band changes

Terraform plans compare configuration and refreshed provider state. A plan that changes one of these inputs proposes its declared effect; review the plan before applying. The consumer guide explains refresh limits and emergency reconciliation.

- `user_principal_name`: in place.
- `display_name`: in place.
- `mail_nickname`: in place.
- `password`: in place.
- `force_change_password_next_sign_in`: in place.
- `account_enabled`: in place.
- `given_name`: in place.
- `surname`: in place.
- `job_title`: in place.
- `department`: in place.
- `usage_location`: in place.
- `additional_properties`: in place.
- `api_version`: in place.
- `name_pattern`: no object change (validation or timing only).
- `mail_nickname_pattern`: no object change (validation or timing only).
<!-- drift:end -->

<!-- permissions:begin -->
## Per-operation permissions

Source: [Graph DevX map](https://raw.githubusercontent.com/microsoftgraph/microsoft-graph-devx-content/56e1917fe45fb7c52c2d9845f569c2ffdb39e4d9/permissions/new/permissions.json) (SHA-256 `4d7dee52659b1d6424bce0b26603302081d39ef9e149bc5fb50de4273b3d3514`).
The map is shared by v1.0 and beta; it does not certify API-version support. Rows show the source's least-privilege annotations, not live-tested consent. Choose an alternative for your authentication type; do not grant every listed scope. AlsoRequires lists additional scope alternatives attached to that row. Missing annotations are unknown, not evidence that an operation needs no permission. Keep the module's documented role, property-specific and tenant restrictions.

| Operation | Authentication | Least-privilege alternative | AlsoRequires |
| --- | --- | --- | --- |
| `POST /users` | DelegatedWork | `User.ReadWrite.All` | — |
| `POST /users` | DelegatedPersonal | Unknown / not annotated | — |
| `POST /users` | Application | `User.ReadWrite.All` | — |
| `GET /users/{id}` | DelegatedWork | `User.ReadBasic.All` | — |
| `GET /users/{id}` | DelegatedWork | `User.ReadWrite.All` | — |
| `GET /users/{id}` | DelegatedPersonal | `User.Read` | — |
| `GET /users/{id}` | DelegatedPersonal | `User.ReadWrite` | — |
| `GET /users/{id}` | Application | `User.ReadBasic.All` | — |
| `GET /users/{id}` | Application | `User.ReadWrite.All` | — |
| `PATCH /users/{id}` | DelegatedWork | `User.ReadWrite.All` | — |
| `PATCH /users/{id}` | DelegatedPersonal | `User.ReadWrite` | — |
| `PATCH /users/{id}` | Application | `User.ReadWrite.All` | — |
| `DELETE /users/{id}` | DelegatedWork | `User.DeleteRestore.All` | — |
| `DELETE /users/{id}` | DelegatedWork | `User.ReadWrite.All` | — |
| `DELETE /users/{id}` | DelegatedPersonal | Unknown / not annotated | — |
| `DELETE /users/{id}` | Application | `User.DeleteRestore.All` | — |
| `DELETE /users/{id}` | Application | `User.ReadWrite.All` | — |
<!-- permissions:end -->
