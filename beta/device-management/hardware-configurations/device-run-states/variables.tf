variable "hardware_configuration_id" {
  description = "The unique identifier of hardwareConfiguration"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.hardware_configuration_id)) > 0
    error_message = "hardware_configuration_id must not be empty."
  }
}

variable "assignment_filter_ids" {
  description = "A list of identifier strings of different assignment filters applied"
  type        = string
  default     = null
}

variable "configuration_error" {
  description = "Error from the hardware configuration execution"
  type        = string
  default     = null
}

variable "configuration_output" {
  description = "Output of the hardware configuration execution"
  type        = string
  default     = null
}

variable "configuration_state" {
  description = "Indicates the type of execution status of the device management script."
  type        = string
  default     = null

  validation {
    condition     = var.configuration_state == null ? true : contains(["unknown", "success", "fail", "scriptError", "pending", "notApplicable"], var.configuration_state)
    error_message = "configuration_state must be one of the documented enum values."
  }
}

variable "device_name" {
  description = "The name of the device"
  type        = string
  default     = null
}

variable "internal_version" {
  description = "The Policy internal version"
  type        = number
  default     = null
}

variable "last_state_update_date_time" {
  description = "The last timestamp of when the hardware configuration executed"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.hardwareConfigurationDeviceState"
  nullable    = false
}

variable "os_version" {
  description = "Operating system version of the device (E.g. 10.0.19042.1165, 10.0.19042.1288 etc.)"
  type        = string
  default     = null
}

variable "upn" {
  description = "User Principal Name (UPN)."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "userId"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
