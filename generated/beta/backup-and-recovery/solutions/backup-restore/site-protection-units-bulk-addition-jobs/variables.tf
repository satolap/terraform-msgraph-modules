variable "created_by" {
  description = "The identity of person who created the job."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The time of creation of the job."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The name of the protection units bulk addition job."
  type        = string
  default     = null
}

variable "error" {
  description = "Error details containing resource resolution failures, if any."
  type        = any
  default     = null
}

variable "last_modified_by" {
  description = "The identity of the person who last modified the job."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "Timestamp of the last modification made to the job."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.siteProtectionUnitsBulkAdditionJob"
  nullable    = false
}

variable "site_ids" {
  description = "The list of SharePoint site IDs to add to the SharePoint protection policy."
  type        = list(string)
  default     = null
}

variable "site_web_urls" {
  description = "The list of SharePoint site URLs to add to the SharePoint protection policy."
  type        = list(string)
  default     = null
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["unknown", "active", "completed", "completedWithErrors", "unknownFutureValue"], var.status)
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
