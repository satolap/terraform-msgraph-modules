variable "tier" {
  description = "Licence tier of the baseline: \"free\", \"p1\" or \"p2\". There is no default and no automatic detection. The free tier reads no licences; \"p1\" and \"p2\" run the shared licence guard. The tier changes no setting."
  type        = string
  nullable    = false

  validation {
    condition     = contains(["free", "p1", "p2"], var.tier)
    error_message = "tier must be one of \"free\", \"p1\" or \"p2\"."
  }
}

variable "user_consent_policy_id" {
  description = "Bare ID of the one app consent policy that governs user consent, without the managePermissionGrantsForSelf. prefix. The default allows delegated permissions classified low for apps from verified publishers or registered in this tenant. null disables user consent. microsoft-user-default-legacy is rejected. The policy must exist."
  type        = string
  default     = "microsoft-user-default-low"
  nullable    = true

  validation {
    condition     = var.user_consent_policy_id == null || !startswith(try(lower(var.user_consent_policy_id), ""), "managepermissiongrantsforself.")
    error_message = "user_consent_policy_id \"${var.user_consent_policy_id == null ? "" : var.user_consent_policy_id}\" must be the bare policy ID without the managePermissionGrantsForSelf. prefix; the module adds the prefix."
  }

  validation {
    condition     = var.user_consent_policy_id == null || try(lower(var.user_consent_policy_id), "") != "microsoft-user-default-legacy"
    error_message = "user_consent_policy_id \"${var.user_consent_policy_id == null ? "" : var.user_consent_policy_id}\" is rejected: the legacy policy lets users consent to any permission that does not need admin consent, for any app. Use microsoft-user-default-low, microsoft-user-default-recommended, a custom policy ID or null."
  }

  validation {
    condition     = var.user_consent_policy_id == null || can(regex("^[A-Za-z0-9][A-Za-z0-9._-]{0,127}$", var.user_consent_policy_id))
    error_message = "user_consent_policy_id \"${var.user_consent_policy_id == null ? "" : var.user_consent_policy_id}\" is not a valid policy ID: use 1 to 128 letters, digits, dots, underscores or hyphens, starting with a letter or digit."
  }
}

variable "allow_invites_from" {
  description = "Who can invite guests: none, adminsAndGuestInviters, adminsGuestInvitersAndAllMembers or everyone. none also blocks administrators from inviting guests."
  type        = string
  default     = "adminsAndGuestInviters"
  nullable    = false

  validation {
    condition     = contains(["none", "adminsAndGuestInviters", "adminsGuestInvitersAndAllMembers", "everyone"], var.allow_invites_from)
    error_message = "allow_invites_from \"${var.allow_invites_from}\" is not one of none, adminsAndGuestInviters, adminsGuestInvitersAndAllMembers or everyone."
  }
}

variable "guest_access" {
  description = "Guest user access level: restricted sets the Restricted Guest User role, limited sets the Guest User role. The member level is not offered."
  type        = string
  default     = "restricted"
  nullable    = false

  validation {
    condition     = contains(["restricted", "limited"], var.guest_access)
    error_message = "guest_access \"${var.guest_access}\" is not supported: use restricted or limited. The member level and raw role IDs are rejected."
  }
}

variable "allow_users_to_create_apps" {
  description = "Whether member users can register applications. null leaves the tenant value unchanged; false stops users registering apps (the Application Developer role grants it back)."
  type        = bool
  default     = null
  nullable    = true
}

variable "allow_users_to_create_tenants" {
  description = "Whether non-admin users can create tenants. null leaves the tenant value unchanged; false limits tenant creation to the Tenant Creator role."
  type        = bool
  default     = null
  nullable    = true
}

variable "restore_prior_values" {
  description = "true PATCHes the snapshot captured before the first apply back to the tenant, for every managed property whose snapshot value was not null. This is step 1 of removal; destroy alone changes nothing in the tenant."
  type        = bool
  default     = false
  nullable    = false
}

variable "restore_over_changes" {
  description = "A restore fails when a managed property no longer holds either the value the current inputs would apply or the snapshot value, because someone changed it in between. true restores the snapshot over those changes."
  type        = bool
  default     = false
  nullable    = false
}
