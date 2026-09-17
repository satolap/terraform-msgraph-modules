variable "calendar_group_id" {
  description = "The unique identifier of calendarGroup"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.calendar_group_id)) > 0
    error_message = "calendar_group_id must not be empty."
  }
}

variable "calendar_id" {
  description = "The unique identifier of calendar"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.calendar_id)) > 0
    error_message = "calendar_id must not be empty."
  }
}

variable "allow_new_time_proposals" {
  description = "true if the meeting organizer allows invitees to propose a new time when responding; otherwise, false. Optional. The default is true."
  type        = bool
  default     = null
}

variable "attendees" {
  description = "The collection of attendees for the event."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.attendee")
    emailAddress    = optional(any)
    proposedNewTime = optional(any)
    status          = optional(any)
    type            = optional(any)
  }))
  default = null
}

variable "body" {
  description = "The body of the message associated with the event. It can be in HTML or text format."
  type        = any
  default     = null
}

variable "body_preview" {
  description = "The preview of the message associated with the event. It's in text format."
  type        = string
  default     = null
}

variable "cancelled_occurrences" {
  description = "Contains occurrenceId property values of canceled instances in a recurring series, if the event is the series master. Instances in a recurring series that are canceled are called canceled occurences.Requires $select to retrieve. Only returned in a Get operation that specifies the ID (seriesMasterId property value) of a series master event."
  type        = list(string)
  default     = null
}

variable "categories" {
  description = "The categories associated with the item"
  type        = list(string)
  default     = null
}

variable "created_date_time" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "end" {
  description = "The date, time, and time zone that the event ends. By default, the end time is in UTC."
  type        = any
  default     = null
}

variable "exception_occurrences" {
  description = "Contains the id property values of the event instances that are exceptions in a recurring series.Exceptions can differ from other occurrences in a recurring series, such as the subject, start or end times, or attendees. Exceptions don't include canceled occurrences.Requires $select and $expand to retrieve. Only returned in a GET operation that specifies the ID (seriesMasterId property value) of a series master event."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.event")
    allowNewTimeProposals = optional(bool)
    attendees = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.attendee")
      emailAddress    = optional(any)
      proposedNewTime = optional(any)
      status          = optional(any)
      type            = optional(any)
    })))
    body                 = optional(any)
    bodyPreview          = optional(string)
    cancelledOccurrences = optional(list(string))
    categories           = optional(list(string))
    createdDateTime      = optional(string)
    end                  = optional(any)
    exceptionOccurrences = optional(any)
    extensions = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.extension")
    })))
    hasAttachments       = optional(bool)
    hideAttendees        = optional(bool)
    importance           = optional(any)
    isAllDay             = optional(bool)
    isCancelled          = optional(bool)
    isDraft              = optional(bool)
    isOnlineMeeting      = optional(bool)
    isOrganizer          = optional(bool)
    isReminderOn         = optional(bool)
    lastModifiedDateTime = optional(string)
    location             = optional(any)
    locations = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.location")
      address              = optional(any)
      coordinates          = optional(any)
      displayName          = optional(string)
      locationEmailAddress = optional(string)
      locationUri          = optional(string)
      uniqueId             = optional(string)
      uniqueIdType         = optional(any)
    })))
    onlineMeetingProvider      = optional(any)
    organizer                  = optional(any)
    originalEndTimeZone        = optional(string)
    originalStart              = optional(string)
    originalStartTimeZone      = optional(string)
    recurrence                 = optional(any)
    reminderMinutesBeforeStart = optional(number)
    responseRequested          = optional(bool)
    responseStatus             = optional(any)
    sensitivity                = optional(any)
    seriesMasterId             = optional(string)
    showAs                     = optional(any)
    start                      = optional(any)
    subject                    = optional(string)
    transactionId              = optional(string)
    webLink                    = optional(string)
  }))
  default = null
}

variable "extensions" {
  description = "The collection of open extensions defined for the event. Nullable."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.extension")
  }))
  default = null
}

variable "has_attachments" {
  description = "Set to true if the event has attachments."
  type        = bool
  default     = null
}

