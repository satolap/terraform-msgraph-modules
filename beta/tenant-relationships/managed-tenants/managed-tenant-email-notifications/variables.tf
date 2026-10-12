variable "alert" {
  description = "Microsoft Graph alert property."
  type        = any
  default     = null
}

variable "created_by_user_id" {
  description = "Microsoft Graph createdByUserId property."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "Microsoft Graph createdDateTime property."
  type        = string
  default     = null
}

variable "email_addresses" {
  description = "Microsoft Graph emailAddresses property."
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.managedTenants.email")
    emailAddress = optional(string)
  }))
  default = null
}

variable "email_body" {
  description = "Microsoft Graph emailBody property."
  type        = string
  default     = null
}

variable "last_action_by_user_id" {
  description = "Microsoft Graph lastActionByUserId property."
  type        = string
  default     = null
}

variable "last_action_date_time" {
  description = "Microsoft Graph lastActionDateTime property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedTenants.managedTenantEmailNotification"
  nullable    = false
}

variable "subject" {
  description = "Microsoft Graph subject property."
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
