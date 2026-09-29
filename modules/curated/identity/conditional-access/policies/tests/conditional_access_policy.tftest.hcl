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

run "defaults_render_full_shape_in_report_only" {
  command = apply

  assert {
    condition     = msgraph_resource.policy.url == "identity/conditionalAccess/policies" && msgraph_resource.policy.api_version == "v1.0"
    error_message = "Policies must be created at identity/conditionalAccess/policies on v1.0."
  }

  assert {
    condition     = msgraph_resource.policy.ignore_missing_property == false
    error_message = "ignore_missing_property must be false so that server-side nulling shows as drift."
  }

  assert {
    condition = jsonencode(msgraph_resource.policy.body) == jsonencode({
      displayName = "Require MFA for pilot"
      state       = "enabledForReportingButNotEnforced"
      conditions = {
        users = {
          includeUsers  = []
          excludeUsers  = ["11111111-1111-1111-1111-111111111111"]
          includeGroups = ["22222222-2222-2222-2222-222222222222"]
          excludeGroups = []
          includeRoles  = []
          excludeRoles  = []
        }
        applications = {
          includeApplications                         = ["All"]
          excludeApplications                         = []
          includeUserActions                          = []
          includeAuthenticationContextClassReferences = []
        }
        clientAppTypes   = ["all"]
        signInRiskLevels = []
        userRiskLevels   = []
        locations        = null
        platforms        = null
        devices          = null
      }
      grantControls = {
        operator        = "OR"
        builtInControls = ["mfa"]
        termsOfUse      = []
      }
      sessionControls = null
    })
    error_message = "The body must render every managed key: lists empty when unset, absent optional parts null, the break-glass user excluded, and report-only state."
  }

  assert {
    condition     = jsonencode(terraform_data.presence.output) == jsonencode(["grantControls"])
    error_message = "The presence signature must list exactly the optional parts that are present."
  }

  assert {
    condition     = jsonencode(local.server_presence) == jsonencode(local.presence) && length(output.optional_parts_not_in_configuration) == 0
    error_message = "The optional parts read back from Microsoft Graph must be mapped into the presence form, and none may be reported as missing from the configuration."
  }

  assert {
    condition     = output.id == "66666666-6666-6666-6666-666666666666" && output.state == "enabledForReportingButNotEnforced" && output.display_name == "Require MFA for pilot"
    error_message = "id, state and display_name must come from the resource and its read-back."
  }

  assert {
    condition     = jsonencode(output.excluded_user_ids) == jsonencode(["11111111-1111-1111-1111-111111111111"]) && length(output.excluded_group_ids) == 0
    error_message = "The read-back exclusions must be exposed."
  }
}

run "value_changes_keep_the_presence_signature" {
  command = apply

  variables {
    display_name          = "Require MFA for pilot renamed"
    state                 = "disabled"
    break_glass_group_ids = ["44444444-4444-4444-4444-444444444444"]
    client_app_types      = ["mobileAppsAndDesktopClients", "browser"]
    grant_controls        = { operator = "AND", built_in_controls = ["mfa", "compliantDevice"] }
  }

  # A new object would take this id; an in-place update keeps the old one.
  override_resource {
    target = msgraph_resource.policy
    values = {
      id = "66666666-6666-6666-6666-000000000001"
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
      }
    }
  }

  assert {
    condition     = jsonencode(terraform_data.presence.output) == jsonencode(["grantControls"])
    error_message = "A value-only change must keep the presence signature, so the policy is updated in place."
  }

  assert {
    condition     = output.id == "66666666-6666-6666-6666-666666666666"
    error_message = "A value-only change must update the policy in place and keep its id."
  }

  assert {
    condition     = msgraph_resource.policy.body.state == "disabled" && msgraph_resource.policy.body.displayName == "Require MFA for pilot renamed"
    error_message = "The update body must carry the new state and name."
  }

  assert {
    condition     = jsonencode(msgraph_resource.policy.body.conditions.users.excludeGroups) == jsonencode(["44444444-4444-4444-4444-444444444444"])
    error_message = "A break-glass group must be merged into excludeGroups."
  }

  assert {
    condition     = jsonencode(msgraph_resource.policy.body.conditions.clientAppTypes) == jsonencode(["browser", "mobileAppsAndDesktopClients"])
    error_message = "clientAppTypes must be sorted."
  }

  assert {
    condition     = jsonencode(msgraph_resource.policy.body.grantControls) == jsonencode({ operator = "AND", builtInControls = ["compliantDevice", "mfa"], termsOfUse = [] })
    error_message = "The update body must carry the full, sorted grant controls object."
  }
}

run "adding_a_session_control_changes_the_presence_signature" {
  command = apply

  variables {
    session_controls = { sign_in_frequency = { type = "hours", value = 12 } }
  }

  override_resource {
    target = msgraph_resource.policy
    values = {
      id = "66666666-6666-6666-6666-000000000002"
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
          session_controls                  = true
          sign_in_frequency                 = true
          persistent_browser                = false
          application_enforced_restrictions = false
          cloud_app_security                = false
        }
      }
    }
  }

  assert {
    condition     = output.id == "66666666-6666-6666-6666-000000000002"
    error_message = "Adding an optional part must replace the policy, so the new object's id is used."
  }

  assert {
    condition     = jsonencode(local.server_presence) == jsonencode(local.presence)
    error_message = "The replacement's read-back optional parts must match the configuration."
  }

  assert {
    condition     = jsonencode(terraform_data.presence.output) == jsonencode(["grantControls", "sessionControls", "sessionControls.signInFrequency"])
    error_message = "Adding a session control must change the presence signature, which replaces the policy."
  }

  assert {
    condition     = jsonencode(msgraph_resource.policy.body.sessionControls) == jsonencode({ signInFrequency = { authenticationType = "primaryAndSecondaryAuthentication", frequencyInterval = "timeBased", isEnabled = true, type = "hours", value = 12 } })
    error_message = "signInFrequency must be sent enabled, with every key."
  }
}

