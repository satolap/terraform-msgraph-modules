variable "exchange_restore_session_id" {
  description = "The unique identifier of exchangeRestoreSession"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.exchange_restore_session_id)) > 0
    error_message = "exchange_restore_session_id must not be empty."
  }
}

variable "completion_date_time" {
  description = "The time when restoration of restore artifact is completed."
  type        = string
  default     = null
}

variable "destination_type" {
  description = "Indicates the restoration destination. The possible values are: new, inPlace, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.destination_type == null ? true : contains(["new", "inPlace", "unknownFutureValue"], var.destination_type)
    error_message = "destination_type must be one of the documented enum values."
  }
}

variable "error" {
  description = "Contains error details if the restore session fails or completes with an error."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.mailboxRestoreArtifact"
  nullable    = false
}

variable "restore_point" {
  description = "Represents the date and time when an artifact is protected by a protectionPolicy and can be restored."
  type        = any
  default     = null
}

variable "restored_folder_id" {
  description = "The newly restored folder identifier for the user."
  type        = string
  default     = null
}

variable "restored_item_count" {
  description = "The number of items that are being restored in the folder."
  type        = number
  default     = null
}

variable "start_date_time" {
  description = "The time when restoration of restore artifact is started."
  type        = string
  default     = null
}

variable "status" {
  description = "The individual restoration status of the restore artifact. The possible values are: added, scheduling, scheduled, inProgress, succeeded, failed, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["added", "scheduling", "scheduled", "inProgress", "succeeded", "failed", "unknownFutureValue"], var.status)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "restoredFolderName"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
