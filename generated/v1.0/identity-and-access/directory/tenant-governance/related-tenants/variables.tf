variable "app_b2_b_sign_in_activity_metrics" {
  description = "Microsoft Graph appB2BSignInActivityMetrics property."
  type        = any
  default     = null
}

variable "b2_b_registration_metrics" {
  description = "Microsoft Graph b2BRegistrationMetrics property."
  type        = any
  default     = null
}

variable "b2_b_sign_in_activity_metrics" {
  description = "Microsoft Graph b2BSignInActivityMetrics property."
  type        = any
  default     = null
}

variable "billing_metrics" {
  description = "Microsoft Graph billingMetrics property."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "Microsoft Graph createdDateTime property."
  type        = string
  default     = null
}

variable "multi_tenant_application_metrics" {
  description = "Microsoft Graph multiTenantApplicationMetrics property."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.relatedTenant"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "isMicrosoftInfrastructure"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
