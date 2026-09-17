variable "classification" {
  description = "Microsoft Graph classification property."
  type        = string
  default     = null

  validation {
    condition     = var.classification == null ? true : contains(["advisory", "incident", "unknownFutureValue"], var.classification)
    error_message = "classification must be one of the documented enum values."
  }
}

variable "details" {
  description = "More details about service event. This property doesn't support filters."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.keyValuePair")
    name       = optional(string)
    value      = optional(string)
  }))
  default = null
}

variable "end_date_time" {
  description = "The end time of the service event."
  type        = string
  default     = null
}

variable "feature" {
  description = "The feature name of the service issue."
  type        = string
  default     = null
}

variable "feature_group" {
  description = "The feature group name of the service issue."
  type        = string
  default     = null
}

variable "impact_description" {
  description = "The description of the service issue impact."
  type        = string
  default     = null
}

variable "is_resolved" {
  description = "Indicates whether the issue is resolved."
  type        = bool
  default     = null
}

variable "last_modified_date_time" {
  description = "The last modified time of the service event."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.serviceHealthIssue"
  nullable    = false
}

variable "origin" {
  description = "Microsoft Graph origin property."
  type        = string
  default     = null

  validation {
    condition     = var.origin == null ? true : contains(["microsoft", "thirdParty", "customer", "unknownFutureValue"], var.origin)
    error_message = "origin must be one of the documented enum values."
  }
}

variable "posts" {
  description = "Collection of historical posts for the service issue."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.serviceHealthIssuePost")
    createdDateTime = optional(string)
    description     = optional(any)
    postType        = optional(any)
  }))
  default = null
}

variable "service" {
  description = "Indicates the service affected by the issue."
  type        = string
  default     = null
}

variable "start_date_time" {
  description = "The start time of the service event."
  type        = string
  default     = null
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["serviceOperational", "investigating", "restoringService", "verifyingService", "serviceRestored", "postIncidentReviewPublished", "serviceDegradation", "serviceInterruption", "extendedRecovery", "falsePositive", "investigationSuspended", "resolved", "mitigatedExternal", "mitigated", "resolvedExternal", "confirmed", "reported", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "title" {
  description = "The title of the service event."
  type        = string
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
