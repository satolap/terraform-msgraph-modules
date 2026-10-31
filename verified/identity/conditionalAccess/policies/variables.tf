variable "displayName" {
  description = "Display name of the Conditional Access policy."
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.displayName)) > 0
    error_message = "displayName must not be empty."
  }
}

variable "state" {
  description = "Policy state. The default, \"enabledForReportingButNotEnforced\" (report-only), evaluates the policy at sign-in without enforcing it. \"enabled\" enforces the policy; set it only after reviewing the report-only results. \"disabled\" turns the policy off."
  type        = string
  default     = "enabledForReportingButNotEnforced"
  nullable    = false

  validation {
    condition     = contains(["disabled", "enabledForReportingButNotEnforced", "enabled"], var.state)
    error_message = "state must be one of \"disabled\", \"enabledForReportingButNotEnforced\" or \"enabled\"."
  }
}

variable "break_glass_user_ids" {
  description = "Object IDs of the emergency access (break-glass) users, each a lowercase GUID, at least one. The module adds them to conditions.users.excludeUsers in every state; they must not appear in users.includeUsers. A planned emergency access guard module (not yet released) is meant to supply these IDs."
  type        = set(string)
  nullable    = false

  validation {
    condition     = length(var.break_glass_user_ids) > 0
    error_message = "break_glass_user_ids must list at least one emergency access user. A group alone is not enough, because its membership can change outside Terraform."
  }

  validation {
    condition     = alltrue([for id in var.break_glass_user_ids : can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", id))])
    error_message = "break_glass_user_ids must contain lowercase GUIDs as Microsoft Graph returns them."
  }
}

variable "break_glass_group_ids" {
  description = "Object IDs of emergency access security groups, each a lowercase GUID. The module adds them to conditions.users.excludeGroups in every state; they must not appear in users.includeGroups. A planned emergency access guard module (not yet released) is meant to supply these IDs."
  type        = set(string)
  default     = []
  nullable    = false

  validation {
    condition     = alltrue([for id in var.break_glass_group_ids : can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", id))])
    error_message = "break_glass_group_ids must contain lowercase GUIDs as Microsoft Graph returns them."
  }
}

variable "users" {
  description = "Users, groups and directory roles in and out of scope. includeUsers takes user object IDs or one of \"All\", \"None\", \"GuestsOrExternalUsers\"; excludeUsers takes user object IDs or \"GuestsOrExternalUsers\"; groups take group object IDs; roles take directory role template IDs. The break-glass inputs are added to the exclusions."
  type = object({
    includeUsers   = optional(set(string), [])
    include_users  = optional(any)
    excludeUsers   = optional(set(string), [])
    exclude_users  = optional(any)
    includeGroups  = optional(set(string), [])
    include_groups = optional(any)
    excludeGroups  = optional(set(string), [])
    exclude_groups = optional(any)
    includeRoles   = optional(set(string), [])
    include_roles  = optional(any)
    excludeRoles   = optional(set(string), [])
    exclude_roles  = optional(any)
  })
  nullable = false

  validation {
    condition     = alltrue([for s in var.users.includeUsers : contains(["All", "None", "GuestsOrExternalUsers"], s) || can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", s))])
    error_message = "users.includeUsers entries must be user object IDs or one of \"All\", \"None\", \"GuestsOrExternalUsers\"."
  }

  validation {
    condition     = alltrue([for s in var.users.excludeUsers : s == "GuestsOrExternalUsers" || can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", s))])
    error_message = "users.excludeUsers entries must be user object IDs or \"GuestsOrExternalUsers\"."
  }

  validation {
    condition     = alltrue([for s in concat(tolist(var.users.includeGroups), tolist(var.users.excludeGroups), tolist(var.users.includeRoles), tolist(var.users.excludeRoles)) : can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", s))])
    error_message = "users group entries must be group object IDs and role entries must be directory role template IDs (GUIDs)."
  }

  validation {
    condition     = length(var.users.includeUsers) + length(var.users.includeGroups) + length(var.users.includeRoles) > 0
    error_message = "users must include at least one user, group or role; use includeUsers = [\"None\"] for a policy that targets nobody."
  }

  # legacy-names guard: v4.0.0 spelled these attributes in snake_case; the object type would otherwise
  # drop them and fall back to the default.
  validation {
    condition     = !can(regex("\"(exclude_groups|exclude_roles|exclude_users|include_groups|include_roles|include_users)\":[^n]", jsonencode(var.users)))
    error_message = "users no longer accepts the v4.0.0 snake_case attribute names; rename them to Graph's names (exclude_groups -> excludeGroups, exclude_roles -> excludeRoles, exclude_users -> excludeUsers, include_groups -> includeGroups, include_roles -> includeRoles, include_users -> includeUsers). An old name that is silently dropped would fall back to its default."
  }
}

variable "applications" {
  description = "Target resources. includeApplications takes application (client) IDs or one of \"All\", \"None\", \"Office365\", \"MicrosoftAdminPortals\"; excludeApplications takes application IDs, \"Office365\" or \"MicrosoftAdminPortals\"; includeUserActions takes \"urn:user:registersecurityinfo\" or \"urn:user:registerdevice\"; includeAuthenticationContextClassReferences takes authentication context IDs such as \"c1\". Exactly one of includeApplications, includeUserActions and includeAuthenticationContextClassReferences must be non-empty."
  type = object({
    includeApplications                             = optional(set(string), [])
    include_applications                            = optional(any)
    excludeApplications                             = optional(set(string), [])
    exclude_applications                            = optional(any)
    includeUserActions                              = optional(set(string), [])
    include_user_actions                            = optional(any)
    includeAuthenticationContextClassReferences     = optional(set(string), [])
    include_authentication_context_class_references = optional(any)
  })
  nullable = false

  validation {
    condition     = alltrue([for s in var.applications.includeApplications : contains(["All", "None", "Office365", "MicrosoftAdminPortals"], s) || can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", s))])
    error_message = "applications.includeApplications entries must be application IDs or one of \"All\", \"None\", \"Office365\", \"MicrosoftAdminPortals\"."
  }

  validation {
    condition     = alltrue([for s in var.applications.excludeApplications : contains(["Office365", "MicrosoftAdminPortals"], s) || can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", s))])
    error_message = "applications.excludeApplications entries must be application IDs or one of \"Office365\", \"MicrosoftAdminPortals\"."
  }

  validation {
    condition     = alltrue([for s in var.applications.includeUserActions : contains(["urn:user:registersecurityinfo", "urn:user:registerdevice"], s)])
    error_message = "applications.includeUserActions entries must be \"urn:user:registersecurityinfo\" or \"urn:user:registerdevice\"."
  }

  validation {
    condition     = alltrue([for s in var.applications.includeAuthenticationContextClassReferences : can(regex("^c([1-9]|[1-9][0-9])$", s))])
    error_message = "applications.includeAuthenticationContextClassReferences entries must be authentication context IDs from \"c1\" to \"c99\"."
  }

  validation {
    condition     = (length(var.applications.includeApplications) > 0 ? 1 : 0) + (length(var.applications.includeUserActions) > 0 ? 1 : 0) + (length(var.applications.includeAuthenticationContextClassReferences) > 0 ? 1 : 0) == 1
    error_message = "applications must set exactly one of includeApplications, includeUserActions or includeAuthenticationContextClassReferences; the target selectors are mutually exclusive."
  }

  # legacy-names guard: v4.0.0 spelled these attributes in snake_case; the object type would otherwise
  # drop them and fall back to the default.
  validation {
    condition     = !can(regex("\"(exclude_applications|include_applications|include_authentication_context_class_references|include_user_actions)\":[^n]", jsonencode(var.applications)))
    error_message = "applications no longer accepts the v4.0.0 snake_case attribute names; rename them to Graph's names (exclude_applications -> excludeApplications, include_applications -> includeApplications, include_authentication_context_class_references -> includeAuthenticationContextClassReferences, include_user_actions -> includeUserActions). An old name that is silently dropped would fall back to its default."
  }
}

variable "client_app_types" {
  description = "Client app types the policy applies to. Microsoft Entra applies \"all\" when the condition is not configured, which is the default here."
  type        = set(string)
  default     = ["all"]
  nullable    = false

  validation {
    condition     = length(var.client_app_types) > 0 && alltrue([for s in var.client_app_types : contains(["all", "browser", "mobileAppsAndDesktopClients", "exchangeActiveSync", "easSupported", "other"], s)])
    error_message = "client_app_types must be non-empty, with entries from \"all\", \"browser\", \"mobileAppsAndDesktopClients\", \"exchangeActiveSync\", \"easSupported\", \"other\"."
  }
}

variable "sign_in_risk_levels" {
  description = "Sign-in risk levels that trigger the policy. Needs Microsoft Entra ID P2 (ID Protection). Don't combine with user_risk_levels."
  type        = set(string)
  default     = []
  nullable    = false

  validation {
    condition     = alltrue([for s in var.sign_in_risk_levels : contains(["low", "medium", "high", "hidden", "none"], s)])
    error_message = "sign_in_risk_levels entries must be \"low\", \"medium\", \"high\", \"hidden\" or \"none\"."
  }
}

variable "user_risk_levels" {
  description = "User risk levels that trigger the policy. Needs Microsoft Entra ID P2 (ID Protection). Don't combine with sign_in_risk_levels."
  type        = set(string)
  default     = []
  nullable    = false

  validation {
    condition     = alltrue([for s in var.user_risk_levels : contains(["low", "medium", "high", "hidden", "none"], s)])
    error_message = "user_risk_levels entries must be \"low\", \"medium\", \"high\", \"hidden\" or \"none\"."
  }
}

variable "locations" {
  description = "Network location condition. includeLocations takes named location IDs, \"All\" or \"AllTrusted\"; excludeLocations takes named location IDs or \"AllTrusted\". null (default) leaves the condition unconfigured. Adding or removing the condition replaces the policy."
  type = object({
    includeLocations  = set(string)
    excludeLocations  = optional(set(string), [])
    exclude_locations = optional(any)
  })
  default = null

  validation {
    condition = var.locations == null || try(
      length(var.locations.includeLocations) > 0 &&
      alltrue([for s in var.locations.includeLocations : contains(["All", "AllTrusted"], s) || can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", s))]) &&
      alltrue([for s in var.locations.excludeLocations : s == "AllTrusted" || can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", s))]),
    false)
    error_message = "locations.includeLocations must be non-empty, with named location IDs, \"All\" or \"AllTrusted\"; locations.excludeLocations entries must be named location IDs or \"AllTrusted\"."
  }

  # legacy-names guard: v4.0.0 spelled these attributes in snake_case; the object type would otherwise
  # drop them and fall back to the default.
  validation {
    condition     = !can(regex("\"(exclude_locations)\":[^n]", jsonencode(var.locations)))
    error_message = "locations no longer accepts the v4.0.0 snake_case attribute names; rename them to Graph's names (exclude_locations -> excludeLocations). An old name that is silently dropped would fall back to its default."
  }
}

variable "platforms" {
  description = "Device platform condition. Entries are \"android\", \"iOS\", \"windows\", \"windowsPhone\", \"macOS\" or \"all\". \"linux\" is not accepted yet: Microsoft Graph lists it after the unknownFutureValue sentinel, so a plain read may return it as unknownFutureValue. null (default) leaves the condition unconfigured. Adding or removing the condition replaces the policy."
  type = object({
    includePlatforms  = set(string)
    excludePlatforms  = optional(set(string), [])
    exclude_platforms = optional(any)
  })
  default = null

  validation {
    condition = var.platforms == null || try(
      length(var.platforms.includePlatforms) > 0 &&
      alltrue([for s in concat(tolist(var.platforms.includePlatforms), tolist(var.platforms.excludePlatforms)) : contains(["android", "iOS", "windows", "windowsPhone", "macOS", "all"], s)]),
    false)
    error_message = "platforms.includePlatforms must be non-empty, and every platform must be \"android\", \"iOS\", \"windows\", \"windowsPhone\", \"macOS\" or \"all\"; \"linux\" is not accepted yet."
  }

  # legacy-names guard: v4.0.0 spelled these attributes in snake_case; the object type would otherwise
  # drop them and fall back to the default.
  validation {
    condition     = !can(regex("\"(exclude_platforms)\":[^n]", jsonencode(var.platforms)))
    error_message = "platforms no longer accepts the v4.0.0 snake_case attribute names; rename them to Graph's names (exclude_platforms -> excludePlatforms). An old name that is silently dropped would fall back to its default."
  }
}

variable "device_filter" {
  description = "Filter for devices (conditions.devices.deviceFilter). mode is \"include\" or \"exclude\"; rule uses the device filter rule syntax, for example device.extensionAttribute1 -ne \"SAW\". null (default) leaves the condition unconfigured. Adding or removing the filter replaces the policy."
  type = object({
    mode = string
    rule = string
  })
  default = null

  validation {
    condition     = var.device_filter == null || try(contains(["include", "exclude"], var.device_filter.mode), false)
    error_message = "device_filter.mode must be \"include\" or \"exclude\"."
  }

  validation {
    condition     = var.device_filter == null || try(length(trimspace(var.device_filter.rule)) > 0 && length(var.device_filter.rule) <= 3072, false)
    error_message = "device_filter.rule must be non-empty and at most 3072 characters."
  }
}

variable "grant_controls" {
  description = "Grant controls. operator is \"AND\" or \"OR\" (default); \"AND\" needs at least two grant controls, because Microsoft Graph stores \"OR\" for a single one. builtInControls takes \"block\", \"mfa\", \"compliantDevice\", \"domainJoinedDevice\", \"compliantApplication\" or \"passwordChange\"; \"approvedApplication\" (Require approved client app) is retired, so use \"compliantApplication\" (Require app protection policy). authentication_strength_id is the ID of an authentication strength policy and cannot be combined with mfa. termsOfUse takes terms of use agreement IDs. null (default) configures no grant controls; a policy needs grant_controls, session_controls or both. Adding or removing grant controls, or the authentication strength, replaces the policy. An authentication_strength_id that is not known at plan time, such as the id of a strength created or replaced in the same apply, also replaces an existing policy; apply in two steps or pass an id that is known at plan."
  type = object({
    operator                   = optional(string, "OR")
    builtInControls            = optional(set(string), [])
    built_in_controls          = optional(any)
    authentication_strength_id = optional(string)
    termsOfUse                 = optional(set(string), [])
    terms_of_use               = optional(any)
  })
  default = null

  validation {
    condition     = var.grant_controls == null || try(contains(["AND", "OR"], var.grant_controls.operator), false)
    error_message = "grant_controls.operator must be \"AND\" or \"OR\"."
  }

  validation {
    condition     = var.grant_controls == null || try(alltrue([for s in var.grant_controls.builtInControls : contains(["block", "mfa", "compliantDevice", "domainJoinedDevice", "compliantApplication", "passwordChange"], s)]), false)
    error_message = "grant_controls.builtInControls entries must be \"block\", \"mfa\", \"compliantDevice\", \"domainJoinedDevice\", \"compliantApplication\" or \"passwordChange\". Microsoft Entra no longer accepts a new or edited policy with \"approvedApplication\"; use \"compliantApplication\"."
  }

  validation {
    condition     = var.grant_controls == null || try(var.grant_controls.authentication_strength_id == null || can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", var.grant_controls.authentication_strength_id)), false)
    error_message = "grant_controls.authentication_strength_id must be a GUID."
  }

  validation {
    condition     = var.grant_controls == null || try(alltrue([for s in var.grant_controls.termsOfUse : can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", s))]), false)
    error_message = "grant_controls.termsOfUse entries must be terms of use agreement IDs (GUIDs)."
  }

  validation {
    condition     = var.grant_controls == null || try(length(var.grant_controls.builtInControls) + length(var.grant_controls.termsOfUse) > 0 || var.grant_controls.authentication_strength_id != null, false)
    error_message = "grant_controls must set at least one of builtInControls, authentication_strength_id or termsOfUse; use null for no grant controls."
  }

  # legacy-names guard: v4.0.0 spelled these attributes in snake_case; the object type would otherwise
  # drop them and fall back to the default.
  validation {
    condition     = !can(regex("\"(built_in_controls|terms_of_use)\":[^n]", jsonencode(var.grant_controls)))
    error_message = "grant_controls no longer accepts the v4.0.0 snake_case attribute names; rename them to Graph's names (built_in_controls -> builtInControls, terms_of_use -> termsOfUse). An old name that is silently dropped would fall back to its default."
  }
}

variable "session_controls" {
  description = "Session controls. Each attribute left unset is not configured. signInFrequency: frequencyInterval \"timeBased\" (default, needs type \"hours\" with a whole value from 1 to 23, or type \"days\" with a whole value from 1 to 365) or \"everyTime\" (no type or value); authenticationType \"primaryAndSecondaryAuthentication\" (default) or \"secondaryAuthentication\". persistent_browser_mode: \"always\" or \"never\". cloudAppSecurityType: \"mcasConfigured\", \"monitorOnly\" or \"blockDownloads\". null (default) configures no session controls; a policy needs grant_controls, session_controls or both. Adding or removing any session control replaces the policy."
  type = object({
    signInFrequency = optional(object({
      frequencyInterval   = optional(string, "timeBased")
      frequency_interval  = optional(any)
      type                = optional(string)
      value               = optional(number)
      authenticationType  = optional(string, "primaryAndSecondaryAuthentication")
      authentication_type = optional(any)
    }))
    sign_in_frequency                 = optional(any)
    persistent_browser_mode           = optional(string)
    applicationEnforcedRestrictions   = optional(bool, false)
    application_enforced_restrictions = optional(any)
    cloudAppSecurityType              = optional(string)
    cloud_app_security_type           = optional(any)
  })
  default = null

  validation {
    condition     = var.session_controls == null || try(var.session_controls.signInFrequency != null || var.session_controls.persistent_browser_mode != null || var.session_controls.applicationEnforcedRestrictions || var.session_controls.cloudAppSecurityType != null, false)
    error_message = "session_controls must configure at least one session control; use null for no session controls."
  }

  validation {
    condition = try(var.session_controls.signInFrequency, null) == null || try(
      contains(["timeBased", "everyTime"], var.session_controls.signInFrequency.frequencyInterval) &&
      contains(["primaryAndSecondaryAuthentication", "secondaryAuthentication"], var.session_controls.signInFrequency.authenticationType) &&
      (var.session_controls.signInFrequency.frequencyInterval == "everyTime"
        ? var.session_controls.signInFrequency.type == null && var.session_controls.signInFrequency.value == null
      : contains(["days", "hours"], var.session_controls.signInFrequency.type) && var.session_controls.signInFrequency.value >= 1 && floor(var.session_controls.signInFrequency.value) == var.session_controls.signInFrequency.value && var.session_controls.signInFrequency.value <= (var.session_controls.signInFrequency.type == "hours" ? 23 : 365)),
    false)
    error_message = "session_controls.signInFrequency: frequencyInterval must be \"timeBased\" or \"everyTime\" and authenticationType \"primaryAndSecondaryAuthentication\" or \"secondaryAuthentication\"; timeBased needs type \"hours\" with a whole value from 1 to 23 or type \"days\" with a whole value from 1 to 365; everyTime takes no type or value."
  }

  validation {
    condition     = try(var.session_controls.persistent_browser_mode, null) == null || try(contains(["always", "never"], var.session_controls.persistent_browser_mode), false)
    error_message = "session_controls.persistent_browser_mode must be \"always\" or \"never\"."
  }

  validation {
    condition     = try(var.session_controls.cloudAppSecurityType, null) == null || try(contains(["mcasConfigured", "monitorOnly", "blockDownloads"], var.session_controls.cloudAppSecurityType), false)
    error_message = "session_controls.cloudAppSecurityType must be \"mcasConfigured\", \"monitorOnly\" or \"blockDownloads\"."
  }

  # legacy-names guard: v4.0.0 spelled these attributes in snake_case; the object type would otherwise
  # drop them and fall back to the default.
  validation {
    condition     = !can(regex("\"(application_enforced_restrictions|authentication_type|cloud_app_security_type|frequency_interval|sign_in_frequency)\":[^n]", jsonencode(var.session_controls)))
    error_message = "session_controls no longer accepts the v4.0.0 snake_case attribute names; rename them to Graph's names (application_enforced_restrictions -> applicationEnforcedRestrictions, authentication_type -> authenticationType, cloud_app_security_type -> cloudAppSecurityType, frequency_interval -> frequencyInterval, sign_in_frequency -> signInFrequency). An old name that is silently dropped would fall back to its default."
  }
}

variable "api_version" {
  description = "Microsoft Graph API version. Only \"v1.0\" is supported; Microsoft does not support beta APIs in production."
  type        = string
  default     = "v1.0"
  nullable    = false

  validation {
    condition     = var.api_version == "v1.0"
    error_message = "api_version must be \"v1.0\"; only \"v1.0\" is supported."
  }
}

variable "timeouts" {
  description = "Timeouts for creating, reading, updating and deleting the policy, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". create, update and delete default to \"10m\" and must be at least \"15s\": after each request the provider waits for three consistent reads 5 seconds apart within the same timeout. read defaults to null, which keeps the provider's default read timeout. Retries count against these timeouts."
  type = object({
    create = optional(string, "10m")
    read   = optional(string)
    update = optional(string, "10m")
    delete = optional(string, "10m")
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.read, var.timeouts.update, var.timeouts.delete] :
      t == null || (can(regex("^([0-9]+[hms])+$", t)) && !can(regex("^(0+[hms])+$", t)))
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.update, var.timeouts.delete] :
      try(sum([for m in regexall("([0-9]+)([hms])", t) : tonumber(m[0]) * lookup({ h = 3600, m = 60, s = 1 }, m[1])]) >= 15, true)
    ])
    error_message = "timeouts.create, timeouts.update and timeouts.delete must be at least \"15s\": after each request the provider waits for three consistent reads 5 seconds apart within the same timeout."
  }
}

variable "name_pattern" {
  description = "Regular expression (RE2 syntax, not anchored unless it says so) that displayName must match, such as the pattern of a naming convention. When it is set and displayName does not match, the plan fails. Null, the default, accepts any displayName."
  type        = string
  default     = null

  validation {
    condition     = var.name_pattern == null || can(regexall(var.name_pattern, ""))
    error_message = "name_pattern must be a valid regular expression (RE2 syntax)."
  }
}

variable "licence_check" {
  description = "Opt-in plan-time licence check. When true, the plan reads the tenant's subscribedSkus (GET /subscribedSkus) and fails unless a subscription with enabled prepaid units lists Microsoft Entra ID P1 (a P2 subscription also qualifies). It needs Organization.Read.All or LicenseAssignment.Read.All, only while it is true. When false, the default, nothing is read and no extra permission is needed."
  type        = bool
  default     = false
  nullable    = false
}
