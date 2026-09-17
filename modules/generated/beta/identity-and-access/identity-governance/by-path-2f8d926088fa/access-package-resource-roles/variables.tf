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

variable "access_package_resource_scope_id" {
  description = "The unique identifier of accessPackageResourceScope"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.access_package_resource_scope_id)) > 0
    error_message = "access_package_resource_scope_id must not be empty."
  }
}

variable "access_package_resource" {
  description = "Microsoft Graph accessPackageResource property."
  type        = any
  default     = null
}

variable "description" {
  description = "A description for the resource role."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the resource role such as the role defined by the application."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.accessPackageResourceRole"
  nullable    = false
}

variable "origin_id" {
  description = "The unique identifier of the resource role in the origin system. For a SharePoint Online site, the originId is the sequence number of the role in the site."
  type        = string
  default     = null
}

variable "origin_system" {
  description = "The type of the resource in the origin system, such as SharePointOnline, AadApplication, AzureResources or AadGroup."
  type        = string
  default     = null
}

variable "type" {
  description = "The role type for the Azure resource role. The possible values are: active, eligible, application, delegated, unknownFutureValue. The values active and eligible are only supported where originSystem is AzureResources while application and delegated aren't currently implemented."
  type        = any
  default     = null

  validation {
    condition     = var.type == null ? true : contains(["active", "eligible", "application", "delegated", "unknownFutureValue"], var.type)
    error_message = "type must be one of the documented enum values."
  }
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
