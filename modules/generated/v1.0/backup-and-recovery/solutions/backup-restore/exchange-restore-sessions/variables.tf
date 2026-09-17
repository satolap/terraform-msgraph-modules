variable "completed_date_time" {
  description = "The time of completion of the restore session."
  type        = string
  default     = null
}

variable "created_by" {
  description = "The identity of person who created the restore session."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The time of creation of the restore session."
  type        = string
  default     = null
}

variable "error" {
  description = "Contains error details if the restore session fails or completes with an error."
  type        = any
  default     = null
}

variable "granular_mailbox_restore_artifacts" {
  description = "Microsoft Graph granularMailboxRestoreArtifacts property."
  type = list(object({
    odata_type         = optional(string, "#microsoft.graph.granularMailboxRestoreArtifact")
    artifactCount      = optional(number)
    completionDateTime = optional(string)
    destinationType    = optional(any)
    error              = optional(any)
    restorePoint       = optional(any)
    restoredFolderId   = optional(string)
    restoredItemCount  = optional(number)
    searchResponseId   = optional(string)
    startDateTime      = optional(string)
    status             = optional(any)
  }))
  default = null
}

variable "last_modified_by" {
  description = "Identity of the person who last modified the restore session."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "Timestamp of the last modification of the restore session."
  type        = string
  default     = null
}

variable "mailbox_restore_artifacts" {
  description = "A collection of restore points and destination details that can be used to restore Exchange mailboxes."
  type = list(object({
    odata_type         = optional(string, "#microsoft.graph.mailboxRestoreArtifact")
    completionDateTime = optional(string)
    destinationType    = optional(any)
    error              = optional(any)
    restorePoint       = optional(any)
    restoredFolderId   = optional(string)
    restoredItemCount  = optional(number)
    startDateTime      = optional(string)
    status             = optional(any)
  }))
  default = null
}

variable "mailbox_restore_artifacts_bulk_addition_requests" {
  description = "A collection of user mailboxes and destination details that can be used to restore Exchange mailboxes."
  type = list(object({
    odata_type             = optional(string, "#microsoft.graph.mailboxRestoreArtifactsBulkAdditionRequest")
    createdBy              = optional(any)
    createdDateTime        = optional(string)
    destinationType        = optional(any)
    directoryObjectIds     = optional(list(string))
    displayName            = optional(string)
    error                  = optional(any)
    lastModifiedBy         = optional(any)
    lastModifiedDateTime   = optional(string)
    mailboxes              = optional(list(string))
    protectionTimePeriod   = optional(any)
    protectionUnitIds      = optional(list(string))
    restorePointPreference = optional(any)
    status                 = optional(string)
    tags                   = optional(any)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.exchangeRestoreSession"
  nullable    = false
}

variable "restore_job_type" {
  description = "Indicates whether the restore session was created normally or by a bulk job."
  type        = any
  default     = null

  validation {
    condition     = var.restore_job_type == null ? true : contains(["standard", "bulk", "unknownFutureValue", "granular"], var.restore_job_type)
    error_message = "restore_job_type must be one of the documented enum values."
  }
}

variable "restore_session_artifact_count" {
  description = "The number of metadata artifacts that belong to this restore session."
  type        = any
  default     = null
}

variable "status" {
  description = "Status of the restore session. The value is an aggregated status of the restored artifacts. The possible values are: draft, activating, active, completedWithError, completed, unknownFutureValue, failed. Use the Prefer: include-unknown-enum-members request header to get the following members in this evolvable enum: failed."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["draft", "activating", "active", "completedWithError", "completed", "unknownFutureValue", "failed"], var.status)
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
