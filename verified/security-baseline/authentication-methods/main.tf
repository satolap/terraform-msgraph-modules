# Updates the tenant authentication methods policy singleton and the per-method
# configurations of Microsoft Authenticator, passkeys (FIDO2) and optionally SMS and voice.
# These objects always exist: the module only PATCHes them, creates and deletes nothing, and
# touches no account, group, Conditional Access policy or security default.
#
# Deleting an msgraph_update_resource sends no request, so the settings would stay as last
# applied. The module therefore stores the prior values on first apply (snapshot) and can
# send them back with restore_previous_state. See the README for the destroy order.

# The licence guard fails the plan for p1 and p2 without a usable subscription. The free
# tier reads no licences. No count or for_each depends on licence data.
module "licence_guard" {
  source = "../licence-guard"

  tier = var.tier
}

locals {
  policy_url = "policies/authenticationMethodsPolicy"
  method_url = "policies/authenticationMethodsPolicy/authenticationMethodConfigurations"
  guid_regex = "^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$"

  break_glass_user_ids  = sort(tolist(var.break_glass_user_ids))
  break_glass_group_ids = sort(tolist(var.break_glass_group_ids))

  break_glass_targets = concat(
    [for id in local.break_glass_user_ids : { id = id, targetType = "user" }],
    [for id in local.break_glass_group_ids : { id = id, targetType = "group" }],
  )

  phone_managed = var.phone_methods != "unmanaged"

  # Every object the module can touch. All of them are snapshotted on every first apply,
  # whatever phone_methods says, so that an input change never destroys a snapshot.
  all_urls = {
    policy                 = local.policy_url
    microsoftAuthenticator = "${local.method_url}/microsoftAuthenticator"
    fido2                  = "${local.method_url}/fido2"
    sms                    = "${local.method_url}/sms"
    voice                  = "${local.method_url}/voice"
  }

  # The objects that are PATCHed: the baseline ones, SMS and voice when phone_methods manages
  # them, and any object whose restore is requested.
  update_keys = [
    for key in keys(local.all_urls) : key
    if contains(["policy", "microsoftAuthenticator", "fido2"], key) || local.phone_managed || contains(var.restore_previous_state, key)
  ]
  update_urls = { for key in local.update_keys : key => local.all_urls[key] }

  managed_method_ids = [for key in keys(local.all_urls) : key if key != "policy"]

  campaign = {
    state                                  = var.campaign_state
    snoozeDurationInDays                   = var.campaign_snooze_days
    enforceRegistrationAfterAllowedSnoozes = var.campaign_require_after_snoozes
    includeTargets = [{
      id                           = var.campaign_include_group_id
      targetType                   = "group"
      targetedAuthenticationMethod = var.campaign_method
    }]
    excludeTargets = local.break_glass_targets
  }

  odata_types = {
    microsoftAuthenticator = "#microsoft.graph.microsoftAuthenticatorAuthenticationMethodConfiguration"
    fido2                  = "#microsoft.graph.fido2AuthenticationMethodConfiguration"
    sms                    = "#microsoft.graph.smsAuthenticationMethodConfiguration"
    voice                  = "#microsoft.graph.voiceAuthenticationMethodConfiguration"
  }

  feature_target = { targetType = "group", id = "all_users" }

  bodies = {
    policy = {
      registrationEnforcement = {
        authenticationMethodsRegistrationCampaign = local.campaign
      }
    }

    microsoftAuthenticator = {
      "@odata.type" = local.odata_types.microsoftAuthenticator
      state         = "enabled"
      includeTargets = [{
        targetType             = "group"
        id                     = var.authenticator_include_group_id
        isRegistrationRequired = false
        authenticationMode     = var.authenticator_mode
      }]
      excludeTargets = []
      featureSettings = {
        displayAppInformationRequiredState = {
          state         = var.authenticator_show_app_name
          includeTarget = local.feature_target
        }
        displayLocationInformationRequiredState = {
          state         = var.authenticator_show_location
          includeTarget = local.feature_target
        }
      }
    }

    fido2 = {
      "@odata.type"                    = local.odata_types.fido2
      state                            = "enabled"
      isSelfServiceRegistrationAllowed = var.fido2_self_service_registration
      includeTargets = [{
        targetType             = "group"
        id                     = var.fido2_include_group_id
        isRegistrationRequired = false
        allowedPasskeyProfiles = []
      }]
      excludeTargets = [for id in sort(tolist(var.fido2_exclude_group_ids)) : { id = id, targetType = "group" }]
    }

    sms = {
      "@odata.type" = local.odata_types.sms
      state         = "enabled"
      includeTargets = [{
        targetType             = "group"
        id                     = var.phone_methods_group_id
        isRegistrationRequired = false
        isUsableForSignIn      = false
      }]
      excludeTargets = []
    }

    voice = {
      "@odata.type"        = local.odata_types.voice
      state                = "enabled"
      isOfficePhoneAllowed = false
      includeTargets = [{
        targetType             = "group"
        id                     = var.phone_methods_group_id
        isRegistrationRequired = false
      }]
      excludeTargets = []
    }
  }

  desired_json = { for key in keys(local.all_urls) : key => jsonencode(local.bodies[key]) }

  # Prior state, restricted to the properties the module can write. Read-only properties
  # (id, displayName, description, lastModifiedDateTime, policyVersion) and properties the
  # module does not manage are never stored or sent back.
  restorable = {
    microsoftAuthenticator = ["state", "includeTargets", "excludeTargets"]
    fido2                  = ["state", "isSelfServiceRegistrationAllowed", "includeTargets", "excludeTargets"]
    sms                    = ["state", "includeTargets", "excludeTargets"]
    voice                  = ["state", "isOfficePhoneAllowed", "includeTargets", "excludeTargets"]
  }

  feature_settings_keys = ["displayAppInformationRequiredState", "displayLocationInformationRequiredState"]

  configurations = { for configuration in try(data.msgraph_resource.policy.output.configurations, []) : lower(configuration.id) => configuration }

  prior = merge(
    {
      policy = { registrationEnforcement = try(data.msgraph_resource.policy.output.registration_enforcement, null) }
    },
    {
      for id, keep in local.restorable : id => merge(
        { "@odata.type" = local.odata_types[id] },
        { for key, value in try(local.configurations[lower(id)], {}) : key => value if contains(keep, key) },
        { for key, value in {
          featureSettings = { for name, setting in try(local.configurations[lower(id)].featureSettings, {}) : name => setting if contains(local.feature_settings_keys, name) }
        } : key => value if id == "microsoftAuthenticator" },
      )
    },
  )

  prior_json = { for key in keys(local.all_urls) : key => jsonencode(local.prior[key]) }

  # The bodies actually sent: the baseline, or the snapshot for an object being restored.
  final_json = { for key in local.update_keys : key => contains(var.restore_previous_state, key) ? terraform_data.snapshot[key].input : local.desired_json[key] }

  # The campaign exclusions of the body actually sent, for the break-glass precondition.
  sent_campaign_exclusions = try([
    for excluded in jsondecode(local.final_json["policy"]).registrationEnforcement.authenticationMethodsRegistrationCampaign.excludeTargets : "${excluded.targetType}/${excluded.id}"
  ], [])

  campaign_excludes_break_glass = alltrue([
    for target in local.break_glass_targets : contains(local.sent_campaign_exclusions, "${target.targetType}/${target.id}")
  ])

  # Include and exclude targets of the current read, and of the baseline about to be sent, as
  # "type/id" lists, for the objects that are PATCHed and not restored.
  current_objects = merge(
    { policy = try(local.prior.policy.registrationEnforcement.authenticationMethodsRegistrationCampaign, {}) },
    { for key in local.managed_method_ids : key => local.prior[key] },
  )
  desired_objects = merge(
    { policy = local.campaign },
    { for key in local.managed_method_ids : key => local.bodies[key] },
  )

  # Objects whose existing non-empty exclusions or include scope differ from the baseline, so
  # that the baseline overwrites them. After an apply the read equals the baseline: no warning.
  overwritten_targets = sort([
    for key in local.update_keys : key
    if !contains(var.restore_previous_state, key) && (
      (
        try(length(local.current_objects[key].excludeTargets), 0) > 0 &&
        try(sort([for target in local.current_objects[key].excludeTargets : try("${target.targetType}/${target.id}", "")]), []) != sort([for target in local.desired_objects[key].excludeTargets : try("${target.targetType}/${target.id}", "")])
        ) || (
        try(length(local.current_objects[key].includeTargets), 0) > 0 &&
        try(sort([for target in local.current_objects[key].includeTargets : try("${target.targetType}/${target.id}", "")]), []) != sort([for target in local.desired_objects[key].includeTargets : try("${target.targetType}/${target.id}", "")])
      )
    )
  ])

  # SMS and voice that are left unmanaged, are not being restored, and no longer match the
  # snapshot: a restrict that was dropped without restoring them.
  phone_drift = var.phone_methods != "unmanaged" ? [] : [
    for key in ["sms", "voice"] : key
    if !contains(var.restore_previous_state, key) && local.prior_json[key] != terraform_data.snapshot[key].input
  ]

  # A campaign must target a method that is enabled for the campaign's users: the method is
  # enabled for all_users, or for exactly the campaign's group. A campaign for all_users with a
  # method scoped to a group fails. Not applicable when the policy is restored from the snapshot.
  campaign_method_include_group = var.campaign_method == "fido2" ? var.fido2_include_group_id : var.authenticator_include_group_id
  campaign_group_has_method = contains(var.restore_previous_state, "policy") || (
    local.campaign_method_include_group == "all_users" || local.campaign_method_include_group == var.campaign_include_group_id
  )

  # A passkey campaign whose own target group is excluded from passkeys prompts users who are
  # denied the method. Excluded users cannot register, so the guard fails (not applicable when
  # the policy is restored from the snapshot).
  campaign_group_excluded_from_fido2 = (
    var.campaign_method == "fido2" && !contains(var.restore_previous_state, "policy") &&
    contains(var.fido2_exclude_group_ids, var.campaign_include_group_id)
  )

  fido2_reaches_break_glass = var.fido2_include_group_id == "all_users" || contains(local.break_glass_group_ids, var.fido2_include_group_id)
}

