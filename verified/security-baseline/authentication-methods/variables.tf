variable "tier" {
  description = "Licence tier of the security baseline: \"free\" (security defaults stay on), \"p1\" (Microsoft Entra ID P1) or \"p2\" (Microsoft Entra ID P2). No setting this module manages needs a premium licence; the tier only makes a composed baseline fail early and consistently. For p1 and p2 the plan fails unless the tenant has a usable subscription for the tier."
  type        = string
  nullable    = false

  validation {
    condition     = contains(["free", "p1", "p2"], var.tier)
    error_message = "tier must be one of \"free\", \"p1\" or \"p2\"."
  }
}

variable "break_glass_user_ids" {
  description = "Object IDs of the existing emergency access (break-glass) users, each a lowercase GUID. At least one. They are excluded from the registration campaign. The module never creates or changes these accounts."
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
  description = "Object IDs of existing emergency access security groups, each a lowercase GUID. They are excluded from the registration campaign, and FIDO2 must not exclude them."
  type        = set(string)
  default     = []
  nullable    = false

  validation {
    condition     = alltrue([for id in var.break_glass_group_ids : can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", id))])
    error_message = "break_glass_group_ids must contain lowercase GUIDs as Microsoft Graph returns them."
  }
}

variable "authenticator_include_group_id" {
  description = "Group that Microsoft Authenticator is enabled for: \"all_users\" or one group ID (one group per method, because of the policy size limits)."
  type        = string
  default     = "all_users"
  nullable    = false

  validation {
    condition     = var.authenticator_include_group_id == "all_users" || can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.authenticator_include_group_id))
    error_message = "authenticator_include_group_id must be \"all_users\" or a lowercase GUID."
  }
}

variable "authenticator_mode" {
  description = "Authentication mode of Microsoft Authenticator: \"any\" or \"push\". \"deviceBasedPush\" is refused because an Authenticator registration campaign needs Any or Push."
  type        = string
  default     = "any"
  nullable    = false

  validation {
    condition     = contains(["any", "push"], var.authenticator_mode)
    error_message = "authenticator_mode must be \"any\" or \"push\"; deviceBasedPush is refused because an Authenticator registration campaign needs Any or Push."
  }
}

variable "authenticator_show_app_name" {
  description = "State of the application name in Authenticator notifications: \"enabled\", \"disabled\" or \"default\" (Microsoft managed)."
  type        = string
  default     = "enabled"
  nullable    = false

  validation {
    condition     = contains(["enabled", "disabled", "default"], var.authenticator_show_app_name)
    error_message = "authenticator_show_app_name must be \"enabled\", \"disabled\" or \"default\"."
  }
}

variable "authenticator_show_location" {
  description = "State of the location in Authenticator notifications: \"enabled\", \"disabled\" or \"default\" (Microsoft managed)."
  type        = string
  default     = "enabled"
  nullable    = false

  validation {
    condition     = contains(["enabled", "disabled", "default"], var.authenticator_show_location)
    error_message = "authenticator_show_location must be \"enabled\", \"disabled\" or \"default\"."
  }
}

variable "fido2_include_group_id" {
  description = "Group that passkeys (FIDO2) are enabled for: \"all_users\" or one of break_glass_group_ids, so that the emergency access accounts can use passkeys."
  type        = string
  default     = "all_users"
  nullable    = false

  validation {
    condition     = var.fido2_include_group_id == "all_users" || can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.fido2_include_group_id))
    error_message = "fido2_include_group_id must be \"all_users\" or a lowercase GUID."
  }
}

