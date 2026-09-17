variable "connector_version" {
  description = "The build version of the Ndes Connector."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The friendly name of the Ndes Connector."
  type        = string
  default     = null
}

variable "enrolled_date_time" {
  description = "Timestamp when on-prem certificate connector was enrolled in Intune."
  type        = string
  default     = null
}

variable "last_connection_date_time" {
  description = "Last connection time for the Ndes Connector"
  type        = string
  default     = null
}

variable "machine_name" {
  description = "Name of the machine running on-prem certificate connector service."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.ndesConnector"
  nullable    = false
}

variable "role_scope_tag_ids" {
  description = "List of Scope Tags for this Entity instance."
  type        = list(string)
  default     = null
}

variable "state" {
  description = "The current status of the Ndes Connector."
  type        = string
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["none", "active", "inactive"], var.state)
    error_message = "state must be one of the documented enum values."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["healthChecks", "healthStatus", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
