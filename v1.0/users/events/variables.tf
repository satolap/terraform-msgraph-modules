variable "user-id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user-id)) > 0
    error_message = "user-id must not be empty."
  }
}

variable "allowNewTimeProposals" {
  description = "true if the meeting organizer allows invitees to propose a new time when responding; otherwise, false. Optional. The default is true."
  type        = bool
  default     = null
}

variable "attendees" {
  description = "The collection of attendees for the event."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.attendee")
    emailAddress = optional(object({
      odata_type = optional(string, "#microsoft.graph.emailAddress")
      address    = optional(string)
      name       = optional(string)
    }))
    proposedNewTime = optional(object({
      odata_type = optional(string, "#microsoft.graph.timeSlot")
      end = optional(object({
        odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
        dateTime   = optional(string)
        timeZone   = optional(string)
      }))
      start = optional(object({
        odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
        dateTime   = optional(string)
        timeZone   = optional(string)
      }))
    }))
    status = optional(object({
      odata_type = optional(string, "#microsoft.graph.responseStatus")
      response   = optional(string)
      time       = optional(string)
    }))
    type = optional(string)
  }))
  default = null

  validation {
    condition     = (var.attendees == null ? true : alltrue([alltrue([for input0 in var.attendees : (input0 == null ? true : alltrue([(input0["status"] == null ? true : alltrue([(input0["status"]["response"] == null ? true : alltrue([(input0["status"]["response"] == null ? true : contains(["none", "organizer", "tentativelyAccepted", "accepted", "declined", "notResponded"], input0["status"]["response"]))]))])), (input0["type"] == null ? true : alltrue([(input0["type"] == null ? true : contains(["required", "optional", "resource"], input0["type"]))]))]))])]))
    error_message = "attendees: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "body" {
  description = "The body of the message associated with the event. It can be in HTML or text format."
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

variable "bodyPreview" {
  description = "The preview of the message associated with the event. It's in text format."
  type        = string
  default     = null
}

variable "cancelledOccurrences" {
  description = "Contains occurrenceId property values of canceled instances in a recurring series, if the event is the series master. Instances in a recurring series that are canceled are called canceled occurences.Requires $select to retrieve. Only returned in a Get operation that specifies the ID (seriesMasterId property value) of a series master event."
  type        = list(string)
  default     = null
}

variable "categories" {
  description = "The categories associated with the item"
  type        = list(string)
  default     = null
}

variable "createdDateTime" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "end" {
  description = "The date, time, and time zone that the event ends. By default, the end time is in UTC."
  type = object({
    odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
    dateTime   = optional(string)
    timeZone   = optional(string)
  })
  default = null
}

variable "exceptionOccurrences" {
  description = "Contains the id property values of the event instances that are exceptions in a recurring series.Exceptions can differ from other occurrences in a recurring series, such as the subject, start or end times, or attendees. Exceptions don't include canceled occurrences.Requires $select and $expand to retrieve. Only returned in a GET operation that specifies the ID (seriesMasterId property value) of a series master event."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.event")
    allowNewTimeProposals = optional(bool)
    attendees = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.attendee")
      emailAddress = optional(object({
        odata_type = optional(string, "#microsoft.graph.emailAddress")
        address    = optional(string)
        name       = optional(string)
      }))
      proposedNewTime = optional(object({
        odata_type = optional(string, "#microsoft.graph.timeSlot")
        end        = optional(any)
        start      = optional(any)
      }))
      status = optional(object({
        odata_type = optional(string, "#microsoft.graph.responseStatus")
        response   = optional(string)
        time       = optional(string)
      }))
      type = optional(string)
    })))
    body = optional(object({
      odata_type  = optional(string, "#microsoft.graph.itemBody")
      content     = optional(string)
      contentType = optional(string)
    }))
    bodyPreview          = optional(string)
    cancelledOccurrences = optional(list(string))
    categories           = optional(list(string))
    createdDateTime      = optional(string)
    end = optional(object({
      odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
      dateTime   = optional(string)
      timeZone   = optional(string)
    }))
    exceptionOccurrences  = optional(any)
    extensions            = optional(any)
    hasAttachments        = optional(bool)
    hideAttendees         = optional(bool)
    importance            = optional(string)
    isAllDay              = optional(bool)
    isCancelled           = optional(bool)
    isDraft               = optional(bool)
    isOnlineMeeting       = optional(bool)
    isOrganizer           = optional(bool)
    isReminderOn          = optional(bool)
    lastModifiedDateTime  = optional(string)
    location              = optional(any)
    locations             = optional(any)
    onlineMeetingProvider = optional(string)
    organizer             = optional(any)
    originalEndTimeZone   = optional(string)
    originalStart         = optional(string)
    originalStartTimeZone = optional(string)
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
    reminderMinutesBeforeStart = optional(number)
    responseRequested          = optional(bool)
    responseStatus = optional(object({
      odata_type = optional(string, "#microsoft.graph.responseStatus")
      response   = optional(string)
      time       = optional(string)
    }))
    sensitivity    = optional(string)
    seriesMasterId = optional(string)
    showAs         = optional(string)
    start = optional(object({
      odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
      dateTime   = optional(string)
      timeZone   = optional(string)
    }))
    subject       = optional(string)
    transactionId = optional(string)
    webLink       = optional(string)
  }))
  default = null

  validation {
    condition     = (var.exceptionOccurrences == null ? true : alltrue([alltrue([for input0 in var.exceptionOccurrences : (input0 == null ? true : alltrue([(input0["attendees"] == null ? true : alltrue([alltrue([for input2 in input0["attendees"] : (input2 == null ? true : alltrue([(input2["status"] == null ? true : alltrue([(input2["status"]["response"] == null ? true : alltrue([(input2["status"]["response"] == null ? true : contains(["none", "organizer", "tentativelyAccepted", "accepted", "declined", "notResponded"], input2["status"]["response"]))]))])), (input2["type"] == null ? true : alltrue([(input2["type"] == null ? true : contains(["required", "optional", "resource"], input2["type"]))]))]))])])), (input0["body"] == null ? true : alltrue([(input0["body"]["contentType"] == null ? true : alltrue([(input0["body"]["contentType"] == null ? true : contains(["text", "html"], input0["body"]["contentType"]))]))])), (input0["importance"] == null ? true : alltrue([(input0["importance"] == null ? true : contains(["low", "normal", "high"], input0["importance"]))])), (input0["onlineMeetingProvider"] == null ? true : alltrue([(input0["onlineMeetingProvider"] == null ? true : contains(["unknown", "skypeForBusiness", "skypeForConsumer", "teamsForBusiness"], input0["onlineMeetingProvider"]))])), (input0["recurrence"] == null ? true : alltrue([(input0["recurrence"]["pattern"] == null ? true : alltrue([(input0["recurrence"]["pattern"]["daysOfWeek"] == null ? true : alltrue([alltrue([for input4 in input0["recurrence"]["pattern"]["daysOfWeek"] : (input4 == null ? true : alltrue([(input4 == null ? true : contains(["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"], input4))]))])])), (input0["recurrence"]["pattern"]["firstDayOfWeek"] == null ? true : alltrue([(input0["recurrence"]["pattern"]["firstDayOfWeek"] == null ? true : contains(["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"], input0["recurrence"]["pattern"]["firstDayOfWeek"]))])), (input0["recurrence"]["pattern"]["index"] == null ? true : alltrue([(input0["recurrence"]["pattern"]["index"] == null ? true : contains(["first", "second", "third", "fourth", "last"], input0["recurrence"]["pattern"]["index"]))])), (input0["recurrence"]["pattern"]["type"] == null ? true : alltrue([(input0["recurrence"]["pattern"]["type"] == null ? true : contains(["daily", "weekly", "absoluteMonthly", "relativeMonthly", "absoluteYearly", "relativeYearly"], input0["recurrence"]["pattern"]["type"]))]))])), (input0["recurrence"]["range"] == null ? true : alltrue([(input0["recurrence"]["range"]["type"] == null ? true : alltrue([(input0["recurrence"]["range"]["type"] == null ? true : contains(["endDate", "noEnd", "numbered"], input0["recurrence"]["range"]["type"]))]))]))])), (input0["responseStatus"] == null ? true : alltrue([(input0["responseStatus"]["response"] == null ? true : alltrue([(input0["responseStatus"]["response"] == null ? true : contains(["none", "organizer", "tentativelyAccepted", "accepted", "declined", "notResponded"], input0["responseStatus"]["response"]))]))])), (input0["sensitivity"] == null ? true : alltrue([(input0["sensitivity"] == null ? true : contains(["normal", "personal", "private", "confidential"], input0["sensitivity"]))])), (input0["showAs"] == null ? true : alltrue([(input0["showAs"] == null ? true : contains(["unknown", "free", "tentative", "busy", "oof", "workingElsewhere"], input0["showAs"]))]))]))])]))
    error_message = "exceptionOccurrences: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "extensions" {
  description = "The collection of open extensions defined for the event. Nullable."
  type        = any
  default     = null
}

