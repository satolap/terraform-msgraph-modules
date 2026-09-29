locals {
  guid = "^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$"

  # One canonical form for every list: GUIDs lower-cased, duplicates removed,
  # sorted. Special values such as All, None, GuestsOrExternalUsers, Office365
  # and MicrosoftAdminPortals are kept as given. The provider compares arrays by
  # position and case when it refreshes the body.
  users = { for k, v in var.users : k => sort(distinct([for s in v : can(regex(local.guid, s)) ? lower(s) : s])) }
  apps  = { for k, v in var.applications : k => sort(distinct([for s in v : can(regex(local.guid, s)) ? lower(s) : s])) }

  break_glass_user_ids  = sort(var.break_glass_user_ids)
  break_glass_group_ids = sort(var.break_glass_group_ids)

  locations = var.locations == null ? null : {
    includeLocations = sort(distinct([for s in var.locations.include_locations : can(regex(local.guid, s)) ? lower(s) : s]))
    excludeLocations = sort(distinct([for s in var.locations.exclude_locations : can(regex(local.guid, s)) ? lower(s) : s]))
  }

  platforms = var.platforms == null ? null : {
    includePlatforms = sort(var.platforms.include_platforms)
    excludePlatforms = sort(var.platforms.exclude_platforms)
  }

  devices = var.device_filter == null ? null : {
    deviceFilter = {
      mode = var.device_filter.mode
      rule = var.device_filter.rule
    }
  }

  built_in_controls          = try(sort(var.grant_controls.built_in_controls), [])
  authentication_strength_id = try(lower(var.grant_controls.authentication_strength_id), null)

  grant_controls = var.grant_controls == null ? null : merge(
    {
      operator        = var.grant_controls.operator
      builtInControls = local.built_in_controls
      termsOfUse      = sort(distinct([for s in var.grant_controls.terms_of_use : lower(s)]))
    },
    local.authentication_strength_id == null ? {} : {
      authenticationStrength = { id = local.authentication_strength_id }
    },
  )

  sign_in_frequency = try(var.session_controls.sign_in_frequency, null)

  # Every configured session control is sent enabled; Graph condenses
  # ineffective session controls to null, which would show as drift.
  session_controls = var.session_controls == null ? null : merge(
    local.sign_in_frequency == null ? {} : {
      signInFrequency = {
        isEnabled          = true
        frequencyInterval  = local.sign_in_frequency.frequency_interval
        authenticationType = local.sign_in_frequency.authentication_type
        type               = local.sign_in_frequency.type
        value              = local.sign_in_frequency.value
      }
    },
    var.session_controls.persistent_browser_mode == null ? {} : {
      persistentBrowser = {
        isEnabled = true
        mode      = var.session_controls.persistent_browser_mode
      }
    },
    var.session_controls.application_enforced_restrictions ? {
      applicationEnforcedRestrictions = {
        isEnabled = true
      }
    } : {},
    var.session_controls.cloud_app_security_type == null ? {} : {
      cloudAppSecurity = {
        isEnabled            = true
        cloudAppSecurityType = var.session_controls.cloud_app_security_type
      }
    },
  )

  # Every managed key is in the body: lists are [] when empty and absent
  # optional parts are null, so out-of-band additions show as drift. The
  # break-glass principals are merged into the exclusions in every state.
  body = {
    displayName = var.display_name
    state       = var.state
    conditions = {
      users = {
        includeUsers  = local.users.include_users
        excludeUsers  = sort(distinct(concat(local.users.exclude_users, local.break_glass_user_ids)))
        includeGroups = local.users.include_groups
        excludeGroups = sort(distinct(concat(local.users.exclude_groups, local.break_glass_group_ids)))
        includeRoles  = local.users.include_roles
        excludeRoles  = local.users.exclude_roles
      }
      applications = {
        includeApplications                         = local.apps.include_applications
        excludeApplications                         = local.apps.exclude_applications
        includeUserActions                          = local.apps.include_user_actions
        includeAuthenticationContextClassReferences = local.apps.include_authentication_context_class_references
      }
      clientAppTypes   = sort(var.client_app_types)
      signInRiskLevels = sort(var.sign_in_risk_levels)
      userRiskLevels   = sort(var.user_risk_levels)
      locations        = local.locations
      platforms        = local.platforms
      devices          = local.devices
    }
    grantControls   = local.grant_controls
    sessionControls = local.session_controls
  }

  # Which optional parts are present. The provider never sends a removed key or
  # a value changed to null, and a PATCH keeps omitted properties, so adding or
  # removing a part replaces the policy (create before destroy) instead.
  presence = sort(compact([
    local.locations == null ? "" : "conditions.locations",
    local.platforms == null ? "" : "conditions.platforms",
    local.devices == null ? "" : "conditions.devices",
    local.grant_controls == null ? "" : "grantControls",
    local.authentication_strength_id == null ? "" : "grantControls.authenticationStrength",
    local.session_controls == null ? "" : "sessionControls",
    try(local.session_controls.signInFrequency, null) == null ? "" : "sessionControls.signInFrequency",
    try(local.session_controls.persistentBrowser, null) == null ? "" : "sessionControls.persistentBrowser",
    try(local.session_controls.applicationEnforcedRestrictions, null) == null ? "" : "sessionControls.applicationEnforcedRestrictions",
    try(local.session_controls.cloudAppSecurity, null) == null ? "" : "sessionControls.cloudAppSecurity",
  ]))

  password_change = contains(local.built_in_controls, "passwordChange")
  all_apps_only   = length(local.apps.include_applications) == 1 && contains(local.apps.include_applications, "All")
  terms_of_use    = try(var.grant_controls.terms_of_use, [])
  register_device = contains(local.apps.include_user_actions, "urn:user:registerdevice")

  # Every ID any include list names, for the break-glass conflict checks.
  included_ids = concat(local.users.include_users, local.users.include_groups, local.users.include_roles)

  # The optional parts Microsoft Graph returned on the last read, in the same
  # form as local.presence; null when no read has exported them. An in-place
  # update cannot remove a part (the provider sends no request for a removed
  # key or a value changed to null), so a part that Graph has and the
  # configuration lacks stays in force until the policy is replaced.
  server_parts = try(msgraph_resource.policy.output.optional_parts, null)
  server_presence = local.server_parts == null ? null : sort(compact([
    try(local.server_parts.locations == true, false) ? "conditions.locations" : "",
    try(local.server_parts.platforms == true, false) ? "conditions.platforms" : "",
    try(local.server_parts.devices == true, false) ? "conditions.devices" : "",
    try(local.server_parts.grant_controls == true, false) ? "grantControls" : "",
    try(local.server_parts.authentication_strength == true, false) ? "grantControls.authenticationStrength" : "",
    try(local.server_parts.session_controls == true, false) ? "sessionControls" : "",
    try(local.server_parts.sign_in_frequency == true, false) ? "sessionControls.signInFrequency" : "",
    try(local.server_parts.persistent_browser == true, false) ? "sessionControls.persistentBrowser" : "",
    try(local.server_parts.application_enforced_restrictions == true, false) ? "sessionControls.applicationEnforcedRestrictions" : "",
    try(local.server_parts.cloud_app_security == true, false) ? "sessionControls.cloudAppSecurity" : "",
  ]))
}

