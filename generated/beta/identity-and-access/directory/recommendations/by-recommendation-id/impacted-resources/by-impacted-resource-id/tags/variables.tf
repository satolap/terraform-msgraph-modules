variable "recommendation_id" {
  description = "The unique identifier of recommendation"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.recommendation_id)) > 0
    error_message = "recommendation_id must not be empty."
  }
}

variable "impacted_resource_id" {
  description = "The unique identifier of impactedResource"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.impacted_resource_id)) > 0
    error_message = "impacted_resource_id must not be empty."
  }
}

variable "display_name" {
  description = "Microsoft Graph displayName property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.recommendationTag"
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
