variable "end" {
  description = "Microsoft Graph end property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
    dateTime   = optional(string)
    timeZone   = optional(string)
  })
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.workPlanRecurrence"
  nullable    = false
}

variable "place_id" {
  description = "Identifier of a place from the Microsoft Graph Places Directory API. Only applicable when workLocationType is set to office."
  type        = string
  default     = null
}

variable "recurrence" {
  description = "Microsoft Graph recurrence property."
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
}

variable "start" {
  description = "Microsoft Graph start property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
    dateTime   = optional(string)
    timeZone   = optional(string)
  })
  default = null
}

variable "work_location_type" {
  description = "Microsoft Graph workLocationType property."
  type        = string
  default     = null

  validation {
    condition     = var.work_location_type == null ? true : contains(["unspecified", "office", "remote", "timeOff", "unknownFutureValue"], var.work_location_type)
    error_message = "work_location_type must be one of the documented enum values."
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
