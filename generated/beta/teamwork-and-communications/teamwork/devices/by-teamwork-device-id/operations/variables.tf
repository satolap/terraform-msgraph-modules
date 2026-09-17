variable "teamwork_device_id" {
  description = "The unique identifier of teamworkDevice"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.teamwork_device_id)) > 0
    error_message = "teamwork_device_id must not be empty."
  }
}

variable "completed_date_time" {
  description = "Time at which the operation reached a final state (for example, Successful, Failed, and Cancelled)."
  type        = string
  default     = null
}

variable "created_by" {
  description = "Identity of the user who created the device operation."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The UTC date and time when the device operation was created."
  type        = string
  default     = null
}

variable "error" {
  description = "Error details are available only in case of a failed status."
  type        = any
  default     = null
}

variable "last_action_by" {
  description = "Identity of the user who last modified the device operation."
  type        = any
  default     = null
}

variable "last_action_date_time" {
  description = "The UTC date and time when the device operation was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.teamworkDeviceOperation"
  nullable    = false
}

variable "operation_type" {
  description = "Microsoft Graph operationType property."
  type        = string
  default     = null

  validation {
    condition     = var.operation_type == null ? true : contains(["deviceRestart", "configUpdate", "deviceDiagnostics", "softwareUpdate", "deviceManagementAgentConfigUpdate", "remoteLogin", "remoteLogout", "unknownFutureValue"], var.operation_type)
    error_message = "operation_type must be one of the documented enum values."
  }
}

variable "started_date_time" {
  description = "Time at which the operation was started."
  type        = string
  default     = null
}

variable "status" {
  description = "The current status of the async operation, for example, Queued, Scheduled, InProgress,  Successful, Cancelled, and Failed."
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
