variable "application" {
  description = "The Entra ID application ID."
  type        = any
  default     = null
}

variable "effective_date_time" {
  description = "Timestamp of the effective activation of the service app."
  type        = string
  default     = null
}

variable "last_modified_by" {
  description = "Identity of the person who last modified the entity."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "Timestamp of the last modification of the entity."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.serviceApp"
  nullable    = false
}

variable "registration_date_time" {
  description = "Timestamp of the creation of the service app entity."
  type        = string
  default     = null
}

variable "status" {
  description = "The status of the service app. This value indicates whether or not the application can be used to control the backup service. The possible values are: inactive, active, pendingActive, pendingInactive, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["inactive", "active", "pendingActive", "pendingInactive", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
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
