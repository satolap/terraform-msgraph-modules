variable "configuration_id" {
  description = "A unique identifier used to manage the external auth method within Microsoft Entra ID."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Custom name given to the registered external MFA."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.externalAuthenticationMethod"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
