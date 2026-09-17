variable "allowed_target_scope" {
  description = "Principals that can be assigned the access package through this policy. The possible values are: notSpecified, specificDirectoryUsers, specificConnectedOrganizationUsers, specificDirectoryServicePrincipals, allMemberUsers, allDirectoryUsers, allDirectoryServicePrincipals, allConfiguredConnectedOrganizationUsers, allExternalUsers, allDirectoryAgentIdentities, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.allowed_target_scope == null ? true : contains(["notSpecified", "specificDirectoryUsers", "specificConnectedOrganizationUsers", "specificDirectoryServicePrincipals", "allMemberUsers", "allDirectoryUsers", "allDirectoryServicePrincipals", "allConfiguredConnectedOrganizationUsers", "allExternalUsers", "allDirectoryAgentIdentities", "unknownFutureValue"], var.allowed_target_scope)
    error_message = "allowed_target_scope must be one of the documented enum values."
  }
}

variable "automatic_request_settings" {
  description = "This property is only present for an auto assignment policy; if absent, this is a request-based policy."
  type        = any
  default     = null
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
  type        = any
  default     = null
}

variable "modified_date_time" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "notification_settings" {
  description = "Microsoft Graph notificationSettings property."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.accessPackageAssignmentPolicy"
  nullable    = false
}

variable "questions" {
  description = "Questions that are posed to the  requestor."
  type = list(object({
    odata_type       = optional(string, "#microsoft.graph.accessPackageQuestion")
    isAnswerEditable = optional(bool)
    isRequired       = optional(bool)
    localizations = optional(list(object({
      odata_type   = optional(string, "#microsoft.graph.accessPackageLocalizedText")
      languageCode = optional(string)
      text         = optional(string)
    })))
    sequence = optional(number)
    text     = optional(string)
  }))
  default = null
}

variable "request_approval_settings" {
  description = "Specifies the settings for approval of requests for an access package assignment through this policy. For example, if approval is required for new requests."
  type        = any
  default     = null
}

variable "requestor_settings" {
  description = "Provides additional settings to select who can create a request for an access package assignment through this policy, and what they can include in their request."
  type        = any
  default     = null
}

variable "review_settings" {
  description = "Settings for access reviews of assignments through this policy."
  type        = any
  default     = null
}

variable "specific_allowed_targets" {
  description = "The principals that can be assigned access from an access package through this policy."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.subjectSet")
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["accessPackage", "catalog", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