resource "terraform_data" "presence" {
  input = local.presence
}

resource "msgraph_resource" "policy" {
  url                     = "identity/conditionalAccess/policies"
  api_version             = var.api_version
  body                    = local.body
  ignore_missing_property = false

  response_export_values = {
    display_name   = "displayName"
    state          = "state"
    exclude_users  = "conditions.users.excludeUsers"
    exclude_groups = "conditions.users.excludeGroups"
    # Which optional parts the policy has on the server, for the
    # optional_parts_not_in_configuration output.
    optional_parts = "{locations: conditions.locations != `null`, platforms: conditions.platforms != `null`, devices: conditions.devices != `null`, grant_controls: grantControls != `null`, authentication_strength: grantControls.authenticationStrength != `null`, session_controls: sessionControls != `null`, sign_in_frequency: sessionControls.signInFrequency != `null`, persistent_browser: sessionControls.persistentBrowser != `null`, application_enforced_restrictions: sessionControls.applicationEnforcedRestrictions != `null`, cloud_app_security: sessionControls.cloudAppSecurity != `null`}"
  }

  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }

  lifecycle {
    create_before_destroy = true
    replace_triggered_by  = [terraform_data.presence]

    precondition {
      condition     = length(setintersection(local.included_ids, local.break_glass_user_ids)) == 0
      error_message = "break_glass_user_ids must not appear in users.include_users, include_groups or include_roles; emergency access users are always excluded."
    }

    precondition {
      condition     = length(setintersection(local.included_ids, local.break_glass_group_ids)) == 0
      error_message = "break_glass_group_ids must not appear in users.include_users, include_groups or include_roles; emergency access groups are always excluded."
    }

    precondition {
      condition     = var.state != "enabledForReportingButNotEnforced" || length(local.apps.include_user_actions) == 0
      error_message = "Report-only mode cannot evaluate user actions. Set state to \"disabled\" or \"enabled\" for a policy with applications.include_user_actions."
    }

    precondition {
      condition     = length(var.sign_in_risk_levels) == 0 || length(var.user_risk_levels) == 0
      error_message = "Don't combine sign_in_risk_levels and user_risk_levels in one policy; create one policy per risk condition."
    }

    precondition {
      condition     = !contains(local.built_in_controls, "mfa") || local.authentication_strength_id == null
      error_message = "grant_controls cannot combine the mfa built-in control with an authentication strength."
    }

    precondition {
      condition = !contains(local.built_in_controls, "block") || (
        length(local.built_in_controls) == 1 &&
        length(local.terms_of_use) == 0 &&
        local.authentication_strength_id == null
      )
      error_message = "The block built-in control must be the only grant control: grant_controls with \"block\" cannot list another built-in control, terms_of_use or an authentication_strength_id."
    }

    precondition {
      condition = !local.password_change || (
        try(var.grant_controls.operator, null) == "AND" &&
        contains(local.built_in_controls, "mfa") &&
        local.authentication_strength_id == null &&
        length(setsubtract(local.built_in_controls, ["passwordChange", "mfa"])) == 0 &&
        length(local.terms_of_use) == 0 &&
        length(var.user_risk_levels) > 0 &&
        length(var.sign_in_risk_levels) == 0 &&
        local.all_apps_only &&
        length(local.apps.exclude_applications) == 0 &&
        var.locations == null &&
        var.platforms == null &&
        var.device_filter == null &&
        length(var.client_app_types) == 1 && contains(var.client_app_types, "all")
      )
      error_message = "passwordChange needs operator \"AND\" with the mfa built-in control, not an authentication strength, and no other grant control or terms of use, user_risk_levels, include_applications = [\"All\"] with no excluded applications, and no other condition: no sign_in_risk_levels, locations, platforms or device_filter, and client_app_types = [\"all\"]."
    }

    precondition {
      condition     = try(var.session_controls.persistent_browser_mode, null) == null || local.all_apps_only
      error_message = "session_controls.persistent_browser_mode needs applications.include_applications = [\"All\"]; the persistent browser session control works correctly only when all apps are selected."
    }

    precondition {
      condition     = var.grant_controls != null || var.session_controls != null
      error_message = "Set grant_controls, session_controls or both; a Conditional Access policy needs at least one access control."
    }

    precondition {
      condition = !local.register_device || (
        length(setsubtract(local.built_in_controls, ["mfa"])) == 0 &&
        length(local.terms_of_use) == 0 &&
        var.device_filter == null &&
        length(var.client_app_types) == 1 && contains(var.client_app_types, "all")
      )
      error_message = "The urn:user:registerdevice user action allows only mfa or an authentication strength as grant controls, with no terms of use, no device_filter and client_app_types = [\"all\"]."
    }
  }
}
