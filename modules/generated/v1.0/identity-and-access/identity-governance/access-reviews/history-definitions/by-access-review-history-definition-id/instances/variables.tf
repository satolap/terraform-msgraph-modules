variable "access_review_history_definition_id" {
  description = "The unique identifier of accessReviewHistoryDefinition"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.access_review_history_definition_id)) > 0
    error_message = "access_review_history_definition_id must not be empty."
  }
}

variable "download_uri" {
  description = "Uri that can be used to retrieve review history data. This URI will be active for 24 hours after being generated. Required."
  type        = string
  default     = null
}

variable "expiration_date_time" {
  description = "Timestamp when this instance and associated data expires and the history is deleted. Required."
  type        = string
  default     = null
}

variable "fulfilled_date_time" {
  description = "Timestamp when all of the available data for this instance was collected and is set after this instance's status is set to done. Required."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.accessReviewHistoryInstance"
  nullable    = false
}

variable "review_history_period_end_date_time" {
  description = "Timestamp reviews ending on or before this date will be included in the fetched history data."
  type        = string
  default     = null
}

variable "review_history_period_start_date_time" {
  description = "Timestamp reviews starting on or after this date will be included in the fetched history data."
  type        = string
  default     = null
}

variable "run_date_time" {
  description = "Timestamp when the instance's history data is scheduled to be generated."
  type        = string
  default     = null
}

variable "status" {
  description = "Represents the status of the review history data collection. The possible values are: done, inProgress, error, requested, unknownFutureValue. Once the status has been marked as done, a link can be generated to retrieve the instance's data by calling generateDownloadUri method."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["done", "inprogress", "error", "requested", "unknownFutureValue"], var.status)
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
