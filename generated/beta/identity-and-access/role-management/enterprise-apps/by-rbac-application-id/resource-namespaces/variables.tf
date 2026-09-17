variable "rbac_application_id" {
  description = "The unique identifier of rbacApplication"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.rbac_application_id)) > 0
    error_message = "rbac_application_id must not be empty."
  }
}

variable "name" {
  description = "Name of the resource namespace. Typically, the same name as the id property, such as microsoft.aad.b2c. Required. Supports $filter (eq, startsWith)."
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
  description = "Operations that an authorized principal is allowed to perform."
  type = list(object({
    odata_type                      = optional(string, "#microsoft.graph.unifiedRbacResourceAction")
    actionVerb                      = optional(string)
    authenticationContext           = optional(any)
    authenticationContextId         = optional(string)
    description                     = optional(string)
    isAuthenticationContextSettable = optional(bool)
    name                            = optional(string)
    resourceScope                   = optional(any)
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
