variable "notification_message_template_id" {
  description = "The unique identifier of notificationMessageTemplate"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.notification_message_template_id)) > 0
    error_message = "notification_message_template_id must not be empty."
  }
}

variable "is_default" {
  description = "Flag to indicate whether or not this is the default locale for language fallback. This flag can only be set. To unset, set this property to true on another Localized Notification Message."
  type        = bool
  default     = null
}

variable "last_modified_date_time" {
  description = "DateTime the object was last modified."
  type        = string
  default     = null
}

variable "locale" {
  description = "The Locale for which this message is destined."
  type        = string
  default     = null
}

variable "message_template" {
  description = "The Message Template content."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.localizedNotificationMessage"
  nullable    = false
}

variable "subject" {
  description = "The Message Template Subject."
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
