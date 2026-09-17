variable "created_by" {
  description = "The identity of the person who created the exclusion unit."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The date and time when the exclusion unit was created. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "directory_object_id" {
  description = "The unique identifier of the directory object (user) associated with the mailbox."
  type        = string
  default     = null
}

variable "error" {
  description = "Contains error details if the exclusion unit is in a failed state."
  type        = any
  default     = null
}

variable "last_modified_by" {
  description = "The identity of the person who last modified the exclusion unit."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time when the exclusion unit was last modified. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "mailbox_type" {
  description = "Microsoft Graph mailboxType property."
  type        = any
  default     = null

  validation {
    condition     = var.mailbox_type == null ? true : contains(["unknown", "user", "shared", "unknownFutureValue"], var.mailbox_type)
    error_message = "mailbox_type must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.mailboxExclusionUnit"
  nullable    = false
}

variable "policy_id" {
  description = "The unique identifier of the protection policy that contains this exclusion unit."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["displayName", "email", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
