variable "principal_id" {
  description = "Object ID of the user or group that receives eligibility for membership or ownership of the group. Lowercase GUID. The caller must establish the principal type; this module does not look it up."
  type        = string

  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.principal_id))
    error_message = "principal_id must be a lowercase object ID (GUID)."
  }
}

variable "group_id" {
  description = "Object ID of the group governed by PIM for Groups whose membership or ownership is made eligible. Lowercase GUID. The module never creates, changes or deletes the group."
  type        = string

  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.group_id))
    error_message = "group_id must be a lowercase group object ID (GUID)."
  }
}

variable "access_id" {
  description = "Which relationship to the group: \"member\" or \"owner\". There is no default so that ownership is never granted by omission."
  type        = string

  validation {
    condition     = contains(["member", "owner"], var.access_id)
    error_message = "access_id must be \"member\" or \"owner\"."
  }
}

variable "justification" {
  description = "Justification sent with the request. Required and explicit. A reworded justification is not part of the grant's identity and does not submit another request."
  type        = string

  validation {
    condition     = length(trimspace(var.justification)) > 0
    error_message = "justification must not be empty."
  }
}

variable "start_date_time" {
  description = "When the eligibility starts, as an RFC 3339 timestamp such as 2026-11-01T00:00:00Z. Required: the window is always explicit."
  type        = string

  validation {
    condition     = can(timeadd(var.start_date_time, "0s"))
    error_message = "start_date_time must be an RFC 3339 timestamp, for example 2026-11-01T00:00:00Z."
  }
}

variable "end_date_time" {
  description = "When the eligibility ends (expiration type afterDateTime), as an RFC 3339 timestamp at least five minutes after start_date_time (PIM for Groups rejects shorter windows) and at most 24 hours later. The 24-hour limit is a conservative limit of this module, not a Graph rule. Permanent, duration-based and recurring schedules are not offered."
  type        = string

  validation {
    condition = can(timeadd(var.end_date_time, "0s")) && try(alltrue([
      timecmp(timeadd(var.start_date_time, "5m"), var.end_date_time) <= 0,
      timecmp(var.end_date_time, timeadd(var.start_date_time, "24h")) <= 0,
    ]), false)
    error_message = "end_date_time must be an RFC 3339 timestamp at least five minutes after start_date_time and at most 24 hours later."
  }
}

variable "verification_delay_seconds" {
  description = "Seconds to wait after submitting the request before reading the schedule and instance back."
  type        = number
  default     = 15

  validation {
    condition     = var.verification_delay_seconds >= 0 && floor(var.verification_delay_seconds) == var.verification_delay_seconds
    error_message = "verification_delay_seconds must be a non-negative whole number."
  }
}

variable "fail_on_verification_mismatch" {
  description = "If true, fail apply while the window is open unless exactly one correlated schedule and one correlated instance are found. A start in the future or an end in the past never fails the check. If false, inspect the state output."
  type        = bool
  default     = true
}
