# Fixtures follow the Microsoft Graph v1.0 responses for the selected properties:
# - Get authenticationMethodsPolicy, whose authenticationMethodConfigurations are expanded
#   (the method ids are returned with a leading capital, for example Fido2);
# - Get identitySecurityDefaultsEnforcementPolicy;
# - List subscribedSkus, as in the licence guard (P1 lists AAD_PREMIUM, P2 lists AAD_PREMIUM_P2).
#
# User, group and SKU IDs are deliberately synthetic; no tenant identities are recorded.

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
            enforceRegistrationAfterAllowedSnoozes = true
            includeTargets                         = [{ id = "all_users", targetType = "group", targetedAuthenticationMethod = "microsoftAuthenticator" }]
            excludeTargets                         = []
          }
        }
        configurations = [
          {
            "@odata.type"         = "#microsoft.graph.microsoftAuthenticatorAuthenticationMethodConfiguration"
            id                    = "MicrosoftAuthenticator"
            state                 = "disabled"
            isSoftwareOathEnabled = false
            includeTargets        = [{ targetType = "group", id = "all_users", isRegistrationRequired = false, authenticationMode = "any" }]
            excludeTargets        = []
            featureSettings = {
              displayAppInformationRequiredState      = { state = "default", includeTarget = { targetType = "group", id = "all_users" }, excludeTarget = { targetType = "group", id = "00000000-0000-0000-0000-000000000000" } }
              displayLocationInformationRequiredState = { state = "default", includeTarget = { targetType = "group", id = "all_users" }, excludeTarget = { targetType = "group", id = "00000000-0000-0000-0000-000000000000" } }
              numberMatchingRequiredState             = { state = "enabled", includeTarget = { targetType = "group", id = "all_users" }, excludeTarget = { targetType = "group", id = "00000000-0000-0000-0000-000000000000" } }
              companionAppAllowedState                = { state = "default", includeTarget = { targetType = "group", id = "all_users" }, excludeTarget = { targetType = "group", id = "00000000-0000-0000-0000-000000000000" } }
            }
          },
          {
            "@odata.type"                    = "#microsoft.graph.fido2AuthenticationMethodConfiguration"
            id                               = "Fido2"
            state                            = "disabled"
            isSelfServiceRegistrationAllowed = false
            isAttestationEnforced            = false
            includeTargets                   = []
            excludeTargets                   = []
            keyRestrictions                  = { isEnforced = false, enforcementType = "block", aaGUIDs = [] }
          },
          {
            "@odata.type"  = "#microsoft.graph.smsAuthenticationMethodConfiguration"
            id             = "Sms"
            state          = "enabled"
            includeTargets = [{ targetType = "group", id = "all_users", isRegistrationRequired = false, isUsableForSignIn = true }]
            excludeTargets = []
          },
          {
            "@odata.type"        = "#microsoft.graph.voiceAuthenticationMethodConfiguration"
            id                   = "Voice"
            state                = "enabled"
            isOfficePhoneAllowed = true
            includeTargets       = [{ targetType = "group", id = "all_users", isRegistrationRequired = false }]
            excludeTargets       = []
          },
          {
            "@odata.type" = "#microsoft.graph.temporaryAccessPassAuthenticationMethodConfiguration"
            id            = "TemporaryAccessPass"
            state         = "disabled"
          },
        ]
      }
    }
  }
}

variables {
  break_glass_user_ids  = ["00000000-0000-4000-8000-000000000020", "00000000-0000-4000-8000-000000000010"]
  break_glass_group_ids = ["00000000-0000-4000-8000-0000000000a0"]
}

