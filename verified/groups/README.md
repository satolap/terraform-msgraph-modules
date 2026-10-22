# groups

Creates a Microsoft Entra ID group (`groups`) via the `microsoft/msgraph` Terraform provider.

The module validates Graph's supported creation types: Microsoft 365 (`Unified`,
mail-enabled) or security groups (not mail-enabled). Dynamic groups require a rule
and cannot accept static `member_ids` or be role-assignable. Group owner/member
bindings currently target the public Microsoft Graph cloud.

`member_ids` binds members in the create request only; to keep the members in sync with a list
after creation, leave it empty and use [`groups/members`](members/README.md), which manages them
authoritatively on every apply.

Groups are one of the resource types that can be added to an entitlement management catalog
(`resource_origin_system = "AadGroup"`), and their member/owner roles can then be granted
through an access package. This module creates the group; use `catalogs/resources`
to add it to a catalog and `access-packages/resource-role-scopes` to grant its member/owner role.

## Usage

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one.

```hcl
module "engineering_group" {
  source  = "satolap/modules/msgraph//verified/groups"
  version = "<version>"

  display_name     = "Engineering"
  mail_nickname    = "engineering"
  security_enabled = true

  owner_ids  = [module.team_lead.id]
  member_ids = [module.developer.id]
}

# Microsoft 365 group
module "project_group" {
  source  = "satolap/modules/msgraph//verified/groups"
  version = "<version>"

  display_name  = "Project X"
  mail_nickname = "projectx"
  group_types   = ["Unified"]
  mail_enabled  = true
  visibility    = "Private"
}
```

## Mail nickname

`mail_nickname` takes at most 64 ASCII characters and none of `@ ( ) \ [ ] " ; : < > ,`
or a space, as Microsoft Learn's [group resource](https://learn.microsoft.com/en-us/graph/api/resources/group?view=graph-rest-1.0)
and [Create group](https://learn.microsoft.com/en-us/graph/api/group-post-groups?view=graph-rest-1.0)
pages document. A period is allowed, as in `help.desk`. The
[Update group](https://learn.microsoft.com/en-us/graph/api/group-update?view=graph-rest-1.0)
page also lists the period, so a change to a nickname with a period may be refused on update
even though creation accepts it.

## Replacement

Microsoft Graph sets `isAssignableToRole`, and the `HiddenMembership` visibility, only when
it creates a group. A change of `is_assignable_to_role` between `true` and `false` or `null`,
or of `visibility` to or from `"HiddenMembership"`, therefore replaces the group: Terraform
plans a destroy and a create of `msgraph_resource.group`. The old group is deleted before the
new one is created, because a Microsoft 365 group's mail nickname must be unique. The new
group has a new object ID, so role assignments, catalog resources and anything else that holds
the old ID must follow it. Owners and members are bound again from `owner_ids` and
`member_ids`; members added outside them are not. A deleted Microsoft 365 group or cloud
security group can be restored for 30 days; Microsoft Learn does not say whether it keeps its
mail nickname during that time, so if creating the new group fails on the nickname, either
permanently delete the old group or choose another `mail_nickname`. A change between `null`
and `false` keeps the group and sends nothing: `false` is Graph's default, so the module sends
`isAssignableToRole` only when it is `true`. A state written by an earlier release with
`is_assignable_to_role = false` plans one in-place update that drops the key from the stored
body; the provider sends no request for a key that left the body.

Because the old group is gone before Graph sees the new one, the plan refuses combinations
that Graph documents as invalid: a role-assignable group with a `visibility` other than `null`
or `"Private"`, and `"HiddenMembership"` on a group whose `group_types` lacks `"Unified"`.

`terraform_data.immutable` holds these two values and makes no API call. Upgrading from a
release without it plans only its creation and no change to the group. Terraform does not
replace in the apply that creates it, so make a change to these inputs in a later apply.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.11.0 |
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
| name_pattern | Regular expression (RE2, not anchored unless it says so) that display_name must match, or the plan fails; null accepts any name | `string` | `null` | no |
| mail_nickname | Mail alias, at most 64 ASCII characters; see [Mail nickname](#mail-nickname) | `string` | n/a | yes |
| mail_nickname_pattern | Regular expression (RE2, not anchored unless it says so) that mail_nickname must match, or the plan fails; null accepts any alias | `string` | `null` | no |
| description | Description of the group | `string` | `null` | no |
| security_enabled | Whether the group is a security group | `bool` | `true` | no |
| mail_enabled | Whether the group is mail-enabled | `bool` | `false` | no |
| group_types | `["Unified"]` for M365, `[]` for security; add `"DynamicMembership"` for dynamic | `list(string)` | `[]` | no |
| visibility | `Public`/`Private`/`HiddenMembership` (M365 groups only); a change to or from `HiddenMembership` replaces the group | `string` | `null` | no |
| is_assignable_to_role | Allow Entra role assignment to the group; a change replaces the group | `bool` | `null` | no |
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
