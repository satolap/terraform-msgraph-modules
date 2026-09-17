variable "device_management_intent_id" {
  description = "The unique identifier of deviceManagementIntent"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.device_management_intent_id)) > 0
    error_message = "device_management_intent_id must not be empty."
  }
}

variable "device_display_name" {
  description = "Device name that is being reported"
  type        = string
  default     = null
}

variable "device_id" {
  description = "Device id that is being reported"
  type        = string
  default     = null
}

variable "last_reported_date_time" {
  description = "Last modified date time of an intent report"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagementIntentDeviceState"
  nullable    = false
}

variable "state" {
  description = "Microsoft Graph state property."
  type        = string
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["unknown", "notApplicable", "compliant", "remediated", "nonCompliant", "error", "conflict", "notAssigned"], var.state)
    error_message = "state must be one of the documented enum values."
  }
}

variable "user_name" {
  description = "The user name that is being reported on a device"
  type        = string
  default     = null
}

variable "user_principal_name" {
  description = "The user principal name that is being reported on a device"
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
