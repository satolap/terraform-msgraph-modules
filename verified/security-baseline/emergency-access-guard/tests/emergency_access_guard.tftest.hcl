# Fixtures follow the Microsoft Graph responses for the selected properties:
# - List users with $select=id,userPrincipalName,accountEnabled,onPremisesSyncEnabled,userType;
# - List groups with $select=id,displayName,securityEnabled,groupTypes,isAssignableToRole;
# - List group members with $select=id, which still returns each member's @odata.type;
# - List subscribedSkus, whose servicePlans copy the Microsoft Entra ID P1 and P2 product rows
#   of the Learn licensing service plan reference (the P2 product also lists AAD_PREMIUM).
#
# User and group IDs are deliberately synthetic; no tenant identities are recorded.

mock_provider "msgraph" {
  mock_data "msgraph_resource" {
    defaults = {
      output = {
        next_link = null
        users = [
          { id = "00000000-0000-4000-8000-000000000010", userPrincipalName = "breakglass1@contoso.onmicrosoft.com", accountEnabled = true, onPremisesSyncEnabled = null, userType = "Member" },
          { id = "00000000-0000-4000-8000-000000000020", userPrincipalName = "breakglass2@contoso.onmicrosoft.com", accountEnabled = true, onPremisesSyncEnabled = null, userType = "Member" },
        ]
        groups  = []
        members = []
        skus    = []
      }
    }
  }
}

variables {
  break_glass_user_ids = ["00000000-0000-4000-8000-000000000020", "00000000-0000-4000-8000-000000000010"]
}

# free keeps security defaults on: the module validates the accounts, reads no licences and
# exposes exact outputs.
run "free_with_two_users" {
  command = plan

  variables {
    tier = "free"
  }

  assert {
    condition     = data.msgraph_resource.users.url == "users" && data.msgraph_resource.users.api_version == "v1.0"
    error_message = "Users must be read from the v1.0 users collection."
  }

  assert {
    condition = data.msgraph_resource.users.query_parameters == tomap({
      "$filter" = tolist(["id in ('00000000-0000-4000-8000-000000000010', '00000000-0000-4000-8000-000000000020')"])
      "$select" = tolist(["id,userPrincipalName,accountEnabled,onPremisesSyncEnabled,userType"])
    })
    error_message = "Users must be read as a filtered collection that selects the checked properties."
  }

  assert {
    condition     = length(data.msgraph_resource.groups) == 0 && length(data.msgraph_resource.group_members) == 0
    error_message = "Without groups, no group or member read is made."
  }

  assert {
    condition     = output.exclude_users == tolist(["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"])
    error_message = "exclude_users must list the break-glass users, sorted."
  }

  assert {
    condition     = length(output.exclude_groups) == 0
    error_message = "exclude_groups must be empty without groups."
  }

  assert {
    condition     = output.conditional_access_users_exclusions.excludeUsers == tolist(["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"]) && length(output.conditional_access_users_exclusions.excludeGroups) == 0 && length(output.conditional_access_users_exclusions) == 2
    error_message = "The exclusions object must carry the Graph property names."
  }

  assert {
    condition     = output.emergency_access_user_ids == tolist(["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"])
    error_message = "emergency_access_user_ids must list the resolved users."
  }

  assert {
    condition     = output.tier == "free" && length(module.licence_guard.licensed_skus) == 0
    error_message = "The free tier passes the licence guard without licensed SKUs."
  }

  assert {
    condition = output.checks == {
      break_glass_user_ids   = "passed"
      users                  = "passed"
      groups                 = "not_applicable"
      expected_group_members = "not_applicable"
      role_assignable_groups = "not_applicable"
      minimum_accounts       = "passed"
      licence                = "not_applicable"
    }
    error_message = "checks must record each check."
  }

  assert {
    condition     = length(output.warnings) == 0
    error_message = "No warnings are expected."
  }
}

