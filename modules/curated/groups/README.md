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
  source = "../../modules/curated/groups"

  display_name     = "Engineering"
  mail_nickname    = "engineering"
  security_enabled = true

  owner_ids  = [module.team_lead.id]
  member_ids = [module.developer.id]
}

# Microsoft 365 group
module "project_group" {
  source = "../../modules/curated/groups"

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

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | DIRECTORY-BASIC | The reviewed create APIs for users, assigned security groups, applications and service principals specify no additional premium license. This covers the object operation only; features built on these objects can require licenses. No additional license specified. | No per-user entitlement for the object operation itself | direct / per_tenant | documented |
| `group_types` contains `"DynamicMembership"` | GROUP-DYNAMIC | Dynamic user membership requires Microsoft Entra ID P1 or Intune for Education coverage in the tenant for each unique user who is a member of one or more dynamic groups. Licenses do not have to be assigned directly to those users. Device-only dynamic membership has no per-device license requirement. Any of: Microsoft Entra ID P1 (`AAD_PREMIUM`); Intune for Education (`INTUNE_EDU`). | Each unique user who is a member of any dynamic group | group_based / per_tenant | documented |
| `is_assignable_to_role` is `true` | GROUP-ROLE | Role-assignable groups require Microsoft Entra ID P1. Just-in-time activation of the roles assigned to the group adds Privileged Identity Management licensing requirements. Any of: Microsoft Entra ID P1 (`AAD_PREMIUM`). | Tenant-wide feature; review Privileged Identity Management coverage separately for activation scenarios | group_based / per_tenant | documented |

Notes:

- A dynamic membership rule and a role-assignable group are separate licensed features, not interchangeable variants of the same test.
- When `group_types` contains `"Unified"`: Microsoft 365 group workloads (mailbox, site, Teams) require their own service and license review.

Sources: [Create user](https://learn.microsoft.com/en-us/graph/api/user-post-users?view=graph-rest-1.0), [Create group](https://learn.microsoft.com/en-us/graph/api/group-post-groups?view=graph-rest-1.0), [Create application](https://learn.microsoft.com/en-us/graph/api/application-post-applications?view=graph-rest-1.0), [Create servicePrincipal](https://learn.microsoft.com/en-us/graph/api/serviceprincipal-post-serviceprincipals?view=graph-rest-1.0), [Dynamic membership license requirements](https://learn.microsoft.com/en-us/entra/identity/users/groups-dynamic-membership#license-requirements), [Role-assignable groups license requirements](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/groups-concept#license-requirements).
<!-- licensing:end -->

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
