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

variable "display_name" {
  description = "The display name of the security baseline"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.securityBaselineState"
  nullable    = false
}

variable "security_baseline_template_id" {
  description = "The security baseline template id"
  type        = string
  default     = null
}

variable "setting_states" {
  description = "The security baseline state for different settings for a device"
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.securityBaselineSettingState")
    contributingPolicies = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.securityBaselineContributingPolicy")
      displayName = optional(string)
      sourceId    = optional(string)
      sourceType  = optional(string)
    })))
    errorCode           = optional(string)
    settingCategoryId   = optional(string)
    settingCategoryName = optional(string)
    settingId           = optional(string)
    settingName         = optional(string)
    sourcePolicies = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.settingSource")
      displayName = optional(string)
      id          = optional(string)
      sourceType  = optional(string)
    })))
    state = optional(string)
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

variable "user_principal_name" {
  description = "User Principal Name"
  type        = string
  default     = null
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
