variable "user_id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_id)) > 0
    error_message = "user_id must not be empty."
  }
}

variable "calendar_group_id" {
  description = "The unique identifier of calendarGroup"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.calendar_group_id)) > 0
    error_message = "calendar_group_id must not be empty."
  }
}

variable "allowed_online_meeting_providers" {
  description = "Represent the online meeting service providers that can be used to create online meetings in this calendar. The possible values are: unknown, skypeForBusiness, skypeForConsumer, teamsForBusiness."
  type        = any
  default     = null
}

variable "calendar_group_id_2" {
  description = "The calendarGroup in which to create the calendar. If the user has never explicitly set a group for the calendar, this property is  null."
  type        = string
  default     = null
}

variable "calendar_permissions" {
  description = "The permissions of the users with whom the calendar is shared."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.calendarPermission")
    allowedRoles         = optional(any)
    isInsideOrganization = optional(bool)
    isRemovable          = optional(bool)
    role                 = optional(any)
  }))
  default = null
}

variable "color" {
  description = "Specifies the color theme to distinguish the calendar from other calendars in a UI. The property values are: auto, lightBlue, lightGreen, lightOrange, lightGray, lightYellow, lightTeal, lightPink, lightBrown, lightRed, maxColor."
  type        = any
  default     = null

  validation {
    condition     = var.color == null ? true : contains(["auto", "lightBlue", "lightGreen", "lightOrange", "lightGray", "lightYellow", "lightTeal", "lightPink", "lightBrown", "lightRed", "maxColor"], var.color)
    error_message = "color must be one of the documented enum values."
  }
}

variable "default_online_meeting_provider" {
  description = "The default online meeting provider for meetings sent from this calendar. The possible values are: unknown, skypeForBusiness, skypeForConsumer, teamsForBusiness."
  type        = any
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
