variable "drive_id" {
  description = "The unique identifier of drive"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.drive_id)) > 0
    error_message = "drive_id must not be empty."
  }
}

variable "drive_item_id" {
  description = "The unique identifier of driveItem"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.drive_item_id)) > 0
    error_message = "drive_item_id must not be empty."
  }
}

variable "workbook_worksheet_id" {
  description = "The unique identifier of workbookWorksheet"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.workbook_worksheet_id)) > 0
    error_message = "workbook_worksheet_id must not be empty."
  }
}

variable "workbook_document_task_id" {
  description = "The unique identifier of workbookDocumentTask"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.workbook_document_task_id)) > 0
    error_message = "workbook_document_task_id must not be empty."
  }
}

variable "content" {
  description = "The content of the reply that is the displayed to end-users."
  type        = string
  default     = null
}

variable "content_type" {
  description = "The content type for the reply. Supported values are: plain, mention."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.workbookCommentReply"
  nullable    = false
}

variable "task" {
  description = "The task associated with the comment thread."
  type        = any
  default     = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "mentions", "richContent"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
