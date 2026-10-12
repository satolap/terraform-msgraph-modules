variable "blue_screen_count" {
  description = "Microsoft Graph blueScreenCount property."
  type        = number
  default     = null
}

variable "boot_total_duration_in_seconds" {
  description = "Microsoft Graph bootTotalDurationInSeconds property."
  type        = any
  default     = null
}

variable "device_id" {
  description = "Microsoft Graph deviceId property."
  type        = string
  default     = null
}

variable "device_make" {
  description = "Microsoft Graph deviceMake property."
  type        = string
  default     = null
}

variable "device_model" {
  description = "Microsoft Graph deviceModel property."
  type        = string
  default     = null
}

variable "device_name" {
  description = "Microsoft Graph deviceName property."
  type        = string
  default     = null
}

variable "health_status" {
  description = "Microsoft Graph healthStatus property."
  type        = string
  default     = null
}

variable "last_updated_date_time" {
  description = "Microsoft Graph lastUpdatedDateTime property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedTenants.deviceHealthStatus"
  nullable    = false
}

variable "os_version" {
  description = "Microsoft Graph osVersion property."
  type        = string
  default     = null
}

variable "primary_disk_type" {
  description = "Microsoft Graph primaryDiskType property."
  type        = string
  default     = null
}

variable "restart_count" {
  description = "Microsoft Graph restartCount property."
  type        = number
  default     = null
}

variable "startup_performance_score" {
  description = "Microsoft Graph startupPerformanceScore property."
  type        = any
  default     = null
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

variable "top_processes" {
  description = "Microsoft Graph topProcesses property."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
