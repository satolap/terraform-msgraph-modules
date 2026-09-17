variable "created_date_time" {
  description = "The date and time when the operation was created."
  type        = string
  default     = null
}

variable "error" {
  description = "The error if the operation failed."
  type        = any
  default     = null
}

variable "last_action_date_time" {
  description = "The date and time when this operation was most recently updated."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.approvalOperation"
  nullable    = false
}

variable "resource_location" {
  description = "The URL for the resource that was newly created or acted upon."
  type        = string
  default     = null
}

variable "status" {
  description = "The status of the operation. The possible values are: scheduled, inProgress, succeeded, failed, timeout, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["scheduled", "inProgress", "succeeded", "failed", "timeout", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
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
