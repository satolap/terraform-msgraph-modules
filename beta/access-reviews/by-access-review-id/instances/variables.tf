variable "access_review_id" {
  description = "The unique identifier of accessReview"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.access_review_id)) > 0
    error_message = "access_review_id must not be empty."
  }
}

variable "business_flow_template_id" {
  description = "The business flow template identifier. Required on create. This value is case sensitive."
  type        = string
  default     = null
}

variable "created_by" {
  description = "The user who created this review."
  type        = any
  default     = null
}

variable "decisions" {
  description = "The collection of decisions for this access review."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.accessReviewDecision")
    accessRecommendation = optional(string)
    accessReviewId       = optional(string)
    appliedBy            = optional(any)
    appliedDateTime      = optional(string)
    applyResult          = optional(string)
    justification        = optional(string)
    reviewResult         = optional(string)
    reviewedBy           = optional(any)
    reviewedDateTime     = optional(string)
  }))
  default = null
}

variable "description" {
  description = "The description provided by the access review creator, to show to the reviewers."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The access review name. Required on create."
  type        = string
  default     = null
}

variable "end_date_time" {
  description = "The DateTime when the review is scheduled to end. This must be at least one day later than the start date. Required on create."
  type        = string
  default     = null
}

variable "instances" {
  description = "The collection of access reviews instances past, present, and future, if this object is a recurring access review."
  type = list(object({
    odata_type             = optional(string, "#microsoft.graph.accessReview")
    businessFlowTemplateId = optional(string)
    createdBy              = optional(any)
    decisions = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.accessReviewDecision")
      accessRecommendation = optional(string)
      accessReviewId       = optional(string)
      appliedBy            = optional(any)
      appliedDateTime      = optional(string)
      applyResult          = optional(string)
      justification        = optional(string)
      reviewResult         = optional(string)
      reviewedBy           = optional(any)
      reviewedDateTime     = optional(string)
    })))
    description = optional(string)
    displayName = optional(string)
    endDateTime = optional(string)
    instances   = optional(any)
    myDecisions = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.accessReviewDecision")
      accessRecommendation = optional(string)
      accessReviewId       = optional(string)
      appliedBy            = optional(any)
      appliedDateTime      = optional(string)
      applyResult          = optional(string)
      justification        = optional(string)
      reviewResult         = optional(string)
      reviewedBy           = optional(any)
      reviewedDateTime     = optional(string)
    })))
    reviewedEntity = optional(any)
    reviewerType   = optional(string)
    reviewers = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.accessReviewReviewer")
      createdDateTime   = optional(string)
      displayName       = optional(string)
      userPrincipalName = optional(string)
    })))
    settings      = optional(any)
    startDateTime = optional(string)
  }))
  default = null
}

variable "my_decisions" {
  description = "The collection of decisions for the caller, if the caller is a reviewer."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.accessReviewDecision")
    accessRecommendation = optional(string)
    accessReviewId       = optional(string)
    appliedBy            = optional(any)
    appliedDateTime      = optional(string)
    applyResult          = optional(string)
    justification        = optional(string)
    reviewResult         = optional(string)
    reviewedBy           = optional(any)
    reviewedDateTime     = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.accessReview"
  nullable    = false
}

variable "reviewed_entity" {
  description = "The object for which the access review is reviewing the access rights assignments. This identity can be the group for the review of memberships of users in a group, or the app for a review of assignments of users to an application. Required on create."
  type        = any
  default     = null
}

variable "reviewer_type" {
  description = "The relationship type of reviewer to the target object, one of: self, delegated, entityOwners. Required on create."
  type        = string
  default     = null
}

variable "reviewers" {
  description = "The collection of reviewers for an access review, if access review reviewerType is of type delegated."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.accessReviewReviewer")
    createdDateTime   = optional(string)
    displayName       = optional(string)
    userPrincipalName = optional(string)
  }))
  default = null
}

variable "settings" {
  description = "The settings of an accessReview, see type definition below."
  type        = any
  default     = null
}

variable "start_date_time" {
  description = "The date and time when the review is scheduled to be start. This date can be in the future.  Required on create."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "status"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
