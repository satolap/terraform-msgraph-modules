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

  validation {
    condition     = (var.recurrence == null ? true : alltrue([(var.recurrence["pattern"] == null ? true : alltrue([(var.recurrence["pattern"]["daysOfWeek"] == null ? true : alltrue([alltrue([for input2 in var.recurrence["pattern"]["daysOfWeek"] : (input2 == null ? true : alltrue([(input2 == null ? true : contains(["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"], input2))]))])])), (var.recurrence["pattern"]["firstDayOfWeek"] == null ? true : alltrue([(var.recurrence["pattern"]["firstDayOfWeek"] == null ? true : contains(["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"], var.recurrence["pattern"]["firstDayOfWeek"]))])), (var.recurrence["pattern"]["index"] == null ? true : alltrue([(var.recurrence["pattern"]["index"] == null ? true : contains(["first", "second", "third", "fourth", "last"], var.recurrence["pattern"]["index"]))])), (var.recurrence["pattern"]["type"] == null ? true : alltrue([(var.recurrence["pattern"]["type"] == null ? true : contains(["daily", "weekly", "absoluteMonthly", "relativeMonthly", "absoluteYearly", "relativeYearly"], var.recurrence["pattern"]["type"]))]))])), (var.recurrence["range"] == null ? true : alltrue([(var.recurrence["range"]["type"] == null ? true : alltrue([(var.recurrence["range"]["type"] == null ? true : contains(["endDate", "noEnd", "numbered"], var.recurrence["range"]["type"]))]))]))]))
    error_message = "recurrence: nested required attributes must be non-null and enum values must be supported input members."
  }
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
    condition     = var.work_location_type == null ? true : contains(["unspecified", "office", "remote", "timeOff"], var.work_location_type)
    error_message = "work_location_type must be one of the documented enum values."
  }
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
