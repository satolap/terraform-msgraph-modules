variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.mobileAppRelationship"
  nullable    = false
}

variable "target_type" {
  description = "Indicates whether the target of a relationship is the parent or the child in the relationship."
  type        = string
  default     = null

  validation {
    condition     = var.target_type == null ? true : contains(["child", "parent", "unknownFutureValue"], var.target_type)
    error_message = "target_type must be one of the documented enum values."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "sourceDisplayName", "sourceDisplayVersion", "sourceId", "sourcePublisherDisplayName", "targetDisplayName", "targetDisplayVersion", "targetId", "targetPublisher", "targetPublisherDisplayName"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