# p1 with an Enabled AAD_PREMIUM SKU, one user and a group whose only member is the same user:
# the user is read once and listed once.
run "p1_with_user_and_group_removes_duplicates" {
  command = plan

  variables {
    tier                      = "p1"
    break_glass_user_ids      = ["00000000-0000-4000-8000-000000000010"]
    break_glass_group_ids     = ["00000000-0000-4000-8000-000000000002"]
    minimum_accounts          = 1
    expected_group_member_ids = ["00000000-0000-4000-8000-000000000010"]
  }

  override_data {
    target = module.licence_guard.data.msgraph_resource.subscribed_skus
    values = {
      output = {
        next_link = null
        skus = [
          {
            skuId            = "00000000-0000-4000-8000-000000000001"
            skuPartNumber    = "AAD_PREMIUM"
            capabilityStatus = "Enabled"
            prepaidUnits     = { enabled = 25, lockedOut = 0, suspended = 0, warning = 0 }
            servicePlans = [
              { servicePlanId = "41781fb2-bc02-4b7c-bd55-b576c07bb09d", servicePlanName = "AAD_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "00000000-0000-4000-8000-000000000016", servicePlanName = "MFA_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
            ]
          },
        ]
      }
    }
  }

  override_data {
    target = data.msgraph_resource.groups
    values = {
      output = {
        next_link = null
        groups = [
          { id = "00000000-0000-4000-8000-000000000002", displayName = "Emergency access accounts", securityEnabled = true, groupTypes = [], isAssignableToRole = true },
        ]
      }
    }
  }

  override_data {
    target = data.msgraph_resource.group_members["e79acd97ac88086665d85a762f43d533a45195b6bac5961a993e6ed362471439"]
    values = {
      output = {
        next_link = null
        members = [
          { "@odata.type" = "#microsoft.graph.user", id = "00000000-0000-4000-8000-000000000010" },
        ]
      }
    }
  }

  override_data {
    target = data.msgraph_resource.users
    values = {
      output = {
        next_link = null
        users = [
          { id = "00000000-0000-4000-8000-000000000010", userPrincipalName = "breakglass1@contoso.onmicrosoft.com", accountEnabled = true, onPremisesSyncEnabled = null, userType = "Member" },
        ]
      }
    }
  }

  assert {
    condition = data.msgraph_resource.groups[0].query_parameters == tomap({
      "$filter" = tolist(["id in ('00000000-0000-4000-8000-000000000002')"])
      "$select" = tolist(["id,displayName,securityEnabled,groupTypes,isAssignableToRole"])
    })
    error_message = "Groups must be read as a filtered collection that selects the checked properties."
  }

  assert {
    condition     = data.msgraph_resource.group_members["e79acd97ac88086665d85a762f43d533a45195b6bac5961a993e6ed362471439"].url == "groups/00000000-0000-4000-8000-000000000002/members"
    error_message = "Direct members must be read from the group's members collection."
  }

  assert {
    condition     = data.msgraph_resource.group_members["e79acd97ac88086665d85a762f43d533a45195b6bac5961a993e6ed362471439"].api_version == "beta" && data.msgraph_resource.group_members["e79acd97ac88086665d85a762f43d533a45195b6bac5961a993e6ed362471439"].query_parameters == tomap({ "$select" = tolist(["id"]) })
    error_message = "Members must be read from beta, which also lists service principals, selecting only id."
  }

  assert {
    condition     = data.msgraph_resource.users.query_parameters["$filter"] == tolist(["id in ('00000000-0000-4000-8000-000000000010')"])
    error_message = "A user that is also a group member must be read once."
  }

  assert {
    condition     = output.exclude_users == tolist(["00000000-0000-4000-8000-000000000010"]) && length(output.exclude_groups) == 0
    error_message = "The snapshot must contain only validated resolved users and no mutable group IDs."
  }

  assert {
    condition     = output.emergency_access_user_ids == tolist(["00000000-0000-4000-8000-000000000010"])
    error_message = "The user reached directly and through the group must be listed once."
  }

  assert {
    condition     = output.tier == "p1" && [for sku in module.licence_guard.licensed_skus : sku.sku_part_number] == ["AAD_PREMIUM"]
    error_message = "The P1 SKU must license p1."
  }

  assert {
    condition = output.checks == {
      break_glass_user_ids   = "passed"
      users                  = "passed"
      groups                 = "passed"
      expected_group_members = "passed"
      role_assignable_groups = "passed"
      minimum_accounts       = "passed"
      licence                = "passed"
    }
    error_message = "Every check must pass."
  }

  assert {
    condition     = length(output.warnings) == 0
    error_message = "A role-assignable group adds no warning."
  }
}

# p2 with an Enabled AAD_PREMIUM_P2 SKU that lists both plans. A group member counts towards
# minimum_accounts, and a group that is not role-assignable only adds a warning.
run "p2_with_group_member_and_warning" {
  command = plan

  variables {
    tier                  = "p2"
    break_glass_user_ids  = ["00000000-0000-4000-8000-000000000010"]
    break_glass_group_ids = ["00000000-0000-4000-8000-000000000002"]
  }

  override_data {
    target = module.licence_guard.data.msgraph_resource.subscribed_skus
    values = {
      output = {
        next_link = null
        skus = [
          {
            skuId            = "00000000-0000-4000-8000-000000000015"
            skuPartNumber    = "AAD_PREMIUM_P2"
            capabilityStatus = "Enabled"
            prepaidUnits     = { enabled = 25, lockedOut = 0, suspended = 0, warning = 0 }
            servicePlans = [
              { servicePlanId = "41781fb2-bc02-4b7c-bd55-b576c07bb09d", servicePlanName = "AAD_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "eec0eb4f-6444-4f95-aba0-50c24d67f998", servicePlanName = "AAD_PREMIUM_P2", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "00000000-0000-4000-8000-000000000016", servicePlanName = "MFA_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
            ]
          },
        ]
      }
    }
  }

  override_data {
    target = data.msgraph_resource.groups
    values = {
      output = {
        next_link = null
        groups = [
          { id = "00000000-0000-4000-8000-000000000002", displayName = "Emergency access accounts", securityEnabled = true, groupTypes = [], isAssignableToRole = null },
        ]
      }
    }
  }

  override_data {
    target = data.msgraph_resource.group_members["e79acd97ac88086665d85a762f43d533a45195b6bac5961a993e6ed362471439"]
    values = {
      output = {
        next_link = null
        members = [
          { "@odata.type" = "#microsoft.graph.user", id = "00000000-0000-4000-8000-000000000021" },
        ]
      }
    }
  }

  override_data {
    target = data.msgraph_resource.users
    values = {
      output = {
        next_link = null
        users = [
          { id = "00000000-0000-4000-8000-000000000010", userPrincipalName = "breakglass1@contoso.onmicrosoft.com", accountEnabled = true, onPremisesSyncEnabled = null, userType = "Member" },
          { id = "00000000-0000-4000-8000-000000000021", userPrincipalName = "breakglass3@contoso.onmicrosoft.com", accountEnabled = true, onPremisesSyncEnabled = false, userType = "Member" },
        ]
      }
    }
  }

  assert {
    condition     = data.msgraph_resource.users.query_parameters["$filter"] == tolist(["id in ('00000000-0000-4000-8000-000000000010', '00000000-0000-4000-8000-000000000021')"])
    error_message = "Group members must be read and checked with the direct users."
  }

  assert {
    condition     = output.exclude_users == tolist(["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000021"]) && length(output.exclude_groups) == 0
    error_message = "Discovery-group members must be snapshotted as validated user exclusions, never through a mutable group exclusion."
  }

  assert {
    condition     = output.emergency_access_user_ids == tolist(["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000021"])
    error_message = "emergency_access_user_ids must include the group member."
  }

  assert {
    condition     = [for sku in module.licence_guard.licensed_skus : sku.sku_part_number] == ["AAD_PREMIUM_P2"]
    error_message = "The P2 SKU must license p2."
  }

  assert {
    condition     = output.checks.role_assignable_groups == "warning" && output.checks.groups == "passed" && output.checks.licence == "passed"
    error_message = "A group that is not role-assignable is a warning by default."
  }

  assert {
    condition     = output.warnings == tolist(["Group 0000...0002 is not role-assignable (isAssignableToRole is not true). A role-assignable group restricts who can change its membership; set require_role_assignable_group to fail the plan instead."])
    error_message = "The warning must name the group."
  }
}

# Precondition 1: the user exclusion is mandatory.
run "rejects_empty_user_ids" {
  command = plan

  variables {
    tier                 = "free"
    break_glass_user_ids = []
  }

  expect_failures = [var.break_glass_user_ids]
}

run "rejects_groups_without_users" {
  command = plan

  variables {
    tier                  = "free"
    break_glass_user_ids  = []
    break_glass_group_ids = ["00000000-0000-4000-8000-000000000002"]
  }

  expect_failures = [var.break_glass_user_ids]
}

run "rejects_malformed_user_id" {
  command = plan

  variables {
    tier                 = "free"
    break_glass_user_ids = ["00000000-0000-4000-8000-000000000010", "breakglass2@contoso.onmicrosoft.com"]
  }

  expect_failures = [var.break_glass_user_ids]
}

run "rejects_uppercase_user_id" {
  command = plan

  variables {
    tier                 = "free"
    break_glass_user_ids = ["AAAAAAAA-AAAA-4AAA-8AAA-AAAAAAAAAAAA"]
  }

  expect_failures = [var.break_glass_user_ids]
}

run "rejects_malformed_group_id" {
  command = plan

  variables {
    tier                  = "free"
    break_glass_group_ids = ["Emergency access accounts"]
  }

  expect_failures = [var.break_glass_group_ids]
}

run "rejects_tier_auto" {
  command = plan

  variables {
    tier = "auto"
  }

  expect_failures = [var.tier]
}

run "rejects_zero_minimum_accounts" {
  command = plan

  variables {
    tier             = "free"
    minimum_accounts = 0
  }

  expect_failures = [var.minimum_accounts]
}

run "rejects_more_than_15_user_ids" {
  command = plan

  variables {
    tier = "free"
    break_glass_user_ids = [
      "00000000-0000-4000-8000-000000000025",
      "00000000-0000-4000-8000-000000000026",
      "00000000-0000-4000-8000-000000000027",
      "00000000-0000-4000-8000-000000000028",
      "00000000-0000-4000-8000-000000000029",
      "00000000-0000-4000-8000-000000000030",
      "00000000-0000-4000-8000-000000000031",
      "00000000-0000-4000-8000-000000000032",
      "00000000-0000-4000-8000-000000000033",
      "00000000-0000-4000-8000-000000000034",
      "00000000-0000-4000-8000-000000000035",
      "00000000-0000-4000-8000-000000000036",
      "00000000-0000-4000-8000-000000000037",
      "00000000-0000-4000-8000-000000000038",
      "00000000-0000-4000-8000-000000000039",
      "00000000-0000-4000-8000-000000000040",
    ]
  }

  expect_failures = [var.break_glass_user_ids]
}

# The in filter takes at most 15 values, so more resolved users fail before the read.
run "users_beyond_the_filter_limit_fail" {
  command = plan

  variables {
    tier                  = "free"
    break_glass_group_ids = ["00000000-0000-4000-8000-000000000002"]
  }

  override_data {
    target = data.msgraph_resource.groups
    values = {
      output = {
        next_link = null
        groups = [
          { id = "00000000-0000-4000-8000-000000000002", displayName = "Emergency access accounts", securityEnabled = true, groupTypes = [], isAssignableToRole = true },
        ]
      }
    }
  }

  override_data {
    target = data.msgraph_resource.group_members["e79acd97ac88086665d85a762f43d533a45195b6bac5961a993e6ed362471439"]
    values = {
      output = {
        next_link = null
        members = [
          { "@odata.type" = "#microsoft.graph.user", id = "00000000-0000-4000-8000-000000000042" },
          { "@odata.type" = "#microsoft.graph.user", id = "00000000-0000-4000-8000-000000000043" },
          { "@odata.type" = "#microsoft.graph.user", id = "00000000-0000-4000-8000-000000000044" },
          { "@odata.type" = "#microsoft.graph.user", id = "00000000-0000-4000-8000-000000000045" },
          { "@odata.type" = "#microsoft.graph.user", id = "00000000-0000-4000-8000-000000000046" },
          { "@odata.type" = "#microsoft.graph.user", id = "00000000-0000-4000-8000-000000000047" },
          { "@odata.type" = "#microsoft.graph.user", id = "00000000-0000-4000-8000-000000000048" },
          { "@odata.type" = "#microsoft.graph.user", id = "00000000-0000-4000-8000-000000000049" },
          { "@odata.type" = "#microsoft.graph.user", id = "00000000-0000-4000-8000-000000000050" },
          { "@odata.type" = "#microsoft.graph.user", id = "00000000-0000-4000-8000-000000000051" },
          { "@odata.type" = "#microsoft.graph.user", id = "00000000-0000-4000-8000-000000000052" },
          { "@odata.type" = "#microsoft.graph.user", id = "00000000-0000-4000-8000-000000000053" },
          { "@odata.type" = "#microsoft.graph.user", id = "00000000-0000-4000-8000-000000000054" },
          { "@odata.type" = "#microsoft.graph.user", id = "00000000-0000-4000-8000-000000000055" },
        ]
      }
    }
  }

  expect_failures = [data.msgraph_resource.users]

  assert {
    condition     = length(local.resolved_user_ids) == 16
    error_message = "The two users and 14 members resolve to 16 users."
  }
}

# Precondition 2: each user exists and follows the emergency access guidance.
run "user_not_found_fails" {
  command = plan

  variables {
    tier             = "free"
    minimum_accounts = 1
  }

  override_data {
    target = data.msgraph_resource.users
    values = {
      output = {
        next_link = null
        users = [
          { id = "00000000-0000-4000-8000-000000000010", userPrincipalName = "breakglass1@contoso.onmicrosoft.com", accountEnabled = true, onPremisesSyncEnabled = null, userType = "Member" },
        ]
      }
    }
  }

  expect_failures = [terraform_data.emergency_access]

  assert {
    condition     = local.user_error == "Emergency access users fail the checks. User 0000...0020: not found."
    error_message = "The error must name the missing user."
  }

  assert {
    condition     = length(local.group_errors) == 0 && length(local.membership_errors) == 0 && local.enough_accounts
    error_message = "Only the user check may fail."
  }
}

run "disabled_user_fails" {
  command = plan

  variables {
    tier = "free"
  }

  override_data {
    target = data.msgraph_resource.users
    values = {
      output = {
        next_link = null
        users = [
          { id = "00000000-0000-4000-8000-000000000010", userPrincipalName = "breakglass1@contoso.onmicrosoft.com", accountEnabled = true, onPremisesSyncEnabled = null, userType = "Member" },
          { id = "00000000-0000-4000-8000-000000000020", userPrincipalName = "breakglass2@contoso.onmicrosoft.com", accountEnabled = false, onPremisesSyncEnabled = null, userType = "Member" },
        ]
      }
    }
  }

  expect_failures = [terraform_data.emergency_access]

  assert {
    condition     = local.user_errors == ["User 0000...0020: accountEnabled is not true."]
    error_message = "The error must name the disabled user."
  }

  assert {
    condition     = length(local.user_errors) > 0 && local.enough_accounts
    error_message = "checks must record the failed user check."
  }
}

run "synchronized_user_fails" {
  command = plan

  variables {
    tier = "free"
  }

  override_data {
    target = data.msgraph_resource.users
    values = {
      output = {
        next_link = null
        users = [
          { id = "00000000-0000-4000-8000-000000000010", userPrincipalName = "breakglass1@contoso.onmicrosoft.com", accountEnabled = true, onPremisesSyncEnabled = true, userType = "Member" },
          { id = "00000000-0000-4000-8000-000000000020", userPrincipalName = "breakglass2@contoso.onmicrosoft.com", accountEnabled = true, onPremisesSyncEnabled = false, userType = "Member" },
        ]
      }
    }
  }

  expect_failures = [terraform_data.emergency_access]

  assert {
    condition     = local.user_errors == ["User 0000...0010: onPremisesSyncEnabled is true (synchronized from on-premises)."]
    error_message = "The error must name the synchronized user."
  }
}

run "custom_domain_upn_fails" {
  command = plan

  variables {
    tier = "free"
  }

  override_data {
    target = data.msgraph_resource.users
    values = {
      output = {
        next_link = null
        users = [
          { id = "00000000-0000-4000-8000-000000000010", userPrincipalName = "breakglass1@contoso.com", accountEnabled = true, onPremisesSyncEnabled = null, userType = "Member" },
          { id = "00000000-0000-4000-8000-000000000020", userPrincipalName = "BreakGlass2@Contoso.OnMicrosoft.com", accountEnabled = true, onPremisesSyncEnabled = null, userType = "Member" },
        ]
      }
    }
  }

  expect_failures = [terraform_data.emergency_access]

  assert {
    condition     = local.user_errors == ["User 0000...0010: userPrincipalName does not end in .onmicrosoft.com."]
    error_message = "The error must name the user and its UPN, and the domain check ignores case."
  }
}

run "custom_domain_upn_allowed_when_not_required" {
  command = plan

  variables {
    tier                    = "free"
    require_onmicrosoft_upn = false
  }

  override_data {
    target = data.msgraph_resource.users
    values = {
      output = {
        next_link = null
        users = [
          { id = "00000000-0000-4000-8000-000000000010", userPrincipalName = "breakglass1@contoso.com", accountEnabled = true, onPremisesSyncEnabled = null, userType = "Member" },
          { id = "00000000-0000-4000-8000-000000000020", userPrincipalName = "breakglass2@contoso.onmicrosoft.com", accountEnabled = true, onPremisesSyncEnabled = null, userType = "Member" },
        ]
      }
    }
  }

  assert {
    condition     = output.checks.users == "passed"
    error_message = "require_onmicrosoft_upn = false must allow a custom domain UPN."
  }
}

run "guest_user_fails" {
  command = plan

  variables {
    tier = "free"
  }

  override_data {
    target = data.msgraph_resource.users
    values = {
      output = {
        next_link = null
        users = [
          { id = "00000000-0000-4000-8000-000000000010", userPrincipalName = "breakglass1@contoso.onmicrosoft.com", accountEnabled = true, onPremisesSyncEnabled = null, userType = "Member" },
          { id = "00000000-0000-4000-8000-000000000020", userPrincipalName = "admin_fabrikam.com#EXT#@contoso.onmicrosoft.com", accountEnabled = true, onPremisesSyncEnabled = null, userType = "Guest" },
        ]
      }
    }
  }

  expect_failures = [terraform_data.emergency_access]

  assert {
    condition     = local.user_errors == ["User 0000...0020: userType is not Member."]
    error_message = "The error must name the guest user."
  }
}

# Precondition 3: each group exists, is an assigned security group and has only users as
# direct members, and each member user passes precondition 2.
run "group_not_found_fails" {
  command = plan

  variables {
    tier                  = "free"
    break_glass_group_ids = ["00000000-0000-4000-8000-000000000002"]
  }

  expect_failures = [terraform_data.emergency_access]

  assert {
    condition     = local.group_error == "Emergency access groups fail the checks. Group 0000...0002: not found."
    error_message = "The error must name the missing group."
  }

  assert {
    condition     = length(data.msgraph_resource.group_members) == 0
    error_message = "The members of a missing group must not be read."
  }

  assert {
    condition     = length(local.user_errors) == 0 && local.enough_accounts
    error_message = "Only the group check may fail."
  }
}

run "non_security_group_fails" {
  command = plan

  variables {
    tier                  = "free"
    break_glass_group_ids = ["00000000-0000-4000-8000-000000000002"]
  }

  override_data {
    target = data.msgraph_resource.groups
    values = {
      output = {
        next_link = null
        groups = [
          { id = "00000000-0000-4000-8000-000000000002", displayName = "Emergency access accounts", securityEnabled = false, groupTypes = ["Unified"], isAssignableToRole = null },
        ]
      }
    }
  }

  expect_failures = [terraform_data.emergency_access]

  assert {
    condition     = local.group_errors == ["Group 0000...0002: securityEnabled is not true."]
    error_message = "The error must name the group that is not a security group."
  }
}

run "dynamic_group_fails" {
  command = plan

  variables {
    tier                  = "free"
    break_glass_group_ids = ["00000000-0000-4000-8000-000000000002"]
  }

  override_data {
    target = data.msgraph_resource.groups
    values = {
      output = {
        next_link = null
        groups = [
          { id = "00000000-0000-4000-8000-000000000002", displayName = "Emergency access accounts", securityEnabled = true, groupTypes = ["DynamicMembership"], isAssignableToRole = null },
        ]
      }
    }
  }

  expect_failures = [terraform_data.emergency_access]

  assert {
    condition     = local.group_errors == ["Group 0000...0002: groupTypes contains DynamicMembership."]
    error_message = "The error must name the dynamic group."
  }
}

run "nested_group_member_fails" {
  command = plan

  variables {
    tier                  = "free"
    break_glass_group_ids = ["00000000-0000-4000-8000-000000000002"]
  }

  override_data {
    target = data.msgraph_resource.groups
    values = {
      output = {
        next_link = null
        groups = [
          { id = "00000000-0000-4000-8000-000000000002", displayName = "Emergency access accounts", securityEnabled = true, groupTypes = [], isAssignableToRole = true },
        ]
      }
    }
  }

  override_data {
    target = data.msgraph_resource.group_members["e79acd97ac88086665d85a762f43d533a45195b6bac5961a993e6ed362471439"]
    values = {
      output = {
        next_link = null
        members = [
          { "@odata.type" = "#microsoft.graph.user", id = "00000000-0000-4000-8000-000000000010" },
          { "@odata.type" = "#microsoft.graph.group", id = "00000000-0000-4000-8000-000000000014" },
        ]
      }
    }
  }

  expect_failures = [terraform_data.emergency_access]

  assert {
    condition     = local.group_errors == ["Group 0000...0002: member 0000...0014 is a group, not a user."]
    error_message = "The error must name the group and its nested group member."
  }

  assert {
    condition     = length(local.user_errors) == 0 && local.resolved_user_ids == tolist(["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"])
    error_message = "A nested group is not resolved into users."
  }
}

run "service_principal_member_fails" {
  command = plan

  variables {
    tier                  = "free"
    break_glass_group_ids = ["00000000-0000-4000-8000-000000000002"]
  }

  override_data {
    target = data.msgraph_resource.groups
    values = {
      output = {
        next_link = null
        groups = [
          { id = "00000000-0000-4000-8000-000000000002", displayName = "Emergency access accounts", securityEnabled = true, groupTypes = [], isAssignableToRole = true },
        ]
      }
    }
  }

  override_data {
    target = data.msgraph_resource.group_members["e79acd97ac88086665d85a762f43d533a45195b6bac5961a993e6ed362471439"]
    values = {
      output = {
        next_link = null
        members = [
          { "@odata.type" = "#microsoft.graph.servicePrincipal", id = "00000000-0000-4000-8000-000000000007" },
        ]
      }
    }
  }

  expect_failures = [terraform_data.emergency_access]

  assert {
    condition     = local.group_errors == ["Group 0000...0002: member 0000...0007 is a servicePrincipal, not a user."]
    error_message = "The error must name the group and its service principal member."
  }
}

run "group_member_user_fails_user_checks" {
  command = plan

  variables {
    tier                  = "free"
    break_glass_group_ids = ["00000000-0000-4000-8000-000000000002"]
  }

  override_data {
    target = data.msgraph_resource.groups
    values = {
      output = {
        next_link = null
        groups = [
          { id = "00000000-0000-4000-8000-000000000002", displayName = "Emergency access accounts", securityEnabled = true, groupTypes = [], isAssignableToRole = true },
        ]
      }
    }
  }

  override_data {
    target = data.msgraph_resource.group_members["e79acd97ac88086665d85a762f43d533a45195b6bac5961a993e6ed362471439"]
    values = {
      output = {
        next_link = null
        members = [
          { "@odata.type" = "#microsoft.graph.user", id = "00000000-0000-4000-8000-000000000021" },
        ]
      }
    }
  }

  override_data {
    target = data.msgraph_resource.users
    values = {
      output = {
        next_link = null
        users = [
          { id = "00000000-0000-4000-8000-000000000010", userPrincipalName = "breakglass1@contoso.onmicrosoft.com", accountEnabled = true, onPremisesSyncEnabled = null, userType = "Member" },
          { id = "00000000-0000-4000-8000-000000000020", userPrincipalName = "breakglass2@contoso.onmicrosoft.com", accountEnabled = true, onPremisesSyncEnabled = null, userType = "Member" },
          { id = "00000000-0000-4000-8000-000000000021", userPrincipalName = "jdoe@contoso.com", accountEnabled = false, onPremisesSyncEnabled = true, userType = "Member" },
        ]
      }
    }
  }

  expect_failures = [terraform_data.emergency_access]

  assert {
    condition     = local.user_errors == ["User 0000...0021 (member of group 0000...0002): accountEnabled is not true; onPremisesSyncEnabled is true (synchronized from on-premises); userPrincipalName does not end in .onmicrosoft.com."]
    error_message = "The error must name the member user, its group and every reason."
  }

  assert {
    condition     = length(local.group_errors) == 0
    error_message = "The group itself passes."
  }
}

run "membership_differs_from_expected_fails" {
  command = plan

  variables {
    tier                      = "free"
    break_glass_group_ids     = ["00000000-0000-4000-8000-000000000002"]
    expected_group_member_ids = ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"]
  }

  override_data {
    target = data.msgraph_resource.groups
    values = {
      output = {
        next_link = null
        groups = [
          { id = "00000000-0000-4000-8000-000000000002", displayName = "Emergency access accounts", securityEnabled = true, groupTypes = [], isAssignableToRole = true },
        ]
      }
    }
  }

  override_data {
    target = data.msgraph_resource.group_members["e79acd97ac88086665d85a762f43d533a45195b6bac5961a993e6ed362471439"]
    values = {
      output = {
        next_link = null
        members = [
          { "@odata.type" = "#microsoft.graph.user", id = "00000000-0000-4000-8000-000000000010" },
          { "@odata.type" = "#microsoft.graph.user", id = "00000000-0000-4000-8000-000000000021" },
        ]
      }
    }
  }

  override_data {
    target = data.msgraph_resource.users
    values = {
      output = {
        next_link = null
        users = [
          { id = "00000000-0000-4000-8000-000000000010", userPrincipalName = "breakglass1@contoso.onmicrosoft.com", accountEnabled = true, onPremisesSyncEnabled = null, userType = "Member" },
          { id = "00000000-0000-4000-8000-000000000020", userPrincipalName = "breakglass2@contoso.onmicrosoft.com", accountEnabled = true, onPremisesSyncEnabled = null, userType = "Member" },
          { id = "00000000-0000-4000-8000-000000000021", userPrincipalName = "breakglass3@contoso.onmicrosoft.com", accountEnabled = true, onPremisesSyncEnabled = null, userType = "Member" },
        ]
      }
    }
  }

  expect_failures = [terraform_data.emergency_access]

  assert {
    condition     = local.membership_error == "The direct members of the emergency access groups differ from expected_group_member_ids; not expected: 0000...0021 (in group 0000...0002); missing: 0000...0020."
    error_message = "The error must name the unexpected and the missing members."
  }

  assert {
    condition     = length(local.user_errors) == 0 && length(local.group_errors) == 0 && length(local.membership_errors) > 0
    error_message = "Only the membership check may fail."
  }
}

run "role_assignable_group_required_fails" {
  command = plan

  variables {
    tier                          = "free"
    break_glass_group_ids         = ["00000000-0000-4000-8000-000000000002"]
    require_role_assignable_group = true
  }

  override_data {
    target = data.msgraph_resource.groups
    values = {
      output = {
        next_link = null
        groups = [
          { id = "00000000-0000-4000-8000-000000000002", displayName = "Emergency access accounts", securityEnabled = true, groupTypes = [], isAssignableToRole = false },
        ]
      }
    }
  }

  expect_failures = [terraform_data.emergency_access]

  assert {
    condition     = local.group_errors == ["Group 0000...0002: isAssignableToRole is not true."]
    error_message = "The error must name the group that is not role-assignable."
  }

  assert {
    condition     = length(local.warnings) == 0 && length(local.not_role_assignable) > 0
    error_message = "A required role-assignable group fails instead of warning."
  }
}

# Precondition 4: enough resolved users.
run "one_user_below_minimum_fails" {
  command = plan

  variables {
    tier                 = "free"
    break_glass_user_ids = ["00000000-0000-4000-8000-000000000010"]
  }

  override_data {
    target = data.msgraph_resource.users
    values = { output = { next_link = null, users = [
      { id = "00000000-0000-4000-8000-000000000010", userPrincipalName = "breakglass1@contoso.onmicrosoft.com", accountEnabled = true, onPremisesSyncEnabled = null, userType = "Member" }
    ] } }
  }

  expect_failures = [terraform_data.emergency_access]

  assert {
    condition     = local.minimum_error == "Only 1 emergency access user(s) resolved (0000...0010), fewer than minimum_accounts = 2. Microsoft recommends two or more emergency access accounts."
    error_message = "The error must name the resolved user and the minimum."
  }

  assert {
    condition     = length(local.user_errors) == 0 && !local.enough_accounts
    error_message = "Only the minimum check may fail."
  }
}

# Precondition 5: licence failures. Terraform tests cannot expect failures from a checkable
# object inside a child module, so these runs plan the licence guard that this module calls
# (module.licence_guard, source ../licence-guard, tier = var.tier) with the same fixtures.
# The p1 and p2 runs above cover the call itself.
run "licence_no_premium_plan_fails" {
  command = plan

  module {
    source = "../licence-guard"
  }

  variables {
    tier = "p1"
  }

  override_data {
    target = data.msgraph_resource.subscribed_skus
    values = {
      output = {
        next_link = null
        skus = [
          {
            skuId            = "00000000-0000-4000-8000-000000000022"
            skuPartNumber    = "ENTERPRISEPREMIUM"
            capabilityStatus = "Enabled"
            prepaidUnits     = { enabled = 25, lockedOut = 0, suspended = 0, warning = 0 }
            servicePlans = [
              { servicePlanId = "00000000-0000-4000-8000-000000000017", servicePlanName = "ADALLOM_S_O365", provisioningStatus = "Success", appliesTo = "Company" },
            ]
          },
        ]
      }
    }
  }

  expect_failures = [output.tier]

  assert {
    condition     = local.licence_error == "Tier p1 is not licensed: no subscribed SKU with capabilityStatus Enabled and enabled prepaid units lists Microsoft Entra ID P1 (AAD_PREMIUM 41781fb2-bc02-4b7c-bd55-b576c07bb09d). No subscribed SKU lists the plan."
    error_message = "The error must name the tier's plan."
  }
}

run "licence_p2_with_only_p1_fails" {
  command = plan

  module {
    source = "../licence-guard"
  }

  variables {
    tier = "p2"
  }

  override_data {
    target = data.msgraph_resource.subscribed_skus
    values = {
      output = {
        next_link = null
        skus = [
          {
            skuId            = "00000000-0000-4000-8000-000000000001"
            skuPartNumber    = "AAD_PREMIUM"
            capabilityStatus = "Enabled"
            prepaidUnits     = { enabled = 25, lockedOut = 0, suspended = 0, warning = 0 }
            servicePlans = [
              { servicePlanId = "41781fb2-bc02-4b7c-bd55-b576c07bb09d", servicePlanName = "AAD_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "00000000-0000-4000-8000-000000000016", servicePlanName = "MFA_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
            ]
          },
        ]
      }
    }
  }

  expect_failures = [output.tier]

  assert {
    condition     = local.licence_error == "Tier p2 is not licensed: no subscribed SKU with capabilityStatus Enabled and enabled prepaid units lists Microsoft Entra ID P2 (AAD_PREMIUM_P2 eec0eb4f-6444-4f95-aba0-50c24d67f998). No subscribed SKU lists the plan."
    error_message = "The error must name the P2 plan."
  }
}

run "licence_suspended_p2_fails" {
  command = plan

  module {
    source = "../licence-guard"
  }

  variables {
    tier = "p2"
  }

  override_data {
    target = data.msgraph_resource.subscribed_skus
    values = {
      output = {
        next_link = null
        skus = [
          {
            skuId            = "00000000-0000-4000-8000-000000000015"
            skuPartNumber    = "AAD_PREMIUM_P2"
            capabilityStatus = "Suspended"
            prepaidUnits     = { enabled = 5, lockedOut = 0, suspended = 20, warning = 0 }
            servicePlans = [
              { servicePlanId = "41781fb2-bc02-4b7c-bd55-b576c07bb09d", servicePlanName = "AAD_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "eec0eb4f-6444-4f95-aba0-50c24d67f998", servicePlanName = "AAD_PREMIUM_P2", provisioningStatus = "Success", appliesTo = "User" },
            ]
          },
        ]
      }
    }
  }

  expect_failures = [output.tier]

  assert {
    condition     = endswith(local.licence_error, "SKUs that list the plan but do not qualify: AAD_PREMIUM_P2 (Suspended, 5 enabled units).")
    error_message = "The error must name the SKU and its Suspended state."
  }
}

run "licence_warning_p2_fails" {
  command = plan

  module {
    source = "../licence-guard"
  }

  variables {
    tier = "p2"
  }

  override_data {
    target = data.msgraph_resource.subscribed_skus
    values = {
      output = {
        next_link = null
        skus = [
          {
            skuId            = "00000000-0000-4000-8000-000000000015"
            skuPartNumber    = "AAD_PREMIUM_P2"
            capabilityStatus = "Warning"
            prepaidUnits     = { enabled = 5, lockedOut = 0, suspended = 0, warning = 20 }
            servicePlans = [
              { servicePlanId = "41781fb2-bc02-4b7c-bd55-b576c07bb09d", servicePlanName = "AAD_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "eec0eb4f-6444-4f95-aba0-50c24d67f998", servicePlanName = "AAD_PREMIUM_P2", provisioningStatus = "Success", appliesTo = "User" },
            ]
          },
        ]
      }
    }
  }

  expect_failures = [output.tier]

  assert {
    condition     = endswith(local.licence_error, "SKUs that list the plan but do not qualify: AAD_PREMIUM_P2 (Warning, 5 enabled units).")
    error_message = "The error must name the SKU and its Warning state."
  }
}

run "licence_enabled_sku_without_units_fails" {
  command = plan

  module {
    source = "../licence-guard"
  }

  variables {
    tier = "p1"
  }

  override_data {
    target = data.msgraph_resource.subscribed_skus
    values = {
      output = {
        next_link = null
        skus = [
          {
            skuId            = "00000000-0000-4000-8000-000000000001"
            skuPartNumber    = "AAD_PREMIUM"
            capabilityStatus = "Enabled"
            prepaidUnits     = { enabled = 0, lockedOut = 0, suspended = 0, warning = 10 }
            servicePlans = [
              { servicePlanId = "41781fb2-bc02-4b7c-bd55-b576c07bb09d", servicePlanName = "AAD_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
            ]
          },
        ]
      }
    }
  }

  expect_failures = [output.tier]

  assert {
    condition     = endswith(local.licence_error, "SKUs that list the plan but do not qualify: AAD_PREMIUM (Enabled, 0 enabled units).")
    error_message = "The error must name the SKU and its 0 enabled units."
  }
}
