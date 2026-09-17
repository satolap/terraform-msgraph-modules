variable "permission_grant_policy_id" {
  description = "The unique identifier of permissionGrantPolicy"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.permission_grant_policy_id)) > 0
    error_message = "permission_grant_policy_id must not be empty."
  }
}

variable "certified_client_applications_only" {
  description = "Set to true to only match on client applications that are Microsoft 365 certified. Set to false to match on any other client app. Default is false."
  type        = bool
  default     = null
}

variable "client_application_ids" {
  description = "A list of appId values for the client applications to match with, or a list with the single value all to match any client application. Default is the single value all."
  type        = list(string)
  default     = null
}

variable "client_application_publisher_ids" {
  description = "A list of Microsoft Partner Network (MPN) IDs for verified publishers of the client application, or a list with the single value all to match with client apps from any publisher. Default is the single value all."
  type        = list(string)
  default     = null
}

variable "client_application_tenant_ids" {
  description = "A list of Microsoft Entra tenant IDs in which the client application is registered, or a list with the single value all to match with client apps registered in any tenant. Default is the single value all."
  type        = list(string)
  default     = null
}

variable "client_applications_from_verified_publisher_only" {
  description = "Set to true to only match on client applications with a verified publisher. Set to false to match on any client app, even if it does not have a verified publisher. Default is false."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.permissionGrantConditionSet"
  nullable    = false
}

variable "permission_classification" {
  description = "The permission classification for the permission being granted, or all to match with any permission classification (including permissions which are not classified). Default is all."
  type        = string
  default     = null
}

variable "permission_type" {
  description = "The permission type of the permission being granted. Possible values: application for application permissions (e.g. app roles), or delegated for delegated permissions. The value delegatedUserConsentable indicates delegated permissions which have not been configured by the API publisher to require admin consent—this value may be used in built-in permission grant policies, but cannot be used in custom permission grant policies. Required."
  type        = any
  default     = null

  validation {
    condition     = var.permission_type == null ? true : contains(["application", "delegated", "delegatedUserConsentable"], var.permission_type)
    error_message = "permission_type must be one of the documented enum values."
  }
}

variable "permissions" {
  description = "The list of id values for the specific permissions to match with, or a list with the single value all to match with any permission. The id of delegated permissions can be found in the publishedPermissionScopes property of the API's servicePrincipal object. The id of application permissions can be found in the appRoles property of the API's servicePrincipal object. The id of resource-specific application permissions can be found in the resourceSpecificApplicationPermissions property of the API's servicePrincipal object. Default is the single value all."
  type        = list(string)
  default     = null
}

variable "resource_application" {
  description = "The appId of the resource application (e.g. the API) for which a permission is being granted, or any to match with any resource application or API. Default is any."
  type        = string
  default     = null
}

variable "scope_sensitivity_labels" {
  description = "Microsoft Graph scopeSensitivityLabels property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.scopeSensitivityLabels")
    labelKind  = optional(any)
  })
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
