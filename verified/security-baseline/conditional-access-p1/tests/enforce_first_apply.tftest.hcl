# Negative case on a fresh state: enforce = true on the first apply fails even when the four
# baseline policies already exist (lost state, a second instance, hand-made placeholders). A
# separate file, because a test file shares state between its runs.
# The fixtures follow
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

run "enforce_on_first_apply_with_existing_baseline" {
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
          { id = "00000000-0000-4000-8000-0000000000a4", displayName = "Security baseline - Require multifactor authentication for Azure management" },
        ]
      }
    }
  }

  expect_failures = [terraform_data.guard]
}
