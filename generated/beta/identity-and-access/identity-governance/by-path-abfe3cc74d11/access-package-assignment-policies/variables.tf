variable "access_package_assignment_id" {
  description = "The unique identifier of accessPackageAssignment"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.access_package_assignment_id)) > 0
    error_message = "access_package_assignment_id must not be empty."
  }
}

variable "access_package_catalog" {
  description = "Microsoft Graph accessPackageCatalog property."
  type        = any
  default     = null
}

variable "access_package_id" {
  description = "Identifier of the access package."
  type        = string
  default     = null
}

variable "access_package_notification_settings" {
  description = "Represents the settings for email notifications for requests to an access package."
  type        = any
  default     = null
}

variable "access_review_settings" {
  description = "Who must review, and how often, the assignments to the access package from this policy. This property is null if reviews aren't required."
  type        = any
  default     = null
}

variable "can_extend" {
  description = "Indicates whether a user can extend the access package assignment duration after approval."
  type        = bool
  default     = null
}

variable "created_by" {
  description = "Microsoft Graph createdBy property."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "custom_extension_handlers" {
  description = "The collection of stages when to execute one or more custom access package workflow extensions. Supports $expand."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.customExtensionHandler")
    customExtension = optional(any)
    stage           = optional(any)
  }))
  default = null
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
  description = "The display name of the policy. Supports $filter (eq)."
  type        = string
  default     = null
}

variable "duration_in_days" {
  description = "The number of days in which assignments from this policy last until they're expired."
  type        = number
  default     = null
}

variable "expiration_date_time" {
  description = "The expiration date for assignments created in this policy. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "modified_by" {
  description = "Microsoft Graph modifiedBy property."
  type        = string
  default     = null
}

variable "modified_date_time" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
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
    id               = optional(string)
    isAnswerEditable = optional(bool)
    isRequired       = optional(bool)
    sequence         = optional(number)
    text             = optional(any)
  }))
  default = null
}

variable "request_approval_settings" {
  description = "Who must approve requests for access package in this policy."
  type        = any
  default     = null
}

variable "requestor_settings" {
  description = "Who can request this access package from this policy."
  type        = any
  default     = null
}

variable "verifiable_credential_settings" {
  description = "Settings for verifiable credentials set up through the Microsoft Entra Verified I D service. These settings represent the verifiable credentials that a requestor of an access package in this policy can present to be assigned the access package."
  type        = any
  default     = null
  sensitive   = true
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["accessPackage", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