# free with defaults: root, Authenticator and passkeys are updated; SMS and voice are not,
# every method body names its @odata.type, and no licence is read.
run "free_defaults" {
  command = plan

  variables {
    tier = "free"
  }

  assert {
    condition     = jsonencode(sort(keys(msgraph_update_resource.object))) == jsonencode(["fido2", "microsoftAuthenticator", "policy"])
    error_message = "free defaults must update the root, microsoftAuthenticator and fido2 only; there is no sms or voice resource."
  }

  assert {
    condition = alltrue([for key, resource in msgraph_update_resource.object : resource.update_method == "PATCH" && resource.api_version == "v1.0"]) && (
      msgraph_update_resource.object["policy"].url == "policies/authenticationMethodsPolicy" &&
      msgraph_update_resource.object["microsoftAuthenticator"].url == "policies/authenticationMethodsPolicy/authenticationMethodConfigurations/microsoftAuthenticator" &&
      msgraph_update_resource.object["fido2"].url == "policies/authenticationMethodsPolicy/authenticationMethodConfigurations/fido2"
    )
    error_message = "Each object must be PATCHed at its documented v1.0 item URL."
  }

  assert {
    condition = (
      msgraph_update_resource.object["microsoftAuthenticator"].body["@odata.type"] == "#microsoft.graph.microsoftAuthenticatorAuthenticationMethodConfiguration" &&
      msgraph_update_resource.object["fido2"].body["@odata.type"] == "#microsoft.graph.fido2AuthenticationMethodConfiguration"
    )
    error_message = "Method PATCH bodies must include @odata.type."
  }

  assert {
    condition = jsonencode(msgraph_update_resource.object["microsoftAuthenticator"].body) == jsonencode({
      "@odata.type" = "#microsoft.graph.microsoftAuthenticatorAuthenticationMethodConfiguration"
      state         = "enabled"
      includeTargets = [{
        targetType             = "group"
        id                     = "all_users"
        isRegistrationRequired = false
        authenticationMode     = "any"
      }]
      excludeTargets = []
      featureSettings = {
        displayAppInformationRequiredState      = { state = "enabled", includeTarget = { targetType = "group", id = "all_users" } }
        displayLocationInformationRequiredState = { state = "enabled", includeTarget = { targetType = "group", id = "all_users" } }
      }
    })
    error_message = "Microsoft Authenticator must be enabled for all users, mode any, showing app name and location."
  }

  assert {
    condition = jsonencode(msgraph_update_resource.object["fido2"].body) == jsonencode({
      "@odata.type"                    = "#microsoft.graph.fido2AuthenticationMethodConfiguration"
      state                            = "enabled"
      isSelfServiceRegistrationAllowed = true
      includeTargets = [{
        targetType             = "group"
        id                     = "all_users"
        isRegistrationRequired = false
        allowedPasskeyProfiles = []
      }]
      excludeTargets = []
    })
    error_message = "Passkeys must be enabled for all users with self-service registration and no deprecated properties."
  }

  assert {
    condition = jsonencode(msgraph_update_resource.object["policy"].body) == jsonencode({
      registrationEnforcement = {
        authenticationMethodsRegistrationCampaign = {
          state                                  = "enabled"
          snoozeDurationInDays                   = 1
          enforceRegistrationAfterAllowedSnoozes = false
          includeTargets                         = [{ id = "all_users", targetType = "group", targetedAuthenticationMethod = "microsoftAuthenticator" }]
          excludeTargets = [
            { id = "00000000-0000-4000-8000-000000000010", targetType = "user" },
            { id = "00000000-0000-4000-8000-000000000020", targetType = "user" },
            { id = "00000000-0000-4000-8000-0000000000a0", targetType = "group" },
          ]
        }
      }
    })
    error_message = "The root PATCH must carry only the registration campaign, excluding every break-glass user and group."
  }

  assert {
    condition     = length(module.licence_guard.licensed_skus) == 0
    error_message = "The free tier must not read subscribedSkus."
  }

  assert {
    condition     = output.tier == "free" && jsonencode(sort(keys(output.managed_urls))) == jsonencode(["fido2", "microsoftAuthenticator", "policy"])
    error_message = "The outputs must pass the tier through and list the managed URLs."
  }
}

