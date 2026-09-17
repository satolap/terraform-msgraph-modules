variable "display_time_to_live" {
  description = "Sets how long (in seconds) this notification content stays in each platform's notification viewer. For example, when the notification is delivered to a Windows device, the value of this property is passed on to ToastNotification.ExpirationTime, which determines how long the toast notification stays in the user's Windows Action Center."
  type        = number
  default     = null
}

variable "expiration_date_time" {
  description = "Sets a UTC expiration date and time on a user notification using ISO 8601 format (for example, midnight UTC on Jan 1, 2019 would look like this: '2019-01-01T00:00:00Z'). When time is up, the notification is removed from the Microsoft Graph notification feed store completely and is no longer part of notification history. Max value is 30 days."
  type        = string
  default     = null
}

variable "group_name" {
  description = "The name of the group that this notification belongs to. It is set by the developer for grouping notifications together."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.notification"
  nullable    = false
}

variable "payload" {
  description = "Microsoft Graph payload property."
  type = object({
    odata_type    = optional(string, "#microsoft.graph.payloadTypes")
    rawContent    = optional(string)
    visualContent = optional(any)
  })
  default = null
}

variable "priority" {
  description = "Indicates the priority of a raw user notification. Visual notifications are sent with high priority by default. Valid values are None, High and Low."
  type        = any
  default     = null

  validation {
    condition     = var.priority == null ? true : contains(["None", "High", "Low"], var.priority)
    error_message = "priority must be one of the documented enum values."
  }
}

variable "target_host_name" {
  description = "Represents the host name of the app to which the calling service wants to post the notification, for the given user. If targeting web endpoints (see targetPolicy.platformTypes), ensure that targetHostName is the same as the name used when creating a subscription on the client side within the application JSON property."
  type        = string
  default     = null
}

variable "target_policy" {
  description = "Target policy object handles notification delivery policy for endpoint types that should be targeted (Windows, iOS, Android and WebPush) for the given user."
  type        = any
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
