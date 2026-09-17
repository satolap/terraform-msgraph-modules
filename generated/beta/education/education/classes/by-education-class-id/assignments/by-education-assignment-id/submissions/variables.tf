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

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.educationSubmission"
  nullable    = false
}

variable "outcomes" {
  description = "Microsoft Graph outcomes property."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.educationOutcome")
    lastModifiedBy       = optional(any)
    lastModifiedDateTime = optional(string)
  }))
  default = null
}

variable "recipient" {
  description = "Who this submission is assigned to."
  type        = any
  default     = null
}

variable "resources" {
  description = "Microsoft Graph resources property."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.educationSubmissionResource")
    assignmentResourceUrl = optional(string)
    dependentResources    = optional(any)
    resource              = optional(any)
  }))
  default = null
}

variable "submitted_resources" {
  description = "Microsoft Graph submittedResources property."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.educationSubmissionResource")
    assignmentResourceUrl = optional(string)
    dependentResources    = optional(any)
    resource              = optional(any)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["assignmentId", "excusedBy", "excusedDateTime", "id", "lastModifiedBy", "lastModifiedDateTime", "reassignedBy", "reassignedDateTime", "resourcesFolderUrl", "returnedBy", "returnedDateTime", "status", "submittedBy", "submittedDateTime", "unsubmittedBy", "unsubmittedDateTime", "webUrl"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
