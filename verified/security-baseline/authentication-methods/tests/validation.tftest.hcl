# Negative cases: each run expects the named object to fail. The fixtures follow
# baseline.tftest.hcl; IDs are deliberately synthetic.

mock_provider "msgraph" {
  mock_data "msgraph_resource" {
    defaults = {
      output = {
        next_link       = null
        skus            = []
        is_enabled      = true
        migration_state = "migrationComplete"
        registration_enforcement = {
          authenticationMethodsRegistrationCampaign = {
            state                                  = "default"
            snoozeDurationInDays                   = 1
            enforceRegistrationAfterAllowedSnoozes = false
            includeTargets                         = []
            excludeTargets                         = []
          }
        }
        configurations = [
          { "@odata.type" = "#microsoft.graph.microsoftAuthenticatorAuthenticationMethodConfiguration", id = "MicrosoftAuthenticator", state = "disabled", includeTargets = [], excludeTargets = [], featureSettings = {} },
          { "@odata.type" = "#microsoft.graph.fido2AuthenticationMethodConfiguration", id = "Fido2", state = "disabled", isSelfServiceRegistrationAllowed = false, includeTargets = [], excludeTargets = [] },
          { "@odata.type" = "#microsoft.graph.smsAuthenticationMethodConfiguration", id = "Sms", state = "enabled", includeTargets = [], excludeTargets = [] },
          { "@odata.type" = "#microsoft.graph.voiceAuthenticationMethodConfiguration", id = "Voice", state = "enabled", isOfficePhoneAllowed = true, includeTargets = [], excludeTargets = [] },
        ]
      }
    }
  }
}

variables {
  tier                  = "free"
  break_glass_user_ids  = ["00000000-0000-4000-8000-000000000010"]
  break_glass_group_ids = ["00000000-0000-4000-8000-0000000000a0"]
}

# At least one break-glass user is mandatory.
run "no_break_glass_user" {
  command = plan

  variables {
    break_glass_user_ids = []
  }

  expect_failures = [var.break_glass_user_ids]
}

