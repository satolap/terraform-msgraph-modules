variable "access_package_assignment_requests" {
  description = "Microsoft Graph accessPackageAssignmentRequests property."
  type = list(object({
    odata_type              = optional(string, "#microsoft.graph.accessPackageAssignmentRequest")
    accessPackageAssignment = optional(any)
    answers = optional(list(object({
      odata_type   = optional(string, "#microsoft.graph.accessPackageAnswer")
      displayValue = optional(string)
    })))
    customExtensionCalloutInstances = optional(list(object({
      odata_type            = optional(string, "#microsoft.graph.customExtensionCalloutInstance")
      customExtensionId     = optional(string)
      detail                = optional(string)
      externalCorrelationId = optional(string)
      status                = optional(any)
    })))
    expirationDateTime = optional(string)
    history = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.requestActivity")
      action            = optional(string)
      actionDateTime    = optional(string)
      detail            = optional(string)
      scheduledDateTime = optional(string)
      userDisplayName   = optional(string)
      userPrincipalName = optional(string)
    })))
    isValidationOnly = optional(bool)
    justification    = optional(string)
    parameters       = optional(any)
  }))
  default = null
}

variable "custom_extension_callout_instances" {
  description = "Information about all the custom extension calls that were made during the access package assignment workflow."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.customExtensionCalloutInstance")
    customExtensionId     = optional(string)
    detail                = optional(string)
    externalCorrelationId = optional(string)
    status                = optional(any)
  }))
  default = null
}

variable "expired_date_time" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.accessPackageAssignment"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["accessPackage", "accessPackageAssignmentPolicy", "accessPackageAssignmentResourceRoles", "accessPackageId", "assignmentPolicyId", "assignmentState", "assignmentStatus", "catalogId", "id", "isExtended", "schedule", "target", "targetId"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
