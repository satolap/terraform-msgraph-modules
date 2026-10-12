variable "citation_jurisdiction" {
  description = "Represents the jurisdiction or agency that published the citation."
  type        = string
  default     = null
}

variable "citation_url" {
  description = "Represents the URL to the published citation."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Unique string that defines a filePlanDescriptorTemplate name."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.citationTemplate"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdBy", "createdDateTime", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