run "break_glass_user_not_a_lowercase_guid" {
  command = plan

  variables {
    break_glass_user_ids = ["BREAKGLASS"]
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

# Excluded users cannot register or use passkeys, so a break-glass group must not be excluded.
run "break_glass_group_in_fido2_exclusions" {
  command = plan

  variables {
    fido2_exclude_group_ids = ["00000000-0000-4000-8000-0000000000a0"]
  }

  expect_failures = [terraform_data.guard]
}

# FIDO2 must target all_users or a break-glass group.
run "fido2_scoped_to_another_group" {
  command = plan

  variables {
    fido2_include_group_id = "00000000-0000-4000-8000-0000000000b0"
  }

  expect_failures = [terraform_data.guard]
}

run "fido2_group_not_a_guid" {
  command = plan

  variables {
    fido2_include_group_id = "everyone"
  }

  expect_failures = [var.fido2_include_group_id]
}

run "fido2_exclusion_not_a_guid" {
  command = plan

  variables {
    fido2_exclude_group_ids = ["everyone"]
  }

  expect_failures = [var.fido2_exclude_group_ids]
}

run "authenticator_group_not_a_guid" {
  command = plan

  variables {
    authenticator_include_group_id = "everyone"
  }

  expect_failures = [var.authenticator_include_group_id]
}

run "campaign_group_not_a_guid" {
  command = plan

  variables {
    campaign_include_group_id = "everyone"
  }

  expect_failures = [var.campaign_include_group_id]
}

run "invalid_tier" {
  command = plan

  variables {
    tier = "premium"
  }

  expect_failures = [var.tier]
}

# The licence failures (p1 without a premium SKU, p2 with P1 only, a P2 SKU in the Suspended or
# Warning state) are raised by the shared licence guard's output precondition. Terraform tests
# cannot expect a failure of a child module output, so they are covered in
# ../licence-guard/tests/licence_guard.tftest.hcl; baseline.tftest.hcl proves that this module
# passes the guard for p1 and p2 and wires its tier input to the guard.

run "snooze_days_below_range" {
  command = plan

  variables {
    campaign_snooze_days = -1
  }

  expect_failures = [var.campaign_snooze_days]
}

run "snooze_days_above_range" {
  command = plan

  variables {
    campaign_snooze_days = 15
  }

  expect_failures = [var.campaign_snooze_days]
}

run "snooze_days_not_whole" {
  command = plan

  variables {
    campaign_snooze_days = 1.5
  }

  expect_failures = [var.campaign_snooze_days]
}

# An Authenticator campaign needs Any or Push.
run "authenticator_device_based_push" {
  command = plan

  variables {
    authenticator_mode = "deviceBasedPush"
  }

  expect_failures = [var.authenticator_mode]
}

run "authenticator_show_app_name_invalid" {
  command = plan

  variables {
    authenticator_show_app_name = "on"
  }

  expect_failures = [var.authenticator_show_app_name]
}

run "authenticator_show_location_invalid" {
  command = plan

  variables {
    authenticator_show_location = "on"
  }

  expect_failures = [var.authenticator_show_location]
}

run "campaign_state_invalid" {
  command = plan

  variables {
    campaign_state = "report-only"
  }

  expect_failures = [var.campaign_state]
}

run "campaign_method_invalid" {
  command = plan

  variables {
    campaign_method = "sms"
  }

  expect_failures = [var.campaign_method]
}

# A passkey campaign needs self-service registration.
run "fido2_campaign_without_self_service_registration" {
  command = plan

  variables {
    campaign_method                 = "fido2"
    fido2_self_service_registration = false
  }

  expect_failures = [terraform_data.guard]
}

run "phone_methods_invalid" {
  command = plan

  variables {
    phone_methods = "disable"
  }

  expect_failures = [var.phone_methods]
}

run "phone_group_not_a_guid" {
  command = plan

  variables {
    phone_methods_group_id = "phones"
  }

  expect_failures = [var.phone_methods_group_id]
}

run "restrict_without_group" {
  command = plan

  variables {
    tier          = "p1"
    phone_methods = "restrict"
  }

  override_data {
    target = module.licence_guard.data.msgraph_resource.subscribed_skus
    values = {
      output = {
        next_link = null
        skus = [{
          skuId            = "00000000-0000-4000-8000-000000000001"
          skuPartNumber    = "AAD_PREMIUM"
          capabilityStatus = "Enabled"
          prepaidUnits     = { enabled = 25, lockedOut = 0, suspended = 0, warning = 0 }
          servicePlans     = [{ servicePlanId = "41781fb2-bc02-4b7c-bd55-b576c07bb09d", servicePlanName = "AAD_PREMIUM", provisioningStatus = "Success", appliesTo = "User" }]
        }]
      }
    }
  }

  expect_failures = [terraform_data.guard]
}

# restrict is refused for the free tier.
run "restrict_with_free_tier" {
  command = plan

  variables {
    phone_methods          = "restrict"
    phone_methods_group_id = "00000000-0000-4000-8000-0000000000e0"
  }

  expect_failures = [terraform_data.guard]
}

# While security defaults are on, Authenticator must stay enabled for all users.
run "security_defaults_on_with_scoped_authenticator" {
  command = plan

  variables {
    authenticator_include_group_id = "00000000-0000-4000-8000-0000000000c0"
  }

  override_data {
    target = data.msgraph_resource.security_defaults
    values = { output = { is_enabled = true } }
  }

  expect_failures = [terraform_data.guard]
}

# Warnings, not failures, in a real run: the free tier assumes security defaults stay on, and
# phone restrictions only bind everywhere after the policy migration completes.
run "security_defaults_off_for_free_warns" {
  command = plan

  override_data {
    target = data.msgraph_resource.security_defaults
    values = { output = { is_enabled = false } }
  }

  expect_failures = [check.security_defaults_stay_on_for_free]
}

run "phone_methods_before_migration_complete_warn" {
  command = plan

  variables {
    tier                   = "p1"
    phone_methods          = "restrict"
    phone_methods_group_id = "00000000-0000-4000-8000-0000000000e0"
  }

  override_data {
    target = module.licence_guard.data.msgraph_resource.subscribed_skus
    values = {
      output = {
        next_link = null
        skus = [{
          skuId            = "00000000-0000-4000-8000-000000000001"
          skuPartNumber    = "AAD_PREMIUM"
          capabilityStatus = "Enabled"
          prepaidUnits     = { enabled = 25, lockedOut = 0, suspended = 0, warning = 0 }
          servicePlans     = [{ servicePlanId = "41781fb2-bc02-4b7c-bd55-b576c07bb09d", servicePlanName = "AAD_PREMIUM", provisioningStatus = "Success", appliesTo = "User" }]
        }]
      }
    }
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        migration_state          = "preMigration"
        registration_enforcement = { authenticationMethodsRegistrationCampaign = { state = "default", snoozeDurationInDays = 1, enforceRegistrationAfterAllowedSnoozes = false, includeTargets = [], excludeTargets = [] } }
        configurations = [
          { "@odata.type" = "#microsoft.graph.microsoftAuthenticatorAuthenticationMethodConfiguration", id = "MicrosoftAuthenticator", state = "disabled", includeTargets = [], excludeTargets = [], featureSettings = {} },
          { "@odata.type" = "#microsoft.graph.fido2AuthenticationMethodConfiguration", id = "Fido2", state = "disabled", isSelfServiceRegistrationAllowed = false, includeTargets = [], excludeTargets = [] },
          { "@odata.type" = "#microsoft.graph.smsAuthenticationMethodConfiguration", id = "Sms", state = "enabled", includeTargets = [], excludeTargets = [] },
          { "@odata.type" = "#microsoft.graph.voiceAuthenticationMethodConfiguration", id = "Voice", state = "enabled", isOfficePhoneAllowed = true, includeTargets = [], excludeTargets = [] },
        ]
      }
    }
  }

  expect_failures = [check.policy_migration_complete_for_phone_methods]
}