# The campaign method, group, snooze and enforcement inputs map to the campaign body, and
# the break-glass exclusions stay in place whatever the campaign state.
run "campaign_inputs_and_exclusions" {
  command = plan

  variables {
    tier                           = "free"
    campaign_method                = "fido2"
    campaign_state                 = "disabled"
    campaign_include_group_id      = "00000000-0000-4000-8000-0000000000b0"
    campaign_snooze_days           = 14
    campaign_require_after_snoozes = true
    break_glass_group_ids          = []
  }

  # The tenant read shows an all-users campaign: narrowing it to a group is an overwrite.
  expect_failures = [check.existing_targets_are_overwritten]

  assert {
    condition = jsonencode(msgraph_update_resource.object["policy"].body) == jsonencode({
      registrationEnforcement = {
        authenticationMethodsRegistrationCampaign = {
          state                                  = "disabled"
          snoozeDurationInDays                   = 14
          enforceRegistrationAfterAllowedSnoozes = true
          includeTargets                         = [{ id = "00000000-0000-4000-8000-0000000000b0", targetType = "group", targetedAuthenticationMethod = "fido2" }]
          excludeTargets = [
            { id = "00000000-0000-4000-8000-000000000010", targetType = "user" },
            { id = "00000000-0000-4000-8000-000000000020", targetType = "user" },
          ]
        }
      }
    })
    error_message = "The campaign body must follow the inputs and keep the break-glass user exclusions."
  }
}

# The other Authenticator and passkey inputs map to the method bodies.
run "method_inputs" {
  command = plan

  variables {
    tier                            = "free"
    authenticator_include_group_id  = "00000000-0000-4000-8000-0000000000c0"
    campaign_include_group_id       = "00000000-0000-4000-8000-0000000000c0"
    authenticator_mode              = "push"
    authenticator_show_app_name     = "default"
    authenticator_show_location     = "disabled"
    fido2_include_group_id          = "00000000-0000-4000-8000-0000000000a0"
    fido2_exclude_group_ids         = ["00000000-0000-4000-8000-0000000000d0"]
    fido2_self_service_registration = false
  }

  # Security defaults off only raises the free-tier warning.
  override_data {
    target = data.msgraph_resource.security_defaults
    values = { output = { is_enabled = false } }
  }

  expect_failures = [check.security_defaults_stay_on_for_free, check.existing_targets_are_overwritten]

  assert {
    condition = (
      msgraph_update_resource.object["microsoftAuthenticator"].body.includeTargets[0].id == "00000000-0000-4000-8000-0000000000c0" &&
      msgraph_update_resource.object["microsoftAuthenticator"].body.includeTargets[0].authenticationMode == "push" &&
      msgraph_update_resource.object["microsoftAuthenticator"].body.featureSettings.displayAppInformationRequiredState.state == "default" &&
      msgraph_update_resource.object["microsoftAuthenticator"].body.featureSettings.displayLocationInformationRequiredState.state == "disabled"
    )
    error_message = "The Authenticator inputs must reach the body."
  }

  assert {
    condition = (
      msgraph_update_resource.object["fido2"].body.includeTargets[0].id == "00000000-0000-4000-8000-0000000000a0" &&
      msgraph_update_resource.object["fido2"].body.isSelfServiceRegistrationAllowed == false &&
      jsonencode(msgraph_update_resource.object["fido2"].body.excludeTargets) == jsonencode([{ id = "00000000-0000-4000-8000-0000000000d0", targetType = "group" }])
    )
    error_message = "The passkey inputs must reach the body."
  }
}

# restrict keeps SMS and voice for one group; the properties follow the Update docs.
run "phone_restrict_p1" {
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

  # The fixture shows SMS and voice enabled for all users: restricting them is an overwrite.
  expect_failures = [check.existing_targets_are_overwritten]

  assert {
    condition     = jsonencode(sort(keys(msgraph_update_resource.object))) == jsonencode(["fido2", "microsoftAuthenticator", "policy", "sms", "voice"])
    error_message = "restrict must add the sms and voice objects."
  }

  assert {
    condition     = msgraph_update_resource.object["sms"].url == "policies/authenticationMethodsPolicy/authenticationMethodConfigurations/sms" && msgraph_update_resource.object["voice"].url == "policies/authenticationMethodsPolicy/authenticationMethodConfigurations/voice"
    error_message = "SMS and voice must be PATCHed at their item URLs."
  }

  assert {
    condition = jsonencode(msgraph_update_resource.object["sms"].body) == jsonencode({
      "@odata.type" = "#microsoft.graph.smsAuthenticationMethodConfiguration"
      state         = "enabled"
      includeTargets = [{
        targetType             = "group"
        id                     = "00000000-0000-4000-8000-0000000000e0"
        isRegistrationRequired = false
        isUsableForSignIn      = false
      }]
      excludeTargets = []
    })
    error_message = "restrict must keep SMS for the group only, not usable for sign-in."
  }

  assert {
    condition = jsonencode(msgraph_update_resource.object["voice"].body) == jsonencode({
      "@odata.type"        = "#microsoft.graph.voiceAuthenticationMethodConfiguration"
      state                = "enabled"
      isOfficePhoneAllowed = false
      includeTargets = [{
        targetType             = "group"
        id                     = "00000000-0000-4000-8000-0000000000e0"
        isRegistrationRequired = false
      }]
      excludeTargets = []
    })
    error_message = "restrict must keep voice for the group only, without office phone."
  }

  assert {
    condition     = length(module.licence_guard.licensed_skus) == 1 && output.tier == "p1"
    error_message = "p1 must read subscribedSkus once and pass with an Enabled P1 SKU."
  }
}

