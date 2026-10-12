variable "compliant_device_count" {
  description = "Number of compliant devices"
  type        = number
  default     = null
}

variable "conflict_device_count" {
  description = "Number of conflict devices"
  type        = number
  default     = null
}

variable "device_compliance_setting_states" {
  description = "Microsoft Graph deviceComplianceSettingStates property."
  type = list(object({
    odata_type                              = optional(string, "#microsoft.graph.deviceComplianceSettingState")
    complianceGracePeriodExpirationDateTime = optional(string)
    deviceId                                = optional(string)
    deviceModel                             = optional(string)
    deviceName                              = optional(string)
    setting                                 = optional(string)
    settingName                             = optional(string)
    state                                   = optional(string)
    userEmail                               = optional(string)
    userId                                  = optional(string)
    userName                                = optional(string)
    userPrincipalName                       = optional(string)
  }))
  default = null
}

variable "error_device_count" {
  description = "Number of error devices"
  type        = number
  default     = null
}

variable "non_compliant_device_count" {
  description = "Number of NonCompliant devices"
  type        = number
  default     = null
}

variable "not_applicable_device_count" {
  description = "Number of not applicable devices"
  type        = number
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceCompliancePolicySettingStateSummary"
  nullable    = false
}

variable "platform_type" {
  description = "Supported platform types for policies."
  type        = string
  default     = null

  validation {
    condition     = var.platform_type == null ? true : contains(["android", "androidForWork", "iOS", "macOS", "windowsPhone81", "windows81AndLater", "windows10AndLater", "all"], var.platform_type)
    error_message = "platform_type must be one of the documented enum values."
  }
}

variable "remediated_device_count" {
  description = "Number of remediated devices"
  type        = number
  default     = null
}

variable "setting" {
  description = "The setting class name and property name."
  type        = string
  default     = null
}

variable "setting_name" {
  description = "Name of the setting."
  type        = string
  default     = null
}

variable "unknown_device_count" {
  description = "Number of unknown devices"
  type        = number
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