# Security defaults are read, never changed. The read depends on no input or licence data.
data "msgraph_resource" "security_defaults" {
  url         = "policies/identitySecurityDefaultsEnforcementPolicy"
  api_version = "v1.0"

  response_export_values = {
    is_enabled = "isEnabled"
  }

  lifecycle {
    postcondition {
      condition     = try(self.output.is_enabled == tobool(self.output.is_enabled), false)
      error_message = "The security defaults response is malformed: isEnabled is not a boolean."
    }
  }
}

# The policy is read with its method configurations expanded. The read happens at plan time,
# before this module's updates, so the snapshot of a first apply holds the original values.
data "msgraph_resource" "policy" {
  url         = local.policy_url
  api_version = "v1.0"

  response_export_values = {
    registration_enforcement = "registrationEnforcement"
    migration_state          = "policyMigrationState"
    configurations           = "authenticationMethodConfigurations"
  }

  lifecycle {
    postcondition {
      condition = try(
        self.output.configurations != null && can(concat(self.output.configurations, [])) &&
        self.output.registration_enforcement != null && can(keys(self.output.registration_enforcement)) &&
        alltrue([for configuration in self.output.configurations : can(concat(configuration.includeTargets, [])) && can(concat(configuration.excludeTargets, [])) if contains([for id in local.managed_method_ids : lower(id)], try(lower(configuration.id), ""))]) &&
        alltrue([for id in local.managed_method_ids : contains([for configuration in self.output.configurations : try(lower(configuration.id), "")], lower(id))]),
        false
      )
      error_message = "The authentication methods policy response is malformed, has no registrationEnforcement object, or does not list every method configuration the module snapshots with includeTargets and excludeTargets."
    }
  }
}

