mock_provider "msgraph" {
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
  display_name         = "Lockout regression"
  break_glass_user_ids = ["11111111-1111-1111-1111-111111111111"]
  users                = { include_users = ["All"] }
  applications         = { include_applications = ["All"] }
  grant_controls       = { built_in_controls = ["block"] }
}

run "all_users_block_defaults_to_report_only_with_direct_exclusions" {
  # A fresh plan cannot evaluate the read-back check; this apply uses only mocks.
  command = apply

  assert {
    condition     = msgraph_resource.policy.body.state == "enabledForReportingButNotEnforced"
    error_message = "A broad block must start in report-only mode."
  }

  assert {
    condition     = contains(msgraph_resource.policy.body.conditions.users.excludeUsers, "11111111-1111-1111-1111-111111111111")
    error_message = "Every broad block must carry the direct emergency-user exclusion."
  }
}

run "all_users_block_rejects_empty_emergency_users_even_with_group" {
  command = plan
  variables {
    break_glass_user_ids  = []
    break_glass_group_ids = ["22222222-2222-2222-2222-222222222222"]
  }
  expect_failures = [var.break_glass_user_ids]
}

run "all_apps_grant_rejects_empty_emergency_users" {
  command = plan
  variables {
    users                = { include_groups = ["22222222-2222-2222-2222-222222222222"] }
    break_glass_user_ids = []
    grant_controls       = { built_in_controls = ["mfa"] }
  }
  expect_failures = [var.break_glass_user_ids]
}

run "broad_grant_rejects_malformed_emergency_user" {
  command = plan
  variables {
    break_glass_user_ids = ["not-a-guid"]
    grant_controls       = { built_in_controls = ["mfa"] }
  }
  expect_failures = [var.break_glass_user_ids]
}

run "broad_block_rejects_null_emergency_user_element" {
  command = plan
  variables {
    break_glass_user_ids = [null]
  }
  expect_failures = [var.break_glass_user_ids]
}

run "broad_block_rejects_emergency_user_explicitly_included" {
  command = plan
  variables {
    users = { include_users = ["All", "11111111-1111-1111-1111-111111111111"] }
  }
  expect_failures = [msgraph_resource.policy]
}

run "broad_block_rejects_mixed_grant_controls" {
  command = plan
  variables {
    grant_controls = { built_in_controls = ["block", "mfa"] }
  }
  expect_failures = [msgraph_resource.policy]
}

run "broad_grant_explicit_enforcement_keeps_exclusions" {
  command = apply
  variables {
    state          = "enabled"
    grant_controls = { built_in_controls = ["mfa"] }
  }
  assert {
    condition     = msgraph_resource.policy.body.state == "enabled" && contains(msgraph_resource.policy.body.conditions.users.excludeUsers, "11111111-1111-1111-1111-111111111111")
    error_message = "Explicit enforcement must preserve emergency-user exclusions."
  }
}

run "broad_strength_grant_keeps_exclusions_in_report_only" {
  command = apply
  variables {
    grant_controls = { authentication_strength_id = "33333333-3333-3333-3333-333333333333" }
  }
  assert {
    condition     = msgraph_resource.policy.body.state == "enabledForReportingButNotEnforced" && length(msgraph_resource.policy.body.conditions.users.excludeUsers) > 0
    error_message = "Authentication strength grants need the same rollout and exclusions."
  }
}

run "broad_terms_grant_keeps_exclusions_when_disabled" {
  command = apply
  variables {
    state          = "disabled"
    grant_controls = { terms_of_use = ["33333333-3333-3333-3333-333333333333"] }
  }
  assert {
    condition     = msgraph_resource.policy.body.state == "disabled" && length(msgraph_resource.policy.body.conditions.users.excludeUsers) > 0
    error_message = "Disabling a policy must preserve its emergency exclusions."
  }
}
