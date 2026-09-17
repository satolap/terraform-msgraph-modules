variable "education_class_id" {
  description = "The unique identifier of educationClass"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.education_class_id)) > 0
    error_message = "education_class_id must not be empty."
  }
}

variable "education_assignment_id" {
  description = "The unique identifier of educationAssignment"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.education_assignment_id)) > 0
    error_message = "education_assignment_id must not be empty."
  }
}

variable "education_assignment_resource_id" {
  description = "The unique identifier of educationAssignmentResource"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.education_assignment_resource_id)) > 0
    error_message = "education_assignment_resource_id must not be empty."
  }
}

variable "dependent_resources" {
  description = "A collection of assignment resources that depend on the parent educationAssignmentResource."
  type = list(object({
    odata_type               = optional(string, "#microsoft.graph.educationAssignmentResource")
    dependentResources       = optional(any)
    distributeForStudentWork = optional(bool)
    resource                 = optional(any)
  }))
  default = null
}

variable "distribute_for_student_work" {
  description = "Indicates whether this resource should be copied to each student submission for modification and submission. Required"
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.educationAssignmentResource"
  nullable    = false
}

variable "resource" {
  description = "Resource object that is associated with this assignment."
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
