variable "terms_and_conditions_id" {
  description = "The unique identifier of termsAndConditions"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.terms_and_conditions_id)) > 0
    error_message = "terms_and_conditions_id must not be empty."
  }
}

variable "accepted_date_time" {
  description = "DateTime when the terms were last accepted by the user."
  type        = string
  default     = null
}

variable "accepted_version" {
  description = "Most recent version number of the T&C accepted by the user."
  type        = number
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.termsAndConditionsAcceptanceStatus"
  nullable    = false
}

variable "terms_and_conditions" {
  description = "Navigation link to the terms and conditions that are assigned."
  type        = any
  default     = null
}

variable "user_display_name" {
  description = "Display name of the user whose acceptance the entity represents."
  type        = string
  default     = null
}

variable "user_principal_name" {
  description = "The userPrincipalName of the User that accepted the term."
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
