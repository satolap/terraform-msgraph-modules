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

```hcl
module "developer" {
  source = "../../modules/users"

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
