variable "end_user_notification_id" {
  description = "The unique identifier of endUserNotification"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.end_user_notification_id)) > 0
    error_message = "end_user_notification_id must not be empty."
  }
}

variable "email_content" {
  description = "Email HTML content."
  type        = string
  default     = null
}

variable "is_default_langauge" {
  description = "Indicates whether this language is default."
  type        = bool
  default     = null
}

variable "language" {
  description = "Notification language."
  type        = string
  default     = null
}

variable "locale" {
  description = "Notification locale."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.endUserNotificationDetail"
  nullable    = false
}

variable "sent_from" {
  description = "Microsoft Graph sentFrom property."
  type = object({
    odata_type  = optional(string, "#microsoft.graph.emailIdentity")
    displayName = optional(string)
    email       = optional(string)
    id          = optional(string)
  })
  default = null
}

variable "subject" {
  description = "Mail subject."
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