run "frequency_change_inside_a_present_part_updates_in_place" {
  command = apply

  variables {
    session_controls = { sign_in_frequency = { frequency_interval = "everyTime" } }
  }

  override_resource {
    target = msgraph_resource.policy
    values = {
      id = "66666666-6666-6666-6666-000000000003"
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
          session_controls                  = true
          sign_in_frequency                 = true
          persistent_browser                = false
          application_enforced_restrictions = false
          cloud_app_security                = false
        }
      }
    }
  }

  assert {
    condition     = output.id == "66666666-6666-6666-6666-000000000002"
    error_message = "A change inside a present session control must update the policy in place and keep its id."
  }

  assert {
    condition     = jsonencode(msgraph_resource.policy.body.sessionControls.signInFrequency) == jsonencode({ authenticationType = "primaryAndSecondaryAuthentication", frequencyInterval = "everyTime", isEnabled = true, type = null, value = null })
    error_message = "Switching to everyTime must send type and value as null inside the whole signInFrequency object."
  }
}

run "removing_a_session_control_changes_the_presence_signature" {
  command = apply

  override_resource {
    target = msgraph_resource.policy
    values = {
      id = "66666666-6666-6666-6666-000000000004"
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
      }
    }
  }

  assert {
    condition     = output.id == "66666666-6666-6666-6666-000000000004"
    error_message = "Removing an optional part must replace the policy, so the new object's id is used."
  }

  assert {
    condition     = jsonencode(terraform_data.presence.output) == jsonencode(["grantControls"]) && msgraph_resource.policy.body.sessionControls == null
    error_message = "Removing the session controls must change the presence signature and send sessionControls as null."
  }
}

run "refresh_only_keeps_body_equal_to_configuration" {
  command = apply

  plan_options {
    mode = refresh-only
  }

  assert {
    condition     = jsonencode(msgraph_resource.policy.body) == jsonencode(local.body)
    error_message = "A refresh-only run must be able to compare the refreshed body with local.body."
  }
}

run "canonicalizes_ids_and_merges_break_glass" {
  command = plan

  variables {
    break_glass_user_ids  = ["11111111-1111-1111-1111-111111111111", "33333333-3333-3333-3333-333333333333"]
    break_glass_group_ids = ["44444444-4444-4444-4444-444444444444"]
    users = {
      include_users  = ["All"]
      exclude_users  = ["AAAAAAAA-0000-0000-0000-000000000001", "aaaaaaaa-0000-0000-0000-000000000001", "GuestsOrExternalUsers", "11111111-1111-1111-1111-111111111111"]
      exclude_groups = ["55555555-5555-5555-5555-555555555555"]
      include_roles  = ["BBBBBBBB-0000-4000-8000-000000000001"]
    }
  }

  assert {
    condition     = jsonencode(msgraph_resource.policy.body.conditions.users.excludeUsers) == jsonencode(["11111111-1111-1111-1111-111111111111", "33333333-3333-3333-3333-333333333333", "GuestsOrExternalUsers", "aaaaaaaa-0000-0000-0000-000000000001"])
    error_message = "excludeUsers must hold the lower-cased, de-duplicated, sorted union of exclude_users and the break-glass users, keeping GuestsOrExternalUsers."
  }

  assert {
    condition     = jsonencode(msgraph_resource.policy.body.conditions.users.excludeGroups) == jsonencode(["44444444-4444-4444-4444-444444444444", "55555555-5555-5555-5555-555555555555"])
    error_message = "excludeGroups must hold the union of exclude_groups and the break-glass groups."
  }

  assert {
    condition     = jsonencode(msgraph_resource.policy.body.conditions.users.includeUsers) == jsonencode(["All"]) && jsonencode(msgraph_resource.policy.body.conditions.users.includeRoles) == jsonencode(["bbbbbbbb-0000-4000-8000-000000000001"])
    error_message = "Special values must be kept as given and role template IDs lower-cased."
  }
}

run "canonicalizes_application_location_terms_of_use_and_strength_ids" {
  command = plan

  variables {
    applications = {
      include_applications = ["AAAAAAAA-0000-0000-0000-00000000000A", "aaaaaaaa-0000-0000-0000-00000000000a", "Office365"]
      exclude_applications = ["BBBBBBBB-0000-0000-0000-00000000000B"]
    }
    locations      = { include_locations = ["CCCCCCCC-0000-0000-0000-00000000000C", "AllTrusted"], exclude_locations = ["DDDDDDDD-0000-0000-0000-00000000000D"] }
    grant_controls = { operator = "AND", built_in_controls = ["compliantDevice"], authentication_strength_id = "EEEEEEEE-0000-0000-0000-00000000000E", terms_of_use = ["ABABABAB-0000-0000-0000-00000000000A", "abababab-0000-0000-0000-00000000000a"] }
  }

  assert {
    condition     = jsonencode(msgraph_resource.policy.body.conditions.applications.includeApplications) == jsonencode(["Office365", "aaaaaaaa-0000-0000-0000-00000000000a"]) && jsonencode(msgraph_resource.policy.body.conditions.applications.excludeApplications) == jsonencode(["bbbbbbbb-0000-0000-0000-00000000000b"])
    error_message = "Application IDs must be lower-cased and de-duplicated, keeping Office365 as given."
  }

  assert {
    condition     = jsonencode(msgraph_resource.policy.body.conditions.locations) == jsonencode({ excludeLocations = ["dddddddd-0000-0000-0000-00000000000d"], includeLocations = ["AllTrusted", "cccccccc-0000-0000-0000-00000000000c"] })
    error_message = "Named location IDs must be lower-cased, keeping AllTrusted as given."
  }

  assert {
    condition     = jsonencode(msgraph_resource.policy.body.grantControls) == jsonencode({ authenticationStrength = { id = "eeeeeeee-0000-0000-0000-00000000000e" }, builtInControls = ["compliantDevice"], operator = "AND", termsOfUse = ["abababab-0000-0000-0000-00000000000a"] })
    error_message = "The authentication strength ID and the terms of use IDs must be lower-cased, and the terms of use de-duplicated."
  }
}

