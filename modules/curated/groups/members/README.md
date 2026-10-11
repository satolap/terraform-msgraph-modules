# groups/members

Manages the **direct members** of one existing Microsoft Entra group
(`groups/{id}/members`) via the `microsoft/msgraph` Terraform provider's
`msgraph_resource_collection`. The folder sits under the [groups](../README.md) module, which
creates a group and can bind members only in its create request; this module keeps the members
of a group equal to a list on every apply.

**This module is authoritative over the direct members of the group.** Every apply adds the IDs
in `member_ids` that the group lacks and removes every direct member that `member_ids` does not
name: users, nested groups, devices, service principals and organizational contacts, including
members added in the admin center or by any other tool or process. An empty list removes every
member. Destroying the module or changing `group_id` removes members too; see
[Limits and lifecycle](#limits-and-lifecycle). Do not use it on a group whose membership another
process also manages, such as an access package that grants the group's member role or another
automation: each would undo the other's changes.

What the module manages, and what it does not:

- **Membership only.** The group must exist. The module neither creates nor reads the group, and
  it does not manage owners.
- **Direct members only.** The provider reads `GET /groups/{id}/members`, which Microsoft Learn
  describes as not transitive. Members of nested groups are neither compared nor changed.
- **One request per change.** For each missing member the provider sends
  `POST /groups/{id}/members/$ref` with
  `{"@odata.id": "https://graph.microsoft.com/<api_version>/directoryObjects/<member id>"}`, and
  for each extra member `DELETE /groups/{id}/members/{member id}/$ref`. It never uses the
  `PATCH /groups/{id}` with `members@odata.bind` that adds up to 20 members in one request.
- **Service principals need beta.** On `api_version = "v1.0"` Microsoft Graph does not list
  service principal members; see [API version and service principals](#api-version-and-service-principals).
- **No read of the group.** The module cannot see whether the group is dynamic, mail-enabled,
  synchronized or role-assignable. Where Microsoft Learn documents the response, Microsoft Graph
  refuses the member changes such a group does not allow; see
  [Groups whose members it cannot manage](#groups-whose-members-it-cannot-manage).
- **Retries the replication delay.** A member added right after the group was created can fail
  with a documented `400 Bad Request` until the group has replicated. The module retries that
  error, and only that error, until the create or update timeout.
- **IDs in lower case.** The module uses `group_id` and every member ID in lower case, so a
  change of case alone plans nothing.

## Usage

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-github) explains how to choose one.

```hcl
module "fabrikam_sponsors" {
  source = "git::https://github.com/satolap/terraform-msgraph-modules.git//modules/curated/groups?ref=<release-tag>"

  display_name  = "Fabrikam sponsors"
  mail_nickname = "fabrikam-sponsors"
  # Leave member_ids unset: the members module below manages the members.
}

module "fabrikam_sponsor_members" {
  source = "git::https://github.com/satolap/terraform-msgraph-modules.git//modules/curated/groups/members?ref=<release-tag>"

  group_id   = module.fabrikam_sponsors.id
  member_ids = [module.sponsor_one.id, module.sponsor_two.id]
}
```

When the group has, or should have, a service principal as a member, read the members on beta:

```hcl
module "automation_members" {
  source = "git::https://github.com/satolap/terraform-msgraph-modules.git//modules/curated/groups/members?ref=<release-tag>"

  group_id    = var.automation_group_id
  member_ids  = [module.deployment_identity.id, module.operator.id]
  api_version = "beta"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.0 |
| msgraph | >= 0.5.0 |

The offline test suite needs Terraform 1.7 or later. The module sets minimum versions only; set
upper bounds in your root module. microsoft/msgraph 0.5.0 is the first release whose
`msgraph_resource_collection` does not abort with "Provider produced inconsistent final plan"
when `member_ids` mixes IDs known during the plan with IDs known only during the same apply,
for example when one member object is replaced
([0.5.0 changelog](https://github.com/microsoft/terraform-provider-msgraph/blob/main/CHANGELOG.md)).
It also includes import, which arrived in 0.4.0.

| Operation | Least privileged application permission | Least privileged delegated roles |
| --- | --- | --- |
| [Add member](https://learn.microsoft.com/en-us/graph/api/group-post-members?view=graph-rest-1.0) | `GroupMember.ReadWrite.All`, and for a service principal member also `Application.ReadWrite.All`, for a device `Device.ReadWrite.All`, for an organizational contact `OrgContact.Read.All` | Group owners, Directory Writers, Groups Administrator, Identity Governance Administrator, User Administrator |
| [Remove member](https://learn.microsoft.com/en-us/graph/api/group-delete-members?view=graph-rest-1.0) | `GroupMember.ReadWrite.All` | Group owners, Directory Writers, Groups Administrator, Identity Governance Administrator, User Administrator |
| [List members](https://learn.microsoft.com/en-us/graph/api/group-list-members?view=graph-rest-1.0), on every refresh | `GroupMember.ReadBasic.All` | Group owners, "Member" users, Directory Readers, Directory Writers, Groups Administrator |

- `GroupMember.ReadWrite.All` includes the read. A delegated caller needs the same permissions
  (with `Device.Read.All` instead of `Device.ReadWrite.All` for a device) plus one of the roles.
  Learn also lists Exchange, SharePoint, Teams and Yammer Administrator for Microsoft 365 groups
  only, and Intune Administrator for security groups only.
- **Role-assignable groups.** Adding or removing members also needs
  `RoleManagement.ReadWrite.Directory`, and a delegated caller needs Privileged Role
  Administrator. Learn says `Group.ReadWrite.All` does not suffice
  ([role-assignable groups](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/groups-concept#how-are-role-assignable-groups-protected)).
- **Hidden membership groups.** Listing the members also needs `Member.Read.Hidden`.
- A `401` or `403` on the list fails the refresh, and with it the plan.

## Groups whose members it cannot manage

| Group | What Microsoft Learn says | What the module does |
| --- | --- | --- |
| Dynamic membership (`groupTypes` contains `DynamicMembership`) | "You can't manually add or remove a member of a dynamic membership group" ([dynamic membership](https://learn.microsoft.com/en-us/entra/identity/users/groups-dynamic-membership#considerations-for-dynamic-membership-groups)); the remove member page says the same | Every add and remove request fails; the error code is not documented. After an import, the refresh lists the rule's members and the plan removes those that `member_ids` does not name, and those requests fail too. |
| Mail-enabled security group or distribution group | Read-only in Microsoft Graph ([types of groups](https://learn.microsoft.com/en-us/graph/api/resources/groups-overview?view=graph-rest-1.0#types-of-groups-supported-in-microsoft-graph)) | The add member page documents `403 Forbidden` for a group that cannot be managed through Microsoft Graph. |
| Synchronized from on-premises Active Directory | Membership can be changed in the cloud after the group's source of authority is converted ([Group SOA](https://learn.microsoft.com/en-us/entra/identity/hybrid/concept-source-of-authority-overview)) | The response to a member change before the conversion is not verified. |
| Microsoft 365 group | Only users can be members ([add member](https://learn.microsoft.com/en-us/graph/api/group-post-members?view=graph-rest-1.0)) | Adding another object type returns `400 Bad Request` ("unsupported as a group member"). |
| Role-assignable group | Needs `RoleManagement.ReadWrite.Directory`; a group cannot be a member ([role-assignable groups](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/groups-concept#how-are-role-assignable-groups-protected)) | The add member page documents `403 Forbidden` without the permission. The response to adding a group is not documented. |
| Hidden membership | Listing needs `Member.Read.Hidden` ([list members](https://learn.microsoft.com/en-us/graph/api/group-list-members?view=graph-rest-1.0)) | What the list returns without it is not verified. |

The module does not read the group to fail at plan time. Such a read (`groupTypes`,
`membershipRule`, `isAssignableToRole`, `mailEnabled`, `securityEnabled`) would only move the
failure earlier: where Learn documents the response above, Microsoft Graph refuses the member
change, so the apply fails without changing the group. The read would cost a request on every
plan, a `401` or `403` on a top-level data source would fail every plan, and for a group created
in the same apply it would run right after the create, when Learn documents replication delays
for new groups and the provider's data source does not retry a `404`. It could not check the
member rules either (only users in a Microsoft 365 group, no group in a role-assignable group)
without reading every member.

## API version and service principals

Microsoft Learn documents a known issue: listing the members of a group on v1.0 does not return
service principals, and it recommends the beta endpoint or `$expand=members`
([list members](https://learn.microsoft.com/en-us/graph/api/group-list-members?view=graph-rest-1.0),
[known issue](https://learn.microsoft.com/en-us/graph/known-issues#get-groupsidmembers-doesnt-return-service-principals-in-v10)).
The provider can only list the collection, so on `api_version = "v1.0"`:

- **A service principal in `member_ids` fails every apply after the first.** The first apply adds
  it. Every later refresh does not list it, so every plan shows it as missing, and the apply sends
  the `POST` again. It is not added twice: Learn documents `400 Bad Request` for an object that is
  already a member, so the apply fails. Whether Graph returns exactly that on v1.0 is not verified.
- **A service principal added outside Terraform is never removed,** and a destroy leaves it in
  the group. The authoritative guarantee does not cover service principals on v1.0.

Rule: **set `api_version = "beta"` whenever the group has or may get a service principal
member.** A validation cannot enforce it, because a member ID is a GUID and the module cannot
tell a service principal from a user without reading every object. Choose the version before the
first apply: after a switch from v1.0 to beta, service principal members that `member_ids` does
not name become visible and the next apply removes them. Learn says that APIs under `/beta` are
subject to change and that their use in production applications is not supported.

## Limits and lifecycle

- **A destroy removes members.** Destroying the module, including removing the module call,
  removes every member that the state lists. Terraform refreshes before a destroy, so that is every
  direct member the list returned, not only those in `member_ids`. The provider's `skip_destroy`
  argument is not exposed, so that a removed module call always removes what it added. To stop managing
  the members without removing them, use a `removed` block with `lifecycle { destroy = false }`
  for the module call (Terraform 1.7 or later) or `terraform state rm`. When the group is
  destroyed in the same apply, Terraform removes the members first, because the collection
  depends on the group ID.
- **Changing `group_id` replaces the collection.** The provider replaces the collection when its
  url changes. The old collection is destroyed first: every member of the old group that the state
  lists is removed, then `member_ids` are added to the new group. If the old group no longer
  exists, the refresh finds it gone and drops it from the state.
- **A group that already has members.** The provider's create adds every ID without reading the
  group first, and Graph returns `400 Bad Request` for an object that is already a member, so the
  first apply on such a group fails for each listed member it already has. A first apply that
  failed part-way, for example on a timeout or a rejected ID, leaves the same situation: the
  members it added stay, but the state holds no collection. Import the collection, then plan: the plan shows the changes from the group's current members. Use the group
  ID in lower case, as the module does, or the plan replaces the collection.
  ```shell
  terraform import 'module.<name>.msgraph_resource_collection.this' 'groups/<group-id>/members/$ref'
  # with api_version = "beta":
  terraform import 'module.<name>.msgraph_resource_collection.this' 'groups/<group-id>/members/$ref?api-version=beta'
  ```
- **Bind members in one place.** Leave `member_ids` of the [groups](../README.md) module empty
  for a group this module manages. Members bound at creation are already members when this
  module's create adds them, so it fails as described above.
- **Requests and failures.** The provider sends the additions first, then the removals. A failed
  request does not stop the others, and the apply then fails with every error. The next refresh
  reads the group again, so the next plan starts from its actual members.
- **Replication delay.** Learn documents `400 Bad Request` with "The source resource object or one
  of the objects being referenced don't exist." for a group that was created moments before, and
  says to retry after a brief delay. The module sets the provider's `retry` to that message, so
  the request is retried until the create or update timeout. Whether Graph returns the message
  for any other cause is not verified; a request that keeps failing with it fails at the timeout.
- **Timeouts.** Create, update and delete send one request per member added or removed. The
  provider's defaults in 0.3.0 to 0.5.0 are 30 minutes for create, update and delete and 5 minutes
  for read. Raise `timeouts` for a large change.
- **Paging and query parameters.** The provider follows `@odata.nextLink`; Learn gives a default
  page size of 100. The module sends no query parameters: Learn supports them on this list only as
  advanced queries, which need a `ConsistencyLevel` header that the provider does not send.
- **Order and case.** Order does not matter: the provider ignores a change of order. A GUID has no
  case, but the provider compares member IDs as written and stores them as Graph returns them, so
  the module uses every ID in lower case.
- **Unknown IDs.** A `group_id` or member ID that is known only after apply, such as the ID of a
  group created in the same apply, plans the collection with an unknown url or list; the requests
  are sent after the group exists.

## Live test status

Live test status: not verified in a licensed tenant. The module is tested with a mock provider
only. These checks are pending:

1. Create the members of a group created in the same apply: whether the replication delay error
   occurs, and whether the retry expression matches the message Graph returns.
2. Authoritative removal of members added outside Terraform: a user, a nested group, a device, an
   organizational contact, and a service principal on beta.
3. A service principal on v1.0: the plan that shows it missing and the `400` on the next apply.
4. The case of member IDs in the list response.
5. A destroy, a `removed` block with `destroy = false`, and a change of `group_id`.
6. Import, the first plan after an import, and a first apply on a group that already has members.
7. The responses for a dynamic, mail-enabled, synchronized and role-assignable group, and for a
   non-user member of a Microsoft 365 group.
8. The list of a hidden membership group without `Member.Read.Hidden`.
9. A refresh right after an apply that does not yet list a member just added.
10. Duration and throttling for several hundred members, and the `403` behaviour under the least
    privileged permissions.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | DIRECTORY-BASIC | The reviewed create APIs for users, assigned security groups, applications and service principals specify no additional premium license. This covers the object operation only; features built on these objects can require licenses. No additional license specified. | No per-user entitlement for the object operation itself | direct / per_tenant | documented |

Notes:

- The add member, remove member and list members pages state no license requirement for the operation, and Microsoft Entra ID Free includes user and group management ([Microsoft Entra ID Free](https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/microsoft-entra-id-free)). The DIRECTORY-BASIC rule is applied to group membership by inference.
- Adding a member to a group with group-based licensing assigns the group's licenses to the member, and removing the member removes them ([Manage groups in Microsoft Graph](https://learn.microsoft.com/en-us/graph/api/resources/groups-overview?view=graph-rest-1.0#group-based-licensing)). The module does not check license capacity.
- A role-assignable group needs Microsoft Entra ID P1 (GROUP-ROLE), and the members of a dynamic membership group cannot be changed at all. Both are properties of the group, which this module does not read, so no input condition applies.
- The group membership rules were reviewed against Microsoft Learn on 2026-10-07, which is later than the review date stated above.

Sources: [Create user](https://learn.microsoft.com/en-us/graph/api/user-post-users?view=graph-rest-1.0), [Create group](https://learn.microsoft.com/en-us/graph/api/group-post-groups?view=graph-rest-1.0), [Create application](https://learn.microsoft.com/en-us/graph/api/application-post-applications?view=graph-rest-1.0), [Create servicePrincipal](https://learn.microsoft.com/en-us/graph/api/serviceprincipal-post-serviceprincipals?view=graph-rest-1.0).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| group_id | Object ID of the existing group; a change replaces the collection, a change of case alone does not | `string` | n/a | yes |
| member_ids | Object IDs of every direct member; authoritative, may be empty, not null; GUIDs, each named once (case-insensitive) | `list(string)` | n/a | yes |
| api_version | `v1.0` or `beta`; use `beta` when a member can be a service principal | `string` | `"v1.0"` | no |
| timeouts | `create`, `read`, `update` and `delete` timeouts, such as `30m`; null keeps the provider's default; the replication delay retry counts against them | `object` | `{}` (provider defaults) | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The provider's ID of the collection, `groups/{group_id}/members`; a reference waits until the membership is applied |
| group_id | The object ID of the group, in lower case |
| member_ids | The member IDs the module manages, in lower case; a reference waits until the membership is applied |

## Tests

`tests/group_members.tftest.hcl` runs offline against a mock provider and needs Terraform 1.7 or
later: `terraform init` and `terraform test` in this folder. It covers the url, the reference
IDs, the API version, the retry expression (that it matches the documented replication message
and not the errors for an existing or a missing object), lower-casing, the empty list, the
timeouts, the outputs and every validation. A mock provider does not run the provider's plan
modifiers, so the replacement on a changed url and the order-insensitive comparison are the
provider's documented and coded behaviour, not tested here. A Python test
(`tests/test_group_members.py`) checks the validation messages, the arguments the module leaves
to the provider (`collection_type`, `skip_destroy`, query parameters) and this README's rules.
There is no live suite yet; see [Live test status](#live-test-status).
