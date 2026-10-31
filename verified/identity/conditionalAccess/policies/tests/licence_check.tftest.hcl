mock_provider "msgraph" {
  mock_data "msgraph_resource" {
    defaults = { output = { next_link = null, skus = [] } }
  }

  mock_resource "msgraph_resource" {
    defaults = {
      id = "66666666-6666-6666-6666-666666666666"
      output = {
        display_name   = "Require MFA for pilot"
        state          = "enabledForReportingButNotEnforced"
        exclude_users  = ["11111111-1111-1111-1111-111111111111"]
        exclude_groups = []
        optional_parts = {
          locations                         = false
          platforms                         = false
          devices                           = false
          grant_controls                    = true
          authentication_strength           = false
          session_controls                  = false
          sign_in_frequency                 = false
          persistent_browser                = false
          application_enforced_restrictions = false
          cloud_app_security                = false
        }
        unmanaged_properties = {
          description                          = false
          template_id                          = false
          application_filter                   = false
          include_guests_or_external_users     = false
          exclude_guests_or_external_users     = false
          client_applications                  = false
          service_principal_risk_levels        = false
          insider_risk_levels                  = false
          authentication_flow_transfer_methods = false
          custom_authentication_factors        = false
          disable_resilience_defaults          = false
          secure_sign_in_session               = false
        }
      }
    }
  }
}

variables {
  displayName          = "Require MFA for pilot"
  break_glass_user_ids = ["11111111-1111-1111-1111-111111111111"]
  users                = { includeGroups = ["22222222-2222-2222-2222-222222222222"] }
  applications         = { includeApplications = ["All"] }
  grant_controls       = { builtInControls = ["mfa"] }
}

# Opt-in licence check (issue #432): licence_check defaults to false and then reads nothing.
# The plan-time check reads subscribedSkus through the shared licence guard only when it is true.

run "disabled_by_default_reads_no_licences" {
  command = apply

  assert {
    condition     = length(module.licence_guard.licensed_skus) == 0 && module.licence_guard.tier == "free"
    error_message = "With licence_check false the guard must use the free tier, which reads no subscription."
  }
}

run "enabled_passes_with_a_p1_subscription" {
  command = apply

  variables {
    licence_check = true
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
            ]
          },
        ]
      }
    }
  }

  assert {
    condition     = module.licence_guard.tier == "p1" && length(module.licence_guard.licensed_skus) == 1
    error_message = "A subscription with enabled units that lists AAD_PREMIUM must satisfy the check."
  }
}

# A failing module output cannot be named in expect_failures from this module, so the two
# failing cases run against the shared guard that this module calls with tier p1, exactly as
# licence_check = true does. The error is the guard's output precondition.

run "enabled_fails_when_no_subscription_lists_the_plan" {
  command = plan

  module {
    source = "../../../security-baseline/licence-guard"
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
            skuPartNumber    = "SOME_OTHER_PRODUCT"
            capabilityStatus = "Enabled"
            prepaidUnits     = { enabled = 25, lockedOut = 0, suspended = 0, warning = 0 }
            servicePlans = [
              { servicePlanId = "11111111-2222-4333-8444-555555555555", servicePlanName = "OTHER_PLAN", provisioningStatus = "Success", appliesTo = "User" },
            ]
          },
        ]
      }
    }
  }

  expect_failures = [output.tier]
}

run "enabled_fails_without_available_capacity" {
  command = plan

  module {
    source = "../../../security-baseline/licence-guard"
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
            prepaidUnits     = { enabled = 0, lockedOut = 0, suspended = 0, warning = 0 }
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
