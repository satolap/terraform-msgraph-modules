variable "print_service_id" {
  description = "The unique identifier of printService"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.print_service_id)) > 0
    error_message = "print_service_id must not be empty."
  }
}

variable "display_name" {
  description = "A human-readable display name for the endpoint."
  type        = string
  default     = null
}

variable "name" {
  description = "Microsoft Graph name property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.printServiceEndpoint"
  nullable    = false
}

variable "uri" {
  description = "The URI that can be used to access the service."
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
