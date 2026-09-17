variable "display_name" {
  description = "The display name for the managed tenant."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedTenants.tenantDetailedInformation"
  nullable    = false
}

variable "tenant_id" {
  description = "The Microsoft Entra tenant identifier for the managed tenant."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["city", "countryCode", "countryName", "defaultDomainName", "id", "industryName", "region", "segmentName", "verticalName"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
