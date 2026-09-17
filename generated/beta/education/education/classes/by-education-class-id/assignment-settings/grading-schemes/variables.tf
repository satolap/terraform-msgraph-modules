variable "education_class_id" {
  description = "The unique identifier of educationClass"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.education_class_id)) > 0
    error_message = "education_class_id must not be empty."
  }
}

variable "display_name" {
  description = "The name of the grading scheme."
  type        = string
  default     = null
}

variable "grades" {
  description = "The grades that make up the scheme."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.educationGradingSchemeGrade")
    defaultPercentage = optional(any)
    displayName       = optional(string)
    minPercentage     = optional(any)
  }))
  default = null
}

variable "hide_points_during_grading" {
  description = "The display setting for the UI. Indicates whether teachers can grade with points in addition to letter grades."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.educationGradingScheme"
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
