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

variable "access_review_instance_decision_item_id" {
  description = "The unique identifier of accessReviewInstanceDecisionItem"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.access_review_instance_decision_item_id)) > 0
    error_message = "access_review_instance_decision_item_id must not be empty."
  }
}

variable "decisions" {
  description = "Each user reviewed in an accessReviewStage has a decision item representing if they were approved, denied, or not yet reviewed."
  type = list(object({
    odata_type       = optional(string, "#microsoft.graph.accessReviewInstanceDecisionItem")
    applyDescription = optional(string)
    decision         = optional(string)
    insights = optional(list(object({
      odata_type             = optional(string, "#microsoft.graph.governanceInsight")
      insightCreatedDateTime = optional(string)
    })))
    instance      = optional(any)
    justification = optional(string)
    permission    = optional(any)
  }))
  default = null
}

variable "fallback_reviewers" {
  description = "This collection of reviewer scopes is used to define the list of fallback reviewers. These fallback reviewers are notified to take action if no users are found from the list of reviewers specified. This can occur when either the group owner is specified as the reviewer but the group owner does not exist, or manager is specified as reviewer but a user's manager does not exist."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.accessReviewReviewerScope")
    query      = optional(string)
    queryRoot  = optional(string)
    queryType  = optional(string)
    reviewerId = optional(string)
    scopeType  = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.accessReviewStage"
  nullable    = false
}

variable "reviewers" {
  description = "This collection of access review scopes is used to define who the reviewers are. For examples of options for assigning reviewers, see Assign reviewers to your access review definition using the Microsoft Graph API."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.accessReviewReviewerScope")
    query      = optional(string)
    queryRoot  = optional(string)
    queryType  = optional(string)
    reviewerId = optional(string)
    scopeType  = optional(string)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["endDateTime", "id", "startDateTime", "status"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
