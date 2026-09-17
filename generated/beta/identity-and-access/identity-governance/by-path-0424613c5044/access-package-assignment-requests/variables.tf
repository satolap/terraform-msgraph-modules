variable "access_package_assignment_id" {
  description = "The unique identifier of accessPackageAssignment"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.access_package_assignment_id)) > 0
    error_message = "access_package_assignment_id must not be empty."
  }
}

variable "access_package_assignment" {
  description = "For a requestType of UserAdd or AdminAdd, an access package assignment requested to be created. For a requestType of UserRemove, AdminRemove, ApproverRemove, or SystemRemove, this property has the id property of an existing assignment to be removed. Supports $expand."
  type        = any
  default     = null
}

variable "answers" {
  description = "Answers provided by the requestor to accessPackageQuestions asked of them at the time of request."
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.accessPackageAnswer")
    displayValue = optional(string)
  }))
  default = null
}

variable "custom_extension_callout_instances" {
  description = "Information about all the custom extension calls that were made during the access package assignment request workflow."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.customExtensionCalloutInstance")
    customExtensionId     = optional(string)
    detail                = optional(string)
    externalCorrelationId = optional(string)
    status                = optional(any)
  }))
  default = null
}

variable "expiration_date_time" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "history" {
  description = "Microsoft Graph history property."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.requestActivity")
    action            = optional(string)
    actionDateTime    = optional(string)
    detail            = optional(string)
    scheduledDateTime = optional(string)
    userDisplayName   = optional(string)
    userPrincipalName = optional(string)
  }))
  default = null
}

variable "is_validation_only" {
  description = "True if the request isn't to be processed for assignment."
  type        = bool
  default     = null
}

variable "justification" {
  description = "The requestor's supplied justification."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.accessPackageAssignmentRequest"
  nullable    = false
}

variable "parameters" {
  description = "Additional parameters that control how the request is processed, such as bypassing the approval requirement configured on the access package policy."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["accessPackage", "completedDate", "createdDateTime", "customExtensionHandlerInstances", "id", "requestState", "requestStatus", "requestType", "requestor", "schedule", "verifiedCredentialsData"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