variable "hasAttachments" {
  description = "Set to true if the event has attachments."
  type        = bool
  default     = null
}

variable "hideAttendees" {
  description = "When set to true, each attendee only sees themselves in the meeting request and meeting Tracking list. The default is false."
  type        = bool
  default     = null
}

variable "importance" {
  description = "The importance of the event. The possible values are: low, normal, high."
  type        = string
  default     = null

  validation {
    condition     = var.importance == null ? true : contains(["low", "normal", "high"], var.importance)
    error_message = "importance must be one of the documented enum values."
  }
}

variable "isAllDay" {
  description = "Set to true if the event lasts all day. If true, regardless of whether it's a single-day or multi-day event, start, and endtime must be set to midnight and be in the same time zone."
  type        = bool
  default     = null
}

variable "isCancelled" {
  description = "Set to true if the event has been canceled."
  type        = bool
  default     = null
}

variable "isDraft" {
  description = "Set to true if the user has updated the meeting in Outlook but hasn't sent the updates to attendees. Set to false if all changes are sent, or if the event is an appointment without any attendees."
  type        = bool
  default     = null
}

variable "isOnlineMeeting" {
  description = "True if this event has online meeting information (that is, onlineMeeting points to an onlineMeetingInfo resource), false otherwise. Default is false (onlineMeeting is null). Optional.  After you set isOnlineMeeting to true, Microsoft Graph initializes onlineMeeting. Subsequently, Outlook ignores any further changes to isOnlineMeeting, and the meeting remains available online."
  type        = bool
  default     = null
}

