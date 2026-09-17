variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedTenants.managementActionTenantDeploymentStatus"
  nullable    = false
}

variable "statuses" {
  description = "The collection of deployment status for each instance of a management action. Optional."
  type = list(object({
    odata_type                = optional(string, "#microsoft.graph.managedTenants.managementActionDeploymentStatus")
    managementTemplateVersion = optional(number)
    status                    = optional(string)
    workloadActionDeploymentStatuses = optional(list(object({
      odata_type             = optional(string, "#microsoft.graph.managedTenants.workloadActionDeploymentStatus")
      error                  = optional(any)
      excludeGroups          = optional(list(string))
      includeAllUsers        = optional(bool)
      includeGroups          = optional(list(string))
      lastDeploymentDateTime = optional(string)
      status                 = optional(string)
    })))
  }))
  default = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "tenantGroupId", "tenantId"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
