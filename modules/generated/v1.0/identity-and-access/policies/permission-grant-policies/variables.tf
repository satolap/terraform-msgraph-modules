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
    clientApplicationIds                        = optional(list(string))
    clientApplicationPublisherIds               = optional(list(string))
    clientApplicationTenantIds                  = optional(list(string))
    clientApplicationsFromVerifiedPublisherOnly = optional(bool)
    permissionClassification                    = optional(string)
    permissionType                              = optional(any)
    permissions                                 = optional(list(string))
    resourceApplication                         = optional(string)
  }))
  default = null
}

variable "includes" {
  description = "Condition sets that are included in this permission grant policy. Automatically expanded on GET."
  type = list(object({
    odata_type                                  = optional(string, "#microsoft.graph.permissionGrantConditionSet")
    clientApplicationIds                        = optional(list(string))
    clientApplicationPublisherIds               = optional(list(string))
    clientApplicationTenantIds                  = optional(list(string))
    clientApplicationsFromVerifiedPublisherOnly = optional(bool)
    permissionClassification                    = optional(string)
    permissionType                              = optional(any)
    permissions                                 = optional(list(string))
    resourceApplication                         = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.permissionGrantPolicy"
  nullable    = false
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
