# Integration tests: run against a real tenant with `terraform test
# -test-directory=tests/integration`. Requires msgraph provider credentials
# (az login or ARM_* environment variables) that carry Policy.Read.All,
# Policy.ReadWrite.ConditionalAccess, Group.ReadWrite.All and User.ReadWrite.All.
# Delegated access needs those scopes in the token plus the Conditional Access
# Administrator (or Security Administrator) and User Administrator roles.
# Set TF_VAR_verified_domain and TF_VAR_initial_user_password for the disabled
# stand-in emergency access user.
#
# Safety: every policy here is disabled or report-only, includes only an empty
# disposable group, and never includes All users. Destroy is implicit: the policy
# state is destroyed before the setup state, so the policy goes before the named
# locations, groups and user it references.

run "setup" {
  module {
    source = "./tests/integration/setup"
  }
}

run "create_policy" {
  command = apply

  variables {
    display_name         = "tftest-ca-${run.setup.suffix}"
    state                = "disabled"
    break_glass_user_ids = [run.setup.break_glass_user_id]
    users                = { include_groups = [run.setup.target_group_id] }
    applications         = { include_applications = ["All"] }
    client_app_types     = ["browser", "mobileAppsAndDesktopClients"]
    locations            = { include_locations = [run.setup.ip_location_id] }
    grant_controls       = { operator = "OR", built_in_controls = ["mfa"] }
  }

  assert {
    condition     = can(regex("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$", output.id))
    error_message = "Graph must return a GUID id for the created policy."
  }

  assert {
    condition     = output.state == "disabled"
    error_message = "The create read-back must show the policy as disabled."
  }

  assert {
    condition     = jsonencode(output.excluded_user_ids) == jsonencode([run.setup.break_glass_user_id]) && length(output.excluded_group_ids) == 0
    error_message = "The create read-back must exclude exactly the stand-in emergency access user."
  }

  assert {
    condition     = length(output.unmanaged_properties_set) == 0
    error_message = "Microsoft Graph returned properties that the module does not manage set on the created policy: ${join(", ", output.unmanaged_properties_set)}."
  }
}

run "verify_created" {
  module {
    source = "./tests/integration/verify"
  }

  variables {
    policy_id = run.create_policy.id
    run_label = "created"
  }

  assert {
    condition     = output.configuration.display_name == "tftest-ca-${run.setup.suffix}" && output.configuration.state == "disabled"
    error_message = "A fresh GET must return the name and the disabled state."
  }

  assert {
    condition = jsonencode(output.configuration.users) == jsonencode({
      excludeGroups = []
      excludeRoles  = []
      excludeUsers  = [run.setup.break_glass_user_id]
      includeGroups = [run.setup.target_group_id]
      includeRoles  = []
      includeUsers  = []
    })
    error_message = "A fresh GET must return the empty target group as the only inclusion and the stand-in emergency access user as the only exclusion."
  }

  assert {
    condition     = jsonencode(output.configuration.applications.includeApplications) == jsonencode(["All"]) && jsonencode(output.configuration.client_app_types) == jsonencode(["browser", "mobileAppsAndDesktopClients"])
    error_message = "A fresh GET must return the target resources and client app types."
  }

  assert {
    condition     = jsonencode(output.configuration.locations) == jsonencode({ exclude = [], include = [run.setup.ip_location_id] })
    error_message = "A fresh GET must return the IP named location as the only included location."
  }

  assert {
    condition     = jsonencode(output.configuration.grant_controls) == jsonencode({ authentication_strength_id = null, built_in_controls = ["mfa"], operator = "OR", terms_of_use = [] })
    error_message = "A fresh GET must return the mfa grant control."
  }

  assert {
    condition     = output.configuration.platforms == null && output.configuration.device_filter == null && output.configuration.session_controls == null
    error_message = "A fresh GET must return no platforms, device filter or session controls."
  }
}

# Idempotency: a refresh-only apply GETs the policy and maps the response onto
# the configured body. If the refreshed body equals local.body, the next plan
# has no change to the body.
run "refresh_created" {
  command = apply

  plan_options {
    mode = refresh-only
  }

  variables {
    display_name         = "tftest-ca-${run.setup.suffix}"
    state                = "disabled"
    break_glass_user_ids = [run.setup.break_glass_user_id]
    users                = { include_groups = [run.setup.target_group_id] }
    applications         = { include_applications = ["All"] }
    client_app_types     = ["browser", "mobileAppsAndDesktopClients"]
    locations            = { include_locations = [run.setup.ip_location_id] }
    grant_controls       = { operator = "OR", built_in_controls = ["mfa"] }
  }

  assert {
    condition     = jsonencode(msgraph_resource.policy.body) == jsonencode(local.body)
    error_message = "After a refresh the body differs from the configuration, so the next plan would not be empty."
  }

  assert {
    condition     = jsonencode(local.server_presence) == jsonencode(local.presence)
    error_message = "The optional parts Microsoft Graph returned must be exactly the configured ones, so optional_parts_not_in_configuration stays empty."
  }

  assert {
    condition     = try(length(local.server_unmanaged), 0) == 12
    error_message = "The read-back must export all 12 unmanaged property keys, or unmanaged_properties_set is empty whatever Microsoft Graph returned."
  }

  assert {
    condition     = length(output.unmanaged_properties_set) == 0
    error_message = "Microsoft Graph returned properties that the module does not manage set on the created policy: ${join(", ", output.unmanaged_properties_set)}."
  }
}