run "renders_every_optional_part" {
  command = plan

  variables {
    locations        = { include_locations = ["All"], exclude_locations = ["AllTrusted", "77777777-7777-7777-7777-777777777777"] }
    platforms        = { include_platforms = ["all"], exclude_platforms = ["iOS"] }
    device_filter    = { mode = "exclude", rule = "device.extensionAttribute1 -ne \"SAW\"" }
    grant_controls   = { operator = "AND", built_in_controls = ["compliantDevice"], authentication_strength_id = "00000000-0000-0000-0000-000000000002", terms_of_use = ["88888888-8888-8888-8888-888888888888"] }
    session_controls = { sign_in_frequency = { frequency_interval = "everyTime" }, persistent_browser_mode = "never", application_enforced_restrictions = true, cloud_app_security_type = "monitorOnly" }
  }

  assert {
    condition     = jsonencode(msgraph_resource.policy.body.conditions.locations) == jsonencode({ excludeLocations = ["77777777-7777-7777-7777-777777777777", "AllTrusted"], includeLocations = ["All"] })
    error_message = "locations must be rendered with sorted include and exclude lists."
  }

  assert {
    condition     = jsonencode(msgraph_resource.policy.body.conditions.platforms) == jsonencode({ excludePlatforms = ["iOS"], includePlatforms = ["all"] })
    error_message = "platforms must be rendered with both lists."
  }

  assert {
    condition     = jsonencode(msgraph_resource.policy.body.conditions.devices) == jsonencode({ deviceFilter = { mode = "exclude", rule = "device.extensionAttribute1 -ne \"SAW\"" } })
    error_message = "device_filter must be rendered as conditions.devices.deviceFilter."
  }

  assert {
    condition     = jsonencode(msgraph_resource.policy.body.grantControls) == jsonencode({ authenticationStrength = { id = "00000000-0000-0000-0000-000000000002" }, builtInControls = ["compliantDevice"], operator = "AND", termsOfUse = ["88888888-8888-8888-8888-888888888888"] })
    error_message = "grantControls must carry the authentication strength by id and the terms of use."
  }

  assert {
    condition = jsonencode(msgraph_resource.policy.body.sessionControls) == jsonencode({
      applicationEnforcedRestrictions = { isEnabled = true }
      cloudAppSecurity                = { cloudAppSecurityType = "monitorOnly", isEnabled = true }
      persistentBrowser               = { isEnabled = true, mode = "never" }
      signInFrequency                 = { authenticationType = "primaryAndSecondaryAuthentication", frequencyInterval = "everyTime", isEnabled = true, type = null, value = null }
    })
    error_message = "Every configured session control must be sent enabled; everyTime sends a null type and value."
  }

  assert {
    condition = jsonencode(terraform_data.presence.input) == jsonencode([
      "conditions.devices",
      "conditions.locations",
      "conditions.platforms",
      "grantControls",
      "grantControls.authenticationStrength",
      "sessionControls",
      "sessionControls.applicationEnforcedRestrictions",
      "sessionControls.cloudAppSecurity",
      "sessionControls.persistentBrowser",
      "sessionControls.signInFrequency",
    ])
    error_message = "The presence signature must list every optional part that is present."
  }
}

run "allows_user_actions_when_disabled" {
  command = plan

  variables {
    state        = "disabled"
    applications = { include_user_actions = ["urn:user:registersecurityinfo"] }
  }

  assert {
    condition     = jsonencode(msgraph_resource.policy.body.conditions.applications.includeUserActions) == jsonencode(["urn:user:registersecurityinfo"]) && length(msgraph_resource.policy.body.conditions.applications.includeApplications) == 0
    error_message = "User actions must be sent, with includeApplications empty."
  }
}

run "allows_password_change_policy" {
  command = plan

  variables {
    users            = { include_users = ["All"] }
    user_risk_levels = ["high"]
    grant_controls   = { operator = "AND", built_in_controls = ["mfa", "passwordChange"] }
  }

  assert {
    condition     = jsonencode(msgraph_resource.policy.body.grantControls.builtInControls) == jsonencode(["mfa", "passwordChange"]) && jsonencode(msgraph_resource.policy.body.conditions.userRiskLevels) == jsonencode(["high"])
    error_message = "A valid password change policy must be accepted."
  }
}

run "allows_block_as_the_only_grant_control" {
  command = plan

  variables {
    grant_controls = { built_in_controls = ["block"] }
  }

  assert {
    condition     = jsonencode(msgraph_resource.policy.body.grantControls) == jsonencode({ operator = "OR", builtInControls = ["block"], termsOfUse = [] })
    error_message = "block alone must be accepted and sent as the only grant control."
  }
}