# A response that omits a managed method configuration fails the read.
run "policy_response_missing_a_method" {
  command = plan

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        migration_state          = "migrationComplete"
        registration_enforcement = { authenticationMethodsRegistrationCampaign = { state = "default", snoozeDurationInDays = 1, enforceRegistrationAfterAllowedSnoozes = false, includeTargets = [], excludeTargets = [] } }
        configurations           = [{ "@odata.type" = "#microsoft.graph.fido2AuthenticationMethodConfiguration", id = "Fido2", state = "disabled", isSelfServiceRegistrationAllowed = false, includeTargets = [], excludeTargets = [] }]
      }
    }
  }

  expect_failures = [data.msgraph_resource.policy]
}

# A response without a registrationEnforcement object would be restored as null.
run "policy_response_without_registration_enforcement" {
  command = plan

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        migration_state          = "migrationComplete"
        registration_enforcement = null
        configurations = [
          { "@odata.type" = "#microsoft.graph.microsoftAuthenticatorAuthenticationMethodConfiguration", id = "MicrosoftAuthenticator", state = "disabled", includeTargets = [], excludeTargets = [], featureSettings = {} },
          { "@odata.type" = "#microsoft.graph.fido2AuthenticationMethodConfiguration", id = "Fido2", state = "disabled", isSelfServiceRegistrationAllowed = false, includeTargets = [], excludeTargets = [] },
          { "@odata.type" = "#microsoft.graph.smsAuthenticationMethodConfiguration", id = "Sms", state = "enabled", includeTargets = [], excludeTargets = [] },
          { "@odata.type" = "#microsoft.graph.voiceAuthenticationMethodConfiguration", id = "Voice", state = "enabled", isOfficePhoneAllowed = true, includeTargets = [], excludeTargets = [] },
        ]
      }
    }
  }

  expect_failures = [data.msgraph_resource.policy]
}

# The campaign must target a method that is enabled for the campaign's users.
run "campaign_group_without_method" {
  command = plan

  variables {
    campaign_include_group_id      = "00000000-0000-4000-8000-0000000000b0"
    authenticator_include_group_id = "00000000-0000-4000-8000-0000000000c0"
  }

  override_data {
    target = data.msgraph_resource.security_defaults
    values = { output = { is_enabled = false } }
  }

  expect_failures = [terraform_data.guard, check.security_defaults_stay_on_for_free]
}