# PATCH in place: rename, disabled to report-only, add a break-glass group,
# change client app types, add the country location, change the grant operator.
run "update_in_place" {
  command = apply

  variables {
    display_name          = "tftest-ca-${run.setup.suffix}-updated"
    state                 = "enabledForReportingButNotEnforced"
    break_glass_user_ids  = [run.setup.break_glass_user_id]
    break_glass_group_ids = [run.setup.break_glass_group_id]
    users                 = { include_groups = [run.setup.target_group_id] }
    applications          = { include_applications = ["All"] }
    client_app_types      = ["all"]
    locations             = { include_locations = [run.setup.ip_location_id, run.setup.country_location_id] }
    grant_controls        = { operator = "AND", built_in_controls = ["mfa"] }
  }

  # Only the id is asserted here: after an update the provider waits for the
  # policy to exist, not for the new values, so its read-back can be stale.
  # verify_updated checks the values with a fresh GET after a delay.
  assert {
    condition     = output.id == run.create_policy.id
    error_message = "A change that keeps every optional part must update the policy in place."
  }
}

run "verify_updated" {
  module {
    source = "./tests/integration/verify"
  }

  variables {
    policy_id = run.update_in_place.id
    run_label = "updated"
  }

  assert {
    condition     = output.configuration.display_name == "tftest-ca-${run.setup.suffix}-updated" && output.configuration.state == "enabledForReportingButNotEnforced"
    error_message = "A fresh GET must return the new name and the report-only state."
  }

  assert {
    condition     = jsonencode(output.configuration.users.excludeGroups) == jsonencode([run.setup.break_glass_group_id]) && jsonencode(output.configuration.users.excludeUsers) == jsonencode([run.setup.break_glass_user_id])
    error_message = "A fresh GET must return both break-glass exclusions."
  }

  assert {
    condition     = jsonencode(output.configuration.users.includeGroups) == jsonencode([run.setup.target_group_id]) && length(output.configuration.users.includeUsers) == 0
    error_message = "The update must not widen the inclusions."
  }

  assert {
    condition     = jsonencode(output.configuration.client_app_types) == jsonencode(["all"]) && jsonencode(output.configuration.locations.include) == jsonencode(sort([run.setup.ip_location_id, run.setup.country_location_id]))
    error_message = "A fresh GET must return the new client app types and both locations."
  }

  assert {
    condition     = output.configuration.grant_controls.operator == "AND"
    error_message = "A fresh GET must return the new grant operator."
  }
}

run "refresh_updated" {
  command = apply

  plan_options {
    mode = refresh-only
  }

  variables {
    display_name          = "tftest-ca-${run.setup.suffix}-updated"
    state                 = "enabledForReportingButNotEnforced"
    break_glass_user_ids  = [run.setup.break_glass_user_id]
    break_glass_group_ids = [run.setup.break_glass_group_id]
    users                 = { include_groups = [run.setup.target_group_id] }
    applications          = { include_applications = ["All"] }
    client_app_types      = ["all"]
    locations             = { include_locations = [run.setup.ip_location_id, run.setup.country_location_id] }
    grant_controls        = { operator = "AND", built_in_controls = ["mfa"] }
  }

  assert {
    condition     = jsonencode(msgraph_resource.policy.body) == jsonencode(local.body)
    error_message = "After a refresh the body differs from the configuration, so the next plan would not be empty."
  }

  assert {
    condition     = jsonencode(local.server_presence) == jsonencode(local.presence)
    error_message = "The optional parts Microsoft Graph returned must be exactly the configured ones, so optional_parts_not_in_configuration stays empty."
  }

  assert {
    condition     = try(length(local.server_unmanaged), 0) == 12
    error_message = "The read-back must export all 12 unmanaged property keys, or unmanaged_properties_set is empty whatever Microsoft Graph returned."
  }

  assert {
    condition     = length(output.unmanaged_properties_set) == 0
    error_message = "Microsoft Graph returned properties that the module does not manage set on the updated policy: ${join(", ", output.unmanaged_properties_set)}."
  }
}

