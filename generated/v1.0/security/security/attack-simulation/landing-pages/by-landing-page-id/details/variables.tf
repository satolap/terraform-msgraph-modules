variable "landing_page_id" {
  description = "The unique identifier of landingPage"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.landing_page_id)) > 0
    error_message = "landing_page_id must not be empty."
  }
}

variable "content" {
  description = "Landing page detail content."
  type        = string
  default     = null
}

variable "is_default_langauge" {
  description = "Indicates whether this language detail is default for the landing page."
  type        = bool
  default     = null
}

variable "language" {
  description = "The content language for the landing page."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.landingPageDetail"
  nullable    = false
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
