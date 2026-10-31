variable "enable_destroy_cleanup" {
  description = "Create the Azure CLI destroy hook that cancels a pending request or revokes the delivered assignment. Keep true for real deployments. Set false only before the first apply when an external owner handles removal, or in offline tests. Changing true to false runs the existing cleanup hook."
  type        = bool
  default     = true
}

variable "target_id" {
  description = "Object ID of the user who receives the assignment. The subject must already exist in the directory: this module sends assignment.targetId and does not invite external users or look the subject up. The caller must establish the subject type."
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.target_id))
    error_message = "target_id must be a user object ID (GUID)."
  }
}

variable "access_package_id" {
  description = "ID of the access package to assign. Take it from the access-packages module's id output."
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.access_package_id))
    error_message = "access_package_id must be an access package ID (GUID)."
  }
}

variable "assignment_policy_id" {
  description = "ID of the assignment policy that governs the request, which must belong to access_package_id. Take it from the assignment-policies module's id output. The policy's approval stages and custom extensions still run: this module never approves a request, bypasses a stage or impersonates the requestor, and a policy that requires approval leaves the request pending."
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.assignment_policy_id))
    error_message = "assignment_policy_id must be an assignment policy ID (GUID)."
  }
}

variable "justification" {
  description = "Justification sent with the adminAdd and adminUpdate requests. The policy can require one."
  type        = string
  default     = "Managed by Terraform"

  validation {
    condition     = length(trimspace(var.justification)) > 0
    error_message = "justification must not be empty."
  }
}

variable "schedule" {
  description = "Optional schedule sent with the adminAdd request: an optional startDateTime (RFC 3339) and an optional expiration of type \"noExpiration\", \"afterDateTime\" (set endDateTime) or \"afterDuration\" (set duration, an ISO 8601 duration of days and time such as \"P30D\"). Null sends no schedule and the policy's expiration applies. It is captured when the request is sent: a later change does not re-send it and does not replace the assignment. Use schedule_update to change the schedule of a delivered assignment."
  type = object({
    startDateTime   = optional(string)
    start_date_time = optional(any)
    expiration = optional(object({
      type          = string
      endDateTime   = optional(string)
      end_date_time = optional(any)
      duration      = optional(string)
    }))
  })
  default = null

  validation {
    condition     = var.schedule == null ? true : (var.schedule.startDateTime == null ? true : can(timeadd(coalesce(var.schedule.startDateTime, "x"), "0s")))
    error_message = "schedule.startDateTime must be an RFC 3339 timestamp, for example 2026-11-01T00:00:00Z."
  }

  validation {
    condition     = var.schedule == null ? true : (var.schedule.expiration == null ? true : contains(["noExpiration", "afterDateTime", "afterDuration"], var.schedule.expiration.type))
    error_message = "schedule.expiration.type must be one of \"noExpiration\", \"afterDateTime\" or \"afterDuration\"."
  }

  validation {
    condition     = var.schedule == null ? true : (var.schedule.expiration == null ? true : ((var.schedule.expiration.type == "afterDateTime") == (var.schedule.expiration.endDateTime != null) && (var.schedule.expiration.type == "afterDuration") == (var.schedule.expiration.duration != null)))
    error_message = "schedule.expiration.endDateTime is required for \"afterDateTime\" and duration for \"afterDuration\"; each is refused for any other type."
  }

  validation {
    condition     = var.schedule == null ? true : (var.schedule.expiration == null ? true : ((var.schedule.expiration.endDateTime == null ? true : can(timeadd(coalesce(var.schedule.expiration.endDateTime, "x"), "0s"))) && (var.schedule.expiration.duration == null ? true : (can(regex("^P([0-9]+D)?(T([0-9]+H)?([0-9]+M)?([0-9]+S)?)?$", coalesce(var.schedule.expiration.duration, "x"))) && !can(regex("T$", coalesce(var.schedule.expiration.duration, "x"))) && coalesce(var.schedule.expiration.duration, "x") != "P"))))
    error_message = "schedule.expiration.endDateTime must be an RFC 3339 timestamp and schedule.expiration.duration an ISO 8601 duration of days and time, such as \"PT8H\" or \"P30D\"."
  }

  # legacy-names guard: v4.0.0 spelled these attributes in snake_case; the object type would otherwise
  # drop them and fall back to the default.
  validation {
    condition     = !can(regex("\"(end_date_time|start_date_time)\":[^n]", jsonencode(var.schedule)))
    error_message = "schedule no longer accepts the v4.0.0 snake_case attribute names; rename them to Graph's names (end_date_time -> endDateTime, start_date_time -> startDateTime). An old name that is silently dropped would fall back to its default."
  }
}

