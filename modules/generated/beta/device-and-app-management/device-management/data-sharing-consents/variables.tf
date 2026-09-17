variable "grant_date_time" {
  description = "The time consent was granted for this account"
  type        = string
  default     = null
}

variable "granted" {
  description = "The granted state for the data sharing consent"
  type        = bool
  default     = null
}

variable "granted_by_upn" {
  description = "The Upn of the user that granted consent for this account"
  type        = string
  default     = null
}

variable "granted_by_user_id" {
  description = "The UserId of the user that granted consent for this account"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.dataSharingConsent"
  nullable    = false
}

variable "service_display_name" {
  description = "The display name of the service work flow"
  type        = string
  default     = null
}

variable "terms_url" {
  description = "The TermsUrl for the data sharing consent"
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
