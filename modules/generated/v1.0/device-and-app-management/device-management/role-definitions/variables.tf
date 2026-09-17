variable "description" {
  description = "Description of the Role definition."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Display Name of the Role definition."
  type        = string
  default     = null
}

variable "is_built_in" {
  description = "Type of Role. Set to True if it is built-in, or set to False if it is a custom role definition."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.roleDefinition"
  nullable    = false
}

variable "role_assignments" {
  description = "List of Role assignments for this role definition."
  type = list(object({
    odata_type     = optional(string, "#microsoft.graph.roleAssignment")
    description    = optional(string)
    displayName    = optional(string)
    resourceScopes = optional(list(string))
    roleDefinition = optional(any)
  }))
  default = null
}

variable "role_permissions" {
  description = "List of Role Permissions this role is allowed to perform. These must match the actionName that is defined as part of the rolePermission."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.rolePermission")
    resourceActions = optional(list(object({
      odata_type                = optional(string, "#microsoft.graph.resourceAction")
      allowedResourceActions    = optional(list(string))
      notAllowedResourceActions = optional(list(string))
    })))
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