variable "schedule_update" {
  description = "Optional adminUpdate of the delivered assignment, for example to extend it: the same shape as schedule. Setting or changing it sends one adminUpdate request for the resolved assignment ID; the update needs a delivered, resolved assignment and is refused otherwise. The update goes through the policy's approval like any request, and its own outcome is reported in update_request_phase. Null sends nothing."
  type = object({
    startDateTime   = optional(string)
    start_date_time = optional(any)
    expiration = optional(object({
      type          = string
      endDateTime   = optional(string)
      end_date_time = optional(any)
      duration      = optional(string)
    }))
  })
  default = null

  validation {
    condition     = var.schedule_update == null ? true : (var.schedule_update.startDateTime == null ? true : can(timeadd(coalesce(var.schedule_update.startDateTime, "x"), "0s")))
    error_message = "schedule_update.startDateTime must be an RFC 3339 timestamp, for example 2026-11-01T00:00:00Z."
  }

  validation {
    condition     = var.schedule_update == null ? true : (var.schedule_update.expiration == null ? true : contains(["noExpiration", "afterDateTime", "afterDuration"], var.schedule_update.expiration.type))
    error_message = "schedule_update.expiration.type must be one of \"noExpiration\", \"afterDateTime\" or \"afterDuration\"."
  }

  validation {
    condition     = var.schedule_update == null ? true : (var.schedule_update.expiration == null ? true : ((var.schedule_update.expiration.type == "afterDateTime") == (var.schedule_update.expiration.endDateTime != null) && (var.schedule_update.expiration.type == "afterDuration") == (var.schedule_update.expiration.duration != null)))
    error_message = "schedule_update.expiration.endDateTime is required for \"afterDateTime\" and duration for \"afterDuration\"; each is refused for any other type."
  }

  validation {
    condition     = var.schedule_update == null ? true : (var.schedule_update.expiration == null ? true : ((var.schedule_update.expiration.endDateTime == null ? true : can(timeadd(coalesce(var.schedule_update.expiration.endDateTime, "x"), "0s"))) && (var.schedule_update.expiration.duration == null ? true : (can(regex("^P([0-9]+D)?(T([0-9]+H)?([0-9]+M)?([0-9]+S)?)?$", coalesce(var.schedule_update.expiration.duration, "x"))) && !can(regex("T$", coalesce(var.schedule_update.expiration.duration, "x"))) && coalesce(var.schedule_update.expiration.duration, "x") != "P"))))
    error_message = "schedule_update.expiration.endDateTime must be an RFC 3339 timestamp and schedule_update.expiration.duration an ISO 8601 duration of days and time, such as \"PT8H\" or \"P30D\"."
  }

  # legacy-names guard: v4.0.0 spelled these attributes in snake_case; the object type would otherwise
  # drop them and fall back to the default.
  validation {
    condition     = !can(regex("\"(end_date_time|start_date_time)\":[^n]", jsonencode(var.schedule_update)))
    error_message = "schedule_update no longer accepts the v4.0.0 snake_case attribute names; rename them to Graph's names (end_date_time -> endDateTime, start_date_time -> startDateTime). An old name that is silently dropped would fall back to its default."
  }
}

variable "adopt_assignment_id" {
  description = "ID of an existing assignment to adopt instead of sending adminAdd. The module sends no request, checks that the assignment belongs to target_id, access_package_id and assignment_policy_id, and reports it. Use it to take over access that already exists, and to recover after the state of a first apply was lost (list the assignments for the three identities, then adopt the one found, so a second adminAdd is never sent). Null sends adminAdd."
  type        = string
  default     = null

  validation {
    condition     = var.adopt_assignment_id == null ? true : can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", coalesce(var.adopt_assignment_id, "x")))
    error_message = "adopt_assignment_id must be an assignment ID (GUID)."
  }
}

variable "revoke_adopted_assignment_on_destroy" {
  description = "Whether destroying the module revokes an adopted assignment. False leaves access that this module did not grant in place. Ignored when adopt_assignment_id is null: an assignment this module granted is always revoked on destroy."
  type        = bool
  default     = false
}

variable "replacement_token" {
  description = "Arbitrary text. Changing it revokes the current assignment and sends a new adminAdd, the supported way to re-grant access after the assignment expired or was removed outside Terraform. Revocation runs first, then the new request."
  type        = string
  default     = null
}

variable "verification_delay_seconds" {
  description = "Seconds to wait after submitting a request before reading its state and the assignment back. This is one bounded wait, not a retry loop: a request that is still pending after it is re-read by every later plan and apply."
  type        = number
  default     = 15

  validation {
    condition     = var.verification_delay_seconds >= 0 && floor(var.verification_delay_seconds) == var.verification_delay_seconds
    error_message = "verification_delay_seconds must be a non-negative whole number."
  }
}

variable "require_delivery" {
  description = "If true, fail apply unless the request is delivered and exactly one matching assignment is delivered. If false, a pending, scheduled or not yet resolvable request is reported through the outputs without failing. A denied, canceled, failed or partially delivered request, an ambiguous match and an expired assignment fail regardless."
  type        = bool
  default     = true
}
