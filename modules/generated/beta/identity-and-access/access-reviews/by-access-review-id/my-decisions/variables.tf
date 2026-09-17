variable "access_review_id" {
  description = "The unique identifier of accessReview"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.access_review_id)) > 0
    error_message = "access_review_id must not be empty."
  }
}

variable "access_recommendation" {
  description = "The feature- generated recommendation shown to the reviewer, one of: Approve, Deny, NotAvailable."
  type        = string
  default     = null
}

variable "access_review_id_2" {
  description = "The feature-generated ID of the access review."
  type        = string
  default     = null
}

variable "applied_by" {
  description = "When the review completes, if the results were manually applied, the user identity of the user who applied the decision. If the review was autoapplied, the userPrincipalName is empty."
  type        = any
  default     = null
}

variable "applied_date_time" {
  description = "The date and time when the review decision was applied."
  type        = string
  default     = null
}

variable "apply_result" {
  description = "The outcome of applying the decision, one of: NotApplied, Success, Failed, NotFound, NotSupported."
  type        = string
  default     = null
}

variable "justification" {
  description = "The reviewer's business justification, if supplied."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.accessReviewDecision"
  nullable    = false
}

variable "review_result" {
  description = "The result of the review, one of NotReviewed, Deny, DontKnow or Approve."
  type        = string
  default     = null
}

variable "reviewed_by" {
  description = "The identity of the reviewer. If the recommendation was used as the review, the userPrincipalName is empty."
  type        = any
  default     = null
}

variable "reviewed_date_time" {
  description = "Microsoft Graph reviewedDateTime property."
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
