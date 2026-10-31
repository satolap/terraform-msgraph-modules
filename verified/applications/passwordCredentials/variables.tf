variable "application-id" {
  description = "Application object ID (not its application/client ID). The module creates a new password and never adopts an existing credential."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("(?i)^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.application-id))
    error_message = "application-id must be an application object ID (a GUID)."
  }
}

variable "displayName" {
  description = "Friendly name of this password. This module requires 1-256 characters with no leading or trailing whitespace; this is a module policy, not a documented Graph limit. Changing it replaces the password."
  type        = string
  nullable    = false

  validation {
    condition     = alltrue([length(var.displayName) > 0, length(var.displayName) <= 256, trimspace(var.displayName) == var.displayName])
    error_message = "displayName must contain 1-256 characters and no leading or trailing whitespace."
  }
}

variable "startDateTime" {
  description = "UTC RFC3339 time when the password becomes valid; null lets Graph use now. A future start can leave an authentication gap after rotation. Changing it replaces the password."
  type        = string
  default     = null

  validation {
    condition     = var.startDateTime == null ? true : can(regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}(\\.[0-9]{1,9})?Z$", var.startDateTime)) ? can(timecmp(var.startDateTime, var.startDateTime)) : false
    error_message = "startDateTime must be null or a valid UTC RFC3339 timestamp ending in Z."
  }
}

variable "endDateTime" {
  description = "UTC RFC3339 expiration. Null uses Graph's documented startDateTime + 2 years default. An explicit end requires an explicit start and must follow it and be in the future at plan time (module policy); Learn states no other universal lifetime limit, and tenant policy can reject it. Changing it replaces the password."
  type        = string
  default     = null

  validation {
    condition     = var.endDateTime == null ? true : can(regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}(\\.[0-9]{1,9})?Z$", var.endDateTime)) ? can(timecmp(var.endDateTime, var.endDateTime)) : false
    error_message = "endDateTime must be null or a valid UTC RFC3339 timestamp ending in Z."
  }

  validation {
    condition     = var.endDateTime == null ? true : var.startDateTime == null ? false : try(timecmp(var.endDateTime, var.startDateTime) > 0, false)
    error_message = "An explicit endDateTime requires startDateTime and must be later than it."
  }

  validation {
    condition     = var.endDateTime == null ? true : try(timecmp(var.endDateTime, plantimestamp()) > 0, false)
    error_message = "An explicit endDateTime must be in the future at plan time; rotation must not replace a working credential with an already expired password."
  }
}

variable "rotation_trigger" {
  description = "Explicit rotation token, for example a caller-managed generation number. Changing it creates and verifies a new password before removing the old one. Never put a password or other secret in this token."
  type        = string
  default     = "initial"
  nullable    = false

  validation {
    condition     = length(trimspace(var.rotation_trigger)) > 0
    error_message = "rotation_trigger must not be empty."
  }
}

variable "acknowledge_secret_in_plan_output" {
  description = "Required opt-in: msgraph 0.6.0 stores secretText in a nonsensitive resource output, so plan, show and state-show output print it in clear text. Set true only when all plan/show output is treated as secret, with no CI plan logs or PR plan comments. This acknowledgement does not redact or encrypt anything."
  type        = bool
  default     = false
  nullable    = false

  validation {
    condition     = var.acknowledge_secret_in_plan_output
    error_message = "Set acknowledge_secret_in_plan_output = true only after accepting that plan, show and state-show output expose the live password in clear text. Keep all such output secret; do not publish CI plan logs or PR plan comments."
  }
}