variable "hide_attendees" {
  description = "When set to true, each attendee only sees themselves in the meeting request and meeting Tracking list. The default is false."
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

variable "is_all_day" {
  description = "Set to true if the event lasts all day. If true, regardless of whether it's a single-day or multi-day event, start, and endtime must be set to midnight and be in the same time zone."
  type        = bool
  default     = null
}

variable "is_cancelled" {
  description = "Set to true if the event has been canceled."
  type        = bool
  default     = null
}

variable "is_draft" {
  description = "Set to true if the user has updated the meeting in Outlook but hasn't sent the updates to attendees. Set to false if all changes are sent, or if the event is an appointment without any attendees."
  type        = bool
  default     = null
}

variable "is_online_meeting" {
  description = "True if this event has online meeting information (that is, onlineMeeting points to an onlineMeetingInfo resource), false otherwise. Default is false (onlineMeeting is null). Optional.  After you set isOnlineMeeting to true, Microsoft Graph initializes onlineMeeting. Subsequently, Outlook ignores any further changes to isOnlineMeeting, and the meeting remains available online."
  type        = bool
  default     = null
}

variable "is_organizer" {
  description = "Set to true if the calendar owner (specified by the owner property of the calendar) is the organizer of the event (specified by the organizer property of the event). It also applies if a delegate organized the event on behalf of the owner."
  type        = bool
  default     = null
}

variable "is_reminder_on" {
  description = "Set to true if an alert is set to remind the user of the event."
  type        = bool
  default     = null
}

variable "last_modified_date_time" {
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
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.location")
    address              = optional(any)
    coordinates          = optional(any)
    displayName          = optional(string)
    locationEmailAddress = optional(string)
    locationUri          = optional(string)
    uniqueId             = optional(string)
    uniqueIdType         = optional(any)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.event"
  nullable    = false
}

variable "online_meeting_provider" {
  description = "Represents the online meeting service provider. By default, onlineMeetingProvider is unknown. The possible values are unknown, teamsForBusiness, skypeForBusiness, and skypeForConsumer. Optional.  After you set onlineMeetingProvider, Microsoft Graph initializes onlineMeeting. Subsequently, you can't change onlineMeetingProvider again, and the meeting remains available online."
  type        = any
  default     = null

  validation {
    condition     = var.online_meeting_provider == null ? true : contains(["unknown", "skypeForBusiness", "skypeForConsumer", "teamsForBusiness"], var.online_meeting_provider)
    error_message = "online_meeting_provider must be one of the documented enum values."
  }
}

variable "organizer" {
  description = "The organizer of the event."
  type        = any
  default     = null
}

variable "original_end_time_zone" {
  description = "The end time zone that was set when the event was created. A value of tzone://Microsoft/Custom indicates that a legacy custom time zone was set in desktop Outlook."
  type        = string
  default     = null
}

variable "original_start" {
  description = "Represents the start time of an event when it's initially created as an occurrence or exception in a recurring series. This property is not returned for events that are single instances. Its date and time information is expressed in ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "original_start_time_zone" {
  description = "The start time zone that was set when the event was created. A value of tzone://Microsoft/Custom indicates that a legacy custom time zone was set in desktop Outlook."
  type        = string
  default     = null
}

variable "recurrence" {
  description = "The recurrence pattern for the event."
  type        = any
  default     = null
}

variable "reminder_minutes_before_start" {
  description = "The number of minutes before the event start time that the reminder alert occurs."
  type        = number
  default     = null
}

variable "response_requested" {
  description = "Default is true, which represents the organizer would like an invitee to send a response to the event."
  type        = bool
  default     = null
}

variable "response_status" {
  description = "Indicates the type of response sent in response to an event message."
  type        = any
  default     = null
}

variable "sensitivity" {
  description = "The possible values are: normal, personal, private, and confidential."
  type        = any
  default     = null

  validation {
    condition     = var.sensitivity == null ? true : contains(["normal", "personal", "private", "confidential"], var.sensitivity)
    error_message = "sensitivity must be one of the documented enum values."
  }
}

variable "series_master_id" {
  description = "The ID for the recurring series master item, if this event is part of a recurring series."
  type        = string
  default     = null
}

variable "show_as" {
  description = "The status to show. The possible values are: free, tentative, busy, oof, workingElsewhere, unknown."
  type        = any
  default     = null

  validation {
    condition     = var.show_as == null ? true : contains(["unknown", "free", "tentative", "busy", "oof", "workingElsewhere"], var.show_as)
    error_message = "show_as must be one of the documented enum values."
  }
}

variable "start" {
  description = "The start date, time, and time zone of the event. By default, the start time is in UTC."
  type        = any
  default     = null
}

variable "subject" {
  description = "The text of the event's subject line."
  type        = string
  default     = null
}

variable "transaction_id" {
  description = "A custom identifier specified by a client app for the server to avoid redundant POST operations in case of client retries to create the same event. It's useful when low network connectivity causes the client to time out before receiving a response from the server for the client's prior create-event request. After you set transactionId when creating an event, you can't change transactionId in a subsequent update. This property is only returned in a response payload if an app has set it. Optional."
  type        = string
  default     = null
}

variable "web_link" {
  description = "The URL to open the event in Outlook on the web.Outlook on the web opens the event in the browser if you are signed in to your mailbox. Otherwise, Outlook on the web prompts you to sign in.This URL can't be accessed from within an iFrame."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["attachments", "calendar", "changeKey", "iCalUId", "id", "instances", "multiValueExtendedProperties", "onlineMeeting", "onlineMeetingUrl", "singleValueExtendedProperties", "type"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
