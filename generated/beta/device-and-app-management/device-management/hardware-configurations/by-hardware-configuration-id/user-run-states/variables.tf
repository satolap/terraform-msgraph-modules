variable "hardware_configuration_id" {
  description = "The unique identifier of hardwareConfiguration"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.hardware_configuration_id)) > 0
    error_message = "hardware_configuration_id must not be empty."
  }
}

variable "error_device_count" {
  description = "Error device count for specific user."
  type        = number
  default     = null
}

variable "failed_device_count" {
  description = "Failed device count for specific user."
  type        = number
  default     = null
}

variable "last_state_update_date_time" {
  description = "Last timestamp when the hardware configuration executed"
  type        = string
  default     = null
}

variable "not_applicable_device_count" {
  description = "Not applicable device count for specific user."
  type        = number
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.hardwareConfigurationUserState"
  nullable    = false
}

variable "pending_device_count" {
  description = "Pending device count for specific user."
  type        = number
  default     = null
}

variable "successful_device_count" {
  description = "Success device count for specific user."
  type        = number
  default     = null
}

variable "unknown_device_count" {
  description = "Unknown device count for specific user."
  type        = number
  default     = null
}

variable "upn" {
  description = "User Principal Name (UPN)."
  type        = string
  default     = null
}

variable "user_email" {
  description = "User Email address."
  type        = string
  default     = null
}

variable "user_name" {
  description = "User name"
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
