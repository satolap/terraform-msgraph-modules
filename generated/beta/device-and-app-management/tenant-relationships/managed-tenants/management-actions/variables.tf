variable "category" {
  description = "Microsoft Graph category property."
  type        = string
  default     = null

  validation {
    condition     = var.category == null ? true : contains(["custom", "devices", "identity", "data", "unknownFutureValue"], var.category)
    error_message = "category must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedTenants.managementAction"
  nullable    = false
}

variable "reference_template_version" {
  description = "Microsoft Graph referenceTemplateVersion property."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["description", "displayName", "id", "referenceTemplateId", "workloadActions"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
