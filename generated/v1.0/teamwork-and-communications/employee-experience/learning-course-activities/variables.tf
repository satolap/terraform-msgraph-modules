variable "completed_date_time" {
  description = "Date and time when the assignment was completed. Optional."
  type        = string
  default     = null
}

variable "completion_percentage" {
  description = "The percentage completion value of the course activity. Optional."
  type        = number
  default     = null
}

variable "externalcourse_activity_id" {
  description = "Microsoft Graph externalcourseActivityId property."
  type        = string
  default     = null
}

variable "learner_user_id" {
  description = "The user ID of the learner to whom the activity is assigned. Required."
  type        = string
  default     = null
}

variable "learning_content_id" {
  description = "The ID of the learning content created in Viva Learning. Required."
  type        = string
  default     = null
}

variable "learning_provider_id" {
  description = "The registration ID of the provider. Required."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.learningCourseActivity"
  nullable    = false
}

variable "status" {
  description = "The status of the course activity. The possible values are: notStarted, inProgress, completed. Required."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["notStarted", "inProgress", "completed", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
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
