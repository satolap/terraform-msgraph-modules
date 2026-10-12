variable "display_name" {
  description = "The display name for the unifiedRoleDefinition. Read-only when isBuiltIn is true. Required.  Supports $filter (eq, in)."
  type        = string
  nullable    = false
}

variable "is_enabled" {
  description = "Flag indicating whether the role is enabled for assignment. If false the role is not available for assignment. Read-only when isBuiltIn is true."
  type        = bool
  nullable    = false
}

variable "role_permissions" {
  description = "List of permissions included in the role. Read-only when isBuiltIn is true. Required."
  type = list(object({
    odata_type              = optional(string, "#microsoft.graph.unifiedRolePermission")
    allowedResourceActions  = optional(list(string))
    condition               = optional(string)
    excludedResourceActions = optional(list(string))
  }))
  nullable = false
}

variable "description" {
  description = "The description for the unifiedRoleDefinition. Read-only when isBuiltIn is true."
  type        = string
  default     = null
}

variable "graph_version" {
  description = "Indicates version of the role definition. Read-only when isBuiltIn is true."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.unifiedRoleDefinition"
  nullable    = false
}

variable "template_id" {
  description = "Custom template identifier that can be set when isBuiltIn is false but is read-only when isBuiltIn is true. This identifier is typically used if one needs an identifier to be the same across different directories."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "inheritsPermissionsFrom", "isBuiltIn", "resourceScopes"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