variable "fido2_exclude_group_ids" {
  description = "Groups excluded from passkeys (FIDO2). Excluded users cannot register or use passkeys, so a break-glass group is refused here."
  type        = set(string)
  default     = []
  nullable    = false

  validation {
    condition     = alltrue([for id in var.fido2_exclude_group_ids : can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", id))])
    error_message = "fido2_exclude_group_ids must contain lowercase GUIDs."
  }
}

variable "fido2_self_service_registration" {
  description = "Whether users may register passkeys themselves (isSelfServiceRegistrationAllowed). Required for a passkey registration campaign."
  type        = bool
  default     = true
  nullable    = false
}

variable "campaign_state" {
  description = "State of the registration campaign: \"enabled\", \"disabled\" or \"default\" (Microsoft managed). \"enabled\" gives a deterministic configuration."
  type        = string
  default     = "enabled"
  nullable    = false

  validation {
    condition     = contains(["enabled", "disabled", "default"], var.campaign_state)
    error_message = "campaign_state must be \"enabled\", \"disabled\" or \"default\"."
  }
}

variable "campaign_method" {
  description = "Method the campaign prompts users to register: \"microsoftAuthenticator\" or \"fido2\". A campaign targets one method at a time."
  type        = string
  default     = "microsoftAuthenticator"
  nullable    = false

  validation {
    condition     = contains(["microsoftAuthenticator", "fido2"], var.campaign_method)
    error_message = "campaign_method must be \"microsoftAuthenticator\" or \"fido2\"."
  }
}

variable "campaign_include_group_id" {
  description = "Group the campaign targets: \"all_users\" or one group ID."
  type        = string
  default     = "all_users"
  nullable    = false

  validation {
    condition     = var.campaign_include_group_id == "all_users" || can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.campaign_include_group_id))
    error_message = "campaign_include_group_id must be \"all_users\" or a lowercase GUID."
  }
}

variable "campaign_snooze_days" {
  description = "Days a user can snooze the campaign prompt, 0 to 14."
  type        = number
  default     = 1
  nullable    = false

  validation {
    condition     = var.campaign_snooze_days >= 0 && var.campaign_snooze_days <= 14 && floor(var.campaign_snooze_days) == var.campaign_snooze_days
    error_message = "campaign_snooze_days must be a whole number from 0 to 14."
  }
}

variable "campaign_require_after_snoozes" {
  description = "Force registration once the allowed snoozes are used (enforceRegistrationAfterAllowedSnoozes). Restrictive, so it is opt-in. The property is documented in the registration campaign how-to but not in the v1.0 resource table."
  type        = bool
  default     = false
  nullable    = false
}

variable "phone_methods" {
  description = "What the module does with SMS and voice: \"unmanaged\" (no change, the default) or \"restrict\" (enabled only for phone_methods_group_id, SMS not usable for sign-in, office phone not allowed). \"restrict\" is refused for tier \"free\". Owner decision of 2026-10-22; \"disable\" can be added later without breaking callers."
  type        = string
  default     = "unmanaged"
  nullable    = false

  validation {
    condition     = contains(["unmanaged", "restrict"], var.phone_methods)
    error_message = "phone_methods must be \"unmanaged\" or \"restrict\"."
  }
}

variable "phone_methods_group_id" {
  description = "Group that keeps SMS and voice when phone_methods is \"restrict\". Required then; ignored otherwise."
  type        = string
  default     = null

  validation {
    condition     = var.phone_methods_group_id == null ? true : can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.phone_methods_group_id))
    error_message = "phone_methods_group_id must be a lowercase GUID."
  }
}

variable "restore_previous_state" {
  description = "Objects whose snapshot of the previous state is sent back instead of the baseline: any of \"policy\", \"microsoftAuthenticator\", \"fido2\", \"sms\", \"voice\". Restore every object, verify by read-back, then destroy: destroying an update-only resource sends no request. Restoring sms or voice works whatever phone_methods says."
  type        = set(string)
  default     = []
  nullable    = false

  validation {
    condition     = alltrue([for key in var.restore_previous_state : contains(["policy", "microsoftAuthenticator", "fido2", "sms", "voice"], key)])
    error_message = "restore_previous_state may contain only \"policy\", \"microsoftAuthenticator\", \"fido2\", \"sms\" and \"voice\"."
  }
}
