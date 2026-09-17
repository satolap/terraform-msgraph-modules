variable "device_management_script_id" {
  description = "The unique identifier of deviceManagementScript"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.device_management_script_id)) > 0
    error_message = "device_management_script_id must not be empty."
  }
}

variable "device_run_states" {
  description = "List of run states for this script across all devices of specific user."
  type = list(object({
    odata_type              = optional(string, "#microsoft.graph.deviceManagementScriptDeviceState")
    errorCode               = optional(number)
    errorDescription        = optional(string)
    lastStateUpdateDateTime = optional(string)
    managedDevice           = optional(any)
    resultMessage           = optional(string)
    runState                = optional(string)
  }))
  default = null
}

variable "error_device_count" {
  description = "Error device count for specific user."
  type        = number
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagementScriptUserState"
  nullable    = false
}

variable "success_device_count" {
  description = "Success device count for specific user."
  type        = number
  default     = null
}

variable "user_principal_name" {
  description = "User principle name of specific user."
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
