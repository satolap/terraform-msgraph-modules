variable "branding_options" {
  description = "Branding Options for the Message Template. Branding is defined in the Intune Admin Console."
  type        = string
  default     = null

  validation {
    condition     = var.branding_options == null ? true : contains(["none", "includeCompanyLogo", "includeCompanyName", "includeContactInformation", "includeCompanyPortalLink", "includeDeviceDetails", "unknownFutureValue"], var.branding_options)
    error_message = "branding_options must be one of the documented enum values."
  }
}

variable "default_locale" {
  description = "The default locale to fallback onto when the requested locale is not available."
  type        = string
  default     = null
}

variable "description" {
  description = "Display name for the Notification Message Template."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Display name for the Notification Message Template."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "DateTime the object was last modified."
  type        = string
  default     = null
}

variable "localized_notification_messages" {
  description = "The list of localized messages for this Notification Message Template."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.localizedNotificationMessage")
    isDefault            = optional(bool)
    lastModifiedDateTime = optional(string)
    locale               = optional(string)
    messageTemplate      = optional(string)
    subject              = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.notificationMessageTemplate"
  nullable    = false
}

variable "role_scope_tag_ids" {
  description = "List of Scope Tags for this Entity instance."
  type        = list(string)
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
