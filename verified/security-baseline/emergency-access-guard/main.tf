# Read-only checks of existing emergency access (break-glass) accounts. The module creates,
# changes and deletes nothing in the tenant: it reads through msgraph_resource data sources
# and fails the plan through preconditions on a terraform_data gate. See:
# https://learn.microsoft.com/entra/identity/role-based-access-control/security-emergency-access

# For p1 and p2 the shared licence guard fails the plan unless a usable subscription lists
# the tier's service plan. The free tier reads no licences.
module "licence_guard" {
  source = "../licence-guard"

  tier = var.tier
}

locals {
  user_ids          = sort(var.break_glass_user_ids)
  group_ids         = sort(var.break_glass_group_ids)
  group_ids_by_hash = { for id in local.group_ids : sha256(id) => id }

  groups = { for group in try(data.msgraph_resource.groups[0].output.groups, []) : lower(group.id) => group }

  # Members are read only for groups that exist, so a deleted group fails a precondition
  # that names it instead of a 404 on its members.
  found_group_ids = [for id in local.group_ids : id if contains(keys(local.groups), id)]

  members = {
    for id in local.found_group_ids : id => [
      for member in try(data.msgraph_resource.group_members[sha256(id)].output.members, []) : {
        id   = lower(member.id)
        type = trimprefix(try(member["@odata.type"], "#microsoft.graph.unknown"), "#microsoft.graph.")
      }
    ]
  }

  # Direct member ID => IDs of the break-glass groups that list it.
  member_groups = {
    for pair in flatten([for id, members in local.members : [for member in members : { member = member.id, group = id }]]) : pair.member => pair.group...
  }
  user_member_ids = distinct(flatten([for id, members in local.members : [for member in members : member.id if member.type == "user"]]))

  # Direct users plus the user members of the groups, without duplicates.
  resolved_user_ids = sort(distinct(concat(local.user_ids, local.user_member_ids)))

  users          = { for user in try(data.msgraph_resource.users.output.users, []) : lower(user.id) => user }
  found_user_ids = [for id in local.resolved_user_ids : id if contains(keys(local.users), id)]

  # Check 2: every resolved user exists and follows Microsoft's emergency access guidance.
  user_reasons = {
    for id in local.resolved_user_ids : id => !contains(keys(local.users), id) ? ["not found"] : compact([
      try(local.users[id].accountEnabled, null) == true ? "" : "accountEnabled is not true",
      try(local.users[id].onPremisesSyncEnabled, null) == true ? "onPremisesSyncEnabled is true (synchronized from on-premises)" : "",
      try(local.users[id].userType, null) == "Member" ? "" : "userType is not Member",
      !var.require_onmicrosoft_upn || endswith(try(lower(local.users[id].userPrincipalName), ""), ".onmicrosoft.com") ? "" : "userPrincipalName does not end in .onmicrosoft.com",
    ])
  }
  user_errors = [
    for id, reasons in local.user_reasons :
    "User ${substr(id, 0, 4)}...${substr(id, -4, 4)}${contains(local.user_ids, id) ? "" : " (member of group ${join(", ", [for group in lookup(local.member_groups, id, []) : "${substr(group, 0, 4)}...${substr(group, -4, 4)}"])})"}: ${join("; ", reasons)}."
    if length(reasons) > 0
  ]

  # Check 3: every group exists, is a security group with assigned membership, and has only
  # users as direct members.
  not_role_assignable = [for id in local.found_group_ids : id if try(local.groups[id].isAssignableToRole, null) != true]
  group_reasons = {
    for id in local.group_ids : id => !contains(keys(local.groups), id) ? ["not found"] : concat(
      compact([
        try(local.groups[id].securityEnabled, null) == true ? "" : "securityEnabled is not true",
        try(contains(local.groups[id].groupTypes, "DynamicMembership"), false) ? "groupTypes contains DynamicMembership" : "",
        var.require_role_assignable_group && contains(local.not_role_assignable, id) ? "isAssignableToRole is not true" : "",
      ]),
      [for member in lookup(local.members, id, []) : "member ${substr(member.id, 0, 4)}...${substr(member.id, -4, 4)} is a ${member.type}, not a user" if member.type != "user"],
    )
  }
  group_errors = [
    for id, reasons in local.group_reasons :
    "Group ${substr(id, 0, 4)}...${substr(id, -4, 4)}: ${join("; ", reasons)}."
    if length(reasons) > 0
  ]

  member_ids         = sort(keys(local.member_groups))
  unexpected_members = var.expected_group_member_ids == null ? [] : sort(setsubtract(local.member_ids, var.expected_group_member_ids))
  missing_members    = var.expected_group_member_ids == null ? [] : sort(setsubtract(var.expected_group_member_ids, local.member_ids))
  membership_errors = compact([
    length(local.unexpected_members) == 0 ? "" : "not expected: ${join(", ", [for id in local.unexpected_members : "${substr(id, 0, 4)}...${substr(id, -4, 4)} (in group ${join(", ", [for group in local.member_groups[id] : "${substr(group, 0, 4)}...${substr(group, -4, 4)}"])})"])}",
    length(local.missing_members) == 0 ? "" : "missing: ${join(", ", [for id in local.missing_members : "${substr(id, 0, 4)}...${substr(id, -4, 4)}"])}",
  ])

  # Check 4: enough resolved users.
  enough_accounts = length(local.found_user_ids) >= var.minimum_accounts

  user_error       = "Emergency access users fail the checks. ${join(" ", local.user_errors)}"
  group_error      = "Emergency access groups fail the checks. ${join(" ", local.group_errors)}"
  membership_error = "The direct members of the emergency access groups differ from expected_group_member_ids; ${join("; ", local.membership_errors)}."
  minimum_error    = "Only ${length(local.found_user_ids)} emergency access user(s) resolved${length(local.found_user_ids) > 0 ? " (${join(", ", [for id in local.found_user_ids : "${substr(id, 0, 4)}...${substr(id, -4, 4)}"])})" : ""}, fewer than minimum_accounts = ${var.minimum_accounts}. Microsoft recommends two or more emergency access accounts."

  warnings = var.require_role_assignable_group ? [] : [
    for id in local.not_role_assignable :
    "Group ${substr(id, 0, 4)}...${substr(id, -4, 4)} is not role-assignable (isAssignableToRole is not true). A role-assignable group restricts who can change its membership; set require_role_assignable_group to fail the plan instead."
  ]
}

