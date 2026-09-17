variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedTenants.cloudPcOverview"
  nullable    = false
}

variable "tenant_id" {
  description = "Microsoft Graph tenantId property."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["frontlineLicensesCount", "id", "lastRefreshedDateTime", "numberOfCloudPcConnectionStatusFailed", "numberOfCloudPcConnectionStatusPassed", "numberOfCloudPcConnectionStatusPending", "numberOfCloudPcConnectionStatusRunning", "numberOfCloudPcConnectionStatusUnkownFutureValue", "numberOfCloudPcStatusDeprovisioning", "numberOfCloudPcStatusFailed", "numberOfCloudPcStatusInGracePeriod", "numberOfCloudPcStatusNotProvisioned", "numberOfCloudPcStatusProvisioned", "numberOfCloudPcStatusProvisioning", "numberOfCloudPcStatusUnknown", "numberOfCloudPcStatusUpgrading", "tenantDisplayName", "totalBusinessLicenses", "totalCloudPcConnectionStatus", "totalCloudPcStatus", "totalEnterpriseLicenses"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
