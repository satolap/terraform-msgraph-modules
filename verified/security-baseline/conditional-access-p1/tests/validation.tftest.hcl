# Negative cases: each run expects the named object to fail. The fixtures follow
# baseline.tftest.hcl; IDs are deliberately synthetic.

mock_provider "msgraph" {
  mock_data "msgraph_resource" {
    defaults = {
      output = {
        next_link  = null
        is_enabled = true
        policies   = []
        groups     = []
        members    = []
        users = [
          { id = "00000000-0000-4000-8000-000000000010", userPrincipalName = "breakglass1@contoso.onmicrosoft.com", accountEnabled = true, onPremisesSyncEnabled = null, userType = "Member" },
          { id = "00000000-0000-4000-8000-000000000020", userPrincipalName = "breakglass2@contoso.onmicrosoft.com", accountEnabled = true, onPremisesSyncEnabled = null, userType = "Member" },
        ]
        skus = [
          {
            skuId            = "00000000-0000-4000-8000-000000000001"
            skuPartNumber    = "AAD_PREMIUM"
            capabilityStatus = "Enabled"
            prepaidUnits     = { enabled = 25, lockedOut = 0, suspended = 0, warning = 0 }
            servicePlans = [
              { servicePlanId = "41781fb2-bc02-4b7c-bd55-b576c07bb09d", servicePlanName = "AAD_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
            ]
          },
        ]
      }
    }
  }

  mock_resource "msgraph_resource" {
    defaults = {
      output = {
        id             = "00000000-0000-4000-8000-0000000000f0"
        state          = "enabledForReportingButNotEnforced"
        exclude_users  = ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"]
        exclude_groups = []
      }
    }
  }
}

variables {
  tier                 = "p1"
  break_glass_user_ids = ["00000000-0000-4000-8000-000000000020", "00000000-0000-4000-8000-000000000010"]
}

# 10. At least one break-glass user, and every value a lowercase GUID.
run "no_break_glass_user" {
  command = plan

  variables {
    break_glass_user_ids = []
  }

  expect_failures = [var.break_glass_user_ids]
}

run "break_glass_user_not_a_guid" {
  command = plan

  variables {
    break_glass_user_ids = ["BREAKGLASS"]
  }

  expect_failures = [var.break_glass_user_ids]
}

run "break_glass_user_uppercase_guid" {
  command = plan

  variables {
    break_glass_user_ids = ["00000000-0000-4000-8000-00000000000A"]
  }

  expect_failures = [var.break_glass_user_ids]
}

run "too_many_break_glass_users" {
  command = plan

  variables {
    break_glass_user_ids = [for index in range(16) : format("00000000-0000-4000-8000-%012d", index + 1)]
  }

  expect_failures = [var.break_glass_user_ids]
}

run "break_glass_group_not_a_lowercase_guid" {
  command = plan

  variables {
    break_glass_group_ids = ["00000000-0000-4000-8000-0000000000A0"]
  }

  expect_failures = [var.break_glass_group_ids]
}

run "too_many_break_glass_groups" {
  command = plan

  variables {
    break_glass_group_ids = [for index in range(16) : format("00000000-0000-4000-8000-%012d", index + 1)]
  }

  expect_failures = [var.break_glass_group_ids]
}

# 13. free is rejected, and the error points to the free-tier modules.
run "free_tier_is_rejected" {
  command = plan

  variables {
    tier = "free"
  }

  expect_failures = [var.tier]
}

run "auto_tier_is_rejected" {
  command = plan

  variables {
    tier = "auto"
  }

  expect_failures = [var.tier]
}

# 14. No premium plan at all, and p2 with only P1.
run "no_premium_plan" {
  command = plan

  module {
    source = "../licence-guard"
  }

  variables {
    tier          = "p1"
    allowed_tiers = ["p1", "p2"]
  }

  override_data {
    target = data.msgraph_resource.subscribed_skus
    values = {
      output = {
        next_link = null
        skus      = []
      }
    }
  }

  expect_failures = [output.tier]
}

run "p2_with_only_p1" {
  command = plan

  module {
    source = "../licence-guard"
  }

  variables {
    tier          = "p2"
    allowed_tiers = ["p1", "p2"]
  }

  expect_failures = [output.tier]
}

# 15. A SKU that lists the plan in a state other than Enabled fails; the error names the SKU.
run "sku_with_warning_status" {
  command = plan

  module {
    source = "../licence-guard"
  }

  variables {
    tier          = "p1"
    allowed_tiers = ["p1", "p2"]
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
            capabilityStatus = "Warning"
            prepaidUnits     = { enabled = 25, lockedOut = 0, suspended = 0, warning = 0 }
            servicePlans = [
              { servicePlanId = "41781fb2-bc02-4b7c-bd55-b576c07bb09d", servicePlanName = "AAD_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
            ]
          },
        ]
      }
    }
  }

  expect_failures = [output.tier]
}

