variable "device_configuration_id" {
  description = "The unique identifier of deviceConfiguration"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.device_configuration_id)) > 0
    error_message = "device_configuration_id must not be empty."
  }
}

variable "devices_count" {
  description = "Devices count for that user."
  type        = number
  default     = null
}

variable "last_reported_date_time" {
  description = "Last modified date time of the policy report."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceConfigurationUserStatus"
  nullable    = false
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["unknown", "notApplicable", "compliant", "remediated", "nonCompliant", "error", "conflict", "notAssigned"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "user_display_name" {
  description = "User name of the DevicePolicyStatus."
  type        = string
  default     = null
}

variable "user_principal_name" {
  description = "UserPrincipalName."
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