run "allows_authentication_context_as_the_only_target_selector" {
  command = plan

  variables {
    applications = { include_authentication_context_class_references = ["c1"] }
  }

  assert {
    condition     = jsonencode(msgraph_resource.policy.body.conditions.applications.includeAuthenticationContextClassReferences) == jsonencode(["c1"]) && length(msgraph_resource.policy.body.conditions.applications.includeApplications) == 0 && length(msgraph_resource.policy.body.conditions.applications.includeUserActions) == 0
    error_message = "An authentication context as the only target selector must be accepted, with the other selectors empty."
  }
}

run "allows_23_hour_sign_in_frequency" {
  command = plan

  variables {
    session_controls = { sign_in_frequency = { type = "hours", value = 23 } }
  }

  assert {
    condition     = msgraph_resource.policy.body.sessionControls.signInFrequency.type == "hours" && msgraph_resource.policy.body.sessionControls.signInFrequency.value == 23
    error_message = "A time-based sign-in frequency of 23 hours must be accepted."
  }
}

run "allows_365_day_sign_in_frequency" {
  command = plan

  variables {
    session_controls = { sign_in_frequency = { type = "days", value = 365 } }
  }

  assert {
    condition     = msgraph_resource.policy.body.sessionControls.signInFrequency.type == "days" && msgraph_resource.policy.body.sessionControls.signInFrequency.value == 365
    error_message = "A time-based sign-in frequency of 365 days must be accepted."
  }
}

run "allows_session_controls_without_grant_controls" {
  command = plan

  variables {
    grant_controls   = null
    session_controls = { sign_in_frequency = { type = "hours", value = 12 } }
  }

  assert {
    condition     = msgraph_resource.policy.body.grantControls == null && msgraph_resource.policy.body.sessionControls.signInFrequency.value == 12
    error_message = "A policy with session controls and no grant controls must be accepted."
  }
}

run "allows_register_device_with_mfa_when_disabled" {
  command = plan

  variables {
    state        = "disabled"
    applications = { include_user_actions = ["urn:user:registerdevice"] }
  }

  assert {
    condition     = jsonencode(msgraph_resource.policy.body.conditions.applications.includeUserActions) == jsonencode(["urn:user:registerdevice"]) && jsonencode(msgraph_resource.policy.body.grantControls.builtInControls) == jsonencode(["mfa"])
    error_message = "Register or join devices with mfa must be accepted."
  }
}

run "rejects_break_glass_user_in_include_users" {
  command = plan

  variables {
    users = { include_users = ["11111111-1111-1111-1111-111111111111"] }
  }

  expect_failures = [msgraph_resource.policy]
}

run "rejects_break_glass_group_in_include_groups" {
  command = plan

  variables {
    break_glass_group_ids = ["22222222-2222-2222-2222-222222222222"]
  }

  expect_failures = [msgraph_resource.policy]
}

run "rejects_break_glass_user_in_include_groups" {
  command = plan

  variables {
    users = { include_groups = ["22222222-2222-2222-2222-222222222222", "11111111-1111-1111-1111-111111111111"] }
  }

  expect_failures = [msgraph_resource.policy]
}

run "rejects_missing_break_glass_user" {
  command = plan

  variables {
    break_glass_user_ids  = []
    break_glass_group_ids = ["44444444-4444-4444-4444-444444444444"]
  }

  expect_failures = [var.break_glass_user_ids]
}

run "rejects_upper_case_break_glass_user" {
  command = plan

  variables {
    break_glass_user_ids = ["AAAAAAAA-0000-0000-0000-000000000001"]
  }

  expect_failures = [var.break_glass_user_ids]
}

run "rejects_upper_case_break_glass_group" {
  command = plan

  variables {
    break_glass_group_ids = ["AAAAAAAA-0000-0000-0000-000000000002"]
  }

  expect_failures = [var.break_glass_group_ids]
}

run "rejects_unknown_state" {
  command = plan

  variables {
    state = "on"
  }

  expect_failures = [var.state]
}

run "rejects_empty_display_name" {
  command = plan

  variables {
    display_name = " "
  }

  expect_failures = [var.display_name]
}

run "rejects_unknown_include_users_keyword" {
  command = plan

  variables {
    users = { include_users = ["Everyone"] }
  }

  expect_failures = [var.users]
}

run "rejects_all_in_exclude_users" {
  command = plan

  variables {
    users = { include_groups = ["22222222-2222-2222-2222-222222222222"], exclude_users = ["All"] }
  }

  expect_failures = [var.users]
}

run "rejects_non_guid_group" {
  command = plan

  variables {
    users = { include_groups = ["engineering"] }
  }

  expect_failures = [var.users]
}

run "rejects_users_without_include" {
  command = plan

  variables {
    users = { exclude_groups = ["22222222-2222-2222-2222-222222222222"] }
  }

  expect_failures = [var.users]
}

run "rejects_unknown_application_keyword" {
  command = plan

  variables {
    applications = { include_applications = ["Office"] }
  }

  expect_failures = [var.applications]
}

run "rejects_all_in_exclude_applications" {
  command = plan

  variables {
    applications = { include_applications = ["All"], exclude_applications = ["All"] }
  }

  expect_failures = [var.applications]
}

run "rejects_unknown_user_action" {
  command = plan

  variables {
    applications = { include_user_actions = ["urn:user:registerapp"] }
  }

  expect_failures = [var.applications]
}

run "rejects_invalid_authentication_context" {
  command = plan

  variables {
    applications = { include_authentication_context_class_references = ["c100"] }
  }

  expect_failures = [var.applications]
}

