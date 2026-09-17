variable "authorization_policy_id" {
  description = "The unique identifier of authorizationPolicy"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.authorization_policy_id)) > 0
    error_message = "authorization_policy_id must not be empty."
  }
}

variable "is_default" {
  description = "Microsoft Graph isDefault property."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.defaultUserRoleOverride"
  nullable    = false
}

variable "role_permissions" {
  description = "Microsoft Graph rolePermissions property."
  type = list(object({
    odata_type              = optional(string, "#microsoft.graph.unifiedRolePermission")
    allowedResourceActions  = optional(list(string))
    condition               = optional(string)
    excludedResourceActions = optional(list(string))
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
