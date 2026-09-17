variable "case_id" {
  description = "The unique identifier of case"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.case_id)) > 0
    error_message = "case_id must not be empty."
  }
}

variable "assigned_to" {
  description = "The user assigned to the task. Supports $filter."
  type        = string
  default     = null
}

variable "category" {
  description = "Microsoft Graph category property."
  type        = string
  default     = null

  validation {
    condition     = var.category == null ? true : contains(["uncategorized", "triage", "contain", "investigate", "remediate", "prevent", "unknownFutureValue"], var.category)
    error_message = "category must be one of the documented enum values."
  }
}

variable "closing_notes" {
  description = "Notes recorded when the task is completed. Supports $filter."
  type        = string
  default     = null
}

variable "created_by" {
  description = "The user or service that created the resource."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "The date and time when the resource was created."
  type        = string
  default     = null
}

variable "description" {
  description = "The description of the task. Supports $filter."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The title of the task. Supports $filter."
  type        = string
  default     = null
}

variable "due_date_time" {
  description = "The target completion date and time for the task. Supports $filter."
  type        = string
  default     = null
}

variable "last_modified_by" {
  description = "The user or service that last modified the resource."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time when the resource was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.caseManagement.task"
  nullable    = false
}

variable "priority" {
  description = "Microsoft Graph priority property."
  type        = string
  default     = null

  validation {
    condition     = var.priority == null ? true : contains(["notSet", "veryLow", "low", "medium", "high", "critical", "unknownFutureValue"], var.priority)
    error_message = "priority must be one of the documented enum values."
  }
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["notSet", "new", "inProgress", "failed", "partiallyCompleted", "skipped", "completed", "unknownFutureValue"], var.status)
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
