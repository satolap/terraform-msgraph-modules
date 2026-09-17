variable "issues" {
  description = "A collection of issues that happened on the service, with detailed information for each issue."
  type = list(object({
    odata_type     = optional(string, "#microsoft.graph.serviceHealthIssue")
    classification = optional(string)
    details = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.keyValuePair")
      name       = optional(string)
      value      = optional(string)
    })))
    endDateTime          = optional(string)
    feature              = optional(string)
    featureGroup         = optional(string)
    impactDescription    = optional(string)
    isResolved           = optional(bool)
    lastModifiedDateTime = optional(string)
    origin               = optional(string)
    posts = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.serviceHealthIssuePost")
      createdDateTime = optional(string)
      description     = optional(any)
      postType        = optional(any)
    })))
    service       = optional(string)
    startDateTime = optional(string)
    status        = optional(string)
    title         = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.serviceHealth"
  nullable    = false
}

variable "service" {
  description = "The service name. Use the list healthOverviews operation to get exact string names for services subscribed by the tenant."
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