run "rejects_applications_without_include" {
  command = plan

  variables {
    applications = { exclude_applications = ["Office365"] }
  }

  expect_failures = [var.applications]
}

# The target selectors are mutually exclusive. The state is disabled so that
# the user action rule for report-only policies cannot fail these runs instead.
run "rejects_applications_with_user_actions" {
  command = plan

  variables {
    state        = "disabled"
    applications = { include_applications = ["All"], include_user_actions = ["urn:user:registersecurityinfo"] }
  }

  expect_failures = [var.applications]
}

run "rejects_applications_with_authentication_context" {
  command = plan

  variables {
    state        = "disabled"
    applications = { include_applications = ["All"], include_authentication_context_class_references = ["c1"] }
  }

  expect_failures = [var.applications]
}

run "rejects_user_actions_with_authentication_context" {
  command = plan

  variables {
    state        = "disabled"
    applications = { include_user_actions = ["urn:user:registersecurityinfo"], include_authentication_context_class_references = ["c1"] }
  }

  expect_failures = [var.applications]
}

run "rejects_empty_client_app_types" {
  command = plan

  variables {
    client_app_types = []
  }

  expect_failures = [var.client_app_types]
}

run "rejects_unknown_client_app_type" {
  command = plan

  variables {
    client_app_types = ["legacy"]
  }

  expect_failures = [var.client_app_types]
}

run "rejects_unknown_sign_in_risk_level" {
  command = plan

  variables {
    sign_in_risk_levels = ["unknownFutureValue"]
  }

  expect_failures = [var.sign_in_risk_levels]
}

run "rejects_unknown_user_risk_level" {
  command = plan

  variables {
    user_risk_levels = ["severe"]
  }

  expect_failures = [var.user_risk_levels]
}

run "rejects_empty_include_locations" {
  command = plan

  variables {
    locations = { include_locations = [] }
  }

  expect_failures = [var.locations]
}

run "rejects_all_in_exclude_locations" {
  command = plan

  variables {
    locations = { include_locations = ["AllTrusted"], exclude_locations = ["All"] }
  }

  expect_failures = [var.locations]
}

run "rejects_empty_include_platforms" {
  command = plan

  variables {
    platforms = { include_platforms = [] }
  }

  expect_failures = [var.platforms]
}

run "rejects_unknown_platform" {
  command = plan

  variables {
    platforms = { include_platforms = ["ios"] }
  }

  expect_failures = [var.platforms]
}

run "rejects_linux_platform" {
  command = plan

  variables {
    platforms = { include_platforms = ["linux"] }
  }

  expect_failures = [var.platforms]
}

run "rejects_unknown_device_filter_mode" {
  command = plan

  variables {
    device_filter = { mode = "only", rule = "device.extensionAttribute1 -ne \"SAW\"" }
  }

  expect_failures = [var.device_filter]
}

run "rejects_empty_device_filter_rule" {
  command = plan

  variables {
    device_filter = { mode = "exclude", rule = " " }
  }

  expect_failures = [var.device_filter]
}

run "rejects_device_filter_rule_over_3072_characters" {
  command = plan

  variables {
    device_filter = { mode = "exclude", rule = join("", [for i in range(1000) : "abcd"]) }
  }

  expect_failures = [var.device_filter]
}

run "rejects_unknown_operator" {
  command = plan

  variables {
    grant_controls = { operator = "XOR", built_in_controls = ["mfa"] }
  }

  expect_failures = [var.grant_controls]
}

run "rejects_risk_remediation" {
  command = plan

  variables {
    grant_controls = { operator = "AND", built_in_controls = ["riskRemediation"] }
  }

  expect_failures = [var.grant_controls]
}

run "rejects_approved_application" {
  command = plan

  variables {
    grant_controls = { operator = "OR", built_in_controls = ["approvedApplication", "compliantApplication"] }
  }

  expect_failures = [var.grant_controls]
}

run "rejects_non_guid_authentication_strength" {
  command = plan

  variables {
    grant_controls = { authentication_strength_id = "phishing-resistant" }
  }

  expect_failures = [var.grant_controls]
}

run "rejects_empty_grant_controls" {
  command = plan

  variables {
    grant_controls = { operator = "OR" }
  }

  expect_failures = [var.grant_controls]
}

run "rejects_empty_session_controls" {
  command = plan

  variables {
    session_controls = {}
  }

  expect_failures = [var.session_controls]
}

run "rejects_time_based_frequency_without_type" {
  command = plan

  variables {
    session_controls = { sign_in_frequency = { value = 4 } }
  }

  expect_failures = [var.session_controls]
}

run "rejects_fractional_frequency" {
  command = plan

  variables {
    session_controls = { sign_in_frequency = { type = "hours", value = 1.5 } }
  }

  expect_failures = [var.session_controls]
}

run "rejects_24_hour_frequency" {
  command = plan

  variables {
    session_controls = { sign_in_frequency = { type = "hours", value = 24 } }
  }

  expect_failures = [var.session_controls]
}

run "rejects_366_day_frequency" {
  command = plan

  variables {
    session_controls = { sign_in_frequency = { type = "days", value = 366 } }
  }

  expect_failures = [var.session_controls]
}

run "rejects_every_time_with_value" {
  command = plan

  variables {
    session_controls = { sign_in_frequency = { frequency_interval = "everyTime", type = "hours", value = 1 } }
  }

  expect_failures = [var.session_controls]
}

