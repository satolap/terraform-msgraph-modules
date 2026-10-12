variable "allowed_target_scope" {
  description = "Principals that can be assigned the access package through this policy. The possible values are: notSpecified, specificDirectoryUsers, specificConnectedOrganizationUsers, specificDirectoryServicePrincipals, allMemberUsers, allDirectoryUsers, allDirectoryServicePrincipals, allConfiguredConnectedOrganizationUsers, allExternalUsers, allDirectoryAgentIdentities, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.allowed_target_scope == null ? true : contains(["notSpecified", "specificDirectoryUsers", "specificConnectedOrganizationUsers", "specificDirectoryServicePrincipals", "allMemberUsers", "allDirectoryUsers", "allDirectoryServicePrincipals", "allConfiguredConnectedOrganizationUsers", "allExternalUsers", "allDirectoryAgentIdentities", "unknownFutureValue"], var.allowed_target_scope)
    error_message = "allowed_target_scope must be one of the documented enum values."
  }
}

variable "automatic_request_settings" {
  description = "This property is only present for an auto assignment policy; if absent, this is a request-based policy."
  type = object({
    odata_type                                 = optional(string, "#microsoft.graph.accessPackageAutomaticRequestSettings")
    gracePeriodBeforeAccessRemoval             = optional(string)
    removeAccessWhenTargetLeavesAllowedTargets = optional(bool)
    requestAccessForAllowedTargets             = optional(bool)
  })
  default = null
}

variable "created_date_time" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "custom_extension_stage_settings" {
  description = "The collection of stages when to execute one or more custom access package workflow extensions. Supports $expand."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.customExtensionStageSetting")
    customExtension = optional(any)
    stage           = optional(string)
  }))
  default = null
}

variable "description" {
  description = "The description of the policy."
  type        = string
  default     = null
}

variable "display_name" {
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
}

variable "modified_date_time" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "notification_settings" {
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

variable "request_approval_settings" {
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
}

variable "requestor_settings" {
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

variable "review_settings" {
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
}

variable "specific_allowed_targets" {
  description = "The principals that can be assigned access from an access package through this policy."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["accessPackage", "catalog", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
