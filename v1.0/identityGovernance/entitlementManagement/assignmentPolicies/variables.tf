variable "allowedTargetScope" {
  description = "Principals that can be assigned the access package through this policy. The possible values are: notSpecified, specificDirectoryUsers, specificConnectedOrganizationUsers, specificDirectoryServicePrincipals, allMemberUsers, allDirectoryUsers, allDirectoryServicePrincipals, allConfiguredConnectedOrganizationUsers, allExternalUsers, allDirectoryAgentIdentities, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.allowedTargetScope == null ? true : contains(["notSpecified", "specificDirectoryUsers", "specificConnectedOrganizationUsers", "specificDirectoryServicePrincipals", "allMemberUsers", "allDirectoryUsers", "allDirectoryServicePrincipals", "allConfiguredConnectedOrganizationUsers", "allExternalUsers", "allDirectoryAgentIdentities"], var.allowedTargetScope)
    error_message = "allowedTargetScope must be one of the documented enum values."
  }
}

variable "automaticRequestSettings" {
  description = "This property is only present for an auto assignment policy; if absent, this is a request-based policy."
  type = object({
    odata_type                                 = optional(string, "#microsoft.graph.accessPackageAutomaticRequestSettings")
    gracePeriodBeforeAccessRemoval             = optional(string)
    removeAccessWhenTargetLeavesAllowedTargets = optional(bool)
    requestAccessForAllowedTargets             = optional(bool)
  })
  default = null
}

variable "createdDateTime" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "customExtensionStageSettings" {
  description = "The collection of stages when to execute one or more custom access package workflow extensions. Supports $expand."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.customExtensionStageSetting")
    customExtension = optional(any)
    stage           = optional(string)
  }))
  default = null

  validation {
    condition     = (var.customExtensionStageSettings == null ? true : alltrue([alltrue([for input0 in var.customExtensionStageSettings : (input0 == null ? true : alltrue([(input0["stage"] == null ? true : alltrue([(input0["stage"] == null ? true : contains(["assignmentRequestCreated", "assignmentRequestApproved", "assignmentRequestGranted", "assignmentRequestRemoved", "assignmentFourteenDaysBeforeExpiration", "assignmentOneDayBeforeExpiration"], input0["stage"]))]))]))])]))
    error_message = "customExtensionStageSettings: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "description" {
  description = "The description of the policy."
  type        = string
  default     = null
}

variable "displayName" {
  description = "The display name of the policy."
  type        = string
  default     = null
}

