variable "enable_destroy_cleanup" {
  description = "Register provider-native destroy cleanup. Keep true for real deployments. Set false only before the first apply when an external owner handles removal, or in offline tests. Changing true to false runs the registered removal action."
  type        = bool
  default     = true
}

variable "assignment_type" {
  description = "Kind of PIM assignment. \"eligible\" makes the principal eligible for the role (roleEligibilityScheduleRequests); \"active\" assigns the role as active through PIM, time-bound or permanent (roleAssignmentScheduleRequests)."
  type        = string

  validation {
    condition     = contains(["eligible", "active"], var.assignment_type)
    error_message = "assignment_type must be one of \"eligible\" or \"active\"."
  }
}

variable "principalId" {
  description = "Object ID of the user or role-assignable group that receives the assignment. A service principal is supported only for an active, time-limited assignment (expiration_type afterDateTime or afterDuration); eligible or permanent service-principal assignments are outside this contract. The caller must establish the principal type; this module does not look it up."
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.principalId))
    error_message = "principalId must be an object ID (GUID)."
  }
}

variable "roleDefinitionId" {
  description = "ID of the Microsoft Entra role definition (built-in or custom) to assign. Set exactly one of roleDefinitionId and role_display_name."
  type        = string
  default     = null

  validation {
    condition     = var.roleDefinitionId == null || can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.roleDefinitionId))
    error_message = "roleDefinitionId must be a role definition ID (GUID)."
  }
}

variable "role_display_name" {
  description = "Display name of the Microsoft Entra role to assign, resolved with a read-only lookup on roleManagement/directory/roleDefinitions that must match exactly one role. Set exactly one of roleDefinitionId and role_display_name."
  type        = string
  default     = null

  validation {
    condition     = var.role_display_name == null || length(trimspace(coalesce(var.role_display_name, " "))) > 0
    error_message = "role_display_name must not be empty."
  }
}

variable "directoryScopeId" {
  description = "Scope of the assignment: \"/\" (tenant), \"/administrativeUnits/<administrative unit ID>\" or \"/<directory object ID>\" (for example an application registration)."
  type        = string
  default     = "/"

  validation {
    condition     = can(regex("^(/|/administrativeUnits/[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}|/[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})$", var.directoryScopeId))
    error_message = "directoryScopeId must be \"/\", \"/administrativeUnits/<GUID>\" or \"/<GUID>\"."
  }
}

variable "justification" {
  description = "Justification sent with the request. PIM role settings can require one."
  type        = string
  default     = "Managed by Terraform"

  validation {
    condition     = length(trimspace(var.justification)) > 0
    error_message = "justification must not be empty."
  }
}

variable "start_date_time" {
  description = "When the assignment starts, as an RFC 3339 timestamp such as 2026-11-01T00:00:00Z. Null starts it when Graph processes the request."
  type        = string
  default     = null

  validation {
    condition     = var.start_date_time == null || can(timeadd(coalesce(var.start_date_time, "x"), "0s"))
    error_message = "start_date_time must be an RFC 3339 timestamp, for example 2026-11-01T00:00:00Z."
  }
}

variable "expiration_type" {
  description = "How the assignment ends: \"noExpiration\" (permanent), \"afterDateTime\" (set end_date_time) or \"afterDuration\" (set duration). PIM role settings can refuse permanent assignments."
  type        = string
  default     = "noExpiration"

  validation {
    condition     = contains(["noExpiration", "afterDateTime", "afterDuration"], var.expiration_type)
    error_message = "expiration_type must be one of \"noExpiration\", \"afterDateTime\" or \"afterDuration\"."
  }
}

variable "end_date_time" {
  description = "End of the assignment as an RFC 3339 timestamp. Required when expiration_type is \"afterDateTime\", refused otherwise."
  type        = string
  default     = null

  validation {
    condition     = var.end_date_time == null || can(timeadd(coalesce(var.end_date_time, "x"), "0s"))
    error_message = "end_date_time must be an RFC 3339 timestamp, for example 2027-01-01T00:00:00Z."
  }
}

variable "duration" {
  description = "Length of the assignment as an ISO 8601 duration of days and time, such as \"PT8H\" or \"P30D\". Required when expiration_type is \"afterDuration\", refused otherwise."
  type        = string
  default     = null

  validation {
    condition = var.duration == null || (
      can(regex("^P([0-9]+D)?(T([0-9]+H)?([0-9]+M)?([0-9]+S)?)?$", coalesce(var.duration, "x"))) &&
      !can(regex("T$", coalesce(var.duration, "x"))) &&
      coalesce(var.duration, "x") != "P"
    )
    error_message = "duration must be an ISO 8601 duration of days, hours, minutes and seconds, such as \"PT8H\" or \"P30D\"."
  }
}

variable "verification_delay_seconds" {
  description = "Seconds to wait after submitting the request before reading the schedule back to verify it."
  type        = number
  default     = 15

  validation {
    condition     = var.verification_delay_seconds >= 0 && floor(var.verification_delay_seconds) == var.verification_delay_seconds
    error_message = "verification_delay_seconds must be a non-negative whole number."
  }
}

variable "fail_on_verification_mismatch" {
  description = "If true, fail apply unless verification finds exactly one matching schedule. A start_date_time in the future never fails the check. If false, inspect the verified output."
  type        = bool
  default     = true
}

variable "api_version" {
  description = "Microsoft Graph API version to target. One of \"v1.0\" or \"beta\"."
  type        = string
  default     = "v1.0"

  validation {
    condition     = contains(["v1.0", "beta"], var.api_version)
    error_message = "api_version must be one of \"v1.0\" or \"beta\"."
  }
}
