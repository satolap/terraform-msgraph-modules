variable "agent_setting" {
  description = "The agent settings associated with the external partner."
  type        = any
  default     = null
}

variable "connection_status" {
  description = "Microsoft Graph connectionStatus property."
  type        = string
  default     = null

  validation {
    condition     = var.connection_status == null ? true : contains(["notAvailable", "available", "healthy", "unhealthy", "unknownFutureValue"], var.connection_status)
    error_message = "connection_status must be one of the documented enum values."
  }
}

variable "enable_connection" {
  description = "Enable or disable the connection to an external partner. If true, an external partner API accepts incoming calls from external partners. Required. Supports $filter (eq)."
  type        = bool
  default     = null
}

variable "last_sync_date_time" {
  description = "Last data sync time for this external partner. The timeStamp type represents date and time information in ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 looks like this: '2014-01-01T00:00:00Z'."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.cloudPcExternalPartner"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "partnerId", "statusDetails"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
