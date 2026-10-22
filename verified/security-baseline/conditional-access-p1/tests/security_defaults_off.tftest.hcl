# Security defaults already off before the module. Separate file: a test file shares state
# between its runs, and the recorded prior value is sticky.
# Positive cases. Fixtures follow the Microsoft Graph responses for the selected properties:
# - List users and subscribedSkus as in the emergency access guard tests;
# - Get identitySecurityDefaultsEnforcementPolicy: isEnabled;
# - List conditionalAccessPolicies: id and displayName;
# - Create conditionalAccessPolicy: the read-back carries id, state and conditions.users.
# IDs are deliberately synthetic; no tenant identities are recorded.

mock_provider "msgraph" {
  mock_data "msgraph_resource" {
    defaults = {
      output = {
        next_link  = null
        is_enabled = false
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

# The first apply is report-only: the recorded mode lets the enforce plans below pass.
run "report_only_first_apply" {
  command = apply

  assert {
    condition     = output.security_defaults_prior_enabled == false && length(msgraph_update_resource.security_defaults_off) == 0
    error_message = "A report-only first apply touches nothing and records security defaults as off."
  }
}

# 5. enforce = true with security defaults already off: no security defaults resource.
run "enforce_with_security_defaults_already_off" {
  command = plan

  variables {
    enforce = true
  }

  override_data {
    target = data.msgraph_resource.security_defaults
    values = {
      output = { is_enabled = false }
    }
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

  assert {
    condition     = length(msgraph_update_resource.security_defaults_off) == 0 && alltrue([for policy in msgraph_resource.policy : policy.body.state == "enabled"])
    error_message = "Security defaults that were already off are left alone."
  }

  assert {
    condition     = output.security_defaults_prior_enabled == false
    error_message = "The prior state is recorded as off."
  }
}

run "decommission_with_prior_state_off_restores_nothing" {
  command = plan

  variables {
    decommission = true
  }

  override_data {
    target = data.msgraph_resource.security_defaults
    values = {
      output = { is_enabled = false }
    }
  }

  assert {
    condition     = length(msgraph_update_resource.security_defaults_restore) == 0 && length(msgraph_resource.policy) == 0
    error_message = "With security defaults off before the module, nothing is restored."
  }
}
