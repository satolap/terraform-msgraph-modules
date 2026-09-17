variable "authentication_configuration" {
  description = "The object which describes the authentication configuration details for calling the API. Basic and PKCS 12 client certificate are supported."
  type        = any
  default     = null
}

variable "display_name" {
  description = "The name of the API connector."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.identityApiConnector"
  nullable    = false
}

variable "target_url" {
  description = "The URL of the API endpoint to call."
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
