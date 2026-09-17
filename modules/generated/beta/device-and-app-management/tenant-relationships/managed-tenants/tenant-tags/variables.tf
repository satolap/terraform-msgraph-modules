variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedTenants.tenantTag"
  nullable    = false
}

variable "tenants" {
  description = "The collection of managed tenants associated with the tenant tag. Optional."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.managedTenants.tenantInfo")
    tenantId   = optional(string)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdByUserId", "createdDateTime", "deletedDateTime", "description", "displayName", "id", "lastActionByUserId", "lastActionDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
