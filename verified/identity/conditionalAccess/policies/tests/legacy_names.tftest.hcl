# v4.0.0 spelled the nested attributes of these inputs in snake_case. Terraform drops an unknown
# object attribute silently and the optional Graph-named attribute falls back to its permissive
# default (a control off), so the guard rejects an old name that carries a value. Each input has
# an accepted run with the Graph names and one rejection run per legacy attribute.

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
  displayName          = "Require MFA for pilot"
  break_glass_user_ids = ["11111111-1111-1111-1111-111111111111"]
  users                = { includeGroups = ["22222222-2222-2222-2222-222222222222"] }
  applications         = { includeApplications = ["All"] }
  grant_controls       = { builtInControls = ["mfa"] }
}

run "users_with_the_graph_names_is_accepted" {
  command = apply
  variables {
    users = { includeGroups = ["22222222-2222-2222-2222-222222222222"] }
  }
}

run "users_rejects_the_legacy_include_users" {
  command = plan
  variables {
    users = { includeGroups = ["22222222-2222-2222-2222-222222222222"], include_users = ["All"] }
  }
  expect_failures = [var.users]
}

run "users_rejects_the_legacy_exclude_users" {
  command = plan
  variables {
    users = { includeGroups = ["22222222-2222-2222-2222-222222222222"], exclude_users = ["22222222-2222-2222-2222-222222222222"] }
  }
  expect_failures = [var.users]
}

run "users_rejects_the_legacy_include_groups" {
  command = plan
  variables {
    users = { includeGroups = ["22222222-2222-2222-2222-222222222222"], include_groups = ["22222222-2222-2222-2222-222222222222"] }
  }
  expect_failures = [var.users]
}

run "users_rejects_the_legacy_exclude_groups" {
  command = plan
  variables {
    users = { includeGroups = ["22222222-2222-2222-2222-222222222222"], exclude_groups = ["22222222-2222-2222-2222-222222222222"] }
  }
  expect_failures = [var.users]
}

run "users_rejects_the_legacy_include_roles" {
  command = plan
  variables {
    users = { includeGroups = ["22222222-2222-2222-2222-222222222222"], include_roles = ["22222222-2222-2222-2222-222222222222"] }
  }
  expect_failures = [var.users]
}

run "users_rejects_the_legacy_exclude_roles" {
  command = plan
  variables {
    users = { includeGroups = ["22222222-2222-2222-2222-222222222222"], exclude_roles = ["22222222-2222-2222-2222-222222222222"] }
  }
  expect_failures = [var.users]
}

run "applications_with_the_graph_names_is_accepted" {
  command = apply
  variables {
    applications = { includeApplications = ["All"] }
  }
}

run "applications_rejects_the_legacy_include_applications" {
  command = plan
  variables {
    applications = { includeApplications = ["All"], include_applications = ["All"] }
  }
  expect_failures = [var.applications]
}

run "applications_rejects_the_legacy_exclude_applications" {
  command = plan
  variables {
    applications = { includeApplications = ["All"], exclude_applications = ["All"] }
  }
  expect_failures = [var.applications]
}

run "applications_rejects_the_legacy_include_user_actions" {
  command = plan
  variables {
    applications = { includeApplications = ["All"], include_user_actions = ["urn:user:registersecurityinfo"] }
  }
  expect_failures = [var.applications]
}

run "applications_rejects_the_legacy_include_authentication_context_class_references" {
  command = plan
  variables {
    applications = { includeApplications = ["All"], include_authentication_context_class_references = ["c1"] }
  }
  expect_failures = [var.applications]
}

run "locations_with_the_graph_names_is_accepted" {
  command = apply
  variables {
    locations = { includeLocations = ["All"] }
  }
}

run "locations_rejects_the_legacy_exclude_locations" {
  command = plan
  variables {
    locations = { includeLocations = ["All"], exclude_locations = ["AllTrusted"] }
  }
  expect_failures = [var.locations]
}

run "platforms_with_the_graph_names_is_accepted" {
  command = apply
  variables {
    platforms = { includePlatforms = ["android"] }
  }
}

run "platforms_rejects_the_legacy_exclude_platforms" {
  command = plan
  variables {
    platforms = { includePlatforms = ["android"], exclude_platforms = ["iOS"] }
  }
  expect_failures = [var.platforms]
}

run "grant_controls_with_the_graph_names_is_accepted" {
  command = apply
  variables {
    grant_controls = { builtInControls = ["mfa"] }
  }
}

run "grant_controls_rejects_the_legacy_built_in_controls" {
  command = plan
  variables {
    grant_controls = { builtInControls = ["mfa"], built_in_controls = ["block"] }
  }
  expect_failures = [var.grant_controls]
}

run "grant_controls_rejects_the_legacy_terms_of_use" {
  command = plan
  variables {
    grant_controls = { builtInControls = ["mfa"], terms_of_use = ["22222222-2222-2222-2222-222222222222"] }
  }
  expect_failures = [var.grant_controls]
}

run "session_controls_with_the_graph_names_is_accepted" {
  command = apply
  variables {
    session_controls = { persistent_browser_mode = "never", signInFrequency = { type = "hours", value = 4 } }
  }
}

run "session_controls_rejects_the_legacy_application_enforced_restrictions" {
  command = plan
  variables {
    session_controls = { persistent_browser_mode = "never", signInFrequency = { type = "hours", value = 4 }, application_enforced_restrictions = true }
  }
  expect_failures = [var.session_controls]
}

run "session_controls_rejects_the_legacy_cloud_app_security_type" {
  command = plan
  variables {
    session_controls = { persistent_browser_mode = "never", signInFrequency = { type = "hours", value = 4 }, cloud_app_security_type = "blockDownloads" }
  }
  expect_failures = [var.session_controls]
}

run "session_controls_rejects_the_legacy_sign_in_frequency" {
  command = plan
  variables {
    session_controls = { persistent_browser_mode = "never", signInFrequency = { type = "hours", value = 4 }, sign_in_frequency = { type = "hours", value = 1 } }
  }
  expect_failures = [var.session_controls]
}

run "session_controls_reject_the_legacy_sign_in_frequency_attributes" {
  command = plan
  variables {
    session_controls = { signInFrequency = { type = "hours", value = 4, frequency_interval = "everyTime", authentication_type = "secondFactor" } }
  }
  expect_failures = [var.session_controls]
}

run "an_explicit_null_legacy_value_is_accepted" {
  command = apply
  variables {
    users            = { includeGroups = ["22222222-2222-2222-2222-222222222222"], include_users = null, exclude_roles = null }
    grant_controls   = { builtInControls = ["mfa"], built_in_controls = null }
    session_controls = { signInFrequency = { type = "hours", value = 4, frequency_interval = null }, sign_in_frequency = null, cloud_app_security_type = null }
  }
}