run "rejects_unknown_persistent_browser_mode" {
  command = plan

  variables {
    session_controls = { persistent_browser_mode = "sometimes" }
  }

  expect_failures = [var.session_controls]
}

run "rejects_unknown_cloud_app_security_type" {
  command = plan

  variables {
    session_controls = { cloud_app_security_type = "blockUploads" }
  }

  expect_failures = [var.session_controls]
}

run "rejects_unknown_api_version" {
  command = plan

  variables {
    api_version = "v2.0"
  }

  expect_failures = [var.api_version]
}

run "rejects_user_actions_in_report_only" {
  command = plan

  variables {
    applications = { include_user_actions = ["urn:user:registerdevice"] }
  }

  expect_failures = [msgraph_resource.policy]
}

run "rejects_combined_risk_levels" {
  command = plan

  variables {
    sign_in_risk_levels = ["high"]
    user_risk_levels    = ["high"]
  }

  expect_failures = [msgraph_resource.policy]
}

run "rejects_mfa_with_authentication_strength" {
  command = plan

  variables {
    grant_controls = { built_in_controls = ["mfa"], authentication_strength_id = "00000000-0000-0000-0000-000000000002" }
  }

  expect_failures = [msgraph_resource.policy]
}

run "rejects_password_change_with_or" {
  command = plan

  variables {
    users            = { include_users = ["All"] }
    user_risk_levels = ["high"]
    grant_controls   = { operator = "OR", built_in_controls = ["mfa", "passwordChange"] }
  }

  expect_failures = [msgraph_resource.policy]
}

run "rejects_password_change_without_mfa" {
  command = plan

  variables {
    users            = { include_users = ["All"] }
    user_risk_levels = ["high"]
    grant_controls   = { operator = "AND", built_in_controls = ["passwordChange"] }
  }

  expect_failures = [msgraph_resource.policy]
}

# passwordChange needs the mfa built-in control; an authentication strength
# does not stand in for it.
run "rejects_password_change_with_authentication_strength" {
  command = plan

  variables {
    users            = { include_users = ["All"] }
    user_risk_levels = ["high"]
    grant_controls   = { operator = "AND", built_in_controls = ["passwordChange"], authentication_strength_id = "00000000-0000-0000-0000-000000000002" }
  }

  expect_failures = [msgraph_resource.policy]
}

# block must be the only grant control.
run "rejects_block_with_mfa" {
  command = plan

  variables {
    grant_controls = { operator = "OR", built_in_controls = ["block", "mfa"] }
  }

  expect_failures = [msgraph_resource.policy]
}

run "rejects_block_with_terms_of_use" {
  command = plan

  variables {
    grant_controls = { built_in_controls = ["block"], terms_of_use = ["88888888-8888-8888-8888-888888888888"] }
  }

  expect_failures = [msgraph_resource.policy]
}

run "rejects_block_with_authentication_strength" {
  command = plan

  variables {
    grant_controls = { built_in_controls = ["block"], authentication_strength_id = "00000000-0000-0000-0000-000000000002" }
  }

  expect_failures = [msgraph_resource.policy]
}

run "rejects_password_change_without_user_risk" {
  command = plan

  variables {
    users          = { include_users = ["All"] }
    grant_controls = { operator = "AND", built_in_controls = ["mfa", "passwordChange"] }
  }

  expect_failures = [msgraph_resource.policy]
}

run "rejects_password_change_with_another_condition" {
  command = plan

  variables {
    users            = { include_users = ["All"] }
    user_risk_levels = ["high"]
    locations        = { include_locations = ["All"] }
    grant_controls   = { operator = "AND", built_in_controls = ["mfa", "passwordChange"] }
  }

  expect_failures = [msgraph_resource.policy]
}

run "rejects_password_change_without_all_applications" {
  command = plan

  variables {
    users            = { include_users = ["All"] }
    user_risk_levels = ["high"]
    applications     = { include_applications = ["Office365"] }
    grant_controls   = { operator = "AND", built_in_controls = ["mfa", "passwordChange"] }
  }

  expect_failures = [msgraph_resource.policy]
}

run "rejects_password_change_with_compliant_device" {
  command = plan

  variables {
    users            = { include_users = ["All"] }
    user_risk_levels = ["high"]
    grant_controls   = { operator = "AND", built_in_controls = ["mfa", "passwordChange", "compliantDevice"] }
  }

  expect_failures = [msgraph_resource.policy]
}

run "rejects_password_change_with_terms_of_use" {
  command = plan

  variables {
    users            = { include_users = ["All"] }
    user_risk_levels = ["high"]
    grant_controls   = { operator = "AND", built_in_controls = ["mfa", "passwordChange"], terms_of_use = ["88888888-8888-8888-8888-888888888888"] }
  }

  expect_failures = [msgraph_resource.policy]
}

run "rejects_password_change_with_an_excluded_application" {
  command = plan

  variables {
    users            = { include_users = ["All"] }
    user_risk_levels = ["high"]
    applications     = { include_applications = ["All"], exclude_applications = ["Office365"] }
    grant_controls   = { operator = "AND", built_in_controls = ["mfa", "passwordChange"] }
  }

  expect_failures = [msgraph_resource.policy]
}

run "rejects_password_change_with_platforms" {
  command = plan

  variables {
    users            = { include_users = ["All"] }
    user_risk_levels = ["high"]
    platforms        = { include_platforms = ["all"] }
    grant_controls   = { operator = "AND", built_in_controls = ["mfa", "passwordChange"] }
  }

  expect_failures = [msgraph_resource.policy]
}

