variable "body" {
  description = "The task body that typically contains information about the task. Only the HTML type is supported."
  type        = any
  default     = null
}

variable "categories" {
  description = "The categories associated with the item."
  type        = list(string)
  default     = null
}

variable "completed_date_time" {
  description = "The date in the specified time zone that the task was finished."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "due_date_time" {
  description = "The date in the specified time zone that the task is to be finished."
  type        = any
  default     = null
}

variable "has_attachments" {
  description = "Set to true if the task has attachments."
  type        = bool
  default     = null
}

variable "importance" {
  description = "The importance of the event. The possible values are: low, normal, high."
  type        = any
  default     = null

  validation {
    condition     = var.importance == null ? true : contains(["low", "normal", "high"], var.importance)
    error_message = "importance must be one of the documented enum values."
  }
}

variable "is_reminder_on" {
  description = "Set to true if an alert is set to remind the user of the task."
  type        = bool
  default     = null
}

variable "last_modified_date_time" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.outlookTask"
  nullable    = false
}

variable "owner" {
  description = "The name of the person who created the task."
  type        = string
  default     = null
}

variable "parent_folder_id" {
  description = "The unique identifier for the task's parent folder."
  type        = string
  default     = null
}

variable "recurrence" {
  description = "The recurrence pattern for the task."
  type        = any
  default     = null
}

variable "reminder_date_time" {
  description = "The date and time for a reminder alert of the task to occur."
  type        = any
  default     = null
}

variable "sensitivity" {
  description = "Indicates the level of privacy for the task. The possible values are: normal, personal, private, confidential."
  type        = any
  default     = null

  validation {
    condition     = var.sensitivity == null ? true : contains(["normal", "personal", "private", "confidential"], var.sensitivity)
    error_message = "sensitivity must be one of the documented enum values."
  }
}

variable "start_date_time" {
  description = "The date in the specified time zone when the task is to begin."
  type        = any
  default     = null
}

variable "status" {
  description = "Indicates the state or progress of the task. The possible values are: notStarted, inProgress, completed, waitingOnOthers, deferred."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["notStarted", "inProgress", "completed", "waitingOnOthers", "deferred"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "subject" {
  description = "A brief description or title of the task."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["assignedTo", "attachments", "changeKey", "id", "multiValueExtendedProperties", "singleValueExtendedProperties"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
