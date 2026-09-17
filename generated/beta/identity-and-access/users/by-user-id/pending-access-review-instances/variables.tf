variable "user_id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_id)) > 0
    error_message = "user_id must not be empty."
  }
}

variable "decisions" {
  description = "Each user reviewed in an accessReviewInstance has a decision item representing if they were approved, denied, or not yet reviewed."
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

variable "definition" {
  description = "There's exactly one accessReviewScheduleDefinition associated with each instance. It's the parent schedule for the instance, where instances are created for each recurrence of a review definition and each group selected to review by the definition."
  type        = any
  default     = null
}

variable "fallback_reviewers" {
  description = "This collection of reviewer scopes is used to define the list of fallback reviewers. These fallback reviewers are notified to take action if no users are found from the list of reviewers specified. This could occur when either the group owner is specified as the reviewer but the group owner doesn't exist, or manager is specified as reviewer but a user's manager doesn't exist. Supports $select."
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
  default     = "#microsoft.graph.accessReviewInstance"
  nullable    = false
}

variable "reviewers" {
  description = "This collection of access review scopes is used to define who the reviewers are. Supports $select. For examples of options for assigning reviewers, see Assign reviewers to your access review definition using the Microsoft Graph API."
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

variable "stages" {
  description = "If the instance has multiple stages, this returns the collection of stages. A new stage will only be created when the previous stage ends. The existence, number, and settings of stages on a review instance are created based on the accessReviewStageSettings on the parent accessReviewScheduleDefinition."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.accessReviewStage")
    decisions = optional(list(object({
      odata_type       = optional(string, "#microsoft.graph.accessReviewInstanceDecisionItem")
      applyDescription = optional(string)
      decision         = optional(string)
      insights         = optional(any)
      instance         = optional(any)
      justification    = optional(string)
      permission       = optional(any)
    })))
    fallbackReviewers = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.accessReviewReviewerScope")
      query      = optional(string)
      queryRoot  = optional(string)
      queryType  = optional(string)
      reviewerId = optional(string)
      scopeType  = optional(string)
    })))
    reviewers = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.accessReviewReviewerScope")
      query      = optional(string)
      queryRoot  = optional(string)
      queryType  = optional(string)
      reviewerId = optional(string)
      scopeType  = optional(string)
    })))
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["contactedReviewers", "delegatedBy", "endDateTime", "errors", "id", "scope", "startDateTime", "status"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