run "rejects_password_change_with_device_filter" {
  command = plan

  variables {
    users            = { include_users = ["All"] }
    user_risk_levels = ["high"]
    device_filter    = { mode = "exclude", rule = "device.extensionAttribute1 -ne \"SAW\"" }
    grant_controls   = { operator = "AND", built_in_controls = ["mfa", "passwordChange"] }
  }

  expect_failures = [msgraph_resource.policy]
}

run "rejects_password_change_with_another_client_app_type" {
  command = plan

  variables {
    users            = { include_users = ["All"] }
    user_risk_levels = ["high"]
    client_app_types = ["browser"]
    grant_controls   = { operator = "AND", built_in_controls = ["mfa", "passwordChange"] }
  }

  expect_failures = [msgraph_resource.policy]
}

run "rejects_persistent_browser_without_all_applications" {
  command = plan

  variables {
    applications     = { include_applications = ["Office365"] }
    session_controls = { persistent_browser_mode = "never" }
  }

  expect_failures = [msgraph_resource.policy]
}

run "rejects_policy_without_controls" {
  command = plan

  variables {
    grant_controls = null
  }

  expect_failures = [msgraph_resource.policy]
}

run "rejects_register_device_with_compliant_device" {
  command = plan

  variables {
    state          = "disabled"
    applications   = { include_user_actions = ["urn:user:registerdevice"] }
    grant_controls = { operator = "OR", built_in_controls = ["mfa", "compliantDevice"] }
  }

  expect_failures = [msgraph_resource.policy]
}

run "rejects_register_device_with_client_app_types" {
  command = plan

  variables {
    state            = "disabled"
    applications     = { include_user_actions = ["urn:user:registerdevice"] }
    client_app_types = ["browser"]
  }

  expect_failures = [msgraph_resource.policy]
}

# An authentication strength id that is unknown at plan time replaces the policy,
# because the presence signature cannot be told. The helper module feeds the
# policy an id that terraform_data reports as unknown whenever its input changes.
# These runs use their own state, so they do not disturb the runs around them.
run "strength_id_from_the_same_apply_creates_the_policy" {
  command = apply

  module {
    source = "./tests/unknown_strength"
  }

  assert {
    condition     = output.id == "66666666-6666-6666-6666-666666666666"
    error_message = "The first apply must create the policy with the mock's default id."
  }
}

run "unknown_strength_id_replaces_the_policy" {
  command = apply

  module {
    source = "./tests/unknown_strength"
  }

  variables {
    strength_seed = "00000000-0000-0000-0000-000000000003"
  }

  # An in-place update would keep the state's id; only a replacement takes this one.
  override_resource {
    target = module.policy.msgraph_resource.policy
    values = {
      id = "66666666-6666-6666-6666-000000000008"
      output = {
        display_name   = "Require a strength for pilot"
        state          = "enabledForReportingButNotEnforced"
        exclude_users  = ["11111111-1111-1111-1111-111111111111"]
        exclude_groups = []
        optional_parts = {
          locations                         = false
          platforms                         = false
          devices                           = false
          grant_controls                    = true
          authentication_strength           = true
          session_controls                  = false
          sign_in_frequency                 = false
          persistent_browser                = false
          application_enforced_restrictions = false
          cloud_app_security                = false
        }
      }
    }
  }

  assert {
    condition     = output.id == "66666666-6666-6666-6666-000000000008"
    error_message = "A strength id that is unknown at plan time must replace the policy, as the README's limits and the id output document."
  }
}

run "known_strength_id_updates_the_policy_in_place" {
  command = apply

  module {
    source = "./tests/unknown_strength"
  }

  variables {
    strength_seed = "00000000-0000-0000-0000-000000000003"
    strength_id   = "00000000-0000-0000-0000-000000000004"
  }

  override_resource {
    target = module.policy.msgraph_resource.policy
    values = {
      id = "66666666-6666-6666-6666-000000000009"
      output = {
        display_name   = "Require a strength for pilot"
        state          = "enabledForReportingButNotEnforced"
        exclude_users  = ["11111111-1111-1111-1111-111111111111"]
        exclude_groups = []
        optional_parts = {
          locations                         = false
          platforms                         = false
          devices                           = false
          grant_controls                    = true
          authentication_strength           = true
          session_controls                  = false
          sign_in_frequency                 = false
          persistent_browser                = false
          application_enforced_restrictions = false
          cloud_app_security                = false
        }
      }
    }
  }

  assert {
    condition     = output.id == "66666666-6666-6666-6666-000000000008"
    error_message = "A strength id that is known at plan time must update the policy in place and keep its id."
  }
}

