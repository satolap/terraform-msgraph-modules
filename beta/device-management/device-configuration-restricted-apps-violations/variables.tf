variable "device_configuration_id" {
  description = "Device configuration profile unique identifier, must be Guid"
  type        = string
  default     = null
}

variable "device_configuration_name" {
  description = "Device configuration profile name"
  type        = string
  default     = null
}

variable "device_name" {
  description = "Device name"
  type        = string
  default     = null
}

variable "managed_device_id" {
  description = "Managed device unique identifier, must be Guid"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.restrictedAppsViolation"
  nullable    = false
}

variable "platform_type" {
  description = "Supported platform types for policies."
  type        = string
  default     = null

  validation {
    condition     = var.platform_type == null ? true : contains(["android", "androidForWork", "iOS", "macOS", "windowsPhone81", "windows81AndLater", "windows10AndLater", "androidWorkProfile", "windows10XProfile", "androidAOSP", "all"], var.platform_type)
    error_message = "platform_type must be one of the documented enum values."
  }
}

variable "restricted_apps" {
  description = "List of violated restricted apps"
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.managedDeviceReportedApp")
    appId      = optional(string)
  }))
  default = null
}

variable "restricted_apps_state" {
  description = "Restricted apps state"
  type        = string
  default     = null

  validation {
    condition     = var.restricted_apps_state == null ? true : contains(["prohibitedApps", "notApprovedApps"], var.restricted_apps_state)
    error_message = "restricted_apps_state must be one of the documented enum values."
  }
}

variable "user_id" {
  description = "User unique identifier, must be Guid"
  type        = string
  default     = null
}

variable "user_name" {
  description = "User name"
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
