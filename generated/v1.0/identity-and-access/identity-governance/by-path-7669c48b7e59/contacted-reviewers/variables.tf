variable "access_review_schedule_definition_id" {
  description = "The unique identifier of accessReviewScheduleDefinition"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.access_review_schedule_definition_id)) > 0
    error_message = "access_review_schedule_definition_id must not be empty."
  }
}

variable "access_review_instance_id" {
  description = "The unique identifier of accessReviewInstance"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.access_review_instance_id)) > 0
    error_message = "access_review_instance_id must not be empty."
  }
}

variable "created_date_time" {
  description = "The date when the reviewer was added for the access review."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Name of reviewer."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.accessReviewReviewer"
  nullable    = false
}

variable "user_principal_name" {
  description = "User principal name of the reviewer."
  type        = string
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