# A campaign for all users while Authenticator is scoped to a group is refused.
run "campaign_all_users_with_scoped_authenticator" {
  command = plan

  variables {
    authenticator_include_group_id = "00000000-0000-4000-8000-0000000000c0"
  }

  override_data {
    target = data.msgraph_resource.security_defaults
    values = { output = { is_enabled = false } }
  }

  expect_failures = [terraform_data.guard, check.security_defaults_stay_on_for_free]
}

# The same for a passkey campaign with passkeys scoped to a break-glass group.
run "campaign_all_users_with_scoped_fido2" {
  command = plan

  variables {
    campaign_method        = "fido2"
    fido2_include_group_id = "00000000-0000-4000-8000-0000000000a0"
  }

  expect_failures = [terraform_data.guard]
}

# A method configuration without includeTargets and excludeTargets cannot be snapshotted.
run "snapshot_needs_targets" {
  command = plan

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        migration_state          = "migrationComplete"
        registration_enforcement = { authenticationMethodsRegistrationCampaign = { state = "default", snoozeDurationInDays = 1, enforceRegistrationAfterAllowedSnoozes = false, includeTargets = [], excludeTargets = [] } }
        configurations = [
          { "@odata.type" = "#microsoft.graph.microsoftAuthenticatorAuthenticationMethodConfiguration", id = "MicrosoftAuthenticator", state = "disabled", featureSettings = {} },
          { "@odata.type" = "#microsoft.graph.fido2AuthenticationMethodConfiguration", id = "Fido2", state = "disabled", isSelfServiceRegistrationAllowed = false, includeTargets = [], excludeTargets = [] },
          { "@odata.type" = "#microsoft.graph.smsAuthenticationMethodConfiguration", id = "Sms", state = "enabled", includeTargets = [], excludeTargets = [] },
          { "@odata.type" = "#microsoft.graph.voiceAuthenticationMethodConfiguration", id = "Voice", state = "enabled", isOfficePhoneAllowed = true, includeTargets = [], excludeTargets = [] },
        ]
      }
    }
  }

  expect_failures = [data.msgraph_resource.policy]
}

run "restore_unknown_object" {
  command = plan

  variables {
    restore_previous_state = ["tap"]
  }

  expect_failures = [var.restore_previous_state]
}

# Existing exclusions or a narrower scope are overwritten: the check warns from the snapshot (a fresh state, so the first read is the snapshot).
run "existing_targets_warn" {
  command = plan

  variables {
    tier = "free"
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        migration_state = "migrationComplete"
        registration_enforcement = {
          authenticationMethodsRegistrationCampaign = {
            state                                  = "enabled"
            snoozeDurationInDays                   = 1
            enforceRegistrationAfterAllowedSnoozes = false
            includeTargets                         = [{ id = "00000000-0000-4000-8000-0000000000f0", targetType = "group", targetedAuthenticationMethod = "microsoftAuthenticator" }]
            excludeTargets                         = []
          }
        }
        configurations = [
          { "@odata.type" = "#microsoft.graph.microsoftAuthenticatorAuthenticationMethodConfiguration", id = "MicrosoftAuthenticator", state = "enabled", includeTargets = [], excludeTargets = [{ id = "00000000-0000-4000-8000-0000000000f1", targetType = "group" }], featureSettings = {} },
          { "@odata.type" = "#microsoft.graph.fido2AuthenticationMethodConfiguration", id = "Fido2", state = "enabled", isSelfServiceRegistrationAllowed = true, includeTargets = [], excludeTargets = [] },
          { "@odata.type" = "#microsoft.graph.smsAuthenticationMethodConfiguration", id = "Sms", state = "enabled", includeTargets = [], excludeTargets = [] },
          { "@odata.type" = "#microsoft.graph.voiceAuthenticationMethodConfiguration", id = "Voice", state = "enabled", isOfficePhoneAllowed = true, includeTargets = [], excludeTargets = [] },
        ]
      }
    }
  }

  expect_failures = [check.existing_targets_are_overwritten]
}
