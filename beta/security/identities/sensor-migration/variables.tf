variable "created_date_time" {
  description = "The date and time the sensor was created."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the sensor."
  type        = string
  default     = null
}

variable "domain_name" {
  description = "The fully qualified domain name (FQDN) of the domain controller where the sensor is installed."
  type        = string
  default     = null
}

variable "graph_version" {
  description = "The version number of the sensor software."
  type        = string
  default     = null
}

variable "health_status" {
  description = "Microsoft Graph healthStatus property."
  type        = string
  default     = null

  validation {
    condition     = var.health_status == null ? true : contains(["healthy", "notHealthyLow", "notHealthyMedium", "notHealthyHigh", "unknownFutureValue"], var.health_status)
    error_message = "health_status must be one of the documented enum values."
  }
}

variable "migration_state" {
  description = "Microsoft Graph migrationState property."
  type        = string
  default     = null

  validation {
    condition     = var.migration_state == null ? true : contains(["readyForMigration", "notReadyForMigration", "upToDate", "migrationFailed", "migrating", "unknownFutureValue"], var.migration_state)
    error_message = "migration_state must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.sensorMigration"
  nullable    = false
}

variable "sensor_type" {
  description = "Microsoft Graph sensorType property."
  type        = string
  default     = null

  validation {
    condition     = var.sensor_type == null ? true : contains(["adConnectIntegrated", "adcsIntegrated", "adfsIntegrated", "domainControllerIntegrated", "domainControllerStandalone", "unknownFutureValue"], var.sensor_type)
    error_message = "sensor_type must be one of the documented enum values."
  }
}

variable "service_status" {
  description = "Microsoft Graph serviceStatus property."
  type        = string
  default     = null

  validation {
    condition     = var.service_status == null ? true : contains(["stopped", "starting", "running", "disabled", "onboarding", "unknown", "unknownFutureValue"], var.service_status)
    error_message = "service_status must be one of the documented enum values."
  }
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
