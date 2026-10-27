variable "allowed_online_meeting_providers" {
  description = "Represent the online meeting service providers that can be used to create online meetings in this calendar. The possible values are: unknown, skypeForBusiness, skypeForConsumer, teamsForBusiness."
  type        = list(string)
  default     = null

  validation {
    condition     = (var.allowed_online_meeting_providers == null ? true : alltrue([alltrue([for input0 in var.allowed_online_meeting_providers : (input0 == null ? true : alltrue([(input0 == null ? true : contains(["unknown", "skypeForBusiness", "skypeForConsumer", "teamsForBusiness"], input0))]))])]))
    error_message = "allowed_online_meeting_providers: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "calendar_group_id" {
  description = "The calendarGroup in which to create the calendar. If the user has never explicitly set a group for the calendar, this property is  null."
  type        = string
  default     = null
}

variable "calendar_permissions" {
  description = "The permissions of the users with whom the calendar is shared."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.calendarPermission")
    allowedRoles         = optional(list(string))
    isInsideOrganization = optional(bool)
    isRemovable          = optional(bool)
    role                 = optional(string)
  }))
  default = null

  validation {
    condition     = (var.calendar_permissions == null ? true : alltrue([alltrue([for input0 in var.calendar_permissions : (input0 == null ? true : alltrue([(input0["allowedRoles"] == null ? true : alltrue([alltrue([for input2 in input0["allowedRoles"] : (input2 == null ? true : alltrue([(input2 == null ? true : contains(["none", "freeBusyRead", "limitedRead", "read", "write", "delegateWithoutPrivateEventAccess", "delegateWithPrivateEventAccess", "custom"], input2))]))])])), (input0["role"] == null ? true : alltrue([(input0["role"] == null ? true : contains(["none", "freeBusyRead", "limitedRead", "read", "write", "delegateWithoutPrivateEventAccess", "delegateWithPrivateEventAccess", "custom"], input0["role"]))]))]))])]))
    error_message = "calendar_permissions: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "color" {
  description = "Specifies the color theme to distinguish the calendar from other calendars in a UI. The property values are: auto, lightBlue, lightGreen, lightOrange, lightGray, lightYellow, lightTeal, lightPink, lightBrown, lightRed, maxColor."
  type        = string
  default     = null

  validation {
    condition     = var.color == null ? true : contains(["auto", "lightBlue", "lightGreen", "lightOrange", "lightGray", "lightYellow", "lightTeal", "lightPink", "lightBrown", "lightRed", "maxColor"], var.color)
    error_message = "color must be one of the documented enum values."
  }
}

variable "default_online_meeting_provider" {
  description = "The default online meeting provider for meetings sent from this calendar. The possible values are: unknown, skypeForBusiness, skypeForConsumer, teamsForBusiness."
  type        = string
  default     = null

  validation {
    condition     = var.default_online_meeting_provider == null ? true : contains(["unknown", "skypeForBusiness", "skypeForConsumer", "teamsForBusiness"], var.default_online_meeting_provider)
    error_message = "default_online_meeting_provider must be one of the documented enum values."
  }
}

variable "hex_color" {
  description = "The calendar color, expressed in a hex color code of three hexadecimal values, each ranging from 00 to FF and representing the red, green, or blue components of the color in the RGB color space. If the user has never explicitly set a color for the calendar, this property is  empty."
  type        = string
  default     = null
}

variable "is_default_calendar" {
  description = "true if this is the default calendar where new events are created by default, false otherwise."
  type        = bool
  default     = null
}

variable "is_removable" {
  description = "Indicates whether this user calendar can be deleted from the user mailbox."
  type        = bool
  default     = null
}

variable "is_tallying_responses" {
  description = "Indicates whether this user calendar supports tracking of meeting responses. Only meeting invites sent from users' primary calendars support tracking of meeting responses."
  type        = bool
  default     = null
}

variable "name" {
  description = "The calendar name."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.calendar"
  nullable    = false
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["calendarView", "canEdit", "canShare", "canViewPrivateItems", "changeKey", "events", "id", "isShared", "isSharedWithMe", "multiValueExtendedProperties", "owner", "singleValueExtendedProperties"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
