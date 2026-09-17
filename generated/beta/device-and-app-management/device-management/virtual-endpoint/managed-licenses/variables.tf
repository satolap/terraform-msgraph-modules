variable "license_type" {
  description = "Microsoft Graph licenseType property."
  type        = string
  default     = null

  validation {
    condition     = var.license_type == null ? true : contains(["frontline", "reserve", "unknownFutureValue"], var.license_type)
    error_message = "license_type must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.cloudPcManagedLicense"
  nullable    = false
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["enabled", "expired", "blocked", "deleted", "unknown", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["activeDateTime", "allotmentLicensesCount", "assignedCount", "displayName", "expirationDateTime", "id", "latestLicenseStartDateTime", "licensesCount", "nextBillingDateTime", "servicePlanId", "subscriptionId"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