# Filtered collection reads: a deleted object is missing from the result, and the precondition
# names its ID, instead of a 404 from GET /users/{id}. The in operator on id needs no advanced
# query headers and takes at most 15 values:
# https://learn.microsoft.com/graph/known-issues#query-parameters
data "msgraph_resource" "users" {
  url         = "users"
  api_version = "v1.0"

  query_parameters = {
    "$filter" = sensitive(["id in (${join(", ", [for id in local.resolved_user_ids : "'${id}'"])})"])
    "$select" = ["id,userPrincipalName,accountEnabled,onPremisesSyncEnabled,userType"]
  }

  response_export_values = {
    users     = "value"
    next_link = "\"@odata.nextLink\""
  }

  lifecycle {
    precondition {
      condition     = length(local.resolved_user_ids) <= 15
      error_message = "Emergency access users exceed the 15 values supported by one Microsoft Graph in filter."
    }

    postcondition {
      condition = try(
        self.output.users != null && can(concat(self.output.users, [])) &&
        contains(keys(self.output), "next_link") && self.output.next_link == null &&
        length(distinct([for user in self.output.users : lower(user.id)])) == length(self.output.users) &&
        alltrue([for user in self.output.users :
          contains(local.resolved_user_ids, lower(user.id)) &&
          contains(keys(user), "onPremisesSyncEnabled") &&
          (user.onPremisesSyncEnabled == null || user.onPremisesSyncEnabled == false || user.onPremisesSyncEnabled == true) &&
          (user.accountEnabled == true || user.accountEnabled == false) &&
          contains(["Member", "Guest"], user.userType) &&
          user.userPrincipalName == tostring(user.userPrincipalName) && can(regex(".+", user.userPrincipalName))
        ]), false
      )
      error_message = "The user response is malformed, incomplete or still paginated; emergency access is not verified."
    }
  }
}

