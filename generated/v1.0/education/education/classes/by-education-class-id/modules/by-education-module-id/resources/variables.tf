variable "education_class_id" {
  description = "The unique identifier of educationClass"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.education_class_id)) > 0
    error_message = "education_class_id must not be empty."
  }
}

variable "education_module_id" {
  description = "The unique identifier of educationModule"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.education_module_id)) > 0
    error_message = "education_module_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.educationModuleResource"
  nullable    = false
}

variable "resource" {
  description = "Resource object that is with this module."
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
