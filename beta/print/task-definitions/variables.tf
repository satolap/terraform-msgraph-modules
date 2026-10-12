variable "created_by" {
  description = "Microsoft Graph createdBy property."
  type = object({
    odata_type           = optional(string, "#microsoft.graph.appIdentity")
    appId                = optional(string)
    displayName          = optional(string)
    servicePrincipalId   = optional(string)
    servicePrincipalName = optional(string)
  })
  default = null
}

variable "display_name" {
  description = "The name of the printTaskDefinition."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.printTaskDefinition"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "tasks"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
