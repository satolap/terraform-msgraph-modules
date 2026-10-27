# directory/administrative-units

<!-- state-protection:start -->
## State and plan protection

This module's state and saved plans retain these declared values:

Potential personal-data inputs: `member_ids`, `scoped_role_members`.

Protect these values with an encrypted remote backend and least-privilege access to state, plans and backups. `sensitive` is presentation redaction, not encryption; provider resource values can still appear in plan/show output. Do not publish plan output in CI logs or PR comments for secret-bearing roots; keep saved plans short-lived and rotate credentials after exposure.

See [Terraform sensitive state guidance](https://developer.hashicorp.com/terraform/language/state/sensitive-data). These are exposure indicators, not a complete data classification; unmarked fields and provider responses also need protection.
<!-- state-protection:end -->

<!-- uses-beta:start -->
Uses beta: **no**. This module and its local child modules do not select beta.
<!-- uses-beta:end -->

<!-- live-status:start -->
Assurance: **verified offline-only**. No current live acceptance is recorded for this module.

![live: offline only](https://img.shields.io/badge/live-offline%20only-lightgrey)
<!-- live-status:end -->

Manages one Microsoft Entra **administrative unit** (`directory/administrativeUnits`) and,
optionally, its members via the `microsoft/msgraph` Terraform provider. An administrative
unit holds users, groups and devices, and limits the scope of the Microsoft Entra roles that
are assigned over it. The folder mirrors the Graph collection it manages.

What the module manages, and what it does not:

- **The unit:** display name, description, visibility (public or hidden membership), the
  restricted management setting, and assigned or dynamic membership with its rule.
- **The members, when you ask for them.** `member_ids` is a list of user, group and device
  object IDs. Null leaves the members unmanaged and creates no member resource. A list,
  including an empty one, is authoritative: the module adds the IDs that are missing and
  removes every other member, including members added outside Terraform.
- **Scoped role members, when you ask for them.** `scoped_role_members` is a map, with keys
  that you choose, of `{ role_id, member_id }` pairs, each a Microsoft Entra role assignment
  limited to this unit
  (`directory/administrativeUnits/{id}/scopedRoleMembers`). The map is additive, not
  authoritative: assignments that were added elsewhere are neither read nor removed. Learn
  documents no update for one, so a changed pair (or a renamed key) deletes the old assignment
  and creates the new one. The keys are known at plan time, so `role_id` and `member_id` can be
  IDs of objects that the same apply creates. Renaming a key while keeping the same pair runs a
  create and a delete with no ordering between them: the create can conflict with the
  assignment that still exists, and a second apply clears it. The repository has no verified module for tenant `roleManagement/directory/roleAssignments`,
  so this input is the one writer for scoped role members of the unit; do not also make the same
  assignment with a `roleAssignments` resource whose `directoryScopeId` is `directory_scope_id`.
  A role assignment of another kind (for example a custom role, or one made through
  `verified/role-management/directory/role-schedules`) can still use `directory_scope_id`.
- **Not supported:** groups created inside the unit, open extensions (the documented
  `extensions` relationship), and the restore of a deleted unit. The Graph v1.0 administrativeUnit
  resource has no other writable property than the ones above.
- **Every managed key is in the body,** on create and on update, except the dynamic rule and
  its processing state, which are sent only for a dynamic unit. Microsoft Learn says that an
  update keeps the properties its body omits, so the module sends `description` and
  `visibility` as `null` when they are unset rather than leaving them out.
- **The restriction cannot change in place.** Learn documents `isMemberManagementRestricted`
  as immutable, so changing `is_member_management_restricted` replaces the unit, and the new
  unit is created before the old one is deleted.
- v1.0 only. There is no `api_version` input.

## When to use this module instead of a generated one

As published when this module was written, the generated module for the same collection
(`modules/generated/v1.0/identity-and-access/directory/administrative-units`) takes every
property as an optional string or boolean, without validating the visibility or the
membership values or requiring a display name, next to an untyped `additional_properties`
input; sends a change of `is_member_management_restricted` as an update, which Learn does not
document because the property is immutable; and cannot manage members, because its `members`
input carries no object IDs and Graph adds members through the `members/$ref` relationship,
not the unit's body. Prefer this module: its inputs are typed and validated, it rejects a
dynamic unit with listed members or an assigned unit with a rule, it replaces the unit when the
restriction changes, and it manages the members as one authoritative collection.

## Usage

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one.

An administrative unit that holds three security groups created in the same configuration:

```hcl
module "partner_groups" {
  source   = "satolap/modules/msgraph//verified/groups"
  version  = "<version>"
  for_each = toset(["owners", "approvers", "members"])

  display_name  = "Fabrikam ${each.key}"
  mail_nickname = "fabrikam-${each.key}"
}

module "partner_unit" {
  source  = "satolap/modules/msgraph//verified/directory/administrative-units"
  version = "<version>"

  display_name = "Fabrikam partner groups"
  description  = "Groups that manage access for the Fabrikam connected organization"
  member_ids   = [for key in ["owners", "approvers", "members"] : module.partner_groups[key].id]
}
```

The group IDs are unknown until the groups exist. The list that holds them is known, so the
plan counts the member resource; the members are added after the groups are created, through
the data flow alone, with no `depends_on`. `member_ids` must be a list whose length is known at
plan time. `module.partner_unit.member_ids` returns the managed IDs, in lower case, after they
are added.

A dynamic unit whose rule selects its members:

```hcl
module "sales_unit" {
  source  = "satolap/modules/msgraph//verified/directory/administrative-units"
  version = "<version>"

  display_name    = "Contoso sales"
  membership_type = "Dynamic"
  membership_rule = "(user.department -eq \"Sales\")"
}
```

A unit with a user, a group and a device as members, and a user who holds a role over the unit.
`role_id` is the object ID of the directory role as activated in the tenant (the `id` of
`/directoryRoles`, not the `roleTemplateId` and not a role definition ID):

```hcl
module "devices_unit" {
  source  = "satolap/modules/msgraph//verified/directory/administrative-units"
  version = "<version>"

  display_name = "Contoso devices"
  member_ids   = [var.user_object_id, var.group_object_id, var.device_object_id]

  scoped_role_members = {
    partner_groups_administrator = {
      role_id   = var.groups_administrator_directory_role_id
      member_id = var.partner_administrator_id
    }
  }
}
```

A role assignment of another kind over the unit, such as a custom role, takes
`directory_scope_id` (`/administrativeUnits/{id}`) as its `directoryScopeId`. Do not make the
same assignment as a scoped role member and as a `roleAssignments` resource.

```hcl
resource "msgraph_resource" "partner_groups_administrator" {
  url = "roleManagement/directory/roleAssignments"
  body = {
    principalId      = var.partner_administrator_id
    roleDefinitionId = var.custom_role_definition_id
    directoryScopeId = module.partner_unit.directory_scope_id
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.11.0 |
| msgraph | >= 0.5.0 |

The offline test suite needs the same Terraform minimum. The module sets minimum versions only; set
upper bounds in your root module. The module needs `microsoft/msgraph` 0.5.0 or later, because
`member_ids` can mix known IDs with IDs that are known only after apply, for example when one
of several member groups is replaced, and the provider's 0.5.0 changelog fixes a "Provider
produced inconsistent final plan" error on `reference_ids` in that case.

| Operation | Least privileged application permission | Least privileged delegated role |
| --- | --- | --- |
| [Create](https://learn.microsoft.com/en-us/graph/api/directory-post-administrativeunits?view=graph-rest-1.0) | `AdministrativeUnit.ReadWrite.All` | Privileged Role Administrator |
| [Update](https://learn.microsoft.com/en-us/graph/api/administrativeunit-update?view=graph-rest-1.0) | `AdministrativeUnit.ReadWrite.All` | Privileged Role Administrator |
| [Delete](https://learn.microsoft.com/en-us/graph/api/administrativeunit-delete?view=graph-rest-1.0) | `AdministrativeUnit.ReadWrite.All` | Privileged Role Administrator |
| [Read, to refresh](https://learn.microsoft.com/en-us/graph/api/administrativeunit-get?view=graph-rest-1.0) | `AdministrativeUnit.Read.All` | Directory Readers (basic properties), Global Reader |
| [Add a member](https://learn.microsoft.com/en-us/graph/api/administrativeunit-post-members?view=graph-rest-1.0) | `AdministrativeUnit.ReadWrite.All` | Privileged Role Administrator |
| [Remove a member](https://learn.microsoft.com/en-us/graph/api/administrativeunit-delete-members?view=graph-rest-1.0) | `AdministrativeUnit.ReadWrite.All` | Privileged Role Administrator |
| [Assign a scoped role member](https://learn.microsoft.com/en-us/graph/api/administrativeunit-post-scopedrolemembers?view=graph-rest-1.0) | `RoleManagement.ReadWrite.Directory` | Privileged Role Administrator |
| [Remove a scoped role member](https://learn.microsoft.com/en-us/graph/api/administrativeunit-delete-scopedrolemembers?view=graph-rest-1.0) | `RoleManagement.ReadWrite.Directory` | Privileged Role Administrator |
| [Read a scoped role member, to refresh](https://learn.microsoft.com/en-us/graph/api/administrativeunit-get-scopedrolemembers?view=graph-rest-1.0) | `RoleManagement.Read.Directory` or `RoleManagement.ReadWrite.Directory` | Directory Readers, Global Reader |
| [List the members, to refresh](https://learn.microsoft.com/en-us/graph/api/administrativeunit-list-members?view=graph-rest-1.0) | `AdministrativeUnit.Read.All`, and `Member.Read.Hidden` for a unit with hidden membership | Directory Readers, Global Reader |

- Every write to the unit and its members needs `AdministrativeUnit.ReadWrite.All`, which also
  covers the reads. `scoped_role_members` also needs `RoleManagement.ReadWrite.Directory` for
  its writes and `RoleManagement.Read.Directory` (or the write permission) for its reads. Learn
  names Privileged Role Administrator as the least privileged role for each write.
- The member resource reads the members with the list operation (`.../members`), not
  `.../members/$ref`. Learn says that an application without permission to read a member's
  type still receives the member with its `id`, which is all the resource needs.
- **Hidden membership.** Learn says that listing the members of a unit with hidden membership
  also needs `Member.Read.Hidden`. What the read returns without it is not verified; if it
  returns no members, every plan would add the managed members again.
- **Restricted management units.** Learn names Global Administrator and Privileged Role
  Administrator as the tenant-scope roles that can create and delete a restricted management
  unit and add or remove its members, and says that Microsoft Graph application permissions
  do not apply to the objects in such a unit. Whether an application that holds
  `AdministrativeUnit.ReadWrite.All` can add members to a restricted management unit or remove
  them is not verified.
- **Objects in a restricted management unit.** Once a group or user is a member of a
  restricted management unit, only administrators and applications assigned a role at the
  scope of that unit can modify it; tenant-level roles and application permissions cannot.
  The identity that manages a member group with another module then needs a role, such as
  Groups Administrator, assigned at `directory_scope_id`.
- Run Terraform for this module as a dedicated automation identity.
- Only Microsoft Graph v1.0 is supported.

## Restricted management units

`is_member_management_restricted = true` creates a
[restricted management administrative unit](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/admin-units-restricted-management).
Learn documents these rules:

- The setting is made at creation and cannot be changed, so the module replaces the unit.
- Users, devices and security groups can be members. Microsoft 365 groups, mail-enabled
  security groups and distribution groups cannot: a group must be security-enabled, not
  mail-enabled, not a Microsoft 365 group and not synchronized from on-premises. The module
  does not check the type of a member.
- **Groups and users in such a unit cannot be managed with Microsoft Entra ID Governance
  features**, such as entitlement management, access reviews, lifecycle workflows and
  Privileged Identity Management. Do not put groups that an access package grants into a
  restricted management unit.
- The membership of a role-assignable group in such a unit can be modified only by Global
  Administrators and Privileged Role Administrators.
- A tenant can hold at most 100 restricted management units.
- When such a unit is deleted, removing its protections from the former members can take up
  to 30 minutes.

## Dynamic membership

`membership_type = "Dynamic"` with `membership_rule` lets a rule select the members, as in
[dynamic administrative units](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/admin-units-members-dynamic).
Learn documents these rules:

- The rule uses the syntax and attributes of dynamic membership groups. A dynamic unit holds
  users or devices, not both, and no groups. The module does not parse the rule.
- Adding and removing members is disabled for a dynamic unit, so `member_ids` must be null.
- `membership_rule_processing_state` is `On` (the module's default for a dynamic unit) or
  `Paused`.
- Changing an assigned unit to dynamic can change its members according to the rule. Changing
  it back to assigned keeps the current members; the module then sends `membershipType`
  alone, as Learn's example does, and Learn says the rule is then no longer processed.
- Dynamic units are available in the global Azure cloud only, not in specialized clouds such
  as Azure Government or Microsoft Azure operated by 21Vianet.
- Learn's property table lists the membership types as `dynamic` and `assigned`, while every
  request and response example uses `Dynamic` and `Assigned`. The module accepts the
  capitalized values that the examples use.

To change a unit whose members this module manages to dynamic membership, apply twice: first
set `member_ids` to null (see [Limits and lifecycle](#limits-and-lifecycle) for what that
removes) and apply, then set `membership_type` and `membership_rule` and apply. In one apply,
the order of the member removals and the update to dynamic is not verified, and Learn says
that a dynamic unit refuses member removals.

## Limits and lifecycle

- **Same Terraform state.** Keep the unit and the resources whose IDs `member_ids` holds in one
  state. Only then can Terraform order the member changes against the creation and deletion of
  those resources; across states nothing orders them.
- **Authoritative members.** With a list, every member that the list does not name is removed
  on the next apply, including members that an administrator added. Adding a group brings the
  group into the unit's scope, not the group's members. Administrative units cannot be
  nested.
- **Stopping member management removes the members.** Changing `member_ids` from a list to null
  destroys the member resource, and the provider removes every member that its last refresh
  read, which is every member of the unit. To
  stop managing the members and keep them, remove the resource from the state first:
  `terraform state rm 'module.<name>.msgraph_resource_collection.members[0]'`, then set
  `member_ids` to null. The provider's `skip_destroy` is not exposed, so that removing the
  module call always removes what it added.
- **Members that already exist.** When the member resource is created, the provider adds every
  listed ID without reading the unit first. Whether Graph rejects an ID that is already a
  member is not verified. To take over the members of an existing unit, import the member
  resource instead:
  `terraform import 'module.<name>.msgraph_resource_collection.members[0]' 'directory/administrativeUnits/<unit-id>/members/$ref'`.
- **Replication delays are retried.** A unit or member object created in the same apply can
  be missing from the replica that serves the add-member request; Learn says to retry such a
  request after a delay. The member resource retries when the error is Graph's "does not
  exist" message for a directory object or the replication message documented for group
  members. An ID that really does not exist therefore fails only when the provider's create
  or update timeout runs out. The exact messages are not verified live.
- **Member IDs in lower case.** The provider compares the configured IDs with the ones it reads
  as exact strings, and Learn's response examples show them in lower case, so the module
  lower-cases them; that Graph always returns them in lower case is not verified. A
  change of case alone plans no change. An ID listed twice, in any case, is rejected.
- **Add-member requests.** The provider sends
  `{"@odata.id": "https://graph.microsoft.com/v1.0/directoryObjects/<id>"}` for each added
  member. Learn's add-member page accepts the ID of a user, group, device or directory object,
  and its list of member references returns `directoryObjects/<id>` URLs, but every request
  example uses the `users/`, `groups/` or `devices/` form. The `directoryObjects/` form is not
  verified live. The module does not set the provider's `collection_type`, which is new in
  `microsoft/msgraph` 0.6.0.
- **A replacement changes the id.** Changing `is_member_management_restricted` creates the new
  unit, removes the managed members from the old unit, adds them to the new one and then
  deletes the old unit. Between the removal and the addition the members are in neither unit.
  The member resource is not created before the old one is destroyed, because Terraform would
  then also force create-before-destroy on every resource whose ID `member_ids` holds, such as
  the member groups. Role
  assignments in the same state that use `directory_scope_id` are replaced with the new scope;
  role assignments made elsewhere keep the old scope and are lost with the old unit. Learn
  advises removing the role assignments scoped to a unit before deleting it. Learn does not say
  that display names must be unique, which the new unit needs while the old one still exists;
  this is not verified. A replacement of a restricted management unit needs a free place under
  the limit of 100.
- **Deletion.** Learn lists deleted administrative units among the directory's deleted items,
  which can be restored. The module does not restore them.
- **Clearing values.** A description or visibility that is no longer configured is sent as
  `null`. Whether Graph accepts a null description or visibility, on create or update, is not
  verified.
- **Drift.** The unit uses `ignore_missing_property = true`: Learn says that
  `membershipType`, `visibility` and `isMemberManagementRestricted` are null until they are
  set, and does not say what Graph returns after a value is sent, so a null in the response is
  not drift. A different non-null value is shown as drift, and a cleared description or
  visibility is not. A different case in a returned `membershipType` would show as drift on
  every plan; this is not verified.
- **Import is not verified.** The resource ID format follows the provider's documentation:
  `terraform import 'module.<name>.msgraph_resource.this' /directory/administrativeUnits/<unit-id>`.
  Set `is_member_management_restricted` to the unit's actual value first: the update cannot
  change it. The module also creates `terraform_data.immutable`, which has no counterpart to
  import; Terraform does not replace a resource when the resource that triggers its
  replacement is first created, so apply once with unchanged inputs after an import.

## Live test status

Live test status: not verified in a licensed tenant. The module is tested with a mock provider
only. These checks are pending, and each needs a tenant and credentials:

1. Create an assigned unit with `description` and `visibility` null, and a restricted management
   unit, as an application with `AdministrativeUnit.ReadWrite.All`; record whether Graph accepts
   the nulls and what it returns for `membershipType`, `visibility` and
   `isMemberManagementRestricted`.
2. Update the name, description and visibility, clear them with `null`, and check that the next
   plan is empty.
3. Add users, security groups and devices with the `directoryObjects/<id>` form, remove some,
   and check that the next plan is empty; add an ID that is already a member.
4. Hidden membership: read the members with and without `Member.Read.Hidden`.
5. Restricted management: add and remove members as an application, and update a member group
   with another module's identity, with and without a role at the unit's scope.
6. Dynamic membership: create a dynamic unit, pause and resume the rule, change it to assigned
   and back, and record the casing that Graph returns.
7. Replace the unit by changing `is_member_management_restricted`, with members, including two
   units with the same display name for the overlap.
8. Three groups created in the same apply as the unit's members, and the replacement of one of
   them.
9. Import of the unit and of its member resource, and the first plan after each.
10. Scoped role members: assign a role over the unit with a directoryRole object ID that is
    activated and one that is not yet activated, record what Graph returns, and check that the
    next plan is empty and that changing a pair replaces the assignment. Whether a
    roleDefinition or roleTemplate ID is also accepted as `roleId` is not verified.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | DIRECTORY-BASIC | The reviewed create APIs for users, assigned security groups, applications and service principals specify no additional premium license. This covers the object operation only; features built on these objects can require licenses. No additional license specified. | No per-user entitlement for the object operation itself | direct / per_tenant | documented |
| `membership_type` is `"Dynamic"` | ADMIN-UNITS-DYNAMIC | Dynamic membership rules for administrative units require Microsoft Entra ID P1 coverage in the tenant for each unique user who is a member of one or more dynamic administrative units. Licenses do not have to be assigned to those users. Devices that are members of a dynamic administrative unit need no license. Any of: Microsoft Entra ID P1 (`AAD_PREMIUM`). | Each unique user who is a member of any dynamic administrative unit | group_based / per_tenant | documented |
| `scoped_role_members` is set | ADMIN-UNITS | Creating administrative units is available with Microsoft Entra ID Free, and their members need only Microsoft Entra ID Free. Each administrator who is assigned a Microsoft Entra role at the scope of an administrative unit, including a restricted management administrative unit, needs Microsoft Entra ID P1. Any of: Microsoft Entra ID P1 (`AAD_PREMIUM`). | Each administrator assigned a Microsoft Entra role scoped to the administrative unit; the members of the unit need only Microsoft Entra ID Free | direct / per_user | documented |

Notes:

- Creating an administrative unit and managing its members is available with Microsoft Entra ID Free, so the baseline is DIRECTORY-BASIC. The module assigns a role over the unit only through scoped_role_members: the ADMIN-UNITS rule, Microsoft Entra ID P1 for each administrator assigned a role scoped to the unit, applies when that input is set, and to any role assignment over the unit that another configuration makes. See [Administrative units license requirements](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/administrative-units#license-requirements).
- Learn lists dynamic membership rules for administrative units as available in the global Azure cloud only, not in specialized clouds such as Azure Government or Microsoft Azure operated by 21Vianet.
- The administrative unit rules were reviewed against Microsoft Learn on 2026-10-07, which is later than the review date stated above.
- When `scoped_role_members` is set: Each administrator that scoped_role_members assigns a Microsoft Entra role at the scope of the unit needs Microsoft Entra ID P1.
- When `is_member_management_restricted` is `true`: A restricted management administrative unit has the same license rule as any other unit. Microsoft Learn says that the groups and users in such a unit cannot be managed with Microsoft Entra ID Governance features such as entitlement management, access reviews, lifecycle workflows and Privileged Identity Management, so do not use one for groups that an access package grants.

Sources: [Create user](https://learn.microsoft.com/en-us/graph/api/user-post-users?view=graph-rest-1.0), [Create group](https://learn.microsoft.com/en-us/graph/api/group-post-groups?view=graph-rest-1.0), [Create application](https://learn.microsoft.com/en-us/graph/api/application-post-applications?view=graph-rest-1.0), [Create servicePrincipal](https://learn.microsoft.com/en-us/graph/api/serviceprincipal-post-serviceprincipals?view=graph-rest-1.0), [Dynamic membership rules for administrative units prerequisites](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/admin-units-members-dynamic#prerequisites), [Administrative units license requirements](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/administrative-units#license-requirements), [Restricted management administrative units license requirements](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/admin-units-restricted-management#license-requirements).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required | On change |
|------|-------------|------|---------|----------| --- |
| display_name | Display name; not empty, at most 256 characters | `string` | n/a | yes | in place |
| name_pattern | Regular expression (RE2, not anchored unless it says so) that display_name must match, or the plan fails; null accepts any name | `string` | `null` | no | no object change (validation or timing only) |
| description | Description; always sent, as `null` when unset | `string` | `null` | no | in place |
| visibility | `null` (public) or `HiddenMembership`; always sent, as `null` when unset | `string` | `null` | no | in place |
| is_member_management_restricted | Restricted management unit; a change replaces the unit | `bool` | `false` | no | replaces `msgraph_resource.this` |
| membership_type | `Assigned` or `Dynamic` | `string` | `"Assigned"` | no | in place |
| membership_rule | Dynamic membership rule; required for `Dynamic`, rejected for `Assigned` | `string` | `null` | no | in place |
| membership_rule_processing_state | `On` or `Paused`; null sends `On` for `Dynamic`; rejected for `Assigned` | `string` | `null` | no | in place |
| member_ids | Object IDs of users, groups and devices (a device by its object ID, not its deviceId); null leaves the members unmanaged, a list is authoritative; GUIDs, each once; rejected for `Dynamic` | `list(string)` | `null` | no | adds or removes relationships of `msgraph_resource_collection.members` |
| scoped_role_members | Entra role assignments limited to the unit, map of `{ role_id, member_id }` entries under keys you choose; `role_id` is the activated directoryRole object ID, not the role template or definition ID; additive; GUIDs, each pair once; `null` counts as `{}` | `map(object)` | `{}` | no | replaces `msgraph_resource.scoped_role_member` when `role_id`, `member_id` changes; creates or deletes `msgraph_resource.scoped_role_member` instances |

## Outputs

| Name | Description | Known in plan after an update |
|------|-------------| --- |
| id | The object ID of the unit; it changes when `is_member_management_restricted` changes | yes |
| directory_scope_id | `/administrativeUnits/{id}`, the `directoryScopeId` of a role assignment over the unit | yes |
| display_name | The configured display name | yes |
| is_member_management_restricted | Whether the unit is a restricted management unit | yes |
| membership_type | `Assigned` or `Dynamic` | yes |
| visibility | `null` or `HiddenMembership` | yes |
| member_ids | The managed member IDs in lower case, read from the member resource; `null` when the members are not managed | no |
| scoped_role_member_ids | scopedRoleMembership IDs, keyed like `scoped_role_members`; empty when none are managed | no |

## Tests

`tests/scoped_role_members.tftest.hcl` covers `scoped_role_members` (one resource per entry,
body, replacement, a member created in the same configuration, validation) and members that are users, groups and devices.
`tests/administrative_unit.tftest.hcl` runs offline against a mock provider and needs Terraform
1.11 or later: `terraform init` and `terraform test` in this folder. It covers the body of an
assigned, a dynamic and a restricted unit, values cleared to `null`, the member resource for
null, empty and listed `member_ids` with its URL and lower-cased references, in-place updates,
the replacement when the restriction changes, every validation and precondition, the outputs,
and three groups created in the same apply as the members (`tests/three_groups`). A mock
provider sends no request, so a Python test (`tests/test_administrative_units.py`) checks the
validation and precondition messages, the body keys, the lifecycle settings and the
provider attributes that the module must not use. There is no live suite yet; see
[Live test status](#live-test-status).
