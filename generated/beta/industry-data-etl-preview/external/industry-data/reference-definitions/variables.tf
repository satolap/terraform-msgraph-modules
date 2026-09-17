variable "code" {
  description = "The code value for the definition that must be unique within the referenceType."
  type        = string
  default     = null
}

variable "display_name" {
  description = "A human-readable representation of the reference code value for display in a user interface."
  type        = string
  default     = null
}

variable "is_disabled" {
  description = "Indicates whether the definition is disabled."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.industryData.referenceDefinition"
  nullable    = false
}

variable "reference_type" {
  description = "The categorical type for a collection of enumerated values."
  type        = string
  default     = null
}

variable "sort_index" {
  description = "The index that specifies the order in which to present the definition to the user. Must be unique within the referenceType."
  type        = number
  default     = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "lastModifiedDateTime", "source"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
