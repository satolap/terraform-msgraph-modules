variable "black_and_white_page_count" {
  description = "Microsoft Graph blackAndWhitePageCount property."
  type        = number
  default     = null
}

variable "color_page_count" {
  description = "Microsoft Graph colorPageCount property."
  type        = number
  default     = null
}

variable "completed_black_and_white_job_count" {
  description = "Microsoft Graph completedBlackAndWhiteJobCount property."
  type        = number
  default     = null
}

variable "completed_color_job_count" {
  description = "Microsoft Graph completedColorJobCount property."
  type        = number
  default     = null
}

variable "completed_job_count" {
  description = "Microsoft Graph completedJobCount property."
  type        = number
  default     = null
}

variable "double_sided_sheet_count" {
  description = "Microsoft Graph doubleSidedSheetCount property."
  type        = number
  default     = null
}

variable "incomplete_job_count" {
  description = "Microsoft Graph incompleteJobCount property."
  type        = number
  default     = null
}

variable "media_sheet_count" {
  description = "Microsoft Graph mediaSheetCount property."
  type        = number
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.printUsage"
  nullable    = false
}

variable "page_count" {
  description = "Microsoft Graph pageCount property."
  type        = number
  default     = null
}

variable "single_sided_sheet_count" {
  description = "Microsoft Graph singleSidedSheetCount property."
  type        = number
  default     = null
}

variable "usage_date" {
  description = "Microsoft Graph usageDate property."
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
