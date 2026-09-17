variable "managed_app_registration_id" {
  description = "The unique identifier of managedAppRegistration"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.managed_app_registration_id)) > 0
    error_message = "managed_app_registration_id must not be empty."
  }
}

variable "graph_version" {
  description = "Version of the entity."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedAppLogCollectionRequest"
  nullable    = false
}

variable "user_log_upload_consent" {
  description = "Represents the current consent status of the associated `managedAppLogCollectionRequest`."
  type        = string
  default     = null

  validation {
    condition     = var.user_log_upload_consent == null ? true : contains(["unknown", "declined", "accepted", "unknownFutureValue"], var.user_log_upload_consent)
    error_message = "user_log_upload_consent must be one of the documented enum values."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["completedDateTime", "id", "managedAppRegistrationId", "requestedByUserPrincipalName", "requestedDateTime", "uploadedLogs"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
