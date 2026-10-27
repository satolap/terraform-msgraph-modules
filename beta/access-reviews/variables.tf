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

variable "timeouts" {
  description = "Optional timeouts of the msgraph_resource, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". create, update and delete must be at least \"15s\": after each request the provider waits for consistent reads within the same timeout. Every value defaults to null, which keeps the provider defaults and sends no timeouts block. The reviewed replication retries of this module, where it has any, count against these timeouts."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.read, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : (can(regex("^([0-9]+[hms])+$", t)) ? !can(regex("^(0+[hms])+$", t)) : false)
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : try(sum([for m in regexall("([0-9]+)([hms])", t) : tonumber(m[0]) * lookup({ h = 3600, m = 60, s = 1 }, m[1])]) >= 15, true)
    ])
    error_message = "timeouts.create, timeouts.update and timeouts.delete must be at least \"15s\"."
  }
}

variable "select_response" {
  description = "Opt in to a configured-property GET selection; this narrows response and can remove fields consumers use."
  type        = bool
  default     = false
  nullable    = false
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
