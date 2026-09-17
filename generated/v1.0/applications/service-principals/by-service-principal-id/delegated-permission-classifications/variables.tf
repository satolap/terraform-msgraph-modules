variable "service_principal_id" {
  description = "The unique identifier of servicePrincipal"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.service_principal_id)) > 0
    error_message = "service_principal_id must not be empty."
  }
}

variable "classification" {
  description = "The classification value. Possible values: low, medium (preview), high (preview). Doesn't support $filter."
  type        = any
  default     = null

  validation {
    condition     = var.classification == null ? true : contains(["low", "medium", "high", "unknownFutureValue"], var.classification)
    error_message = "classification must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.delegatedPermissionClassification"
  nullable    = false
}

variable "permission_id" {
  description = "The unique identifier (id) for the delegated permission listed in the oauth2PermissionScopes collection of the servicePrincipal. Required on create. Doesn't support $filter."
  type        = string
  default     = null
}

variable "permission_name" {
  description = "The claim value (value) for the delegated permission listed in the oauth2PermissionScopes collection of the servicePrincipal. Doesn't support $filter."
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
