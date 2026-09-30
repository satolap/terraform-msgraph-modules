variable "display_name" {
  description = "Display name of the Conditional Access policy."
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.display_name)) > 0
    error_message = "display_name must not be empty."
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
  description = "Object IDs of the emergency access (break-glass) users, each a lowercase GUID, at least one. The module adds them to conditions.users.excludeUsers in every state; they must not appear in users.include_users. A planned emergency access guard module (not yet released) is meant to supply these IDs."
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
  description = "Object IDs of emergency access security groups, each a lowercase GUID. The module adds them to conditions.users.excludeGroups in every state; they must not appear in users.include_groups. A planned emergency access guard module (not yet released) is meant to supply these IDs."
  type        = set(string)
  default     = []
  nullable    = false

  validation {
    condition     = alltrue([for id in var.break_glass_group_ids : can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", id))])
    error_message = "break_glass_group_ids must contain lowercase GUIDs as Microsoft Graph returns them."
  }
}

variable "users" {
  description = "Users, groups and directory roles in and out of scope. include_users takes user object IDs or one of \"All\", \"None\", \"GuestsOrExternalUsers\"; exclude_users takes user object IDs or \"GuestsOrExternalUsers\"; groups take group object IDs; roles take directory role template IDs. The break-glass inputs are added to the exclusions."
  type = object({
    include_users  = optional(set(string), [])
    exclude_users  = optional(set(string), [])
    include_groups = optional(set(string), [])
    exclude_groups = optional(set(string), [])
    include_roles  = optional(set(string), [])
    exclude_roles  = optional(set(string), [])
  })
  nullable = false

  validation {
    condition     = alltrue([for s in var.users.include_users : contains(["All", "None", "GuestsOrExternalUsers"], s) || can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", s))])
    error_message = "users.include_users entries must be user object IDs or one of \"All\", \"None\", \"GuestsOrExternalUsers\"."
  }

  validation {
    condition     = alltrue([for s in var.users.exclude_users : s == "GuestsOrExternalUsers" || can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", s))])
    error_message = "users.exclude_users entries must be user object IDs or \"GuestsOrExternalUsers\"."
  }

  validation {
    condition     = alltrue([for s in concat(tolist(var.users.include_groups), tolist(var.users.exclude_groups), tolist(var.users.include_roles), tolist(var.users.exclude_roles)) : can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", s))])
    error_message = "users group entries must be group object IDs and role entries must be directory role template IDs (GUIDs)."
  }

  validation {
    condition     = length(var.users.include_users) + length(var.users.include_groups) + length(var.users.include_roles) > 0
    error_message = "users must include at least one user, group or role; use include_users = [\"None\"] for a policy that targets nobody."
  }
}

variable "applications" {
  description = "Target resources. include_applications takes application (client) IDs or one of \"All\", \"None\", \"Office365\", \"MicrosoftAdminPortals\"; exclude_applications takes application IDs, \"Office365\" or \"MicrosoftAdminPortals\"; include_user_actions takes \"urn:user:registersecurityinfo\" or \"urn:user:registerdevice\"; include_authentication_context_class_references takes authentication context IDs such as \"c1\". Exactly one of include_applications, include_user_actions and include_authentication_context_class_references must be non-empty."
  type = object({
    include_applications                            = optional(set(string), [])
    exclude_applications                            = optional(set(string), [])
    include_user_actions                            = optional(set(string), [])
    include_authentication_context_class_references = optional(set(string), [])
  })
  nullable = false

  validation {
    condition     = alltrue([for s in var.applications.include_applications : contains(["All", "None", "Office365", "MicrosoftAdminPortals"], s) || can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", s))])
    error_message = "applications.include_applications entries must be application IDs or one of \"All\", \"None\", \"Office365\", \"MicrosoftAdminPortals\"."
  }

  validation {
    condition     = alltrue([for s in var.applications.exclude_applications : contains(["Office365", "MicrosoftAdminPortals"], s) || can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", s))])
    error_message = "applications.exclude_applications entries must be application IDs or one of \"Office365\", \"MicrosoftAdminPortals\"."
  }

  validation {
    condition     = alltrue([for s in var.applications.include_user_actions : contains(["urn:user:registersecurityinfo", "urn:user:registerdevice"], s)])
    error_message = "applications.include_user_actions entries must be \"urn:user:registersecurityinfo\" or \"urn:user:registerdevice\"."
  }

  validation {
    condition     = alltrue([for s in var.applications.include_authentication_context_class_references : can(regex("^c([1-9]|[1-9][0-9])$", s))])
    error_message = "applications.include_authentication_context_class_references entries must be authentication context IDs from \"c1\" to \"c99\"."
  }

  validation {
    condition     = (length(var.applications.include_applications) > 0 ? 1 : 0) + (length(var.applications.include_user_actions) > 0 ? 1 : 0) + (length(var.applications.include_authentication_context_class_references) > 0 ? 1 : 0) == 1
    error_message = "applications must set exactly one of include_applications, include_user_actions or include_authentication_context_class_references; the target selectors are mutually exclusive."
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
  description = "Network location condition. include_locations takes named location IDs, \"All\" or \"AllTrusted\"; exclude_locations takes named location IDs or \"AllTrusted\". null (default) leaves the condition unconfigured. Adding or removing the condition replaces the policy."
  type = object({
    include_locations = set(string)
    exclude_locations = optional(set(string), [])
  })
  default = null

  validation {
    condition = var.locations == null || try(
      length(var.locations.include_locations) > 0 &&
      alltrue([for s in var.locations.include_locations : contains(["All", "AllTrusted"], s) || can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", s))]) &&
      alltrue([for s in var.locations.exclude_locations : s == "AllTrusted" || can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", s))]),
    false)
    error_message = "locations.include_locations must be non-empty, with named location IDs, \"All\" or \"AllTrusted\"; locations.exclude_locations entries must be named location IDs or \"AllTrusted\"."
  }
}

variable "platforms" {
  description = "Device platform condition. Entries are \"android\", \"iOS\", \"windows\", \"windowsPhone\", \"macOS\" or \"all\". \"linux\" is not accepted yet: Microsoft Graph lists it after the unknownFutureValue sentinel, so a plain read may return it as unknownFutureValue. null (default) leaves the condition unconfigured. Adding or removing the condition replaces the policy."
  type = object({
    include_platforms = set(string)
    exclude_platforms = optional(set(string), [])
  })
  default = null

  validation {
    condition = var.platforms == null || try(
      length(var.platforms.include_platforms) > 0 &&
      alltrue([for s in concat(tolist(var.platforms.include_platforms), tolist(var.platforms.exclude_platforms)) : contains(["android", "iOS", "windows", "windowsPhone", "macOS", "all"], s)]),
    false)
    error_message = "platforms.include_platforms must be non-empty, and every platform must be \"android\", \"iOS\", \"windows\", \"windowsPhone\", \"macOS\" or \"all\"; \"linux\" is not accepted yet."
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
  description = "Grant controls. operator is \"AND\" or \"OR\" (default). built_in_controls takes \"block\", \"mfa\", \"compliantDevice\", \"domainJoinedDevice\", \"compliantApplication\" or \"passwordChange\"; \"approvedApplication\" (Require approved client app) is retired, so use \"compliantApplication\" (Require app protection policy). authentication_strength_id is the ID of an authentication strength policy and cannot be combined with mfa. terms_of_use takes terms of use agreement IDs. null (default) configures no grant controls; a policy needs grant_controls, session_controls or both. Adding or removing grant controls, or the authentication strength, replaces the policy. An authentication_strength_id that is not known at plan time, such as the id of a strength created or replaced in the same apply, also replaces an existing policy; apply in two steps or pass an id that is known at plan."
  type = object({
    operator                   = optional(string, "OR")
    built_in_controls          = optional(set(string), [])
    authentication_strength_id = optional(string)
    terms_of_use               = optional(set(string), [])
  })
  default = null

  validation {
    condition     = var.grant_controls == null || try(contains(["AND", "OR"], var.grant_controls.operator), false)
    error_message = "grant_controls.operator must be \"AND\" or \"OR\"."
  }

  validation {
    condition     = var.grant_controls == null || try(alltrue([for s in var.grant_controls.built_in_controls : contains(["block", "mfa", "compliantDevice", "domainJoinedDevice", "compliantApplication", "passwordChange"], s)]), false)
    error_message = "grant_controls.built_in_controls entries must be \"block\", \"mfa\", \"compliantDevice\", \"domainJoinedDevice\", \"compliantApplication\" or \"passwordChange\". Microsoft Entra no longer accepts a new or edited policy with \"approvedApplication\"; use \"compliantApplication\"."
  }

  validation {
    condition     = var.grant_controls == null || try(var.grant_controls.authentication_strength_id == null || can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", var.grant_controls.authentication_strength_id)), false)
    error_message = "grant_controls.authentication_strength_id must be a GUID."
  }

  validation {
    condition     = var.grant_controls == null || try(alltrue([for s in var.grant_controls.terms_of_use : can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", s))]), false)
    error_message = "grant_controls.terms_of_use entries must be terms of use agreement IDs (GUIDs)."
  }

  validation {
    condition     = var.grant_controls == null || try(length(var.grant_controls.built_in_controls) + length(var.grant_controls.terms_of_use) > 0 || var.grant_controls.authentication_strength_id != null, false)
    error_message = "grant_controls must set at least one of built_in_controls, authentication_strength_id or terms_of_use; use null for no grant controls."
  }
}

variable "session_controls" {
  description = "Session controls. Each attribute left unset is not configured. sign_in_frequency: frequency_interval \"timeBased\" (default, needs type \"hours\" with a whole value from 1 to 23, or type \"days\" with a whole value from 1 to 365) or \"everyTime\" (no type or value); authentication_type \"primaryAndSecondaryAuthentication\" (default) or \"secondaryAuthentication\". persistent_browser_mode: \"always\" or \"never\". cloud_app_security_type: \"mcasConfigured\", \"monitorOnly\" or \"blockDownloads\". null (default) configures no session controls; a policy needs grant_controls, session_controls or both. Adding or removing any session control replaces the policy."
  type = object({
    sign_in_frequency = optional(object({
      frequency_interval  = optional(string, "timeBased")
      type                = optional(string)
      value               = optional(number)
      authentication_type = optional(string, "primaryAndSecondaryAuthentication")
    }))
    persistent_browser_mode           = optional(string)
    application_enforced_restrictions = optional(bool, false)
    cloud_app_security_type           = optional(string)
  })
  default = null

  validation {
    condition     = var.session_controls == null || try(var.session_controls.sign_in_frequency != null || var.session_controls.persistent_browser_mode != null || var.session_controls.application_enforced_restrictions || var.session_controls.cloud_app_security_type != null, false)
    error_message = "session_controls must configure at least one session control; use null for no session controls."
  }

  validation {
    condition = try(var.session_controls.sign_in_frequency, null) == null || try(
      contains(["timeBased", "everyTime"], var.session_controls.sign_in_frequency.frequency_interval) &&
      contains(["primaryAndSecondaryAuthentication", "secondaryAuthentication"], var.session_controls.sign_in_frequency.authentication_type) &&
      (var.session_controls.sign_in_frequency.frequency_interval == "everyTime"
        ? var.session_controls.sign_in_frequency.type == null && var.session_controls.sign_in_frequency.value == null
      : contains(["days", "hours"], var.session_controls.sign_in_frequency.type) && var.session_controls.sign_in_frequency.value >= 1 && floor(var.session_controls.sign_in_frequency.value) == var.session_controls.sign_in_frequency.value && var.session_controls.sign_in_frequency.value <= (var.session_controls.sign_in_frequency.type == "hours" ? 23 : 365)),
    false)
    error_message = "session_controls.sign_in_frequency: frequency_interval must be \"timeBased\" or \"everyTime\" and authentication_type \"primaryAndSecondaryAuthentication\" or \"secondaryAuthentication\"; timeBased needs type \"hours\" with a whole value from 1 to 23 or type \"days\" with a whole value from 1 to 365; everyTime takes no type or value."
  }

  validation {
    condition     = try(var.session_controls.persistent_browser_mode, null) == null || try(contains(["always", "never"], var.session_controls.persistent_browser_mode), false)
    error_message = "session_controls.persistent_browser_mode must be \"always\" or \"never\"."
  }

  validation {
    condition     = try(var.session_controls.cloud_app_security_type, null) == null || try(contains(["mcasConfigured", "monitorOnly", "blockDownloads"], var.session_controls.cloud_app_security_type), false)
    error_message = "session_controls.cloud_app_security_type must be \"mcasConfigured\", \"monitorOnly\" or \"blockDownloads\"."
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
