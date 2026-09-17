variable "deleted_date_time" {
  description = "Date and time when this object was deleted. Always null when the object hasn't been deleted."
  type        = string
  default     = null
}

variable "description" {
  description = "Description for this policy. Required."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Display name for this policy. Required."
  type        = string
  default     = null
}

variable "excludes" {
  description = "Condition sets that are excluded in this permission grant policy. Automatically expanded on GET."
  type = list(object({
    odata_type                                  = optional(string, "#microsoft.graph.permissionGrantConditionSet")
    certifiedClientApplicationsOnly             = optional(bool)
    clientApplicationIds                        = optional(list(string))
    clientApplicationPublisherIds               = optional(list(string))
    clientApplicationTenantIds                  = optional(list(string))
    clientApplicationsFromVerifiedPublisherOnly = optional(bool)
    permissionClassification                    = optional(string)
    permissionType                              = optional(any)
    permissions                                 = optional(list(string))
    resourceApplication                         = optional(string)
    scopeSensitivityLabels = optional(object({
      odata_type = optional(string, "#microsoft.graph.scopeSensitivityLabels")
      labelKind  = optional(any)
    }))
  }))
  default = null
}

variable "include_all_pre_approved_applications" {
  description = "Set to true to create all pre-approval policies in the tenant. Set to false to disable all pre-approval policies in the tenant. The default is false."
  type        = bool
  default     = null
}

variable "includes" {
  description = "Condition sets that are included in this permission grant policy. Automatically expanded on GET."
  type = list(object({
    odata_type                                  = optional(string, "#microsoft.graph.permissionGrantConditionSet")
    certifiedClientApplicationsOnly             = optional(bool)
    clientApplicationIds                        = optional(list(string))
    clientApplicationPublisherIds               = optional(list(string))
    clientApplicationTenantIds                  = optional(list(string))
    clientApplicationsFromVerifiedPublisherOnly = optional(bool)
    permissionClassification                    = optional(string)
    permissionType                              = optional(any)
    permissions                                 = optional(list(string))
    resourceApplication                         = optional(string)
    scopeSensitivityLabels = optional(object({
      odata_type = optional(string, "#microsoft.graph.scopeSensitivityLabels")
      labelKind  = optional(any)
    }))
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.permissionGrantPolicy"
  nullable    = false
}

variable "resource_scope_type" {
  description = "The resource type the pre-approval policy applies to. Possible values: team for groups and teams, chat for chats, tenant for all supported resources in the tenant. Required."
  type        = any
  default     = null

  validation {
    condition     = var.resource_scope_type == null ? true : contains(["group", "chat", "tenant", "unknownFutureValue", "team"], var.resource_scope_type)
    error_message = "resource_scope_type must be one of the documented enum values."
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