# P1 and P2 together pass p2.
run "p2_licensed" {
  command = plan

  variables {
    tier = "p2"
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
            servicePlans     = [{ servicePlanId = "41781fb2-bc02-4b7c-bd55-b576c07bb09d", servicePlanName = "AAD_PREMIUM", provisioningStatus = "Success", appliesTo = "User" }]
          },
          {
            skuId            = "00000000-0000-4000-8000-000000000002"
            skuPartNumber    = "AAD_PREMIUM_P2"
            capabilityStatus = "Enabled"
            prepaidUnits     = { enabled = 5, lockedOut = 0, suspended = 0, warning = 0 }
            servicePlans     = [{ servicePlanId = "eec0eb4f-6444-4f95-aba0-50c24d67f998", servicePlanName = "AAD_PREMIUM_P2", provisioningStatus = "Success", appliesTo = "User" }]
          },
        ]
      }
    }
  }

  assert {
    condition     = output.tier == "p2"
    error_message = "P1 plus P2 licenses p2."
  }
}

# The first apply captures the writable properties of the prior state, without read-only or
# unmanaged properties.
run "first_apply_captures_snapshot" {
  command = apply

  variables {
    tier = "free"
  }

  assert {
    condition     = jsonencode(sort(keys(output.previous_state))) == jsonencode(["fido2", "microsoftAuthenticator", "policy", "sms", "voice"])
    error_message = "The snapshot must cover all five objects, whatever phone_methods says."
  }

  assert {
    condition     = jsonencode(output.previous_state["policy"]) == jsonencode({ registrationEnforcement = { authenticationMethodsRegistrationCampaign = { state = "default", snoozeDurationInDays = 1, enforceRegistrationAfterAllowedSnoozes = true, includeTargets = [{ id = "all_users", targetType = "group", targetedAuthenticationMethod = "microsoftAuthenticator" }], excludeTargets = [] } } })
    error_message = "The root snapshot must hold registrationEnforcement only."
  }

  assert {
    condition = jsonencode(output.previous_state["fido2"]) == jsonencode({
      "@odata.type"                    = "#microsoft.graph.fido2AuthenticationMethodConfiguration"
      state                            = "disabled"
      isSelfServiceRegistrationAllowed = false
      includeTargets                   = []
      excludeTargets                   = []
    })
    error_message = "The passkey snapshot must hold the writable properties only: no id, no deprecated isAttestationEnforced or keyRestrictions."
  }

  assert {
    condition = jsonencode(output.previous_state["microsoftAuthenticator"]) == jsonencode({
      "@odata.type"  = "#microsoft.graph.microsoftAuthenticatorAuthenticationMethodConfiguration"
      state          = "disabled"
      includeTargets = [{ targetType = "group", id = "all_users", isRegistrationRequired = false, authenticationMode = "any" }]
      excludeTargets = []
      featureSettings = {
        displayAppInformationRequiredState      = { state = "default", includeTarget = { targetType = "group", id = "all_users" }, excludeTarget = { targetType = "group", id = "00000000-0000-0000-0000-000000000000" } }
        displayLocationInformationRequiredState = { state = "default", includeTarget = { targetType = "group", id = "all_users" }, excludeTarget = { targetType = "group", id = "00000000-0000-0000-0000-000000000000" } }
      }
    })
    error_message = "The Authenticator snapshot must hold only the managed properties and feature settings."
  }
}

