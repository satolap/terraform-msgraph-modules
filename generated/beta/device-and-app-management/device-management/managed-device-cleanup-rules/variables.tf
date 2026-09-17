variable "description" {
  description = "Indicates the description for the device clean up rule."
  type        = string
  default     = null
}

variable "device_cleanup_rule_platform_type" {
  description = "Define the platform type for which the admin wants to create the device clean up rule"
  type        = string
  default     = null

  validation {
    condition     = var.device_cleanup_rule_platform_type == null ? true : contains(["all", "androidAOSP", "androidDeviceAdministrator", "androidDedicatedAndFullyManagedCorporateOwnedWorkProfile", "chromeOS", "androidPersonallyOwnedWorkProfile", "ios", "macOS", "windows", "windowsHolographic", "unknownFutureValue", "visionOS", "tvOS"], var.device_cleanup_rule_platform_type)
    error_message = "device_cleanup_rule_platform_type must be one of the documented enum values."
  }
}

variable "device_inactivity_before_retirement_in_days" {
  description = "Indicates the number of days when the device has not contacted Intune. Valid values 0 to 2147483647"
  type        = number
  default     = null
}

variable "display_name" {
  description = "Indicates the display name of the device cleanup rule."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedDeviceCleanupRule"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "lastModifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
