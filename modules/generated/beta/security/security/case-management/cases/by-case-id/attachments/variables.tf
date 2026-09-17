variable "case_id" {
  description = "The unique identifier of case"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.case_id)) > 0
    error_message = "case_id must not be empty."
  }
}

variable "content" {
  description = "The binary content stream for the attachment. Use the Upload content and Download content methods to access it."
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
  description = "The description of the attachment."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the attachment."
  type        = string
  default     = null
}

variable "file_extension" {
  description = "The file extension of the attachment. The service normalizes the value to include a leading period."
  type        = string
  default     = null
}

variable "file_size" {
  description = "The size of the attachment in bytes. The maximum file size is 100 MB."
  type        = number
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
  default     = "#microsoft.graph.security.caseManagement.attachment"
  nullable    = false
}

variable "origin" {
  description = "The origin reference for the attachment."
  type        = any
  default     = null
}

variable "scan_result" {
  description = "Microsoft Graph scanResult property."
  type        = string
  default     = null

  validation {
    condition     = var.scan_result == null ? true : contains(["unscanned", "noThreatsFound", "malicious", "unknownFutureValue"], var.scan_result)
    error_message = "scan_result must be one of the documented enum values."
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
