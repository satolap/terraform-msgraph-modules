variable "last_directory_sync_date_time" {
  description = "The ChromebookTenant's LastDirectorySyncDateTime"
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "The ChromebookTenant's LastModifiedDateTime"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.chromeOSOnboardingSettings"
  nullable    = false
}

variable "onboarding_status" {
  description = "The onboarding status of the tenant."
  type        = string
  default     = null

  validation {
    condition     = var.onboarding_status == null ? true : contains(["unknown", "inprogress", "onboarded", "failed", "offboarding", "unknownFutureValue"], var.onboarding_status)
    error_message = "onboarding_status must be one of the documented enum values."
  }
}

variable "owner_user_principal_name" {
  description = "The ChromebookTenant's OwnerUserPrincipalName"
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
