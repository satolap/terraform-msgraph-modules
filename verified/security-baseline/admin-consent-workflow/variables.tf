variable "tier" {
  description = "Licence tier of the security baseline: \"free\", \"p1\" (Microsoft Entra ID P1) or \"p2\" (Microsoft Entra ID P2). This module configures nothing premium and the value changes no setting. For free the plan reads no licences; for p1 and p2 it fails unless the tenant has a usable subscription for the tier. There is no default."
  type        = string
  nullable    = false

  validation {
    condition     = contains(["free", "p1", "p2"], var.tier)
    error_message = "tier must be one of \"free\", \"p1\" or \"p2\"."
  }
}

variable "enabled" {
  description = "Turn the admin consent workflow on (isEnabled). Enabling it blocks no one: it only gives users who cannot consent a way to request an app. When true, at least one reviewer is required unless restore_previous_state is true."
  type        = bool
  default     = true
  nullable    = false
}

variable "reviewer_user_ids" {
  description = "Object IDs of users who review consent requests, each a lowercase GUID without duplicates. Rendered as { query = \"/users/<id>\", queryType = \"MicrosoftGraph\" }. Being a reviewer grants no privileges."
  type        = list(string)
  default     = []
  nullable    = false

  validation {
    condition     = alltrue([for id in var.reviewer_user_ids : can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", id))])
    error_message = "reviewer_user_ids must contain lowercase GUIDs as Microsoft Graph returns them."
  }

  validation {
    condition     = length(distinct(var.reviewer_user_ids)) == length(var.reviewer_user_ids)
    error_message = "reviewer_user_ids must not contain duplicate IDs."
  }
}

variable "reviewer_group_ids" {
  description = "Object IDs of groups whose members review consent requests, each a lowercase GUID without duplicates. Rendered as { query = \"/groups/<id>/transitiveMembers\", queryType = \"MicrosoftGraph\" }, the form Microsoft documents for access review reviewers; its use in this policy awaits live confirmation. Being a reviewer grants no privileges."
  type        = list(string)
  default     = []
  nullable    = false

  validation {
    condition     = alltrue([for id in var.reviewer_group_ids : can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", id))])
    error_message = "reviewer_group_ids must contain lowercase GUIDs as Microsoft Graph returns them."
  }

  validation {
    condition     = length(distinct(var.reviewer_group_ids)) == length(var.reviewer_group_ids)
    error_message = "reviewer_group_ids must not contain duplicate IDs."
  }
}

variable "notify_reviewers" {
  description = "Send reviewers email notifications of new requests (notifyReviewers). Turning this off also stops the emails that tell requesters about decisions."
  type        = bool
  default     = true
  nullable    = false
}

variable "reminders_enabled" {
  description = "Send reviewers reminder emails (remindersEnabled)."
  type        = bool
  default     = true
  nullable    = false
}

variable "request_duration_in_days" {
  description = "Days a request stays active before it expires without a decision (requestDurationInDays), a whole number from 1 to 30. Microsoft Learn documents neither the range nor the portal default; both are unverified until the live run."
  type        = number
  default     = 30
  nullable    = false

  validation {
    condition     = var.request_duration_in_days >= 1 && var.request_duration_in_days <= 30 && floor(var.request_duration_in_days) == var.request_duration_in_days
    error_message = "request_duration_in_days must be a whole number from 1 to 30."
  }
}

variable "restore_previous_state" {
  description = "When true, PUT the policy captured when the module first applied instead of the other inputs. Apply with true first, then destroy: destroying sends no request and leaves the settings as last set."
  type        = bool
  default     = false
  nullable    = false
}