# After the tenant changes (the baseline is applied), a second plan reads the new values but
# the snapshot keeps the original ones.
run "second_plan_keeps_snapshot" {
  command = plan

  variables {
    tier = "free"
  }

  override_data {
    target = data.msgraph_resource.policy
    values = {
      output = {
        migration_state          = "migrationComplete"
        registration_enforcement = { authenticationMethodsRegistrationCampaign = { state = "enabled", snoozeDurationInDays = 1, enforceRegistrationAfterAllowedSnoozes = false, includeTargets = [], excludeTargets = [] } }
        configurations = [
          { "@odata.type" = "#microsoft.graph.microsoftAuthenticatorAuthenticationMethodConfiguration", id = "MicrosoftAuthenticator", state = "enabled", includeTargets = [], excludeTargets = [], featureSettings = {} },
          { "@odata.type" = "#microsoft.graph.fido2AuthenticationMethodConfiguration", id = "Fido2", state = "enabled", isSelfServiceRegistrationAllowed = true, includeTargets = [], excludeTargets = [] },
          { "@odata.type" = "#microsoft.graph.smsAuthenticationMethodConfiguration", id = "Sms", state = "disabled", includeTargets = [], excludeTargets = [] },
          { "@odata.type" = "#microsoft.graph.voiceAuthenticationMethodConfiguration", id = "Voice", state = "disabled", isOfficePhoneAllowed = false, includeTargets = [], excludeTargets = [] },
        ]
      }
    }
  }

  # The tenant changed since the snapshot, so the unmanaged SMS and voice no longer match it.
  expect_failures = [check.unmanaged_phone_methods_match_snapshot]

  assert {
    condition     = output.previous_state["fido2"].state == "disabled" && output.previous_state["policy"].registrationEnforcement.authenticationMethodsRegistrationCampaign.state == "default"
    error_message = "The snapshot must keep the first-apply values after the tenant changed."
  }

  assert {
    condition = terraform_data.snapshot["fido2"].input == jsonencode({
      "@odata.type"                    = "#microsoft.graph.fido2AuthenticationMethodConfiguration"
      state                            = "disabled"
      isSelfServiceRegistrationAllowed = false
      includeTargets                   = []
      excludeTargets                   = []
    })
    error_message = "The stored snapshot input must still be the first-apply value, although the tenant read now returns an enabled passkey configuration."
  }

  assert {
    condition     = terraform_data.snapshot["sms"].input == jsonencode(jsondecode(terraform_data.snapshot["sms"].input)) && jsondecode(terraform_data.snapshot["sms"].input).state == "enabled"
    error_message = "The SMS snapshot must keep the first-apply state."
  }

  assert {
    condition = terraform_data.snapshot["sms"].input == jsonencode({
      "@odata.type"  = "#microsoft.graph.smsAuthenticationMethodConfiguration"
      state          = "enabled"
      includeTargets = [{ targetType = "group", id = "all_users", isRegistrationRequired = false, isUsableForSignIn = true }]
      excludeTargets = []
    })
    error_message = "The stored SMS snapshot must be the literal first-apply configuration."
  }
}

# restore_previous_state sends the snapshot back, object by object, with the constant
# @odata.type of each method.
run "restore_sends_snapshot" {
  command = plan

  variables {
    tier                   = "free"
    restore_previous_state = ["policy", "microsoftAuthenticator", "fido2", "sms", "voice"]
  }

  assert {
    condition = alltrue([
      for key, resource in msgraph_update_resource.object :
      jsonencode(resource.body) == jsonencode(output.previous_state[key])
    ]) && jsonencode(sort(keys(msgraph_update_resource.object))) == jsonencode(["fido2", "microsoftAuthenticator", "policy", "sms", "voice"])
    error_message = "Every PATCH body, SMS and voice included, must equal the snapshot when everything is restored."
  }

  assert {
    condition = (
      msgraph_update_resource.object["sms"].body["@odata.type"] == "#microsoft.graph.smsAuthenticationMethodConfiguration" &&
      msgraph_update_resource.object["voice"].body["@odata.type"] == "#microsoft.graph.voiceAuthenticationMethodConfiguration" &&
      msgraph_update_resource.object["fido2"].body["@odata.type"] == "#microsoft.graph.fido2AuthenticationMethodConfiguration"
    )
    error_message = "A restored method body must carry the constant @odata.type."
  }
}