# Plan-time guard for every cross-input rule and for the break-glass exclusions.
resource "terraform_data" "guard" {
  input = {
    tier = module.licence_guard.tier
  }

  lifecycle {
    precondition {
      condition     = var.tier != "free" || !local.phone_managed
      error_message = "phone_methods \"${var.phone_methods}\" is refused for tier \"free\": without Microsoft Entra ID P1 the tenant keeps security defaults on and the module leaves SMS and voice unmanaged. Use phone_methods = \"unmanaged\"."
    }

    precondition {
      condition     = local.campaign_group_has_method
      error_message = "The campaign targets group ${var.campaign_include_group_id} for ${var.campaign_method}, but that method is not enabled for the same group: set campaign_include_group_id equal to the method's include group, or enable the method for all_users."
    }

    precondition {
      condition     = !local.campaign_group_excluded_from_fido2
      error_message = "The campaign targets group ${var.campaign_include_group_id} for fido2, but that group is in fido2_exclude_group_ids: excluded users are denied passkeys, so every campaign target would be blocked. Remove the group from fido2_exclude_group_ids or target another group."
    }

    precondition {
      condition     = var.phone_methods != "restrict" || var.phone_methods_group_id != null
      error_message = "phone_methods = \"restrict\" needs phone_methods_group_id: the group that keeps SMS and voice."
    }

    precondition {
      condition     = var.campaign_method != "fido2" || var.fido2_self_service_registration
      error_message = "campaign_method = \"fido2\" needs fido2_self_service_registration = true: users cannot register a passkey from the campaign otherwise."
    }

    precondition {
      condition     = local.fido2_reaches_break_glass
      error_message = "Passkeys (FIDO2) must target \"all_users\" or one of break_glass_group_ids, so that the emergency access accounts can use them. fido2_include_group_id is neither."
    }

    precondition {
      condition     = length(setintersection(var.fido2_exclude_group_ids, var.break_glass_group_ids)) == 0
      error_message = "A break-glass group is in fido2_exclude_group_ids. Excluded users are blocked from passkey registration and sign-in entirely, and passkeys are the recommended method for emergency access accounts."
    }

    precondition {
      condition     = !try(data.msgraph_resource.security_defaults.output.is_enabled, false) || var.authenticator_include_group_id == "all_users"
      error_message = "Security defaults are on: authenticator_include_group_id must be \"all_users\", because security defaults users register and use Microsoft Authenticator notifications."
    }
  }
}

