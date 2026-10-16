variable "device_management_intent_id" {
  description = "The unique identifier of deviceManagementIntent"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.device_management_intent_id)) > 0
    error_message = "device_management_intent_id must not be empty."
  }
}

variable "compliant_count" {
  description = "Number of compliant devices"
  type        = number
  default     = null
}

variable "conflict_count" {
  description = "Number of devices in conflict"
  type        = number
  default     = null
}

variable "error_count" {
  description = "Number of error devices"
  type        = number
  default     = null
}

variable "non_compliant_count" {
  description = "Number of non compliant devices"
  type        = number
  default     = null
}

variable "not_applicable_count" {
  description = "Number of not applicable devices"
  type        = number
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagementIntentDeviceSettingStateSummary"
  nullable    = false
}

variable "remediated_count" {
  description = "Number of remediated devices"
  type        = number
  default     = null
}

variable "setting_name" {
  description = "Name of a setting"
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