# optional_parts_not_in_configuration compares the optional parts Microsoft
# Graph returned with the configured ones. The first two runs cover every one of
# the ten mapping lines from the read-back object to local.server_presence. The
# override replaces the read-back object, so a mock provider never evaluates the
# JMESPath keys in response_export_values that produce it; only a live run or a
# static check of those keys can catch a wrong one. The last run stays last: it
# leaves a mismatch in state on purpose.
run "every_optional_part_read_back_matches_the_configuration" {
  command = apply

  variables {
    locations        = { include_locations = ["All"], exclude_locations = ["AllTrusted", "77777777-7777-7777-7777-777777777777"] }
    platforms        = { include_platforms = ["all"], exclude_platforms = ["iOS"] }
    device_filter    = { mode = "exclude", rule = "device.extensionAttribute1 -ne \"SAW\"" }
    grant_controls   = { operator = "AND", built_in_controls = ["compliantDevice"], authentication_strength_id = "00000000-0000-0000-0000-000000000002", terms_of_use = ["88888888-8888-8888-8888-888888888888"] }
    session_controls = { sign_in_frequency = { frequency_interval = "everyTime" }, persistent_browser_mode = "never", application_enforced_restrictions = true, cloud_app_security_type = "monitorOnly" }
  }

  override_resource {
    target = msgraph_resource.policy
    values = {
      id = "66666666-6666-6666-6666-000000000010"
      output = {
        display_name   = "Require MFA for pilot"
        state          = "enabledForReportingButNotEnforced"
        exclude_users  = ["11111111-1111-1111-1111-111111111111"]
        exclude_groups = []
        optional_parts = {
          locations                         = true
          platforms                         = true
          devices                           = true
          grant_controls                    = true
          authentication_strength           = true
          session_controls                  = true
          sign_in_frequency                 = true
          persistent_browser                = true
          application_enforced_restrictions = true
          cloud_app_security                = true
        }
      }
    }
  }

  assert {
    condition     = length(local.presence) == 10 && length(local.server_presence) == 10
    error_message = "All ten optional parts must appear in the configured and in the read-back presence lists."
  }

  assert {
    condition     = jsonencode(local.server_presence) == jsonencode(local.presence)
    error_message = "Every optional part read back from Microsoft Graph must map to the same entry as the configured part."
  }

  assert {
    condition     = length(output.optional_parts_not_in_configuration) == 0
    error_message = "A read-back that matches the configuration must report no part as missing from it."
  }
}

run "only_grant_controls_read_back_lists_nothing" {
  command = apply

  override_resource {
    target = msgraph_resource.policy
    values = {
      id = "66666666-6666-6666-6666-000000000011"
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
      }
    }
  }

  assert {
    condition     = jsonencode(local.server_presence) == jsonencode(["grantControls"]) && jsonencode(local.presence) == jsonencode(["grantControls"])
    error_message = "Only grant controls must be present in the configuration and in the read-back."
  }

  assert {
    condition     = length(output.optional_parts_not_in_configuration) == 0
    error_message = "A policy with only grant controls must report no part as missing from the configuration."
  }
}

# Microsoft Graph may return GUIDs in another case than the module sent; the
# exclusion outputs are lower-cased. A session control is added so that the
# presence signature changes and the override's read-back applies to a new object.
run "read_back_exclusions_are_lower_cased" {
  command = apply

  variables {
    session_controls = { application_enforced_restrictions = true }
  }

  override_resource {
    target = msgraph_resource.policy
    values = {
      id = "66666666-6666-6666-6666-000000000012"
      output = {
        display_name   = "Require MFA for pilot"
        state          = "enabledForReportingButNotEnforced"
        exclude_users  = ["AAAAAAAA-0000-0000-0000-000000000001", "GuestsOrExternalUsers"]
        exclude_groups = ["BBBBBBBB-0000-0000-0000-000000000002"]
        optional_parts = {
          locations                         = false
          platforms                         = false
          devices                           = false
          grant_controls                    = true
          authentication_strength           = false
          session_controls                  = true
          sign_in_frequency                 = false
          persistent_browser                = false
          application_enforced_restrictions = true
          cloud_app_security                = false
        }
      }
    }
  }

  assert {
    condition     = output.id == "66666666-6666-6666-6666-000000000012"
    error_message = "Adding a session control must replace the policy, so the new object's read-back is used."
  }

  assert {
    condition     = jsonencode(output.excluded_user_ids) == jsonencode(["GuestsOrExternalUsers", "aaaaaaaa-0000-0000-0000-000000000001"])
    error_message = "excluded_user_ids must lower-case GUIDs and keep GuestsOrExternalUsers as given."
  }

  assert {
    condition     = jsonencode(output.excluded_group_ids) == jsonencode(["bbbbbbbb-0000-0000-0000-000000000002"])
    error_message = "excluded_group_ids must be lower-cased."
  }
}

run "adding_a_location_replaces_the_policy_and_matches_graph" {
  command = apply

  variables {
    locations = { include_locations = ["All"], exclude_locations = ["AllTrusted"] }
  }

  override_resource {
    target = msgraph_resource.policy
    values = {
      id = "66666666-6666-6666-6666-000000000005"
      output = {
        display_name   = "Require MFA for pilot"
        state          = "enabledForReportingButNotEnforced"
        exclude_users  = ["11111111-1111-1111-1111-111111111111"]
        exclude_groups = []
        optional_parts = {
          locations                         = true
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
      }
    }
  }

  assert {
    condition     = output.id == "66666666-6666-6666-6666-000000000005"
    error_message = "Adding the location condition must replace the policy."
  }

  assert {
    condition     = jsonencode(local.server_presence) == jsonencode(["conditions.locations", "grantControls"])
    error_message = "The read-back optional parts must include the location condition."
  }
}

run "reports_an_optional_part_that_graph_has_and_the_configuration_lacks" {
  command = apply

  # The configuration drops the location condition, but the object read back
  # still has one, as after an out-of-band addition or a retried replacement.
  override_resource {
    target = msgraph_resource.policy
    values = {
      id = "66666666-6666-6666-6666-000000000006"
      output = {
        display_name   = "Require MFA for pilot"
        state          = "enabledForReportingButNotEnforced"
        exclude_users  = ["11111111-1111-1111-1111-111111111111"]
        exclude_groups = []
        optional_parts = {
          locations                         = true
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
      }
    }
  }

  assert {
    condition     = jsonencode(output.optional_parts_not_in_configuration) == jsonencode(["conditions.locations"])
    error_message = "A part that Microsoft Graph returned and the configuration lacks must be reported, because an in-place apply cannot remove it."
  }
}
