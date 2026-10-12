variable "display_name" {
  description = "Display name of the partner."
  type        = string
  default     = null
}

variable "last_connection_date_time" {
  description = "Timestamp of the last request sent to Intune by the TEM partner."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.remoteAssistancePartner"
  nullable    = false
}

variable "onboarding_status" {
  description = "The current TeamViewer connector status"
  type        = string
  default     = null

  validation {
    condition     = var.onboarding_status == null ? true : contains(["notOnboarded", "onboarding", "onboarded"], var.onboarding_status)
    error_message = "onboarding_status must be one of the documented enum values."
  }
}

variable "onboarding_url" {
  description = "URL of the partner's onboarding portal, where an administrator can configure their Remote Assistance service."
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
