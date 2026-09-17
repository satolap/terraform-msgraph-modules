variable "education_user_id" {
  description = "The unique identifier of educationUser"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.education_user_id)) > 0
    error_message = "education_user_id must not be empty."
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

variable "education_submission_id" {
  description = "The unique identifier of educationSubmission"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.education_submission_id)) > 0
    error_message = "education_submission_id must not be empty."
  }
}

variable "education_submission_resource_id" {
  description = "The unique identifier of educationSubmissionResource"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.education_submission_resource_id)) > 0
    error_message = "education_submission_resource_id must not be empty."
  }
}

variable "assignment_resource_url" {
  description = "Pointer to the assignment from which the resource was copied. If the value is null, the student uploaded the resource."
  type        = string
  default     = null
}

variable "dependent_resources" {
  description = "A collection of submission resources that depend on the parent educationSubmissionResource."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.educationSubmissionResource")
    assignmentResourceUrl = optional(string)
    dependentResources    = optional(any)
    resource              = optional(any)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.educationSubmissionResource"
  nullable    = false
}

variable "resource" {
  description = "Resource object."
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
