variable "ediscovery_case_id" {
  description = "The unique identifier of ediscoveryCase"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.ediscovery_case_id)) > 0
    error_message = "ediscovery_case_id must not be empty."
  }
}

variable "created_date_time" {
  description = "Created date and time of the dataSourceContainer entity."
  type        = string
  default     = null
}

variable "data_source" {
  description = "User source or SharePoint site data source as noncustodial data source."
  type        = any
  default     = null
}

variable "display_name" {
  description = "Display name of the dataSourceContainer entity."
  type        = string
  default     = null
}

variable "hold_status" {
  description = "The hold status of the dataSourceContainer. The possible values are: notApplied, applied, applying, removing, partial"
  type        = any
  default     = null

  validation {
    condition     = var.hold_status == null ? true : contains(["notApplied", "applied", "applying", "removing", "partial", "unknownFutureValue"], var.hold_status)
    error_message = "hold_status must be one of the documented enum values."
  }
}

variable "last_index_operation" {
  description = "Operation entity that represents the latest indexing for the noncustodial data source."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "Last modified date and time of the dataSourceContainer."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.ediscoveryNoncustodialDataSource"
  nullable    = false
}

variable "released_date_time" {
  description = "Date and time that the dataSourceContainer was released from the case."
  type        = string
  default     = null
}

variable "status" {
  description = "Latest status of the dataSourceContainer. The possible values are: Active, Released."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["active", "released", "unknownFutureValue"], var.status)
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