resource "terraform_data" "snapshot" {
  for_each = local.all_urls

  input = local.prior_json[each.key]

  # The first value stays, so a later plan after a tenant change shows no difference.
  lifecycle {
    ignore_changes = [input]
  }
}

resource "msgraph_update_resource" "object" {
  for_each = local.update_urls

  url           = each.value
  api_version   = "v1.0"
  update_method = "PATCH"
  body          = jsondecode(local.final_json[each.key])

  depends_on = [terraform_data.guard, terraform_data.snapshot]

  # A refactor guard: the campaign body always lists the break-glass IDs by construction, so
  # this only fails if a later change drops them. Checked on the body actually sent: the campaign never prompts or forces a break-glass
  # account to register (not applicable when the campaign is restored from the snapshot).
  lifecycle {
    precondition {
      condition     = each.key != "policy" || contains(var.restore_previous_state, "policy") || local.campaign_excludes_break_glass
      error_message = "The registration campaign excludeTargets do not contain every break-glass user and group."
    }
  }
}

# Warnings only: neither condition blocks an apply.
check "security_defaults_stay_on_for_free" {
  assert {
    condition     = var.tier != "free" || try(data.msgraph_resource.security_defaults.output.is_enabled, false)
    error_message = "Security defaults are off. The free tier assumes they stay on."
  }
}

check "existing_targets_are_overwritten" {
  assert {
    condition     = length(local.overwritten_targets) == 0
    error_message = "Existing exclusions or include scope on ${join(", ", local.overwritten_targets)} differ from the baseline and are overwritten. The snapshot (output previous_state) keeps the originals; review them before applying."
  }
}

check "unmanaged_phone_methods_match_snapshot" {
  assert {
    condition     = length(local.phone_drift) == 0
    error_message = "phone_methods is unmanaged but ${join(" and ", local.phone_drift)} no longer match the snapshot: restore them with restore_previous_state before dropping phone_methods = \"restrict\"."
  }
}

check "policy_migration_complete_for_phone_methods" {
  assert {
    condition     = var.phone_methods == "unmanaged" || try(data.msgraph_resource.policy.output.migration_state, "") == "migrationComplete"
    error_message = "policyMigrationState is not migrationComplete: users still enabled in the legacy MFA or self-service password reset policy keep SMS and voice."
  }
}
