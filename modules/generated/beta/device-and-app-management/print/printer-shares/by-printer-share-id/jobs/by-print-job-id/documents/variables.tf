variable "printer_share_id" {
  description = "The unique identifier of printerShare"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.printer_share_id)) > 0
    error_message = "printer_share_id must not be empty."
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
    colorMode       = optional(string)
    copies          = optional(number)
    dpi             = optional(number)
    duplexMode      = optional(string)
    feedDirection   = optional(string)
    feedOrientation = optional(string)
    finishings      = optional(list(string))
    fitPdfToPage    = optional(bool)
    inputBin        = optional(string)
    margin = optional(object({
      odata_type = optional(string, "#microsoft.graph.printMargin")
      bottom     = optional(number)
      left       = optional(number)
      right      = optional(number)
      top        = optional(number)
    }))
    mediaSize       = optional(string)
    mediaType       = optional(string)
    multipageLayout = optional(string)
    orientation     = optional(string)
    outputBin       = optional(string)
    pageRanges = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.integerRange")
      end        = optional(number)
      maximum    = optional(number)
      minimum    = optional(number)
      start      = optional(number)
    })))
    pagesPerSheet = optional(number)
    quality       = optional(string)
    scaling       = optional(string)
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