data "msgraph_resource" "groups" {
  count = nonsensitive(sensitive(length(var.break_glass_group_ids) > 0 ? 1 : 0))

  url         = "groups"
  api_version = "v1.0"

  query_parameters = {
    "$filter" = sensitive(["id in (${join(", ", [for id in local.group_ids : "'${id}'"])})"])
    "$select" = ["id,displayName,securityEnabled,groupTypes,isAssignableToRole"]
  }

  response_export_values = {
    groups    = "value"
    next_link = "\"@odata.nextLink\""
  }

  lifecycle {
    postcondition {
      condition = try(
        self.output.groups != null && can(concat(self.output.groups, [])) &&
        contains(keys(self.output), "next_link") && self.output.next_link == null &&
        length(distinct([for group in self.output.groups : lower(group.id)])) == length(self.output.groups) &&
        alltrue([for group in self.output.groups :
          contains(local.group_ids, lower(group.id)) &&
          (group.securityEnabled == true || group.securityEnabled == false) && can(concat(group.groupTypes, [])) &&
          group.groupTypes != null && alltrue([for kind in group.groupTypes : kind != null && kind == tostring(kind)]) &&
          (group.isAssignableToRole == null || group.isAssignableToRole == true || group.isAssignableToRole == false)
        ]), false
      )
      error_message = "The group response is malformed, incomplete or still paginated; emergency access is not verified."
    }
  }
}

# The v1.0 members endpoint omits service principal members (Microsoft Graph known issue), so
# this read uses beta: https://learn.microsoft.com/graph/known-issues#get-groupsidmembers-doesnt-return-service-principals-in-v10
# Each member's @odata.type and id are returned even without permission to read its type.
data "msgraph_resource" "group_members" {
  for_each = nonsensitive(sensitive(toset([for id in local.found_group_ids : sha256(id)])))

  url         = sensitive("groups/${local.group_ids_by_hash[each.key]}/members")
  api_version = "beta"

  query_parameters = {
    "$select" = ["id"]
  }

  response_export_values = {
    members   = "value"
    next_link = "\"@odata.nextLink\""
  }

  lifecycle {
    postcondition {
      condition = try(
        self.output.members != null && can(concat(self.output.members, [])) &&
        contains(keys(self.output), "next_link") && self.output.next_link == null &&
        length(distinct([for member in self.output.members : lower(member.id)])) == length(self.output.members) &&
        alltrue([for member in self.output.members :
          can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", member.id)) &&
          contains(["#microsoft.graph.user", "#microsoft.graph.group", "#microsoft.graph.servicePrincipal", "#microsoft.graph.device", "#microsoft.graph.orgContact"], member["@odata.type"])
        ]), false
      )
      error_message = "A group membership response is malformed, incomplete or still paginated."
    }
  }
}

# The gate holds no tenant state. Its preconditions fail the plan, or the apply when the reads
# are deferred, with a message that names each failing ID and the reason.
resource "terraform_data" "emergency_access" {
  input = sensitive({
    tier                = module.licence_guard.tier
    direct_user_ids     = local.user_ids
    discovery_group_ids = local.group_ids
    resolved_user_ids   = local.resolved_user_ids
  })

  lifecycle {
    precondition {
      condition     = length(local.user_errors) == 0
      error_message = nonsensitive(sensitive(local.user_error))
    }

    precondition {
      condition     = length(local.group_errors) == 0
      error_message = nonsensitive(sensitive(local.group_error))
    }

    precondition {
      condition     = length(local.membership_errors) == 0
      error_message = nonsensitive(sensitive(local.membership_error))
    }

    precondition {
      condition     = local.enough_accounts
      error_message = nonsensitive(sensitive(local.minimum_error))
    }
  }
}

# Hash keys avoid putting object IDs in Terraform addresses. An unknown input ID
# makes for_each invalid during planning, rather than silently deferring the guard.
resource "terraform_data" "known_users" {
  for_each = nonsensitive(sensitive(toset([for id in var.break_glass_user_ids : sha256(id)])))
  input    = sensitive(each.value)
}
