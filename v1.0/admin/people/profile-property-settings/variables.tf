variable "display_name" {
  description = "Name of the property-level setting."
  type        = string
  default     = null
}

variable "name" {
  description = "Other name of the property-level setting. For backward compatibility."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.profilePropertySetting"
  nullable    = false
}

variable "prioritized_source_urls" {
  description = "A collection of prioritized profile source URLs ordered by data precedence within an organization."
  type        = list(string)
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