# A restore of one object leaves the others on the baseline.
run "restore_one_object" {
  command = plan

  variables {
    tier                   = "free"
    restore_previous_state = ["fido2"]
  }

  assert {
    condition     = jsonencode(msgraph_update_resource.object["fido2"].body) == jsonencode(output.previous_state["fido2"]) && msgraph_update_resource.object["microsoftAuthenticator"].body.state == "enabled"
    error_message = "Only the listed object is restored."
  }
}

# restrict, then back to unmanaged: SMS and voice are restored first, and their snapshots
# survive the input change.
run "restrict_apply" {
  command = apply

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

  # The fixture shows SMS and voice enabled for all users: restricting them is an overwrite.
  expect_failures = [check.existing_targets_are_overwritten]

  assert {
    condition     = msgraph_update_resource.object["sms"].body.state == "enabled" && msgraph_update_resource.object["sms"].body.includeTargets[0].isUsableForSignIn == false
    error_message = "restrict must PATCH SMS."
  }
}

run "unmanaged_with_phone_restore" {
  command = plan

  variables {
    tier                   = "p1"
    phone_methods          = "unmanaged"
    restore_previous_state = ["sms", "voice"]
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

  assert {
    condition = (
      jsonencode(msgraph_update_resource.object["sms"].body) == jsonencode(output.previous_state["sms"]) &&
      jsonencode(msgraph_update_resource.object["voice"].body) == jsonencode(output.previous_state["voice"]) &&
      msgraph_update_resource.object["sms"].body.state == "enabled" &&
      msgraph_update_resource.object["sms"].body.includeTargets[0].isUsableForSignIn == true &&
      msgraph_update_resource.object["voice"].body.isOfficePhoneAllowed == true
    )
    error_message = "With phone_methods unmanaged, a requested restore must still PATCH SMS and voice with the original values."
  }

  assert {
    condition     = jsonencode(sort(keys(terraform_data.snapshot))) == jsonencode(["fido2", "microsoftAuthenticator", "policy", "sms", "voice"])
    error_message = "No snapshot may be destroyed by the input change."
  }
}

run "unmanaged_after_restore_keeps_snapshots" {
  command = plan

  variables {
    tier          = "p1"
    phone_methods = "unmanaged"
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

  assert {
    condition     = jsonencode(sort(keys(msgraph_update_resource.object))) == jsonencode(["fido2", "microsoftAuthenticator", "policy"]) && jsonencode(sort(keys(output.previous_state))) == jsonencode(["fido2", "microsoftAuthenticator", "policy", "sms", "voice"])
    error_message = "Back on unmanaged, SMS and voice are no longer PATCHed but their snapshots remain."
  }
}

# Dropping restrict without restoring SMS and voice warns: they no longer match the snapshot.
run "unmanaged_without_restore_warns" {
  command = plan

  variables {
    tier          = "p1"
    phone_methods = "unmanaged"
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
        migration_state          = "migrationComplete"
        registration_enforcement = { authenticationMethodsRegistrationCampaign = { state = "enabled", snoozeDurationInDays = 1, enforceRegistrationAfterAllowedSnoozes = false, includeTargets = [], excludeTargets = [] } }
        configurations = [
          { "@odata.type" = "#microsoft.graph.microsoftAuthenticatorAuthenticationMethodConfiguration", id = "MicrosoftAuthenticator", state = "enabled", includeTargets = [], excludeTargets = [], featureSettings = {} },
          { "@odata.type" = "#microsoft.graph.fido2AuthenticationMethodConfiguration", id = "Fido2", state = "enabled", isSelfServiceRegistrationAllowed = true, includeTargets = [], excludeTargets = [] },
          { "@odata.type" = "#microsoft.graph.smsAuthenticationMethodConfiguration", id = "Sms", state = "enabled", includeTargets = [{ targetType = "group", id = "00000000-0000-4000-8000-0000000000e0", isRegistrationRequired = false, isUsableForSignIn = false }], excludeTargets = [] },
          { "@odata.type" = "#microsoft.graph.voiceAuthenticationMethodConfiguration", id = "Voice", state = "enabled", isOfficePhoneAllowed = false, includeTargets = [], excludeTargets = [] },
        ]
      }
    }
  }

  expect_failures = [check.unmanaged_phone_methods_match_snapshot]
}
