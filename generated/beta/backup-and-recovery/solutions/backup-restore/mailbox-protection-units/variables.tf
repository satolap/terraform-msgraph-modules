variable "backup_retention_period_in_days" {
  description = "The retention period of the backup, in days."
  type        = number
  default     = null
}

variable "billing_policy_id" {
  description = "The unique identifier of the billing policy assigned to the protection unit for cost allocation."
  type        = string
  default     = null
}

variable "created_by" {
  description = "The identity of person who created the protection unit."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The time of creation of the protection unit."
  type        = string
  default     = null
}

variable "directory_object_id" {
  description = "The ID of the directory object."
  type        = string
  default     = null
}

variable "error" {
  description = "Contains error details if an error occurred while creating a protection unit."
  type        = any
  default     = null
}

variable "last_modified_by" {
  description = "The identity of person who last modified the protection unit."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "Timestamp of the last modification of this protection unit."
  type        = string
  default     = null
}

variable "mailbox_type" {
  description = "The type of mailbox which is assigned to the user with id: directoryObjectId.The possible values are: unknown, user, shared, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.mailbox_type == null ? true : contains(["unknown", "user", "shared", "unknownFutureValue"], var.mailbox_type)
    error_message = "mailbox_type must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.mailboxProtectionUnit"
  nullable    = false
}

variable "offboard_requested_date_time" {
  description = "The time when protection unit offboard was requested."
  type        = string
  default     = null
}

variable "policy_id" {
  description = "The unique identifier of the protection policy based on which protection unit was created."
  type        = string
  default     = null
}

variable "protection_sources" {
  description = "Microsoft Graph protectionSources property."
  type        = string
  default     = null

  validation {
    condition     = var.protection_sources == null ? true : contains(["none", "manual", "dynamicRule", "unknownFutureValue"], var.protection_sources)
    error_message = "protection_sources must be one of the documented enum values."
  }
}

variable "status" {
  description = "The status of the protection unit. The possible values are: protectRequested, protected, unprotectRequested, unprotected, removeRequested, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["protectRequested", "protected", "unprotectRequested", "unprotected", "removeRequested", "unknownFutureValue", "offboardRequested", "offboarded", "cancelOffboardRequested"], var.status)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["displayName", "email", "id", "pendingRetentionPeriodChange"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
