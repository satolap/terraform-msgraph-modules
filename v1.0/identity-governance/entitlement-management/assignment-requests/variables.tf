variable "answers" {
  description = "Answers provided by the requestor to accessPackageQuestions asked of them at the time of request."
  type        = any
  default     = null
}

variable "assignment" {
  description = "For a requestType of userAdd or adminAdd, this is an access package assignment requested to be created. For a requestType of userRemove, adminRemove, approverRemove, or systemRemove, this has the id property of an existing assignment to be removed.   Supports $expand."
  type        = any
  default     = null
}

variable "custom_extension_callout_instances" {
  description = "Information about all the custom extension calls that were made during the access package assignment workflow."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.customExtensionCalloutInstance")
    customExtensionId     = optional(string)
    detail                = optional(string)
    externalCorrelationId = optional(string)
    status                = optional(string)
  }))
  default = null

  validation {
    condition     = (var.custom_extension_callout_instances == null ? true : alltrue([alltrue([for input0 in var.custom_extension_callout_instances : (input0 == null ? true : alltrue([(input0["status"] == null ? true : alltrue([(input0["status"] == null ? true : contains(["calloutSent", "callbackReceived", "calloutFailed", "callbackTimedOut", "waitingForCallback"], input0["status"]))]))]))])]))
    error_message = "custom_extension_callout_instances: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "justification" {
  description = "The requestor's supplied justification."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.accessPackageAssignmentRequest"
  nullable    = false
}

variable "parameters" {
  description = "Microsoft Graph parameters property."
  type = object({
    odata_type     = optional(string, "#microsoft.graph.accessPackageAssignmentRequestParameters")
    bypassApproval = optional(bool)
  })
  default = null
}

variable "request_type" {
  description = "The type of the request. The possible values are: notSpecified, userAdd, userUpdate, userRemove, adminAdd, adminUpdate, adminRemove, systemAdd, systemUpdate, systemRemove, onBehalfAdd (not supported), unknownFutureValue. Use the Prefer: include-unknown-enum-members request header to get the following values in this evolvable enum: approverRemove. Requests from the user have a requestType of userAdd, userUpdate, or userRemove. This property can't be changed once set."
  type        = string
  default     = null

  validation {
    condition     = var.request_type == null ? true : contains(["notSpecified", "userAdd", "userUpdate", "userRemove", "adminAdd", "adminUpdate", "adminRemove", "systemAdd", "systemUpdate", "systemRemove", "onBehalfAdd"], var.request_type)
    error_message = "request_type must be one of the documented enum values."
  }
}

variable "schedule" {
  description = "The range of dates that access is to be assigned to the requestor. This property can't be changed once set, but a new schedule for an assignment can be included in another userUpdate or adminUpdate assignment request."
  type = object({
    odata_type = optional(string, "#microsoft.graph.entitlementManagementSchedule")
    expiration = optional(object({
      odata_type  = optional(string, "#microsoft.graph.expirationPattern")
      duration    = optional(string)
      endDateTime = optional(string)
      type        = optional(string)
    }))
    recurrence = optional(object({
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
    }))
    startDateTime = optional(string)
  })
  default = null

  validation {
    condition     = (var.schedule == null ? true : alltrue([(var.schedule["expiration"] == null ? true : alltrue([(var.schedule["expiration"]["type"] == null ? true : alltrue([(var.schedule["expiration"]["type"] == null ? true : contains(["notSpecified", "noExpiration", "afterDateTime", "afterDuration"], var.schedule["expiration"]["type"]))]))])), (var.schedule["recurrence"] == null ? true : alltrue([(var.schedule["recurrence"]["pattern"] == null ? true : alltrue([(var.schedule["recurrence"]["pattern"]["daysOfWeek"] == null ? true : alltrue([alltrue([for input3 in var.schedule["recurrence"]["pattern"]["daysOfWeek"] : (input3 == null ? true : alltrue([(input3 == null ? true : contains(["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"], input3))]))])])), (var.schedule["recurrence"]["pattern"]["firstDayOfWeek"] == null ? true : alltrue([(var.schedule["recurrence"]["pattern"]["firstDayOfWeek"] == null ? true : contains(["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"], var.schedule["recurrence"]["pattern"]["firstDayOfWeek"]))])), (var.schedule["recurrence"]["pattern"]["index"] == null ? true : alltrue([(var.schedule["recurrence"]["pattern"]["index"] == null ? true : contains(["first", "second", "third", "fourth", "last"], var.schedule["recurrence"]["pattern"]["index"]))])), (var.schedule["recurrence"]["pattern"]["type"] == null ? true : alltrue([(var.schedule["recurrence"]["pattern"]["type"] == null ? true : contains(["daily", "weekly", "absoluteMonthly", "relativeMonthly", "absoluteYearly", "relativeYearly"], var.schedule["recurrence"]["pattern"]["type"]))]))])), (var.schedule["recurrence"]["range"] == null ? true : alltrue([(var.schedule["recurrence"]["range"]["type"] == null ? true : alltrue([(var.schedule["recurrence"]["range"]["type"] == null ? true : contains(["endDate", "noEnd", "numbered"], var.schedule["recurrence"]["range"]["type"]))]))]))]))]))
    error_message = "schedule: nested required attributes must be non-null and enum values must be supported input members."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["accessPackage", "completedDateTime", "createdDateTime", "id", "requestor", "state", "status"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
