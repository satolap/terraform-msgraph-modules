variable "display_name" {
  description = "The display name of the subject."
  type        = string
  default     = null
}

variable "email" {
  description = "The email address of the user subject. If the subject is in other types, it's empty."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.governanceSubject"
  nullable    = false
}

variable "principal_name" {
  description = "The principal name of the user subject. If the subject is in other types, it's empty."
  type        = string
  default     = null
}

variable "type" {
  description = "The type of the subject. The value can be User, Group, and ServicePrincipal."
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
