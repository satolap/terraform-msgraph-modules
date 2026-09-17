variable "terms_and_conditions_id" {
  description = "The unique identifier of termsAndConditions"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.terms_and_conditions_id)) > 0
    error_message = "terms_and_conditions_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.termsAndConditionsAssignment"
  nullable    = false
}

variable "target" {
  description = "Assignment target that the T&C policy is assigned to."
  type        = any
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
