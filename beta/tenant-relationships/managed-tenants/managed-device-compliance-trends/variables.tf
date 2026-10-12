variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedTenants.managedDeviceComplianceTrend"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["compliantDeviceCount", "configManagerDeviceCount", "countDateTime", "errorDeviceCount", "id", "inGracePeriodDeviceCount", "noncompliantDeviceCount", "tenantDisplayName", "tenantId", "unknownDeviceCount"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
