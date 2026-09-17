variable "one_drive_for_business_restore_session_id" {
  description = "The unique identifier of oneDriveForBusinessRestoreSession"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.one_drive_for_business_restore_session_id)) > 0
    error_message = "one_drive_for_business_restore_session_id must not be empty."
  }
}

variable "created_by" {
  description = "The identity of the person who created the bulk request."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The time when the bulk request was created."
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

variable "directory_object_ids" {
  description = "The list of directory object IDs that are added to the corresponding OneDrive for work or school restore session in a bulk operation."
  type        = list(string)
  default     = null
}

variable "display_name" {
  description = "Name of the addition request."
  type        = string
  default     = null
}

variable "drives" {
  description = "The list of email addresses that are added to the corresponding OneDrive for work or school restore session in a bulk operation."
  type        = list(string)
  default     = null
}

variable "error" {
  description = "Error details are populated for resource resolution failures."
  type        = any
  default     = null
}

variable "last_modified_by" {
  description = "Identity of the person who last modified this entity."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "Timestamp when this entity was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.driveRestoreArtifactsBulkAdditionRequest"
  nullable    = false
}

variable "protection_time_period" {
  description = "The start and end date and time of the protection period."
  type        = any
  default     = null
}

variable "protection_unit_ids" {
  description = "Indicates which protection units to restore. This property isn't implemented yet. Future value; don't use."
  type        = list(string)
  default     = null
}

variable "restore_point_preference" {
  description = "Indicates which restore point to return. The possible values are: oldest, latest, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.restore_point_preference == null ? true : contains(["latest", "oldest", "unknownFutureValue"], var.restore_point_preference)
    error_message = "restore_point_preference must be one of the documented enum values."
  }
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

variable "tags" {
  description = "The type of the restore point. The possible values are: none, fastRestore, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.tags == null ? true : contains(["none", "fastRestore", "unknownFutureValue"], var.tags)
    error_message = "tags must be one of the documented enum values."
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
