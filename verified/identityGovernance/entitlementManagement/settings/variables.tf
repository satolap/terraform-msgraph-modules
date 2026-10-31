variable "externalUserLifecycleAction" {
  description = "What entitlement management does to an external user (guest) when their last access package assignment is removed (externalUserLifecycleAction): \"none\" (keep the guest), \"blockSignIn\" (block sign-in, keep the account) or \"blockSignInAndDelete\" (block sign-in, then delete the account after the duration). The default null leaves the setting unmanaged: it is omitted from the request and never changed or restored. unknownFutureValue is not accepted. Microsoft's Update example writes the value as \"None\" while the reference lists \"none\"; the module sends the listed lowerCamel spelling, which awaits live confirmation."
  type        = string
  default     = null

  validation {
    condition     = var.externalUserLifecycleAction == null ? true : contains(["none", "blockSignIn", "blockSignInAndDelete"], var.externalUserLifecycleAction)
    error_message = "externalUserLifecycleAction must be null, \"none\", \"blockSignIn\" or \"blockSignInAndDelete\"."
  }
}

variable "durationUntilExternalUserDeletedAfterBlocked" {
  description = "How long a blocked external user is kept before the account is deleted (durationUntilExternalUserDeletedAfterBlocked), as an ISO 8601 duration in whole days, for example \"P30D\". Microsoft documents it only for externalUserLifecycleAction = \"blockSignInAndDelete\" and describes it as typically many days; the permitted range and the portal default are undocumented. The default null leaves it unmanaged: omitted from the request, never changed or restored. The module cannot clear it, because Microsoft documents no clearing value."
  type        = string
  default     = null

  validation {
    condition     = var.durationUntilExternalUserDeletedAfterBlocked == null ? true : can(regex("^P[1-9][0-9]*D$", var.durationUntilExternalUserDeletedAfterBlocked))
    error_message = "durationUntilExternalUserDeletedAfterBlocked must be null or a whole number of days of at least one in ISO 8601 form without leading zeros, for example \"P30D\". Leading zeros are rejected because the service may return the normalized form and every plan would then show a difference."
  }

  validation {
    condition     = var.durationUntilExternalUserDeletedAfterBlocked == null ? true : var.externalUserLifecycleAction == "blockSignInAndDelete"
    error_message = "durationUntilExternalUserDeletedAfterBlocked applies only with externalUserLifecycleAction = \"blockSignInAndDelete\"."
  }
}

variable "allow_external_user_deletion" {
  description = "Explicit acknowledgement that externalUserLifecycleAction = \"blockSignInAndDelete\" makes the service delete guest accounts, with the data and access they hold, once the duration passes after their last assignment ends. Required for that action, and also for a restore whose snapshot holds that action; it changes nothing else. The action applies to every existing and future guest whose last assignment is removed, not only those of one access package."
  type        = bool
  default     = false
  nullable    = false
}

variable "restore_previous_state" {
  description = "When true, PATCH the settings this module owns (the inputs that are not null) back to the values captured when the module first applied, instead of the input values. Apply with true first, then destroy or remove the inputs: destroying sends no request and leaves the settings as last set. Settings whose input is null are not owned and are never restored, and neither is a setting that became owned only after the first apply. A restore fails if it would overwrite a value that someone changed since (see restore_over_changes), and if it would write blockSignInAndDelete without allow_external_user_deletion."
  type        = bool
  default     = false
  nullable    = false
}

variable "restore_over_changes" {
  description = "A restore fails when a property it would write no longer holds either the value the current inputs apply or the snapshot value, because someone changed it in between. true restores the snapshot over those changes. The inputs are those of the restoring run, so keep them unchanged while restoring."
  type        = bool
  default     = false
  nullable    = false
}
