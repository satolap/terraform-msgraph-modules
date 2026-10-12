variable "user_id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_id)) > 0
    error_message = "user_id must not be empty."
  }
}

variable "managed_device_id" {
  description = "The unique identifier of managedDevice"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.managed_device_id)) > 0
    error_message = "managed_device_id must not be empty."
  }
}

variable "security_baseline_state_id" {
  description = "The unique identifier of securityBaselineState"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.security_baseline_state_id)) > 0
    error_message = "security_baseline_state_id must not be empty."
  }
}

variable "contributing_policies" {
  description = "The policies that contribute to this setting instance"
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.securityBaselineContributingPolicy")
    displayName = optional(string)
    sourceId    = optional(string)
    sourceType  = optional(string)
  }))
  default = null
}

variable "error_code" {
  description = "The error code if the setting is in error state"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.securityBaselineSettingState"
  nullable    = false
}

variable "setting_category_id" {
  description = "The setting category id which this setting belongs to"
  type        = string
  default     = null
}

variable "setting_category_name" {
  description = "The setting category name which this setting belongs to"
  type        = string
  default     = null
}

variable "setting_id" {
  description = "The setting id guid"
  type        = string
  default     = null
}

variable "setting_name" {
  description = "The setting name that is being reported"
  type        = string
  default     = null
}

variable "source_policies" {
  description = "The policies that contribute to this setting instance"
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.settingSource")
    displayName = optional(string)
    id          = optional(string)
    sourceType  = optional(string)
  }))
  default = null
}

variable "state" {
  description = "Security Baseline Compliance State"
  type        = string
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["unknown", "secure", "notApplicable", "notSecure", "error", "conflict"], var.state)
    error_message = "state must be one of the documented enum values."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