run "sku_with_suspended_status" {
  command = plan

  module {
    source = "../licence-guard"
  }

  variables {
    tier          = "p1"
    allowed_tiers = ["p1", "p2"]
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
            capabilityStatus = "Suspended"
            prepaidUnits     = { enabled = 0, lockedOut = 0, suspended = 25, warning = 0 }
            servicePlans = [
              { servicePlanId = "41781fb2-bc02-4b7c-bd55-b576c07bb09d", servicePlanName = "AAD_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
            ]
          },
        ]
      }
    }
  }

  expect_failures = [output.tier]
}

# The first apply is report-only, so the enforce cases below fail for their own reasons.
run "report_only_first_apply" {
  command = apply
}

# 16. enforce = true before the baseline exists (here one policy is missing).
run "enforce_before_baseline_exists" {
  command = plan

  variables {
    enforce = true
  }

  expect_failures = [terraform_data.guard]
}

run "enforce_with_one_policy_missing" {
  command = plan

  variables {
    enforce = true
  }

  override_data {
    target = data.msgraph_resource.existing_policies[0]
    values = {
      output = {
        next_link = null
        policies = [
          { id = "00000000-0000-4000-8000-0000000000a1", displayName = "Security baseline - Require multifactor authentication for admins" },
          { id = "00000000-0000-4000-8000-0000000000a2", displayName = "Security baseline - Block legacy authentication" },
          { id = "00000000-0000-4000-8000-0000000000a3", displayName = "Security baseline - Require multifactor authentication for all users" },
        ]
      }
    }
  }

  expect_failures = [terraform_data.guard]
}

# The baseline is found by display name, so another prefix does not satisfy the precondition.
run "enforce_with_policies_under_another_prefix" {
  command = plan

  variables {
    enforce             = true
    display_name_prefix = "Contoso - "
  }

  override_data {
    target = data.msgraph_resource.existing_policies[0]
    values = {
      output = {
        next_link = null
        policies = [
          { id = "00000000-0000-4000-8000-0000000000a1", displayName = "Security baseline - Require multifactor authentication for admins" },
          { id = "00000000-0000-4000-8000-0000000000a2", displayName = "Security baseline - Block legacy authentication" },
          { id = "00000000-0000-4000-8000-0000000000a3", displayName = "Security baseline - Require multifactor authentication for all users" },
          { id = "00000000-0000-4000-8000-0000000000a4", displayName = "Security baseline - Require multifactor authentication for Azure management" },
        ]
      }
    }
  }

  expect_failures = [terraform_data.guard]
}

run "enforce_with_paginated_policy_list" {
  command = plan

  variables {
    enforce = true
  }

  override_data {
    target = data.msgraph_resource.existing_policies[0]
    values = {
      output = {
        next_link = "https://graph.microsoft.com/v1.0/identity/conditionalAccess/policies?$skiptoken=x"
        policies  = []
      }
    }
  }

  expect_failures = [data.msgraph_resource.existing_policies[0]]
}

# 17. enforce and decommission together.
run "enforce_and_decommission" {
  command = plan

  variables {
    enforce      = true
    decommission = true
  }

  expect_failures = [terraform_data.guard]
}

# 18. enforce = false after the module turned security defaults off, without decommission.
run "stranded_first_apply" {
  command = apply
}

run "enforce_false_after_security_defaults_turned_off" {
  command = plan

  override_data {
    target = data.msgraph_resource.security_defaults
    values = {
      output = { is_enabled = false }
    }
  }

  expect_failures = [terraform_data.guard]
}

# 19. A value in additional_admin_role_template_ids that is not a GUID.
run "additional_admin_role_not_a_guid" {
  command = plan

  variables {
    additional_admin_role_template_ids = ["Global Administrator"]
  }

  expect_failures = [var.additional_admin_role_template_ids]
}

run "display_name_prefix_too_long" {
  command = plan

  variables {
    display_name_prefix = join("", [for index in range(101) : "x"])
  }

  expect_failures = [var.display_name_prefix]
}

# Fewer than two emergency access accounts only warns.
run "single_break_glass_user_warns" {
  command = plan

  variables {
    break_glass_user_ids = ["00000000-0000-4000-8000-000000000010"]
  }

  override_data {
    target = module.emergency_access[0].data.msgraph_resource.users
    values = {
      output = {
        next_link = null
        users = [
          { id = "00000000-0000-4000-8000-000000000010", userPrincipalName = "breakglass1@contoso.onmicrosoft.com", accountEnabled = true, onPremisesSyncEnabled = null, userType = "Member" },
        ]
      }
    }
  }

  expect_failures = [check.two_emergency_access_accounts]
}

# 11. The break-glass user lookup returns no user: the emergency access guard fails the plan.
run "break_glass_user_not_found" {
  command = plan

  module {
    source = "../emergency-access-guard"
  }

  variables {
    minimum_accounts = 1
  }

  override_data {
    target = data.msgraph_resource.users
    values = {
      output = {
        next_link = null
        users     = []
      }
    }
  }

  expect_failures = [terraform_data.emergency_access]
}
