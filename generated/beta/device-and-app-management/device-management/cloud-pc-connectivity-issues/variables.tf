variable "device_id" {
  description = "The Intune DeviceId of the device the connection is associated with."
  type        = string
  default     = null
}

variable "error_code" {
  description = "The error code of the connectivity issue."
  type        = string
  default     = null
}

variable "error_date_time" {
  description = "The time that the connection initiated. The time is shown in ISO 8601 format and Coordinated Universal Time (UTC) time."
  type        = string
  default     = null
}

variable "error_description" {
  description = "The detailed description of what went wrong."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.cloudPCConnectivityIssue"
  nullable    = false
}

variable "recommended_action" {
  description = "The recommended action to fix the corresponding error."
  type        = string
  default     = null
}

variable "user_id" {
  description = "The unique id of user who initialize the connection."
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
