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

  validation {
    condition     = (var.fallback_reviewers == null ? true : alltrue([alltrue([for input0 in var.fallback_reviewers : (input0 == null ? true : alltrue([(input0["scopeType"] == null ? true : alltrue([(input0["scopeType"] == null ? true : contains(["user", "group", "self", "manager", "sponsor", "resourceOwner", "managerOrSponsor"], input0["scopeType"]))]))]))])]))
    error_message = "fallback_reviewers: nested required attributes must be non-null and enum values must be supported input members."
  }
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

  validation {
    condition     = (var.instances == null ? true : alltrue([alltrue([for input0 in var.instances : (input0 == null ? true : alltrue([(input0["fallbackReviewers"] == null ? true : alltrue([alltrue([for input2 in input0["fallbackReviewers"] : (input2 == null ? true : alltrue([(input2["scopeType"] == null ? true : alltrue([(input2["scopeType"] == null ? true : contains(["user", "group", "self", "manager", "sponsor", "resourceOwner", "managerOrSponsor"], input2["scopeType"]))]))]))])])), (input0["reviewers"] == null ? true : alltrue([alltrue([for input2 in input0["reviewers"] : (input2 == null ? true : alltrue([(input2["scopeType"] == null ? true : alltrue([(input2["scopeType"] == null ? true : contains(["user", "group", "self", "manager", "sponsor", "resourceOwner", "managerOrSponsor"], input2["scopeType"]))]))]))])]))]))])]))
    error_message = "instances: nested required attributes must be non-null and enum values must be supported input members."
  }
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

  validation {
    condition     = (var.reviewers == null ? true : alltrue([alltrue([for input0 in var.reviewers : (input0 == null ? true : alltrue([(input0["scopeType"] == null ? true : alltrue([(input0["scopeType"] == null ? true : contains(["user", "group", "self", "manager", "sponsor", "resourceOwner", "managerOrSponsor"], input0["scopeType"]))]))]))])]))
    error_message = "reviewers: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "scope" {
  description = "Defines the entities whose access is reviewed. For supported scopes, see accessReviewScope. Required on create. Supports $select and $filter (contains only). For examples of options for configuring scope, see Configure the scope of your access review definition using the Microsoft Graph API."
  type        = any
  default     = null
}

variable "settings" {
  description = "The settings for an access review series, see type definition below. Supports $select. Required on create."
  type = object({
    odata_type                           = optional(string, "#microsoft.graph.accessReviewScheduleSettings")
    applyActions                         = optional(any)
    autoApplyDecisionsEnabled            = optional(bool)
    decisionHistoriesForReviewersEnabled = optional(bool)
    defaultDecision                      = optional(string)
    defaultDecisionEnabled               = optional(bool)
    instanceDurationInDays               = optional(number)
    justificationRequiredOnApproval      = optional(bool)
    mailNotificationsEnabled             = optional(bool)
    recommendationInsightSettings        = optional(any)
    recommendationLookBackDuration       = optional(string)
    recommendationsEnabled               = optional(bool)
    recurrence = optional(object({
      odata_type = optional(string, "#microsoft.graph.patternedRecurrence")
      pattern = optional(object({
        odata_type     = optional(string, "#microsoft.graph.recurrencePattern")
        dayOfMonth     = optional(number)
        daysOfWeek     = optional(list(string))
        firstDayOfWeek = optional(string)
        index          = optional(string)
        interval       = optional(number)
        month          = optional(number)
        type           = optional(string)
      }))
      range = optional(object({
        odata_type          = optional(string, "#microsoft.graph.recurrenceRange")
        endDate             = optional(string)
        numberOfOccurrences = optional(number)
        recurrenceTimeZone  = optional(string)
        startDate           = optional(string)
        type                = optional(string)
      }))
    }))
    reminderNotificationsEnabled = optional(bool)
  })
  default = null

  validation {
    condition     = (var.settings == null ? true : alltrue([(var.settings["recurrence"] == null ? true : alltrue([(var.settings["recurrence"]["pattern"] == null ? true : alltrue([(var.settings["recurrence"]["pattern"]["daysOfWeek"] == null ? true : alltrue([alltrue([for input3 in var.settings["recurrence"]["pattern"]["daysOfWeek"] : (input3 == null ? true : alltrue([(input3 == null ? true : contains(["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"], input3))]))])])), (var.settings["recurrence"]["pattern"]["firstDayOfWeek"] == null ? true : alltrue([(var.settings["recurrence"]["pattern"]["firstDayOfWeek"] == null ? true : contains(["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"], var.settings["recurrence"]["pattern"]["firstDayOfWeek"]))])), (var.settings["recurrence"]["pattern"]["index"] == null ? true : alltrue([(var.settings["recurrence"]["pattern"]["index"] == null ? true : contains(["first", "second", "third", "fourth", "last"], var.settings["recurrence"]["pattern"]["index"]))])), (var.settings["recurrence"]["pattern"]["type"] == null ? true : alltrue([(var.settings["recurrence"]["pattern"]["type"] == null ? true : contains(["daily", "weekly", "absoluteMonthly", "relativeMonthly", "absoluteYearly", "relativeYearly"], var.settings["recurrence"]["pattern"]["type"]))]))])), (var.settings["recurrence"]["range"] == null ? true : alltrue([(var.settings["recurrence"]["range"]["type"] == null ? true : alltrue([(var.settings["recurrence"]["range"]["type"] == null ? true : contains(["endDate", "noEnd", "numbered"], var.settings["recurrence"]["range"]["type"]))]))]))]))]))
    error_message = "settings: nested required attributes must be non-null and enum values must be supported input members."
  }
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
    recommendationInsightSettings = optional(any)
    recommendationsEnabled        = optional(bool)
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

  validation {
    condition     = (var.stage_settings == null ? true : alltrue([alltrue([for input0 in var.stage_settings : (input0 == null ? true : alltrue([(input0["fallbackReviewers"] == null ? true : alltrue([alltrue([for input2 in input0["fallbackReviewers"] : (input2 == null ? true : alltrue([(input2["scopeType"] == null ? true : alltrue([(input2["scopeType"] == null ? true : contains(["user", "group", "self", "manager", "sponsor", "resourceOwner", "managerOrSponsor"], input2["scopeType"]))]))]))])])), (input0["reviewers"] == null ? true : alltrue([alltrue([for input2 in input0["reviewers"] : (input2 == null ? true : alltrue([(input2["scopeType"] == null ? true : alltrue([(input2["scopeType"] == null ? true : contains(["user", "group", "self", "manager", "sponsor", "resourceOwner", "managerOrSponsor"], input2["scopeType"]))]))]))])]))]))])]))
    error_message = "stage_settings: nested required attributes must be non-null and enum values must be supported input members."
  }
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdBy", "createdDateTime", "id", "lastModifiedDateTime", "status"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
