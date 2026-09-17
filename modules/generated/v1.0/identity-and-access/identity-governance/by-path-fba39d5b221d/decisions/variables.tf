variable "access_review_instance_id" {
  description = "The unique identifier of accessReviewInstance"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.access_review_instance_id)) > 0
    error_message = "access_review_instance_id must not be empty."
  }
}

variable "access_review_stage_id" {
  description = "The unique identifier of accessReviewStage"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.access_review_stage_id)) > 0
    error_message = "access_review_stage_id must not be empty."
  }
}

variable "decision" {
  description = "Result of the review. Possible values: Approve, Deny, NotReviewed, or DontKnow. Supports $select, $orderby, and $filter (eq only)."
  type        = string
  default     = null
}

variable "insights" {
  description = "Insights are recommendations to reviewers on whether to approve or deny a decision. There can be multiple insights associated with an accessReviewInstanceDecisionItem."
  type = list(object({
    odata_type             = optional(string, "#microsoft.graph.governanceInsight")
    insightCreatedDateTime = optional(string)
  }))
  default = null
}

variable "justification" {
  description = "Justification left by the reviewer when they made the decision."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.accessReviewInstanceDecisionItem"
  nullable    = false
}

variable "permission" {
  description = "Microsoft Graph permission property."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["accessReviewId", "appliedBy", "appliedDateTime", "applyDescription", "applyResult", "id", "principal", "principalLink", "recommendation", "resource", "resourceLink", "reviewedBy", "reviewedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
