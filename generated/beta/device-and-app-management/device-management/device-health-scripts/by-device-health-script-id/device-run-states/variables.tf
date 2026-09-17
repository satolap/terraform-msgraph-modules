variable "device_health_script_id" {
  description = "The unique identifier of deviceHealthScript"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.device_health_script_id)) > 0
    error_message = "device_health_script_id must not be empty."
  }
}

variable "assignment_filter_ids" {
  description = "A list of the assignment filter ids used for health script applicability evaluation"
  type        = list(string)
  default     = null
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
  description = "The next timestamp of when the device health script is expected to execute"
  type        = string
  default     = null
}

variable "last_state_update_date_time" {
  description = "The last timestamp of when the device health script executed"
  type        = string
  default     = null
}

variable "last_sync_date_time" {
  description = "The last time that Intune Managment Extension synced with Intune"
  type        = string
  default     = null
}

variable "managed_device" {
  description = "The managed device on which the device health script executed"
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceHealthScriptDeviceState"
  nullable    = false
}

variable "post_remediation_detection_script_error" {
  description = "Error from the detection script after remediation"
  type        = string
  default     = null
}

variable "post_remediation_detection_script_output" {
  description = "Detection script output after remediation"
  type        = string
  default     = null
}

variable "pre_remediation_detection_script_error" {
  description = "Error from the detection script before remediation"
  type        = string
  default     = null
}

variable "pre_remediation_detection_script_output" {
  description = "Output of the detection script before remediation"
  type        = string
  default     = null
}

variable "remediation_script_error" {
  description = "Error output of the remediation script"
  type        = string
  default     = null
}

variable "remediation_state" {
  description = "Indicates the type of execution status of the device management script."
  type        = string
  default     = null

  validation {
    condition     = var.remediation_state == null ? true : contains(["unknown", "skipped", "success", "remediationFailed", "scriptError", "unknownFutureValue"], var.remediation_state)
    error_message = "remediation_state must be one of the documented enum values."
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