variable "isOrganizer" {
  description = "Set to true if the calendar owner (specified by the owner property of the calendar) is the organizer of the event (specified by the organizer property of the event). It also applies if a delegate organized the event on behalf of the owner."
  type        = bool
  default     = null
}

variable "isReminderOn" {
  description = "Set to true if an alert is set to remind the user of the event."
  type        = bool
  default     = null
}

variable "lastModifiedDateTime" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "location" {
  description = "The location of the event."
  type        = any
  default     = null
}

variable "locations" {
  description = "The locations where the event is held or attended from. The location and locations properties always correspond with each other. If you update the location property, any prior locations in the locations collection are removed and replaced by the new location value."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.event"
  nullable    = false
}

variable "onlineMeetingProvider" {
  description = "Represents the online meeting service provider. By default, onlineMeetingProvider is unknown. The possible values are unknown, teamsForBusiness, skypeForBusiness, and skypeForConsumer. Optional.  After you set onlineMeetingProvider, Microsoft Graph initializes onlineMeeting. Subsequently, you can't change onlineMeetingProvider again, and the meeting remains available online."
  type        = string
  default     = null

  validation {
    condition     = var.onlineMeetingProvider == null ? true : contains(["unknown", "skypeForBusiness", "skypeForConsumer", "teamsForBusiness"], var.onlineMeetingProvider)
    error_message = "onlineMeetingProvider must be one of the documented enum values."
  }
}

