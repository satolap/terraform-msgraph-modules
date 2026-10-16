variable "ios_managed_app_protection_id" {
  description = "The unique identifier of iosManagedAppProtection"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.ios_managed_app_protection_id)) > 0
    error_message = "ios_managed_app_protection_id must not be empty."
  }
}

variable "graph_version" {
  description = "Version of the entity."
  type        = string
  default     = null
}

variable "mobile_app_identifier" {
  description = "The identifier for an app with it's operating system type."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedMobileApp"
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
