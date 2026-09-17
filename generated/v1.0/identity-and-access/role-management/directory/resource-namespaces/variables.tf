variable "name" {
  description = "Microsoft Graph name property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.unifiedRbacResourceNamespace"
  nullable    = false
}

variable "resource_actions" {
  description = "Microsoft Graph resourceActions property."
  type = list(object({
    odata_type                      = optional(string, "#microsoft.graph.unifiedRbacResourceAction")
    actionVerb                      = optional(string)
    authenticationContextId         = optional(string)
    description                     = optional(string)
    isAuthenticationContextSettable = optional(bool)
    name                            = optional(string)
    resourceScopeId                 = optional(string)
  }))
  default = null
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
