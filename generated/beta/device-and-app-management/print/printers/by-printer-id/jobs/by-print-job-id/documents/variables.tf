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

variable "configuration" {
  description = "Microsoft Graph configuration property."
  type = object({
    odata_type      = optional(string, "#microsoft.graph.printerDocumentConfiguration")
    collate         = optional(bool)
    colorMode       = optional(any)
    copies          = optional(number)
    dpi             = optional(number)
    duplexMode      = optional(any)
    feedDirection   = optional(any)
    feedOrientation = optional(any)
    finishings      = optional(any)
    fitPdfToPage    = optional(bool)
    inputBin        = optional(string)
    margin          = optional(any)
    mediaSize       = optional(string)
    mediaType       = optional(string)
    multipageLayout = optional(any)
    orientation     = optional(any)
    outputBin       = optional(string)
    pageRanges = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.integerRange")
      end        = optional(number)
      maximum    = optional(number)
      minimum    = optional(number)
      start      = optional(number)
    })))
    pagesPerSheet = optional(number)
    quality       = optional(any)
    scaling       = optional(any)
  })
  default = null
}

variable "downloaded_date_time" {
  description = "Microsoft Graph downloadedDateTime property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.printDocument"
  nullable    = false
}

variable "uploaded_date_time" {
  description = "Microsoft Graph uploadedDateTime property."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["contentType", "displayName", "id", "size"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
