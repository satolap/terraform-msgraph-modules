variable "todo_task_list_id" {
  description = "The unique identifier of todoTaskList"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.todo_task_list_id)) > 0
    error_message = "todo_task_list_id must not be empty."
  }
}

variable "attachment_sessions" {
  description = "Microsoft Graph attachmentSessions property."
  type = list(object({
    odata_type         = optional(string, "#microsoft.graph.attachmentSession")
    content            = optional(string)
    expirationDateTime = optional(string)
    nextExpectedRanges = optional(list(string))
  }))
  default = null
}

variable "attachments" {
  description = "A collection of file attachments for the task."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.attachmentBase")
    contentType          = optional(string)
    lastModifiedDateTime = optional(string)
    name                 = optional(string)
    size                 = optional(number)
  }))
  default = null
}

variable "body" {
  description = "The task body that typically contains information about the task."
  type        = any
  default     = null
}

variable "body_last_modified_date_time" {
  description = "The date and time when the task body was last modified. By default, it is in UTC. You can provide a custom time zone in the request header. The property value uses ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2020 would look like this: '2020-01-01T00:00:00Z'."
  type        = string
  default     = null
}

variable "categories" {
  description = "The categories associated with the task. Each category corresponds to the displayName property of an outlookCategory that the user has defined."
  type        = list(string)
  default     = null
}

variable "checklist_items" {
  description = "A collection of checklistItems linked to a task."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.checklistItem")
    checkedDateTime = optional(string)
    createdDateTime = optional(string)
    displayName     = optional(string)
    isChecked       = optional(bool)
  }))
  default = null
}

variable "completed_date_time" {
  description = "The date and time in the specified time zone that the task was finished."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The date and time when the task was created. By default, it is in UTC. You can provide a custom time zone in the request header. The property value uses ISO 8601 format. For example, midnight UTC on Jan 1, 2020 would look like this: '2020-01-01T00:00:00Z'."
  type        = string
  default     = null
}

variable "due_date_time" {
  description = "The date and time in the specified time zone that the task is to be finished."
  type        = any
  default     = null
}

variable "extensions" {
  description = "The collection of open extensions defined for the task. Nullable."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.extension")
  }))
  default = null
}

variable "has_attachments" {
  description = "Indicates whether the task has attachments."
  type        = bool
  default     = null
}

variable "importance" {
  description = "Microsoft Graph importance property."
  type        = string
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
  description = "The date and time when the task was last modified. By default, it is in UTC. You can provide a custom time zone in the request header. The property value uses ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2020 would look like this: '2020-01-01T00:00:00Z'."
  type        = string
  default     = null
}

variable "linked_resources" {
  description = "A collection of resources linked to the task."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.linkedResource")
    applicationName = optional(string)
    displayName     = optional(string)
    externalId      = optional(string)
    webUrl          = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.todoTask"
  nullable    = false
}

variable "recurrence" {
  description = "The recurrence pattern for the task."
  type        = any
  default     = null
}

variable "reminder_date_time" {
  description = "The date and time in the specified time zone for a reminder alert of the task to occur."
  type        = any
  default     = null
}

variable "start_date_time" {
  description = "The date and time in the specified time zone at which the task is scheduled to start."
  type        = any
  default     = null
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["notStarted", "inProgress", "completed", "waitingOnOthers", "deferred"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "title" {
  description = "A brief description of the task."
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
