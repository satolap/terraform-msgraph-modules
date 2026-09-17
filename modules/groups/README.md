# groups

Creates a Microsoft Entra ID group (`groups`) via the `microsoft/msgraph` Terraform provider.

The module validates Graph's supported creation types: Microsoft 365 (`Unified`,
mail-enabled) or security groups (not mail-enabled). Dynamic groups require a rule
and cannot accept static `member_ids` or be role-assignable. Group owner/member
bindings currently target the public Microsoft Graph cloud.

Groups are one of the resource types that can be added to an entitlement management catalog
(`resource_origin_system = "AadGroup"`), and their member/owner roles can then be granted
through an access package. This module creates the group; use `catalogs/resources`
to add it to a catalog and `access-packages/resource-role-scopes` to grant its member/owner role.

## Usage

```hcl
module "engineering_group" {
  source = "../../modules/groups"

  display_name     = "Engineering"
  mail_nickname    = "engineering"
  security_enabled = true

  owner_ids  = [module.team_lead.id]
  member_ids = [module.developer.id]
}

# Microsoft 365 group
module "project_group" {
  source = "../../modules/groups"

  display_name  = "Project X"
  mail_nickname = "projectx"
  group_types   = ["Unified"]
  mail_enabled  = true
  visibility    = "Private"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.0 |
| msgraph | >= 0.3.0 |

Requires the `Group.ReadWrite.All` Microsoft Graph permission (or `Directory.ReadWrite.All`).
Setting `is_assignable_to_role = true` additionally requires `RoleManagement.ReadWrite.Directory`.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| display_name | Display name of the group | `string` | n/a | yes |
| mail_nickname | Mail alias (no spaces/special characters) | `string` | n/a | yes |
| description | Description of the group | `string` | `null` | no |
| security_enabled | Whether the group is a security group | `bool` | `true` | no |
| mail_enabled | Whether the group is mail-enabled | `bool` | `false` | no |
| group_types | `["Unified"]` for M365, `[]` for security; add `"DynamicMembership"` for dynamic | `list(string)` | `[]` | no |
| visibility | `Public`/`Private`/`HiddenMembership` (M365 groups only) | `string` | `null` | no |
| is_assignable_to_role | Allow Entra role assignment to the group (create-time only) | `bool` | `null` | no |
| membership_rule | Dynamic membership rule (required with `DynamicMembership`) | `string` | `null` | no |
| owner_ids | Directory object IDs to set as owners | `list(string)` | `[]` | no |
| member_ids | Directory object IDs to set as members | `list(string)` | `[]` | no |
| api_version | Graph API version (`v1.0` or `beta`) | `string` | `"v1.0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The object ID of the group (use as `resource_origin_id` for catalog/role-scope modules) |
| display_name | The display name of the group |
| mail | The SMTP address, if mail-enabled |
