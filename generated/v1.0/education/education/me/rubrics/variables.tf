variable "description" {
  description = "The description of this rubric."
  type        = any
  default     = null
}

variable "display_name" {
  description = "The name of this rubric."
  type        = string
  default     = null
}

variable "grading" {
  description = "The grading type of this rubric. You can use null for a no-points rubric or educationAssignmentPointsGradeType for a points rubric."
  type        = any
  default     = null
}

variable "levels" {
  description = "The collection of levels making up this rubric."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.rubricLevel")
    description = optional(any)
    displayName = optional(string)
    grading     = optional(any)
    levelId     = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.educationRubric"
  nullable    = false
}

variable "qualities" {
  description = "The collection of qualities making up this rubric."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.rubricQuality")
    criteria = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.rubricCriterion")
      description = optional(any)
    })))
    description = optional(any)
    displayName = optional(string)
    qualityId   = optional(string)
    weight      = optional(any)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdBy", "createdDateTime", "id", "lastModifiedBy", "lastModifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
