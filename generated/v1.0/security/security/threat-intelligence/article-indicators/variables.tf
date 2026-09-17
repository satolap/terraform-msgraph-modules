variable "artifact" {
  description = "Microsoft Graph artifact property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.security.artifact")
  })
  default = null
}

variable "graph_source" {
  description = "Microsoft Graph source property."
  type        = string
  default     = null

  validation {
    condition     = var.graph_source == null ? true : contains(["microsoft", "osint", "public", "unknownFutureValue"], var.graph_source)
    error_message = "graph_source must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.articleIndicator"
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
