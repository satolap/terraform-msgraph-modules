variable "service_principal_id" {
  description = "The unique identifier of servicePrincipal"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.service_principal_id)) > 0
    error_message = "service_principal_id must not be empty."
  }
}

variable "app_role_id" {
  description = "The identifier (id) for the app role that's assigned to the principal. This app role must be exposed in the appRoles property on the resource application's service principal (resourceId). If the resource application hasn't declared any app roles, a default app role ID of 00000000-0000-0000-0000-000000000000 can be specified to signal that the principal is assigned to the resource app without any specific app roles. Required on create."
  type        = string
  default     = null
}

variable "deleted_date_time" {
  description = "Date and time when this object was deleted. Always null when the object hasn't been deleted."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.appRoleAssignment"
  nullable    = false
}

variable "principal_id" {
  description = "The unique identifier (id) for the user, security group, or service principal being granted the app role. Security groups with dynamic memberships are supported. Required on create."
  type        = string
  default     = null
}

variable "resource_display_name" {
  description = "The display name of the resource app's service principal to which the assignment is made. Maximum length is 256 characters."
  type        = string
  default     = null
}

variable "resource_id" {
  description = "The unique identifier (id) for the resource service principal for which the assignment is made. Required on create. Supports $filter (eq only)."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "principalDisplayName", "principalType"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
