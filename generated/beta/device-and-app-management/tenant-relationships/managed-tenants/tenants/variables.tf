variable "contract" {
  description = "The relationship details for the tenant with the managing entity."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedTenants.tenant"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "displayName", "id", "lastUpdatedDateTime", "tenantId", "tenantStatusInformation"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