variable "expiration" {
  description = "The expiration date for assignments created in this policy."
  type = object({
    odata_type  = optional(string, "#microsoft.graph.expirationPattern")
    duration    = optional(string)
    endDateTime = optional(string)
    type        = optional(string)
  })
  default = null

  validation {
    condition     = (var.expiration == null ? true : alltrue([(var.expiration["type"] == null ? true : alltrue([(var.expiration["type"] == null ? true : contains(["notSpecified", "noExpiration", "afterDateTime", "afterDuration"], var.expiration["type"]))]))]))
    error_message = "expiration: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "modifiedDateTime" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "notificationSettings" {
  description = "Microsoft Graph notificationSettings property."
  type = object({
    odata_type                       = optional(string, "#microsoft.graph.accessPackageNotificationSettings")
    isAssignmentNotificationDisabled = optional(bool)
  })
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.accessPackageAssignmentPolicy"
  nullable    = false
}

variable "questions" {
  description = "Questions that are posed to the  requestor."
  type        = any
  default     = null
}

variable "requestApprovalSettings" {
  description = "Specifies the settings for approval of requests for an access package assignment through this policy. For example, if approval is required for new requests."
  type = object({
    odata_type                       = optional(string, "#microsoft.graph.accessPackageAssignmentApprovalSettings")
    isApprovalRequiredForAdd         = optional(bool)
    isApprovalRequiredForUpdate      = optional(bool)
    isRequestorJustificationRequired = optional(bool)
    stages = optional(list(object({
      odata_type                      = optional(string, "#microsoft.graph.accessPackageApprovalStage")
      approverInformationVisibility   = optional(string)
      durationBeforeAutomaticDenial   = optional(string)
      durationBeforeEscalation        = optional(string)
      escalationApprovers             = optional(any)
      fallbackEscalationApprovers     = optional(any)
      fallbackPrimaryApprovers        = optional(any)
      isApproverJustificationRequired = optional(bool)
      isEscalationEnabled             = optional(bool)
      primaryApprovers                = optional(any)
    })))
  })
  default = null

  validation {
    condition     = (var.requestApprovalSettings == null ? true : alltrue([(var.requestApprovalSettings["stages"] == null ? true : alltrue([alltrue([for input1 in var.requestApprovalSettings["stages"] : (input1 == null ? true : alltrue([(input1["approverInformationVisibility"] == null ? true : alltrue([(input1["approverInformationVisibility"] == null ? true : contains(["default", "notVisible", "visible"], input1["approverInformationVisibility"]))]))]))])]))]))
    error_message = "requestApprovalSettings: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "requestorSettings" {
  description = "Provides additional settings to select who can create a request for an access package assignment through this policy, and what they can include in their request."
  type = object({
    odata_type                             = optional(string, "#microsoft.graph.accessPackageAssignmentRequestorSettings")
    allowCustomAssignmentSchedule          = optional(bool)
    enableOnBehalfRequestorsToAddAccess    = optional(bool)
    enableOnBehalfRequestorsToRemoveAccess = optional(bool)
    enableOnBehalfRequestorsToUpdateAccess = optional(bool)
    enableTargetsToSelfAddAccess           = optional(bool)
    enableTargetsToSelfRemoveAccess        = optional(bool)
    enableTargetsToSelfUpdateAccess        = optional(bool)
    onBehalfRequestors                     = optional(any)
  })
  default = null
}

variable "reviewSettings" {
  description = "Settings for access reviews of assignments through this policy."
  type = object({
    odata_type                      = optional(string, "#microsoft.graph.accessPackageAssignmentReviewSettings")
    expirationBehavior              = optional(string)
    fallbackReviewers               = optional(any)
    isEnabled                       = optional(bool)
    isRecommendationEnabled         = optional(bool)
    isReviewerJustificationRequired = optional(bool)
    isSelfReview                    = optional(bool)
    primaryReviewers                = optional(any)
    schedule = optional(object({
      odata_type = optional(string, "#microsoft.graph.entitlementManagementSchedule")
      expiration = optional(object({
        odata_type  = optional(string, "#microsoft.graph.expirationPattern")
        duration    = optional(string)
        endDateTime = optional(string)
        type        = optional(string)
      }))
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
      startDateTime = optional(string)
    }))
  })
  default = null

  validation {
    condition     = (var.reviewSettings == null ? true : alltrue([(var.reviewSettings["expirationBehavior"] == null ? true : alltrue([(var.reviewSettings["expirationBehavior"] == null ? true : contains(["keepAccess", "removeAccess", "acceptAccessRecommendation"], var.reviewSettings["expirationBehavior"]))])), (var.reviewSettings["schedule"] == null ? true : alltrue([(var.reviewSettings["schedule"]["expiration"] == null ? true : alltrue([(var.reviewSettings["schedule"]["expiration"]["type"] == null ? true : alltrue([(var.reviewSettings["schedule"]["expiration"]["type"] == null ? true : contains(["notSpecified", "noExpiration", "afterDateTime", "afterDuration"], var.reviewSettings["schedule"]["expiration"]["type"]))]))])), (var.reviewSettings["schedule"]["recurrence"] == null ? true : alltrue([(var.reviewSettings["schedule"]["recurrence"]["pattern"] == null ? true : alltrue([(var.reviewSettings["schedule"]["recurrence"]["pattern"]["daysOfWeek"] == null ? true : alltrue([alltrue([for input4 in var.reviewSettings["schedule"]["recurrence"]["pattern"]["daysOfWeek"] : (input4 == null ? true : alltrue([(input4 == null ? true : contains(["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"], input4))]))])])), (var.reviewSettings["schedule"]["recurrence"]["pattern"]["firstDayOfWeek"] == null ? true : alltrue([(var.reviewSettings["schedule"]["recurrence"]["pattern"]["firstDayOfWeek"] == null ? true : contains(["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"], var.reviewSettings["schedule"]["recurrence"]["pattern"]["firstDayOfWeek"]))])), (var.reviewSettings["schedule"]["recurrence"]["pattern"]["index"] == null ? true : alltrue([(var.reviewSettings["schedule"]["recurrence"]["pattern"]["index"] == null ? true : contains(["first", "second", "third", "fourth", "last"], var.reviewSettings["schedule"]["recurrence"]["pattern"]["index"]))])), (var.reviewSettings["schedule"]["recurrence"]["pattern"]["type"] == null ? true : alltrue([(var.reviewSettings["schedule"]["recurrence"]["pattern"]["type"] == null ? true : contains(["daily", "weekly", "absoluteMonthly", "relativeMonthly", "absoluteYearly", "relativeYearly"], var.reviewSettings["schedule"]["recurrence"]["pattern"]["type"]))]))])), (var.reviewSettings["schedule"]["recurrence"]["range"] == null ? true : alltrue([(var.reviewSettings["schedule"]["recurrence"]["range"]["type"] == null ? true : alltrue([(var.reviewSettings["schedule"]["recurrence"]["range"]["type"] == null ? true : contains(["endDate", "noEnd", "numbered"], var.reviewSettings["schedule"]["recurrence"]["range"]["type"]))]))]))]))]))]))
    error_message = "reviewSettings: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "specificAllowedTargets" {
  description = "The principals that can be assigned access from an access package through this policy."
  type        = any
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["accessPackage", "catalog", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
