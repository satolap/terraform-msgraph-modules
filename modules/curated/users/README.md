# users

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

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one.

```hcl
module "developer" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/curated/users?ref=<release-tag>"

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
| terraform | >= 1.5.0 |
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

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | DIRECTORY-BASIC | The reviewed create APIs for users, assigned security groups, applications and service principals specify no additional premium license. This covers the object operation only; features built on these objects can require licenses. No additional license specified. | No per-user entitlement for the object operation itself | direct / per_tenant | documented |

Notes:

- Creating a directory user does not provision a mailbox or license the user for premium features. License the fixture for the scenario in which it participates and verify service readiness separately.

Sources: [Create user](https://learn.microsoft.com/en-us/graph/api/user-post-users?view=graph-rest-1.0), [Create group](https://learn.microsoft.com/en-us/graph/api/group-post-groups?view=graph-rest-1.0), [Create application](https://learn.microsoft.com/en-us/graph/api/application-post-applications?view=graph-rest-1.0), [Create servicePrincipal](https://learn.microsoft.com/en-us/graph/api/serviceprincipal-post-serviceprincipals?view=graph-rest-1.0).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| user_principal_name | UPN (alias@verified-domain) | `string` | n/a | yes |
| display_name | Display name (1-256 characters) | `string` | n/a | yes |
| mail_nickname | Mail alias | `string` | n/a | yes |
| password | Initial password (sensitive) | `string` | n/a | yes |
| force_change_password_next_sign_in | Force password change on next sign-in | `bool` | `true` | no |
| account_enabled | Whether the account is enabled | `bool` | `true` | no |
| given_name | First name | `string` | `null` | no |
| surname | Last name | `string` | `null` | no |
| job_title | Job title | `string` | `null` | no |
| department | Department | `string` | `null` | no |
| usage_location | Two-letter ISO 3166 country code | `string` | `null` | no |
| additional_properties | Other writable user properties; cannot override explicit module inputs | `any` (object) | `{}` | no |
| api_version | Graph API version (`v1.0` or `beta`) | `string` | `"v1.0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The object ID of the user |
| user_principal_name | The UPN of the user |
| display_name | The display name of the user |
