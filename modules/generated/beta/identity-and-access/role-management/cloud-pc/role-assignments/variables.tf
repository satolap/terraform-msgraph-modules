variable "app_scope_ids" {
  description = "Ids of the app specific scopes when the assignment scopes are app specific. The scopes of an assignment determine the set of resources for which the principal has access. Directory scopes are shared scopes stored in the directory that are understood by multiple applications. Use / for tenant-wide scope. App scopes are scopes that are defined and understood by this application only."
  type        = list(string)
  default     = null
}

variable "condition" {
  description = "Microsoft Graph condition property."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the role assignment."
  type        = string
  default     = null
}

variable "directory_scope_ids" {
  description = "Ids of the directory objects that represent the scopes of the assignment. The scopes of an assignment determine the set of resources for which the principals have been granted access. Directory scopes are shared scopes stored in the directory that are understood by multiple applications. App scopes are scopes that are defined and understood by this application only."
  type        = list(string)
  default     = null
}

variable "display_name" {
  description = "Name of the role assignment. Required."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.unifiedRoleAssignmentMultiple"
  nullable    = false
}

variable "principal_ids" {
  description = "Identifiers of the principals to which the assignment is granted. Supports $filter (any operator only)."
  type        = list(string)
  default     = null
}

variable "role_definition" {
  description = "Specifies the roleDefinition that the assignment is for. Provided so that callers can get the role definition using $expand at the same time as getting the role assignment. Supports $filter (eq operator on id, isBuiltIn, and displayName, and startsWith operator on displayName)  and $expand."
  type        = any
  default     = null
}

variable "role_definition_id" {
  description = "Identifier of the unifiedRoleDefinition the assignment is for."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["appScopes", "directoryScopes", "id", "principals"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
