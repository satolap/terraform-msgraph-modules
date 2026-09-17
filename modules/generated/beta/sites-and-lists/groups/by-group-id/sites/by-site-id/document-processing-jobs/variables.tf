variable "group_id" {
  description = "The unique identifier of group"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.group_id)) > 0
    error_message = "group_id must not be empty."
  }
}

variable "site_id" {
  description = "The unique identifier of site"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.site_id)) > 0
    error_message = "site_id must not be empty."
  }
}

variable "job_type" {
  description = "The document processing job type. The possible values are: file, folder"
  type        = any
  default     = null

  validation {
    condition     = var.job_type == null ? true : contains(["file", "folder", "unknownFutureValue"], var.job_type)
    error_message = "job_type must be one of the documented enum values."
  }
}

variable "list_item_unique_id" {
  description = "The listItemUniqueId of the file, or folder to process. Use GET driveItem resource operation and read  sharepointIds property to get listItemUniqueId."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.documentProcessingJob"
  nullable    = false
}

variable "status" {
  description = "The document processing Job status. The possible values are: inProgress, completed, failed, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["inProgress", "completed", "failed", "unknownFutureValue"], var.status)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
