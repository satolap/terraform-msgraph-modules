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
  display_name         = "Require MFA for pilot"
  break_glass_user_ids = ["11111111-1111-1111-1111-111111111111"]
  users                = { include_groups = ["22222222-2222-2222-2222-222222222222"] }
  applications         = { include_applications = ["All"] }
  grant_controls       = { built_in_controls = ["mfa"] }
}

# name_pattern: optional, null by default. When set, display_name must match it
# or the plan fails. The pattern uses placeholder segments, not a real convention.

run "accepts_any_display_name_without_name_pattern" {
  command = apply

  variables {
    display_name = "Not following any convention"
  }

  assert {
    condition     = msgraph_resource.policy.body.displayName == "Not following any convention"
    error_message = "Without name_pattern, any display_name must be accepted."
  }
}

run "accepts_a_display_name_that_matches_name_pattern" {
  command = apply

  variables {
    display_name = "Example ORG-DEV-Name"
    name_pattern = "ORG-(DEV|PRD)-"
  }

  assert {
    condition     = msgraph_resource.policy.body.displayName == "Example ORG-DEV-Name"
    error_message = "A display_name that matches name_pattern must be accepted."
  }
}

run "rejects_a_display_name_that_does_not_match_name_pattern" {
  command = plan

  variables {
    display_name = "Example without the prefix"
    name_pattern = "^ORG-(DEV|PRD)-"
  }

  expect_failures = [msgraph_resource.policy]
}

run "rejects_an_invalid_name_pattern" {
  command = plan

  variables {
    name_pattern = "(unclosed"
  }

  expect_failures = [var.name_pattern]
}

# A convention can allow the "ENABLE IN EMERGENCY" prefix that Microsoft Learn
# recommends for contingency policies.
run "accepts_the_contingency_prefix_when_the_pattern_allows_it" {
  command = apply

  variables {
    display_name = "ENABLE IN EMERGENCY - CA001-AllApps-RequireMFA-AllUsers"
    name_pattern = "^(ENABLE IN EMERGENCY - )?CA[0-9]{3}-"
  }

  assert {
    condition     = msgraph_resource.policy.body.displayName == "ENABLE IN EMERGENCY - CA001-AllApps-RequireMFA-AllUsers"
    error_message = "A contingency policy name that the pattern allows must be accepted."
  }
}

run "rejects_a_contingency_name_that_the_pattern_does_not_allow" {
  command = plan

  variables {
    display_name = "ENABLE IN EMERGENCY - CA001-AllApps-RequireMFA-AllUsers"
    name_pattern = "^CA[0-9]{3}-"
  }

  expect_failures = [msgraph_resource.policy]
}
