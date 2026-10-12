variable "app_friendly_name" {
  description = "Microsoft Graph appFriendlyName property."
  type        = string
  default     = null
}

variable "app_name" {
  description = "Microsoft Graph appName property."
  type        = string
  default     = null
}

variable "app_publisher" {
  description = "Microsoft Graph appPublisher property."
  type        = string
  default     = null
}

variable "last_updated_date_time" {
  description = "Microsoft Graph lastUpdatedDateTime property."
  type        = string
  default     = null
}

variable "mean_time_to_failure_in_minutes" {
  description = "Microsoft Graph meanTimeToFailureInMinutes property."
  type        = number
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedTenants.appPerformance"
  nullable    = false
}

variable "tenant_display_name" {
  description = "Microsoft Graph tenantDisplayName property."
  type        = string
  default     = null
}

variable "tenant_id" {
  description = "Microsoft Graph tenantId property."
  type        = string
  default     = null
}

variable "total_active_device_count" {
  description = "Microsoft Graph totalActiveDeviceCount property."
  type        = number
  default     = null
}

variable "total_app_crash_count" {
  description = "Microsoft Graph totalAppCrashCount property."
  type        = number
  default     = null
}

variable "total_app_freeze_count" {
  description = "Microsoft Graph totalAppFreezeCount property."
  type        = number
  default     = null
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
