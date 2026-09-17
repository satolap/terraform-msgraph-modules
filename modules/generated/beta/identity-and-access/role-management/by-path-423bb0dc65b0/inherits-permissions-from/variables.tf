variable "rbac_application_id" {
  description = "The unique identifier of rbacApplication"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.rbac_application_id)) > 0
    error_message = "rbac_application_id must not be empty."
  }
}

variable "unified_role_definition_id" {
  description = "The unique identifier of unifiedRoleDefinition"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.unified_role_definition_id)) > 0
    error_message = "unified_role_definition_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.unifiedRoleDefinition"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["allowedPrincipalTypes", "description", "displayName", "id", "inheritsPermissionsFrom", "isBuiltIn", "isEnabled", "isPrivileged", "resourceScopes", "rolePermissions", "templateId", "version"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
