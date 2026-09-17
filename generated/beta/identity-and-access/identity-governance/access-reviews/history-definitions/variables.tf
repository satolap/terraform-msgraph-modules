variable "created_by" {
  description = "Microsoft Graph createdBy property."
  type = object({
    odata_type        = optional(string, "#microsoft.graph.userIdentity")
    displayName       = optional(string)
    id                = optional(string)
    ipAddress         = optional(string)
    userPrincipalName = optional(string)
  })
  default = null
}

variable "created_date_time" {
  description = "Timestamp when the access review definition was created."
  type        = string
  default     = null
}

variable "decisions" {
  description = "Determines which review decisions will be included in the fetched review history data if specified. Optional on create. All decisions are included by default if no decisions are provided on create. The possible values are: approve, deny, dontKnow, notReviewed, and notNotified."
  type        = any
  default     = null
}

variable "display_name" {
  description = "Name for the access review history data collection. Required."
  type        = string
  default     = null
}

variable "download_uri" {
  description = "Microsoft Graph downloadUri property."
  type        = string
  default     = null
}

variable "fulfilled_date_time" {
  description = "Microsoft Graph fulfilledDateTime property."
  type        = string
  default     = null
}

variable "instances" {
  description = "If the accessReviewHistoryDefinition is a recurring definition, instances represent each recurrence. A definition that doesn't recur will have exactly one instance."
  type = list(object({
    odata_type                       = optional(string, "#microsoft.graph.accessReviewHistoryInstance")
    downloadUri                      = optional(string)
    expirationDateTime               = optional(string)
    fulfilledDateTime                = optional(string)
    reviewHistoryPeriodEndDateTime   = optional(string)
    reviewHistoryPeriodStartDateTime = optional(string)
    runDateTime                      = optional(string)
    status                           = optional(any)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.accessReviewHistoryDefinition"
  nullable    = false
}

variable "review_history_period_end_date_time" {
  description = "A timestamp. Reviews ending on or before this date will be included in the fetched history data. Only required if scheduleSettings is not defined."
  type        = string
  default     = null
}

variable "review_history_period_start_date_time" {
  description = "A timestamp. Reviews starting on or before this date will be included in the fetched history data. Only required if scheduleSettings isn't defined."
  type        = string
  default     = null
}

variable "schedule_settings" {
  description = "The settings for a recurring access review history definition series. Only required if reviewHistoryPeriodStartDateTime or reviewHistoryPeriodEndDateTime aren't defined. Not supported yet."
  type        = any
  default     = null
}

variable "scopes" {
  description = "Used to scope what reviews are included in the fetched history data. Fetches reviews whose scope matches with this provided scope. Required."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.accessReviewScope")
  }))
  default = null
}

variable "status" {
  description = "Represents the status of the review history data collection. The possible values are: done, inProgress, error, requested, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["done", "inprogress", "error", "requested", "unknownFutureValue"], var.status)
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
