variable "backup_size_in_bytes" {
  description = "The size of the backup in bytes."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "The date and time when the browse session was created. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "error" {
  description = "Contains the error details if the browse session creation fails."
  type        = any
  default     = null
}

variable "expiration_date_time" {
  description = "The date and time after which the browse session is deleted automatically."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.sharePointBrowseSession"
  nullable    = false
}

variable "restore_point_date_time" {
  description = "The date and time of the restore point on which the browse session is created."
  type        = string
  default     = null
}

variable "restore_point_id" {
  description = "Microsoft Graph restorePointId property."
  type        = string
  default     = null
}

variable "site_id" {
  description = "Id of the backed-up SharePoint site."
  type        = string
  default     = null
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["creating", "created", "failed", "unknownFutureValue"], var.status)
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
