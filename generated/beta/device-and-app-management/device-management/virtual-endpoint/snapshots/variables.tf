variable "cloud_pc_id" {
  description = "The unique identifier for the Cloud PC."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "The date and time at which the snapshot was taken. The timestamp is shown in ISO 8601 format and Coordinated Universal Time (UTC). For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "expiration_date_time" {
  description = "The date and time when the snapshot expires. The timestamp is shown in ISO 8601 format and Coordinated Universal Time (UTC). For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "last_restored_date_time" {
  description = "The date and time at which the snapshot was last used to restore the Cloud PC device. The timestamp is shown in ISO 8601 format and Coordinated Universal Time (UTC). For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.cloudPcSnapshot"
  nullable    = false
}

variable "snapshot_type" {
  description = "The type of snapshot that indicates how to create the snapshot. Possible values are automatic, manual, unknownFutureValue, retention. Use the Prefer: include-unknown-enum-members request header to get the following members from this evolvable enum: retention. The default value is automatic."
  type        = any
  default     = null

  validation {
    condition     = var.snapshot_type == null ? true : contains(["automatic", "manual", "unknownFutureValue", "retention"], var.snapshot_type)
    error_message = "snapshot_type must be one of the documented enum values."
  }
}

variable "status" {
  description = "The status of the Cloud PC snapshot. The possible values are: ready, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["ready", "unknownFutureValue"], var.status)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["healthCheckStatus", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
