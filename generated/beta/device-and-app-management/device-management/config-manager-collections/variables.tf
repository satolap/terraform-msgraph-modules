variable "collection_identifier" {
  description = "The collection identifier in SCCM."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "The created date."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The DisplayName."
  type        = string
  default     = null
}

variable "hierarchy_identifier" {
  description = "The Hierarchy Identifier."
  type        = string
  default     = null
}

variable "hierarchy_name" {
  description = "The HierarchyName."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "The last modified date."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.configManagerCollection"
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
