variable "additional_notification_recipients" {
  description = "Defines the list of additional users or group members to be notified of the access review progress."
  type = list(object({
    odata_type                 = optional(string, "#microsoft.graph.accessReviewNotificationRecipientItem")
    notificationRecipientScope = optional(any)
    notificationTemplateType   = optional(string)
  }))
  default = null
}

variable "description_for_admins" {
  description = "Description provided by review creators to provide more context of the review to admins. Supports $select."
  type        = string
  default     = null
}

variable "description_for_reviewers" {
  description = "Description provided  by review creators to provide more context of the review to reviewers. Reviewers see this description in the email sent to them requesting their review. Email notifications support up to 256 characters. Supports $select."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Name of the access review series. Supports $select and $orderby. Required on create."
  type        = string
  default     = null
}

variable "fallback_reviewers" {
  description = "This collection of reviewer scopes is used to define the list of fallback reviewers. These fallback reviewers are notified to take action if no users are found from the list of reviewers specified. This could occur when either the group owner is specified as the reviewer but the group owner doesn't exist, or manager is specified as reviewer but a user's manager doesn't exist. See accessReviewReviewerScope. Replaces backupReviewers. Supports $select. NOTE: The value of this property will be ignored if fallback reviewers are assigned through the stageSettings property."
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

variable "instance_enumeration_scope" {
  description = "This property is required when scoping a review to guest users' access across all Microsoft 365 groups and determines which Microsoft 365 groups are reviewed. Each group becomes a unique accessReviewInstance of the access review series.  For supported scopes, see accessReviewScope. Supports $select. For examples of options for configuring instanceEnumerationScope, see Configure the scope of your access review definition using the Microsoft Graph API."
  type        = any
  default     = null
}

variable "instances" {
  description = "If the accessReviewScheduleDefinition is a recurring access review, instances represent each recurrence. A review that doesn't recur will have exactly one instance. Instances also represent each unique resource under review in the accessReviewScheduleDefinition. If a review has multiple resources and multiple instances, each resource has a unique instance for each recurrence."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.accessReviewInstance")
    decisions = optional(list(object({
      odata_type    = optional(string, "#microsoft.graph.accessReviewInstanceDecisionItem")
      decision      = optional(string)
      insights      = optional(any)
      justification = optional(string)
      permission    = optional(any)
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
    stages = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.accessReviewStage")
      decisions         = optional(any)
      fallbackReviewers = optional(any)
      reviewers         = optional(any)
    })))
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.accessReviewScheduleDefinition"
  nullable    = false
}

variable "reviewers" {
  description = "This collection of access review scopes is used to define who are the reviewers. The reviewers property is only updatable if individual users are assigned as reviewers. Required on create. Supports $select. For examples of options for assigning reviewers, see Assign reviewers to your access review definition using the Microsoft Graph API. NOTE: The value of this property will be ignored if reviewers are assigned through the stageSettings property."
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

variable "scope" {
  description = "Defines the entities whose access is reviewed. For supported scopes, see accessReviewScope. Required on create. Supports $select and $filter (contains only). For examples of options for configuring scope, see Configure the scope of your access review definition using the Microsoft Graph API."
  type        = any
  default     = null
}

variable "settings" {
  description = "The settings for an access review series, see type definition below. Supports $select. Required on create."
  type        = any
  default     = null
}

variable "stage_settings" {
  description = "Required only for a multi-stage access review to define the stages and their settings. You can break down each review instance into up to three sequential stages, where each stage can have a different set of reviewers, fallback reviewers, and settings. Stages are created sequentially based on the dependsOn property. Optional.  When this property is defined, its settings are used instead of the corresponding settings in the accessReviewScheduleDefinition object and its settings, reviewers, and fallbackReviewers properties."
  type = list(object({
    odata_type                       = optional(string, "#microsoft.graph.accessReviewStageSettings")
    decisionsThatWillMoveToNextStage = optional(list(string))
    dependsOn                        = optional(list(string))
    durationInDays                   = optional(number)
    fallbackReviewers = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.accessReviewReviewerScope")
      query      = optional(string)
      queryRoot  = optional(string)
      queryType  = optional(string)
      reviewerId = optional(string)
      scopeType  = optional(string)
    })))
    recommendationInsightSettings = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.accessReviewRecommendationInsightSetting")
    })))
    recommendationsEnabled = optional(bool)
    reviewers = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.accessReviewReviewerScope")
      query      = optional(string)
      queryRoot  = optional(string)
      queryType  = optional(string)
      reviewerId = optional(string)
      scopeType  = optional(string)
    })))
    stageId = optional(string)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdBy", "createdDateTime", "id", "lastModifiedDateTime", "status"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
