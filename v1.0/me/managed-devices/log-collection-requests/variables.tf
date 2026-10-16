variable "managed_device_id" {
  description = "The unique identifier of managedDevice"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.managed_device_id)) > 0
    error_message = "managed_device_id must not be empty."
  }
}

variable "enrolled_by_user" {
  description = "The User Principal Name (UPN) of the user that enrolled the device."
  type        = string
  default     = null
}

variable "expiration_date_time_utc" {
  description = "The DateTime of the expiration of the logs."
  type        = string
  default     = null
}

variable "initiated_by_user_principal_name" {
  description = "The UPN for who initiated the request."
  type        = string
  default     = null
}

variable "managed_device_id_2" {
  description = "Indicates Intune device unique identifier."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceLogCollectionResponse"
  nullable    = false
}

variable "received_date_time_utc" {
  description = "The DateTime the request was received."
  type        = string
  default     = null
}

variable "requested_date_time_utc" {
  description = "The DateTime of the request."
  type        = string
  default     = null
}

variable "size_in_kb" {
  description = "The size of the logs in KB. Valid values -1.79769313486232E+308 to 1.79769313486232E+308"
  type        = any
  default     = null
}

variable "status" {
  description = "AppLogUploadStatus"
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["pending", "completed", "failed", "unknownFutureValue"], var.status)
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
