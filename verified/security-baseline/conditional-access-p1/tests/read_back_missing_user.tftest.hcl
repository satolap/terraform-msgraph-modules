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

# 12. Read-back postcondition: one policy comes back without a break-glass user.
run "read_back_lacks_a_break_glass_user" {
  command = apply

  override_resource {
    target = msgraph_resource.policy["legacy_auth"]
    values = {
      output = {
        id             = "00000000-0000-4000-8000-0000000000f1"
        state          = "enabledForReportingButNotEnforced"
        exclude_users  = ["00000000-0000-4000-8000-000000000010"]
        exclude_groups = []
      }
    }
  }

  expect_failures = [msgraph_resource.policy["legacy_auth"]]
}
