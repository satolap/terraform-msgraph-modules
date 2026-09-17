variable "created_date_time" {
  description = "Indicates the creation date and time for the custom device scope."
  type        = string
  default     = null
}

variable "device_scope_name" {
  description = "The name of the user experience analytics device Scope configuration."
  type        = string
  default     = null
}

variable "enabled" {
  description = "Indicates whether a device scope is enabled or disabled. When TRUE, the device scope is enabled. When FALSE, the device scope is disabled. Default value is FALSE."
  type        = bool
  default     = null
}

variable "is_built_in" {
  description = "Indicates whether the device scope configuration is built-in or custom. When TRUE, the device scope configuration is built-in. When FALSE, the device scope configuration is custom. Default value is FALSE."
  type        = bool
  default     = null
}

variable "last_modified_date_time" {
  description = "Indicates the last updated date and time for the custom device scope."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.userExperienceAnalyticsDeviceScope"
  nullable    = false
}

variable "operator" {
  description = "Device scope configuration query operator. Possible values are: equals, notEquals, contains, notContains, greaterThan, lessThan. Default value: equals."
  type        = string
  default     = null

  validation {
    condition     = var.operator == null ? true : contains(["none", "equals", "unknownFutureValue"], var.operator)
    error_message = "operator must be one of the documented enum values."
  }
}

variable "owner_id" {
  description = "The unique identifier of the person (admin) who created the device scope configuration."
  type        = string
  default     = null
}

variable "parameter" {
  description = "Device scope configuration parameter. It will be expend in future to add more parameter. Eg: device scope parameter can be OS version, Disk Type, Device manufacturer, device model or Scope tag. Default value: scopeTag."
  type        = string
  default     = null

  validation {
    condition     = var.parameter == null ? true : contains(["none", "scopeTag", "unknownFutureValue"], var.parameter)
    error_message = "parameter must be one of the documented enum values."
  }
}

variable "status" {
  description = "Indicates the device scope status after the device scope has been enabled. Possible values are: none, computing, insufficientData or completed. Default value is none."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["none", "computing", "insufficientData", "completed", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "value" {
  description = "The device scope configuration query clause value."
  type        = string
  default     = null
}

variable "value_object_id" {
  description = "The unique identifier for a user device scope tag Id used for the creation of device scope configuration."
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
