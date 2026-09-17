variable "drive_id" {
  description = "The unique identifier of drive"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.drive_id)) > 0
    error_message = "drive_id must not be empty."
  }
}

variable "drive_item_id" {
  description = "The unique identifier of driveItem"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.drive_item_id)) > 0
    error_message = "drive_item_id must not be empty."
  }
}

variable "workbook_comment_id" {
  description = "The unique identifier of workbookComment"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.workbook_comment_id)) > 0
    error_message = "workbook_comment_id must not be empty."
  }
}

variable "assignee" {
  description = "The user identity the task is assigned to. Only present when the type property is assign. Nullable."
  type        = any
  default     = null
}

variable "changed_by" {
  description = "Microsoft Graph changedBy property."
  type = object({
    odata_type  = optional(string, "#microsoft.graph.workbookEmailIdentity")
    displayName = optional(string)
    email       = optional(string)
    id          = optional(string)
  })
  default = null
}

variable "comment_id" {
  description = "The identifier of the associated comment."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "Date and time when the task was changed. Nullable. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "due_date_time" {
  description = "The due date and time for the task. Only present when the type property is setSchedule. Nullable. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.workbookDocumentTaskChange"
  nullable    = false
}

variable "percent_complete" {
  description = "An integer value from 0 to 100 that represents the percentage of the completion of the task and associated comment. 100 means that the task and associated comment are completed. If you change the completion from 100 to a lower value, the associated task and comment are reactivated. Only present when the type property is setPercentComplete. Nullable."
  type        = number
  default     = null
}

variable "priority" {
  description = "An integer value from 0 to 10 that represents the priority of the task. A lower value indicates a higher priority. 5 indicates the default priority if not set. Only present when the type property is setPriority. Nullable."
  type        = number
  default     = null
}

variable "start_date_time" {
  description = "The start date and time for the task. Only present when the type property is setSchedule. Nullable. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "title" {
  description = "The title of the task. Only present when the type property is setTitle. Nullable."
  type        = string
  default     = null
}

variable "type" {
  description = "The type of the change history. The possible values are: create, assign, unassign, unassignAll, setPriority, setTitle, setPercentComplete, setSchedule, remove, restore, undo."
  type        = string
  default     = null
}

variable "undo_change_id" {
  description = "The ID of the workbookDocumentTaskChange that was undone for the undo change action. Only exists on an undo change history. Nullable."
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
