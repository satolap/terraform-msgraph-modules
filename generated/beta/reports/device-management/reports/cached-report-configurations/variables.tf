variable "expiration_date_time" {
  description = "Time that the cached report expires."
  type        = string
  default     = null
}

variable "filter" {
  description = "Filters applied on report creation."
  type        = string
  default     = null
}

variable "last_refresh_date_time" {
  description = "Time that the cached report was last refreshed."
  type        = string
  default     = null
}

variable "metadata" {
  description = "Caller-managed metadata associated with the report."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagementCachedReportConfiguration"
  nullable    = false
}

variable "order_by" {
  description = "Ordering of columns in the report."
  type        = list(string)
  default     = null
}

variable "report_name" {
  description = "Name of the report."
  type        = string
  default     = null
}

variable "select" {
  description = "Columns selected from the report."
  type        = list(string)
  default     = null
}

variable "status" {
  description = "Possible statuses associated with a generated report."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["unknown", "notStarted", "inProgress", "completed", "failed"], var.status)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
