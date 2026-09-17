variable "action_summary" {
  description = "Run summary of this bulk action."
  type        = any
  default     = null
}

variable "cloud_pc_ids" {
  description = "Microsoft Graph cloudPcIds property."
  type        = list(string)
  default     = null
}

variable "created_date_time" {
  description = "The date and time when the bulk action was created. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Name of the bulk action."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.cloudPcBulkAction"
  nullable    = false
}

variable "scheduled_during_maintenance_window" {
  description = "Indicates whether the bulk action is scheduled according to the maintenance window. When true, the bulk action uses the maintenance window to schedule the action; false means that the bulk action doesn't use the maintenance window. The default value is false."
  type        = bool
  default     = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "initiatedByUserPrincipalName", "status"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
