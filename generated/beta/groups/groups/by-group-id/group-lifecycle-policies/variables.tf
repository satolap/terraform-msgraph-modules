variable "group_id" {
  description = "The unique identifier of group"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.group_id)) > 0
    error_message = "group_id must not be empty."
  }
}

variable "alternate_notification_emails" {
  description = "List of email address to send notifications for groups without owners. Multiple email address can be defined by separating email address with a semicolon."
  type        = string
  default     = null
}

variable "group_lifetime_in_days" {
  description = "Number of days before a group expires and needs to be renewed. Once renewed, the group expiration is extended by the number of days defined."
  type        = number
  default     = null
}

variable "managed_group_types" {
  description = "The group type for which the expiration policy applies. Possible values are All, Selected or None."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.groupLifecyclePolicy"
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
