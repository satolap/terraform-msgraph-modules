variable "education_class_id" {
  description = "The unique identifier of educationClass"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.education_class_id)) > 0
    error_message = "education_class_id must not be empty."
  }
}

variable "description" {
  description = "Description of the module."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Name of the module."
  type        = string
  default     = null
}

variable "is_pinned" {
  description = "Indicates whether the module is pinned or not."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.educationModule"
  nullable    = false
}

variable "resources" {
  description = "Learning objects that are associated with this module. Only teachers can modify this list. Nullable."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.educationModuleResource")
    resource   = optional(any)
  }))
  default = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdBy", "createdDateTime", "id", "lastModifiedBy", "lastModifiedDateTime", "resourcesFolderUrl", "status"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
