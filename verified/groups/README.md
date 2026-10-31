# groups

<!-- state-protection:start -->
## State and plan protection

This module's state and saved plans retain these declared values:

Potential personal-data inputs: `member_ids`, `owner_ids`.

Protect these values with an encrypted remote backend and least-privilege access to state, plans and backups. `sensitive` is presentation redaction, not encryption; provider resource values can still appear in plan/show output. Do not publish plan output in CI logs or PR comments for secret-bearing roots; keep saved plans short-lived and rotate credentials after exposure.

See [Terraform sensitive state guidance](https://developer.hashicorp.com/terraform/language/state/sensitive-data). These are exposure indicators, not a complete data classification; unmarked fields and provider responses also need protection.
<!-- state-protection:end -->

<!-- uses-beta:start -->
Uses beta: **optional**. Beta is an optional api_version selection for compatibility; no beta-only capability is required by this module's contract. Prefer v1.0. Beta is preview and may change without notice. Pin module and provider versions; read `interface-changes.json` before upgrading.
<!-- uses-beta:end -->

<!-- live-status:start -->
Assurance: **verified live-accepted** (2026-10-24, commit `344ecc7e`). Acceptance covers the recorded run and configuration.

![live Dev: passed 2026-10-24](https://img.shields.io/badge/live%20Dev-passed%202026--10--24-brightgreen)
<!-- live-status:end -->

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

Replace `<version>` with a release version, such as `0.5.0`; the [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one.

```hcl
module "engineering_group" {
  source  = "satolap/modules/msgraph//verified/groups"
  version = "<version>"

  displayName     = "Engineering"
  mailNickname    = "engineering"
  securityEnabled = true

  owner_ids  = [module.team_lead.id]
  member_ids = [module.developer.id]
}

# Microsoft 365 group
module "project_group" {
  source  = "satolap/modules/msgraph//verified/groups"
  version = "<version>"

  displayName  = "Project X"
  mailNickname = "projectx"
  groupTypes   = ["Unified"]
  mailEnabled  = true
  visibility   = "Private"
}
```

## Mail nickname

`mailNickname` takes at most 64 ASCII characters and none of `@ ( ) \ [ ] " ; : < > ,`
or a space, as Microsoft Learn's [group resource](https://learn.microsoft.com/en-us/graph/api/resources/group?view=graph-rest-1.0)
and [Create group](https://learn.microsoft.com/en-us/graph/api/group-post-groups?view=graph-rest-1.0)
pages document. A period is allowed, as in `help.desk`. The
[Update group](https://learn.microsoft.com/en-us/graph/api/group-update?view=graph-rest-1.0)
page also lists the period, so a change to a nickname with a period may be refused on update
even though creation accepts it.

## Replacement

Microsoft Graph sets `isAssignableToRole`, and the `HiddenMembership` visibility, only when
it creates a group. A change of `isAssignableToRole` between `true` and `false` or `null`,
or of `visibility` to or from `"HiddenMembership"`, therefore replaces the group: Terraform
plans a destroy and a create of `msgraph_resource.group`. The old group is deleted before the
new one is created, because a Microsoft 365 group's mail nickname must be unique. The new
group has a new object ID, so role assignments, catalog resources and anything else that holds
the old ID must follow it. Owners and members are bound again from `owner_ids` and
`member_ids`; members added outside them are not. A deleted Microsoft 365 group or cloud
security group can be restored for 30 days; Microsoft Learn does not say whether it keeps its
mail nickname during that time, so if creating the new group fails on the nickname, either
permanently delete the old group or choose another `mailNickname`. A change between `null`
and `false` keeps the group and sends nothing: `false` is Graph's default, so the module sends
`isAssignableToRole` only when it is `true`. A state written by an earlier release with
`isAssignableToRole = false` plans one in-place update that drops the key from the stored
body; the provider sends no request for a key that left the body.

Because the old group is gone before Graph sees the new one, the plan refuses combinations
that Graph documents as invalid: a role-assignable group with a `visibility` other than `null`
or `"Private"`, and `"HiddenMembership"` on a group whose `groupTypes` lacks `"Unified"`.

`terraform_data.immutable` holds these two values and makes no API call. Upgrading from a
release without it plans only its creation and no change to the group. Terraform does not
replace in the apply that creates it, so make a change to these inputs in a later apply.

### Mail settings and the Microsoft 365 group type are fixed at creation

Microsoft Learn's update group page does not list `mailEnabled` among the updatable properties,
and Microsoft Graph documents no conversion between a security group and a Microsoft 365 group.
A change of `mailEnabled`, or adding or removing `"Unified"` in `groupTypes`, therefore fails
the plan instead of sending a PATCH that Graph may refuse or ignore. Create a new group with the
other setting and move its members and references. Adding or removing `"DynamicMembership"`
(with `membershipRule`) is documented as a change of an existing group and updates it in place.
`terraform_data.created` keeps the creation-time values, makes no API call and is replaced with
`terraform_data.immutable`, so a replacement of the group may carry new mail settings. A group
that exists from before this resource, or that was imported, takes its snapshot from the first
plan, which therefore cannot refuse a conversion made in that same plan: upgrade first with
unchanged `mailEnabled` and `groupTypes`. Two postconditions compare the `mailEnabled` and
`groupTypes` values that Graph returns with the configuration, so a conversion that Graph ignored
fails the apply, and a missing read-back fails it too.
This is documentation-based; a live run records what Graph does (GB-directory-objects-519, -520).

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.11.0 |
| msgraph | >= 0.3.0 |

Requires the `Group.ReadWrite.All` Microsoft Graph permission (or `Directory.ReadWrite.All`).
Setting `isAssignableToRole = true` additionally requires `RoleManagement.ReadWrite.Directory`.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

Before deployment, check the requirements of the features you enable and the users who benefit. You can inspect tenant subscriptions with `GET /subscribedSkus`; this requires `Organization.Read.All` or `LicenseAssignment.Read.All` ([List subscribedSkus](https://learn.microsoft.com/en-us/graph/api/subscribedsku-list?view=graph-rest-1.0)).

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | DIRECTORY-BASIC | The reviewed create APIs for users, assigned security groups, applications and service principals specify no additional premium license. This covers the object operation only; features built on these objects can require licenses. No additional license specified. | No per-user entitlement for the object operation itself | direct / per_tenant | documented |
| `groupTypes` contains `"DynamicMembership"` | GROUP-DYNAMIC | Dynamic user membership requires Microsoft Entra ID P1 or Intune for Education coverage in the tenant for each unique user who is a member of one or more dynamic groups. Licenses do not have to be assigned directly to those users. Device-only dynamic membership has no per-device license requirement. Any of: Microsoft Entra ID P1 (`AAD_PREMIUM`); Intune for Education (`INTUNE_EDU`). | Each unique user who is a member of any dynamic group | group_based / per_tenant | documented |
| `isAssignableToRole` is `true` | GROUP-ROLE | Role-assignable groups require Microsoft Entra ID P1. Just-in-time activation of the roles assigned to the group adds Privileged Identity Management licensing requirements. Any of: Microsoft Entra ID P1 (`AAD_PREMIUM`). | Tenant-wide feature; review Privileged Identity Management coverage separately for activation scenarios | group_based / per_tenant | documented |

Notes:

- A dynamic membership rule and a role-assignable group are separate licensed features, not interchangeable variants of the same test.
- When `groupTypes` contains `"Unified"`: Microsoft 365 group workloads (mailbox, site, Teams) require their own service and license review.

Sources: [Create user](https://learn.microsoft.com/en-us/graph/api/user-post-users?view=graph-rest-1.0), [Create group](https://learn.microsoft.com/en-us/graph/api/group-post-groups?view=graph-rest-1.0), [Create application](https://learn.microsoft.com/en-us/graph/api/application-post-applications?view=graph-rest-1.0), [Create servicePrincipal](https://learn.microsoft.com/en-us/graph/api/serviceprincipal-post-serviceprincipals?view=graph-rest-1.0), [Dynamic membership license requirements](https://learn.microsoft.com/en-us/entra/identity/users/groups-dynamic-membership#license-requirements), [Role-assignable groups license requirements](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/groups-concept#license-requirements).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required | On change |
|------|-------------|------|---------|----------| --- |
| displayName | Display name of the group | `string` | n/a | yes | in place |
| name_pattern | Regular expression (RE2, not anchored unless it says so) that displayName must match, or the plan fails; null accepts any name | `string` | `null` | no | no object change (validation or timing only) |
| mailNickname | Mail alias, at most 64 ASCII characters; see [Mail nickname](#mail-nickname) | `string` | n/a | yes | in place |
| mail_nickname_pattern | Regular expression (RE2, not anchored unless it says so) that mailNickname must match, or the plan fails; null accepts any alias | `string` | `null` | no | no object change (validation or timing only) |
| description | Description of the group | `string` | `null` | no | in place |
| securityEnabled | Whether the group is a security group | `bool` | `true` | no | in place |
| mailEnabled | Whether the group is mail-enabled | `bool` | `false` | no | kept from creation: a change is refused or ignored (see notes) |
| groupTypes | `["Unified"]` for M365, `[]` for security; add `"DynamicMembership"` for dynamic | `list(string)` | `[]` | no | kept from creation: a change is refused or ignored (see notes) |
| visibility | `Public`/`Private`/`HiddenMembership` (M365 groups only); a change to or from `HiddenMembership` replaces the group | `string` | `null` | no | replaces `msgraph_resource.group` when `var.visibility == "HiddenMembership"` changes |
| isAssignableToRole | Allow Entra role assignment to the group; a change replaces the group | `bool` | `null` | no | replaces `msgraph_resource.group` when `var.isAssignableToRole == true` changes |
| membershipRule | Dynamic membership rule (required with `DynamicMembership`) | `string` | `null` | no | in place |
| owner_ids | Directory object IDs to set as owners | `list(string)` | `[]` | no | changes `msgraph_resource.group`; see the module notes |
| member_ids | Directory object IDs to set as members | `list(string)` | `[]` | no | changes `msgraph_resource.group`; see the module notes |
| api_version | Graph API version (`v1.0` or `beta`) | `string` | `"v1.0"` | no | in place |

Unique values, inferred from the pinned metadata (declaration.json gives each source): `mailNickname` within the tenant, among Microsoft 365 groups. Graph refuses a value already used in that scope.

## Outputs

| Name | Description | Known in plan after an update |
|------|-------------| --- |
| id | The object ID of the group (use as `resource_origin_id` for catalog/role-scope modules) | yes |
| display_name | The display name of the group | no |
| mail | The SMTP address, if mail-enabled | no |

<!-- drift:start -->
## Drift and out-of-band changes

Terraform plans compare configuration and refreshed provider state. A plan that changes one of these inputs proposes its declared effect; review the plan before applying. The consumer guide explains refresh limits and emergency reconciliation.

- `displayName`: in place.
- `mailNickname`: in place.
- `description`: in place.
- `securityEnabled`: in place.
- `mailEnabled`: kept from creation: a change is refused or ignored (see notes).
- `groupTypes`: kept from creation: a change is refused or ignored (see notes).
- `visibility`: replaces `msgraph_resource.group` when `var.visibility == "HiddenMembership"` changes.
- `isAssignableToRole`: replaces `msgraph_resource.group` when `var.isAssignableToRole == true` changes.
- `membershipRule`: in place.
- `owner_ids`: changes `msgraph_resource.group`; see the module notes.
- `member_ids`: changes `msgraph_resource.group`; see the module notes.
- `api_version`: in place.
- `name_pattern`: no object change (validation or timing only).
- `mail_nickname_pattern`: no object change (validation or timing only).
<!-- drift:end -->

<!-- permissions:begin -->
## Per-operation permissions

Source: [Graph DevX map](https://raw.githubusercontent.com/microsoftgraph/microsoft-graph-devx-content/56e1917fe45fb7c52c2d9845f569c2ffdb39e4d9/permissions/new/permissions.json) (SHA-256 `4d7dee52659b1d6424bce0b26603302081d39ef9e149bc5fb50de4273b3d3514`).
The map is shared by v1.0 and beta; it does not certify API-version support. Rows show the source's least-privilege annotations, not live-tested consent. Choose an alternative for your authentication type; do not grant every listed scope. AlsoRequires lists additional scope alternatives attached to that row. Missing annotations are unknown, not evidence that an operation needs no permission. Keep the module's documented role, property-specific and tenant restrictions.

Derived from this module's Terraform sources, including optional guards, destroy actions and local child modules. The checked inventory is `docs/permissions/verified-operations.json`. These are potential requests, not a preflight scope list. A provider primitive may expose an update that Graph does not support. Source paths and conditions are retained in the inventory.

| Operation | Authentication | Least-privilege alternative | AlsoRequires | Unknown reason |
| --- | --- | --- | --- | --- |
| `POST /groups` | DelegatedWork | `Group.ReadWrite.All` | - | - |
| `POST /groups` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `POST /groups` | Application | `Group.Create` | - | - |
| `GET /groups/{id}` | DelegatedWork | `Group-NestingSupport.ReadWrite.All` | - | - |
| `GET /groups/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `GET /groups/{id}` | Application | `Group-NestingSupport.ReadWrite.All` | - | - |
| `DELETE /groups/{id}` | DelegatedWork | `Group.ReadWrite.All` | - | - |
| `DELETE /groups/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `DELETE /groups/{id}` | Application | `Group.ReadWrite.All` | - | - |
| `PATCH /groups/{id}` | DelegatedWork | `Group-NestingSupport.ReadWrite.All` | - | - |
| `PATCH /groups/{id}` | DelegatedPersonal | Unknown / not annotated | - | The pinned DevX entry omits this authentication scheme; support is not inferred. |
| `PATCH /groups/{id}` | Application | `Group-NestingSupport.ReadWrite.All` | - | - |

### Property-specific coverage

Route annotations do not establish that the listed scopes cover every selected or writable property. Dynamic bodies, additional properties and default responses remain unbounded. Keep the reviewed permission guidance above; in particular, a group-nesting scope is not general group-property access. The pin's method/path entries do not distinguish property grants from navigation or sub-resource operations; property coverage stays unknown.

| Operation | Properties | Source evidence |
| --- | --- | --- |
| `POST /groups` | `description`, `displayName`, `groupTypes`, `isAssignableToRole`, `mailEnabled`, `mailNickname`, `members@odata.bind`, `membershipRule`, `membershipRuleProcessingState`, `owners@odata.bind`, `securityEnabled`, `visibility` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
| `PATCH /groups/{id}` | `description`, `displayName`, `groupTypes`, `isAssignableToRole`, `mailEnabled`, `mailNickname`, `members@odata.bind`, `membershipRule`, `membershipRuleProcessingState`, `owners@odata.bind`, `securityEnabled`, `visibility` | Unknown: the pinned DevX method/path entries do not establish property-specific grants; route annotations alone do not prove coverage. |
<!-- permissions:end -->
