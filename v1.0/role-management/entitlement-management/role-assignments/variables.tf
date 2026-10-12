variable "app_scope_id" {
  description = "Identifier of the app specific scope when the assignment scope is app specific. The scope of an assignment determines the set of resources for which the principal has been granted access. App scopes are scopes that are defined and understood by a resource application only. For the entitlement management provider, use this property to specify a catalog. For example, /AccessPackageCatalog/beedadfe-01d5-4025-910b-84abb9369997. Supports $filter (eq, in). For example, /roleManagement/entitlementManagement/roleAssignments?$filter=appScopeId eq '/AccessPackageCatalog/{catalog id}'."
  type        = string
  default     = null
}

variable "condition" {
  description = "Microsoft Graph condition property."
  type        = string
  default     = null
}

variable "directory_scope_id" {
  description = "Identifier of the directory object representing the scope of the assignment. The scope of an assignment determines the set of resources for which the principal has been granted access. Directory scopes are shared scopes stored in the directory that are understood by multiple applications, unlike app scopes that are defined and understood by a resource application only. Supports $filter (eq, in)."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.unifiedRoleAssignment"
  nullable    = false
}

variable "principal_id" {
  description = "Identifier of the principal to which the assignment is granted. Supported principals are users, role-assignable groups, and service principals. Supports $filter (eq, in)."
  type        = string
  default     = null
}

variable "principal_organization_id" {
  description = "Microsoft Graph principalOrganizationId property."
  type        = string
  default     = null
}

variable "role_definition" {
  description = "The roleDefinition the assignment is for. Supports $expand."
  type        = any
  default     = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["appScope", "directoryScope", "id", "principal", "roleDefinitionId"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
