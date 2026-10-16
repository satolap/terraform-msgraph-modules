variable "share_point_restore_session_id" {
  description = "The unique identifier of sharePointRestoreSession"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.share_point_restore_session_id)) > 0
    error_message = "share_point_restore_session_id must not be empty."
  }
}

variable "browse_session_id" {
  description = "The unique identifier of the browseSession"
  type        = string
  default     = null
}

variable "completion_date_time" {
  description = "Date time when the artifact's restoration completes."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.granularSiteRestoreArtifact"
  nullable    = false
}

variable "restore_point_date_time" {
  description = "The restore point date time to which the artifact is restored."
  type        = string
  default     = null
}

variable "restored_item_key" {
  description = "The unique identifier for the restored artifact."
  type        = string
  default     = null
}

variable "restored_item_path" {
  description = "The path of the restored artifact. It's the path of the folder where all the artifacts are restored within a granular restore session."
  type        = string
  default     = null
}

variable "restored_item_web_url" {
  description = "The web url of the restored artifact."
  type        = string
  default     = null
}

variable "site_id" {
  description = "Id of the site in which artifact is present."
  type        = string
  default     = null
}

variable "start_date_time" {
  description = "The start time of the restoration."
  type        = string
  default     = null
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["added", "scheduling", "scheduled", "inProgress", "succeeded", "failed", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "web_url" {
  description = "The original web url of the artifact being restored."
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
