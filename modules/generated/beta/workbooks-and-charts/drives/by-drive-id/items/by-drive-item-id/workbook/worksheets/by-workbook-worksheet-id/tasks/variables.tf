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

variable "workbook_worksheet_id" {
  description = "The unique identifier of workbookWorksheet"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.workbook_worksheet_id)) > 0
    error_message = "workbook_worksheet_id must not be empty."
  }
}

variable "assignees" {
  description = "A collection of user identities the task is assigned to."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.workbookEmailIdentity")
    displayName = optional(string)
    email       = optional(string)
    id          = optional(string)
  }))
  default = null
}

variable "changes" {
  description = "A collection of task change histories."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.workbookDocumentTaskChange")
    assignee   = optional(any)
    changedBy = optional(object({
      odata_type  = optional(string, "#microsoft.graph.workbookEmailIdentity")
      displayName = optional(string)
      email       = optional(string)
      id          = optional(string)
    }))
    commentId       = optional(string)
    createdDateTime = optional(string)
    dueDateTime     = optional(string)
    percentComplete = optional(number)
    priority        = optional(number)
    startDateTime   = optional(string)
    title           = optional(string)
    type            = optional(string)
    undoChangeId    = optional(string)
  }))
  default = null
}

variable "comment" {
  description = "The comment that the task is associated with."
  type        = any
  default     = null
}

variable "completed_by" {
  description = "The identity of the user who completed the task. Nullable."
  type        = any
  default     = null
}

variable "completed_date_time" {
  description = "Date and time when the task was completed. Nullable. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "created_by" {
  description = "A user identity that creates the task. Nullable."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "Date and time when the task was created. Nullable. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.workbookDocumentTask"
  nullable    = false
}

variable "percent_complete" {
  description = "An integer value from 0 to 100 that represents the percentage of the completion of the task. 100 means that the task is completed. Nullable."
  type        = number
  default     = null
}

variable "priority" {
  description = "An integer value from 0 to 10 that represents the priority of the task. A lower value indicates a higher priority. Nullable."
  type        = number
  default     = null
}

variable "start_and_due_date_time" {
  description = "Start and due date of the task. Nullable."
  type        = any
  default     = null
}

variable "title" {
  description = "The title of the task."
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