variable "organizer" {
  description = "The organizer of the event."
  type        = any
  default     = null
}

variable "originalEndTimeZone" {
  description = "The end time zone that was set when the event was created. A value of tzone://Microsoft/Custom indicates that a legacy custom time zone was set in desktop Outlook."
  type        = string
  default     = null
}

variable "originalStart" {
  description = "Represents the start time of an event when it's initially created as an occurrence or exception in a recurring series. This property is not returned for events that are single instances. Its date and time information is expressed in ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "originalStartTimeZone" {
  description = "The start time zone that was set when the event was created. A value of tzone://Microsoft/Custom indicates that a legacy custom time zone was set in desktop Outlook."
  type        = string
  default     = null
}

variable "recurrence" {
  description = "The recurrence pattern for the event."
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

variable "reminderMinutesBeforeStart" {
  description = "The number of minutes before the event start time that the reminder alert occurs."
  type        = number
  default     = null
}

variable "responseRequested" {
  description = "Default is true, which represents the organizer would like an invitee to send a response to the event."
  type        = bool
  default     = null
}

variable "responseStatus" {
  description = "Indicates the type of response sent in response to an event message."
  type = object({
    odata_type = optional(string, "#microsoft.graph.responseStatus")
    response   = optional(string)
    time       = optional(string)
  })
  default = null

  validation {
    condition     = (var.responseStatus == null ? true : alltrue([(var.responseStatus["response"] == null ? true : alltrue([(var.responseStatus["response"] == null ? true : contains(["none", "organizer", "tentativelyAccepted", "accepted", "declined", "notResponded"], var.responseStatus["response"]))]))]))
    error_message = "responseStatus: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "sensitivity" {
  description = "The possible values are: normal, personal, private, and confidential."
  type        = string
  default     = null

  validation {
    condition     = var.sensitivity == null ? true : contains(["normal", "personal", "private", "confidential"], var.sensitivity)
    error_message = "sensitivity must be one of the documented enum values."
  }
}

variable "seriesMasterId" {
  description = "The ID for the recurring series master item, if this event is part of a recurring series."
  type        = string
  default     = null
}

variable "showAs" {
  description = "The status to show. The possible values are: free, tentative, busy, oof, workingElsewhere, unknown."
  type        = string
  default     = null

  validation {
    condition     = var.showAs == null ? true : contains(["unknown", "free", "tentative", "busy", "oof", "workingElsewhere"], var.showAs)
    error_message = "showAs must be one of the documented enum values."
  }
}

variable "start" {
  description = "The start date, time, and time zone of the event. By default, the start time is in UTC."
  type = object({
    odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
    dateTime   = optional(string)
    timeZone   = optional(string)
  })
  default = null
}

variable "subject" {
  description = "The text of the event's subject line."
  type        = string
  default     = null
}

variable "transactionId" {
  description = "A custom identifier specified by a client app for the server to avoid redundant POST operations in case of client retries to create the same event. It's useful when low network connectivity causes the client to time out before receiving a response from the server for the client's prior create-event request. After you set transactionId when creating an event, you can't change transactionId in a subsequent update. This property is only returned in a response payload if an app has set it. Optional."
  type        = string
  default     = null
}

variable "webLink" {
  description = "The URL to open the event in Outlook on the web.Outlook on the web opens the event in the browser if you are signed in to your mailbox. Otherwise, Outlook on the web prompts you to sign in.This URL can't be accessed from within an iFrame."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["attachments", "calendar", "changeKey", "iCalUId", "id", "instances", "multiValueExtendedProperties", "onlineMeeting", "onlineMeetingUrl", "singleValueExtendedProperties", "type"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
