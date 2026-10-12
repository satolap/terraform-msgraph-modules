variable "device_custom_attribute_shell_script_id" {
  description = "The unique identifier of deviceCustomAttributeShellScript"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.device_custom_attribute_shell_script_id)) > 0
    error_message = "device_custom_attribute_shell_script_id must not be empty."
  }
}

variable "error_code" {
  description = "Error code corresponding to erroneous execution of the device management script."
  type        = number
  default     = null
}

variable "error_description" {
  description = "Error description corresponding to erroneous execution of the device management script."
  type        = string
  default     = null
}

variable "last_state_update_date_time" {
  description = "Latest time the device management script executes."
  type        = string
  default     = null
}

variable "managed_device" {
  description = "The managed devices that executes the device management script."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagementScriptDeviceState"
  nullable    = false
}

variable "result_message" {
  description = "Details of execution output."
  type        = string
  default     = null
}

variable "run_state" {
  description = "Indicates the type of execution status of the device management script."
  type        = string
  default     = null

  validation {
    condition     = var.run_state == null ? true : contains(["unknown", "success", "fail", "scriptError", "pending", "notApplicable"], var.run_state)
    error_message = "run_state must be one of the documented enum values."
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
