variable "created_by" {
  description = "The identity of the person who created the bulk addition job."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The date and time when the bulk addition job was created. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the bulk addition job."
  type        = string
  default     = null
}

variable "error" {
  description = "Contains error details if the bulk addition job failed."
  type        = any
  default     = null
}

variable "last_modified_by" {
  description = "The identity of the person who last modified the bulk addition job."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time when the bulk addition job was last modified. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "mailboxes" {
  description = "The email addresses of the mailboxes to be added as exclusion units to the protection policy."
  type        = list(string)
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.mailboxExclusionUnitsBulkAdditionJob"
  nullable    = false
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["created", "active", "completed", "completedWithErrors", "unknownFutureValue"], var.status)
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
