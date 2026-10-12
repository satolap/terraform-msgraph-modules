variable "printer_id" {
  description = "The unique identifier of printer"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.printer_id)) > 0
    error_message = "printer_id must not be empty."
  }
}

variable "print_job_id" {
  description = "The unique identifier of printJob"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.print_job_id)) > 0
    error_message = "print_job_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.printDocument"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["contentType", "displayName", "downloadedDateTime", "id", "size", "uploadedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
