variable "device_compliance_script_id" {
  description = "The unique identifier of deviceComplianceScript"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.device_compliance_script_id)) > 0
    error_message = "device_compliance_script_id must not be empty."
  }
}

variable "detection_state" {
  description = "Indicates the type of execution status of the device management script."
  type        = string
  default     = null

  validation {
    condition     = var.detection_state == null ? true : contains(["unknown", "success", "fail", "scriptError", "pending", "notApplicable"], var.detection_state)
    error_message = "detection_state must be one of the documented enum values."
  }
}

variable "expected_state_update_date_time" {
  description = "The next timestamp of when the device compliance script is expected to execute"
  type        = string
  default     = null
}

variable "last_state_update_date_time" {
  description = "The last timestamp of when the device compliance script executed"
  type        = string
  default     = null
}

variable "last_sync_date_time" {
  description = "The last time that Intune Managment Extension synced with Intune"
  type        = string
  default     = null
}

variable "managed_device" {
  description = "The managed device on which the device compliance script executed"
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceComplianceScriptDeviceState"
  nullable    = false
}

variable "script_error" {
  description = "Error from the detection script"
  type        = string
  default     = null
}

variable "script_output" {
  description = "Output of the detection script"
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
