variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  nullable    = false

  validation {
    condition     = var.odata_type == null ? true : contains(["#microsoft.graph.windowsUpdates.driverUpdateCatalogEntry", "#microsoft.graph.windowsUpdates.featureUpdateCatalogEntry", "#microsoft.graph.windowsUpdates.qualityUpdateCatalogEntry", "#microsoft.graph.windowsUpdates.recoveryUpdateCatalogEntry"], var.odata_type)
    error_message = "odata_type must name a concrete Graph type."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["deployableUntilDateTime", "displayName", "id", "releaseDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
