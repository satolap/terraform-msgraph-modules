variable "access_package_id" {
  description = "The unique identifier of accessPackage"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.access_package_id)) > 0
    error_message = "access_package_id must not be empty."
  }
}

variable "access_package_resource_role_scope_id" {
  description = "The unique identifier of accessPackageResourceRoleScope"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.access_package_resource_role_scope_id)) > 0
    error_message = "access_package_resource_role_scope_id must not be empty."
  }
}

variable "access_package_resource" {
  description = "Microsoft Graph accessPackageResource property."
  type        = any
  default     = null
}

variable "description" {
  description = "The description of the scope."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the scope."
  type        = string
  default     = null
}

variable "is_root_scope" {
  description = "True if the scopes are arranged in a hierarchy and this is the top or root scope of the resource."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.accessPackageResourceScope"
  nullable    = false
}

variable "origin_id" {
  description = "The unique identifier of the resource in the origin system. If a Microsoft Entra group, originId is the identifier of the group. Supports $filter (eq)."
  type        = string
  default     = null
}

variable "origin_system" {
  description = "The type of the resource in the origin system, such as SharePointOnline, AadApplication, AadGroup, AzureResources, or CustomDataProvidedResource. Supports $filter (eq)."
  type        = string
  default     = null
}

variable "role_origin_id" {
  description = "The origin system for the role, if different."
  type        = string
  default     = null
}

variable "url" {
  description = "A resource locator for the scope."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
