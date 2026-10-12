variable "vulnerability_id" {
  description = "The unique identifier of vulnerability"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.vulnerability_id)) > 0
    error_message = "vulnerability_id must not be empty."
  }
}

variable "name" {
  description = "The name of this vulnerability component."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.vulnerabilityComponent"
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