# Presence change: remove the location condition, add a device filter, a
# sign-in frequency session control and the built-in Multifactor
# authentication strength (which replaces the mfa control). The policy is
# replaced, create before destroy.
run "replace_on_presence_change" {
  command = apply

  variables {
    display_name          = "tftest-ca-${run.setup.suffix}-updated"
    state                 = "enabledForReportingButNotEnforced"
    break_glass_user_ids  = [run.setup.break_glass_user_id]
    break_glass_group_ids = [run.setup.break_glass_group_id]
    users                 = { include_groups = [run.setup.target_group_id] }
    applications          = { include_applications = ["All"] }
    client_app_types      = ["all"]
    device_filter         = { mode = "exclude", rule = "device.extensionAttribute1 -ne \"SAW\"" }
    grant_controls        = { operator = "OR", authentication_strength_id = "00000000-0000-0000-0000-000000000002" }
    session_controls      = { sign_in_frequency = { type = "hours", value = 12 } }
  }

  assert {
    condition     = output.id != run.update_in_place.id
    error_message = "Adding or removing an optional part must replace the policy."
  }

  assert {
    condition     = output.state == "enabledForReportingButNotEnforced"
    error_message = "The replacement must be report-only."
  }

  assert {
    condition     = length(output.unmanaged_properties_set) == 0
    error_message = "Microsoft Graph returned properties that the module does not manage set on the replacement: ${join(", ", output.unmanaged_properties_set)}."
  }
}

run "verify_replaced" {
  module {
    source = "./tests/integration/verify"
  }

  variables {
    policy_id = run.replace_on_presence_change.id
    run_label = "replaced"
  }

  assert {
    condition     = output.configuration.locations == null
    error_message = "A fresh GET of the replacement must return no location condition."
  }

  assert {
    condition     = jsonencode(output.configuration.device_filter) == jsonencode({ mode = "exclude", rule = "device.extensionAttribute1 -ne \"SAW\"" })
    error_message = "A fresh GET must return the device filter as sent."
  }

  assert {
    condition     = jsonencode(output.configuration.grant_controls) == jsonencode({ authentication_strength_id = "00000000-0000-0000-0000-000000000002", built_in_controls = [], operator = "OR", terms_of_use = [] })
    error_message = "A fresh GET must return the authentication strength and no built-in controls."
  }

  assert {
    condition     = jsonencode(output.configuration.session_controls.sign_in_frequency) == jsonencode({ authentication_type = "primaryAndSecondaryAuthentication", frequency_interval = "timeBased", is_enabled = true, type = "hours", value = 12 })
    error_message = "A fresh GET must return the sign-in frequency as sent."
  }

  assert {
    condition     = jsonencode(output.configuration.users.excludeUsers) == jsonencode([run.setup.break_glass_user_id]) && jsonencode(output.configuration.users.excludeGroups) == jsonencode([run.setup.break_glass_group_id])
    error_message = "The replacement must carry both break-glass exclusions."
  }
}

run "refresh_replaced" {
  command = apply

  plan_options {
    mode = refresh-only
  }

  variables {
    display_name          = "tftest-ca-${run.setup.suffix}-updated"
    state                 = "enabledForReportingButNotEnforced"
    break_glass_user_ids  = [run.setup.break_glass_user_id]
    break_glass_group_ids = [run.setup.break_glass_group_id]
    users                 = { include_groups = [run.setup.target_group_id] }
    applications          = { include_applications = ["All"] }
    client_app_types      = ["all"]
    device_filter         = { mode = "exclude", rule = "device.extensionAttribute1 -ne \"SAW\"" }
    grant_controls        = { operator = "OR", authentication_strength_id = "00000000-0000-0000-0000-000000000002" }
    session_controls      = { sign_in_frequency = { type = "hours", value = 12 } }
  }

  assert {
    condition     = jsonencode(msgraph_resource.policy.body) == jsonencode(local.body)
    error_message = "After a refresh the body differs from the configuration, so the next plan would not be empty."
  }

  assert {
    condition     = jsonencode(local.server_presence) == jsonencode(local.presence)
    error_message = "The optional parts Microsoft Graph returned must be exactly the configured ones, so optional_parts_not_in_configuration stays empty."
  }

  assert {
    condition     = try(length(local.server_unmanaged), 0) == 12
    error_message = "The read-back must export all 12 unmanaged property keys, or unmanaged_properties_set is empty whatever Microsoft Graph returned."
  }

  assert {
    condition     = length(output.unmanaged_properties_set) == 0
    error_message = "Microsoft Graph returned properties that the module does not manage set on the replacement: ${join(", ", output.unmanaged_properties_set)}."
  }
}
