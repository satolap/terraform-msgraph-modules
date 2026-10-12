variable "description" {
  description = "The search answer description that is shown on the search results page."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The search answer name that is displayed in search results."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.search.acronym"
  nullable    = false
}

variable "stands_for" {
  description = "What the acronym stands for."
  type        = string
  default     = null
}

variable "state" {
  description = "Microsoft Graph state property."
  type        = string
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["published", "draft", "excluded", "unknownFutureValue"], var.state)
    error_message = "state must be one of the documented enum values."
  }
}

variable "web_url" {
  description = "The URL link for the search answer. When users select this search answer from the search results, they're directed to the specified URL."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "lastModifiedBy", "lastModifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
