variable "todoTaskList-id" {
  description = "The unique identifier of todoTaskList"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.todoTaskList-id)) > 0
    error_message = "todoTaskList-id must not be empty."
  }
}

variable "attachmentSessions" {
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
  type        = any
  default     = null
}

variable "body" {
  description = "The task body that typically contains information about the task."
  type = object({
    odata_type  = optional(string, "#microsoft.graph.itemBody")
    content     = optional(string)
    contentType = optional(string)
  })
  default = null

  validation {
    condition     = (var.body == null ? true : alltrue([(var.body["contentType"] == null ? true : alltrue([(var.body["contentType"] == null ? true : contains(["text", "html"], var.body["contentType"]))]))]))
    error_message = "body: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "bodyLastModifiedDateTime" {
  description = "The date and time when the task body was last modified. By default, it is in UTC. You can provide a custom time zone in the request header. The property value uses ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2020 would look like this: '2020-01-01T00:00:00Z'."
  type        = string
  default     = null
}

variable "categories" {
  description = "The categories associated with the task. Each category corresponds to the displayName property of an outlookCategory that the user has defined."
  type        = list(string)
  default     = null
}

variable "checklistItems" {
  description = "A collection of smaller subtasks linked to the more complex parent task."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.checklistItem")
    checkedDateTime = optional(string)
    createdDateTime = optional(string)
    displayName     = optional(string)
    isChecked       = optional(bool)
  }))
  default = null
}

variable "completedDateTime" {
  description = "The date and time in the specified time zone that the task was finished."
  type = object({
    odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
    dateTime   = optional(string)
    timeZone   = optional(string)
  })
  default = null
}

variable "createdDateTime" {
  description = "The date and time when the task was created. By default, it is in UTC. You can provide a custom time zone in the request header. The property value uses ISO 8601 format. For example, midnight UTC on Jan 1, 2020 would look like this: '2020-01-01T00:00:00Z'."
  type        = string
  default     = null
}

variable "dueDateTime" {
  description = "The date and time in the specified time zone that the task is to be finished."
  type = object({
    odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
    dateTime   = optional(string)
    timeZone   = optional(string)
  })
  default = null
}

variable "extensions" {
  description = "The collection of open extensions defined for the task. Nullable."
  type        = any
  default     = null
}

variable "hasAttachments" {
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

variable "isReminderOn" {
  description = "Set to true if an alert is set to remind the user of the task."
  type        = bool
  default     = null
}

variable "lastModifiedDateTime" {
  description = "The date and time when the task was last modified. By default, it is in UTC. You can provide a custom time zone in the request header. The property value uses ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2020 would look like this: '2020-01-01T00:00:00Z'."
  type        = string
  default     = null
}

variable "linkedResources" {
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
  type = object({
    odata_type = optional(string, "#microsoft.graph.patternedRecurrence")
    pattern = optional(object({
      odata_type     = optional(string, "#microsoft.graph.recurrencePattern")
      dayOfMonth     = optional(number)
      daysOfWeek     = optional(list(string))
      firstDayOfWeek = optional(string)
      index          = optional(string)
      interval       = optional(number)
      month          = optional(number)
      type           = optional(string)
    }))
    range = optional(object({
      odata_type          = optional(string, "#microsoft.graph.recurrenceRange")
      endDate             = optional(string)
      numberOfOccurrences = optional(number)
      recurrenceTimeZone  = optional(string)
      startDate           = optional(string)
      type                = optional(string)
    }))
  })
  default = null

  validation {
    condition     = (var.recurrence == null ? true : alltrue([(var.recurrence["pattern"] == null ? true : alltrue([(var.recurrence["pattern"]["daysOfWeek"] == null ? true : alltrue([alltrue([for input2 in var.recurrence["pattern"]["daysOfWeek"] : (input2 == null ? true : alltrue([(input2 == null ? true : contains(["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"], input2))]))])])), (var.recurrence["pattern"]["firstDayOfWeek"] == null ? true : alltrue([(var.recurrence["pattern"]["firstDayOfWeek"] == null ? true : contains(["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"], var.recurrence["pattern"]["firstDayOfWeek"]))])), (var.recurrence["pattern"]["index"] == null ? true : alltrue([(var.recurrence["pattern"]["index"] == null ? true : contains(["first", "second", "third", "fourth", "last"], var.recurrence["pattern"]["index"]))])), (var.recurrence["pattern"]["type"] == null ? true : alltrue([(var.recurrence["pattern"]["type"] == null ? true : contains(["daily", "weekly", "absoluteMonthly", "relativeMonthly", "absoluteYearly", "relativeYearly"], var.recurrence["pattern"]["type"]))]))])), (var.recurrence["range"] == null ? true : alltrue([(var.recurrence["range"]["type"] == null ? true : alltrue([(var.recurrence["range"]["type"] == null ? true : contains(["endDate", "noEnd", "numbered"], var.recurrence["range"]["type"]))]))]))]))
    error_message = "recurrence: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "reminderDateTime" {
  description = "The date and time in the specified time zone for a reminder alert of the task to occur."
  type = object({
    odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
    dateTime   = optional(string)
    timeZone   = optional(string)
  })
  default = null
}

variable "singleValueExtendedProperties" {
  description = "A collection of custom fields linked to the task."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.singleValueExtendedProperty")
    value      = optional(string)
  }))
  default = null
}

variable "startDateTime" {
  description = "The date and time in the specified time zone at which the task is scheduled to start."
  type = object({
    odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
    dateTime   = optional(string)
    timeZone   = optional(string)
  })
  default = null
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

variable "timeouts" {
  description = "Optional timeouts of the msgraph_resource, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". create, update and delete must be at least \"15s\": after each request the provider waits for consistent reads within the same timeout. Every value defaults to null, which keeps the provider defaults and sends no timeouts block. The reviewed replication retries of this module, where it has any, count against these timeouts."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.read, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : (can(regex("^([0-9]+[hms])+$", t)) ? !can(regex("^(0+[hms])+$", t)) : false)
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : try(sum([for m in regexall("([0-9]+)([hms])", t) : tonumber(m[0]) * lookup({ h = 3600, m = 60, s = 1 }, m[1])]) >= 15, true)
    ])
    error_message = "timeouts.create, timeouts.update and timeouts.delete must be at least \"15s\"."
  }
}

variable "select_response" {
  description = "Opt in to a configured-property GET selection; this narrows response and can remove fields consumers use."
  type        = bool
  default     = false
  nullable    = false
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
