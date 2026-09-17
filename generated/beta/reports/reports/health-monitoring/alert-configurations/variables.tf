variable "email_notification_configurations" {
  description = "Defines the recipients of email notifications for an alert type. Currently, only one email notification configuration is supported for an alert configuration, meaning only one group can receive notifications for an alert type."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.healthMonitoring.emailNotificationConfiguration")
    groupId    = optional(string)
    isEnabled  = optional(bool)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.healthMonitoring.alertConfiguration"
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
