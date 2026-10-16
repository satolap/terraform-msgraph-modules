variable "rbac_application_id" {
  description = "The unique identifier of rbacApplication"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.rbac_application_id)) > 0
    error_message = "rbac_application_id must not be empty."
  }
}

variable "unified_rbac_resource_namespace_id" {
  description = "The unique identifier of unifiedRbacResourceNamespace"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.unified_rbac_resource_namespace_id)) > 0
    error_message = "unified_rbac_resource_namespace_id must not be empty."
  }
}

variable "action_verb" {
  description = "HTTP method for the action, such as DELETE, GET, PATCH, POST, PUT, or null. Supports $filter (eq) but not for null values."
  type        = string
  default     = null
}

variable "authentication_context" {
  description = "Microsoft Graph authenticationContext property."
  type        = any
  default     = null
}

variable "authentication_context_id" {
  description = "Microsoft Graph authenticationContextId property."
  type        = string
  default     = null
}

variable "description" {
  description = "Description for the action. Supports $filter (eq)."
  type        = string
  default     = null
}

variable "is_authentication_context_settable" {
  description = "Microsoft Graph isAuthenticationContextSettable property."
  type        = bool
  default     = null
}

variable "name" {
  description = "Name for the action within the resource namespace, such as microsoft.insights/programs/update. Can include slash character (/). Case insensitive. Required. Supports $filter (eq)."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.unifiedRbacResourceAction"
  nullable    = false
}

variable "resource_scope" {
  description = "Microsoft Graph resourceScope property."
  type        = any
  default     = null
}

variable "resource_scope_id" {
  description = "Not implemented."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "isPrivileged"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
