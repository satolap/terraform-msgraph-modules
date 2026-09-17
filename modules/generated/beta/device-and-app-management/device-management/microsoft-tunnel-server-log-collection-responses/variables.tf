variable "end_date_time" {
  description = "The end time of the logs collected"
  type        = string
  default     = null
}

variable "expiry_date_time" {
  description = "The time when the log collection is expired"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.microsoftTunnelServerLogCollectionResponse"
  nullable    = false
}

variable "request_date_time" {
  description = "The time when the log collection was requested"
  type        = string
  default     = null
}

variable "server_id" {
  description = "ID of the server the log collection is requested upon"
  type        = string
  default     = null
}

variable "size_in_bytes" {
  description = "The size of the logs in bytes"
  type        = number
  default     = null
}

variable "start_date_time" {
  description = "The start time of the logs collected"
  type        = string
  default     = null
}

variable "status" {
  description = "Enum type that represent the status of log collection"
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
