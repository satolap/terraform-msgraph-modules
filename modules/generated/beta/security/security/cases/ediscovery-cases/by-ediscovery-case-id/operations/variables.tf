variable "ediscovery_case_id" {
  description = "The unique identifier of ediscoveryCase"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.ediscovery_case_id)) > 0
    error_message = "ediscovery_case_id must not be empty."
  }
}

variable "action" {
  description = "The type of action the operation represents. The possible values are: contentExport,  applyTags, convertToPdf, index, estimateStatistics, addToReviewSet, holdUpdate, unknownFutureValue, purgeData, exportReport, exportResult, holdPolicySync. Use the Prefer: include-unknown-enum-members request header to get the following values from this evolvable enum: purgeData, exportReport, exportResult, holdPolicySync."
  type        = any
  default     = null

  validation {
    condition     = var.action == null ? true : contains(["contentExport", "applyTags", "convertToPdf", "index", "estimateStatistics", "addToReviewSet", "holdUpdate", "unknownFutureValue", "purgeData", "exportReport", "exportResult", "holdPolicySync"], var.action)
    error_message = "action must be one of the documented enum values."
  }
}

variable "completed_date_time" {
  description = "The date and time the operation was completed."
  type        = string
  default     = null
}

variable "created_by" {
  description = "The user that created the operation."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The date and time the operation was created."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.caseOperation"
  nullable    = false
}

variable "percent_progress" {
  description = "The progress of the operation."
  type        = number
  default     = null
}

variable "result_info" {
  description = "Contains success and failure-specific result information."
  type        = any
  default     = null
}

variable "status" {
  description = "The status of the case operation. The possible values are: notStarted, submissionFailed, running, succeeded, partiallySucceeded, failed, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["notStarted", "submissionFailed", "running", "succeeded", "partiallySucceeded", "failed", "unknownFutureValue"], var.status)
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
