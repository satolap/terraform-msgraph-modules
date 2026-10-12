variable "campaign_schedule" {
  description = "Details about the schedule and current status for a training campaign"
  type = object({
    odata_type         = optional(string, "#microsoft.graph.campaignSchedule")
    completionDateTime = optional(string)
    launchDateTime     = optional(string)
    status             = optional(string)
  })
  default = null
}

variable "created_by" {
  description = "Identity of the user who created the training campaign"
  type = object({
    odata_type  = optional(string, "#microsoft.graph.emailIdentity")
    displayName = optional(string)
    email       = optional(string)
    id          = optional(string)
  })
  default = null
}

variable "created_date_time" {
  description = "Date and time of creation of the training campaign."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the training campaign."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Display name of the training campaign. Supports $filter and $orderby."
  type        = string
  default     = null
}

variable "end_user_notification_setting" {
  description = "Details about the end user notification setting."
  type        = any
  default     = null
}

variable "excluded_account_target" {
  description = "Users excluded from the training campaign."
  type        = any
  default     = null
}

variable "included_account_target" {
  description = "Users targeted in the training campaign."
  type        = any
  default     = null
}

variable "last_modified_by" {
  description = "Identity of the user who most recently modified the training campaign."
  type = object({
    odata_type  = optional(string, "#microsoft.graph.emailIdentity")
    displayName = optional(string)
    email       = optional(string)
    id          = optional(string)
  })
  default = null
}

variable "last_modified_date_time" {
  description = "Date and time of the most recent modification of the training campaign."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.trainingCampaign"
  nullable    = false
}

variable "report" {
  description = "Report of the training campaign."
  type = object({
    odata_type = optional(string, "#microsoft.graph.trainingCampaignReport")
    campaignUsers = optional(list(object({
      odata_type               = optional(string, "#microsoft.graph.userSimulationDetails")
      assignedTrainingsCount   = optional(number)
      completedTrainingsCount  = optional(number)
      compromisedDateTime      = optional(string)
      inProgressTrainingsCount = optional(number)
      isCompromised            = optional(bool)
      latestSimulationActivity = optional(string)
      reportedPhishDateTime    = optional(string)
      simulationEvents = optional(list(object({
        odata_type              = optional(string, "#microsoft.graph.userSimulationEventInfo")
        browser                 = optional(string)
        clickSource             = optional(string)
        eventDateTime           = optional(string)
        eventName               = optional(string)
        ipAddress               = optional(string)
        osPlatformDeviceDetails = optional(string)
      })))
      simulationUser = optional(object({
        odata_type      = optional(string, "#microsoft.graph.attackSimulationUser")
        displayName     = optional(string)
        email           = optional(string)
        outOfOfficeDays = optional(number)
        userId          = optional(string)
      }))
      trainingEvents = optional(list(object({
        odata_type                  = optional(string, "#microsoft.graph.userTrainingEventInfo")
        displayName                 = optional(string)
        latestTrainingStatus        = optional(string)
        trainingAssignedProperties  = optional(any)
        trainingCompletedProperties = optional(any)
        trainingUpdatedProperties   = optional(any)
      })))
    })))
    overview = optional(object({
      odata_type = optional(string, "#microsoft.graph.trainingCampaignReportOverview")
      trainingModuleCompletion = optional(object({
        odata_type = optional(string, "#microsoft.graph.trainingEventsContent")
        assignedTrainingsInfos = optional(list(object({
          odata_type         = optional(string, "#microsoft.graph.assignedTrainingInfo")
          assignedUserCount  = optional(number)
          completedUserCount = optional(number)
          displayName        = optional(string)
        })))
        trainingsAssignedUserCount = optional(number)
      }))
      trainingNotificationDeliveryStatus = optional(object({
        odata_type                     = optional(string, "#microsoft.graph.trainingNotificationDelivery")
        failedMessageDeliveryCount     = optional(number)
        resolvedTargetsCount           = optional(number)
        successfulMessageDeliveryCount = optional(number)
      }))
      userCompletionStatus = optional(object({
        odata_type                   = optional(string, "#microsoft.graph.userTrainingCompletionSummary")
        completedUsersCount          = optional(number)
        inProgressUsersCount         = optional(number)
        notCompletedUsersCount       = optional(number)
        notStartedUsersCount         = optional(number)
        previouslyAssignedUsersCount = optional(number)
      }))
    }))
  })
  default = null
}

variable "training_setting" {
  description = "Details about the training settings for a training campaign."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
