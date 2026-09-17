variable "user_activity_id" {
  description = "The unique identifier of userActivity"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_activity_id)) > 0
    error_message = "user_activity_id must not be empty."
  }
}

variable "active_duration_seconds" {
  description = "Optional. The duration of active user engagement. if not supplied, this is calculated from the startedDateTime and lastActiveDateTime."
  type        = number
  default     = null
}

variable "activity" {
  description = "Microsoft Graph activity property."
  type = object({
    odata_type         = optional(string, "#microsoft.graph.userActivity")
    activationUrl      = optional(string)
    activitySourceHost = optional(string)
    appActivityId      = optional(string)
    appDisplayName     = optional(string)
    contentInfo        = optional(any)
    contentUrl         = optional(string)
    createdDateTime    = optional(string)
    expirationDateTime = optional(string)
    fallbackUrl        = optional(string)
    historyItems = optional(list(object({
      odata_type            = optional(string, "#microsoft.graph.activityHistoryItem")
      activeDurationSeconds = optional(number)
      activity              = optional(any)
      createdDateTime       = optional(string)
      expirationDateTime    = optional(string)
      lastActiveDateTime    = optional(string)
      lastModifiedDateTime  = optional(string)
      startedDateTime       = optional(string)
      status                = optional(any)
      userTimezone          = optional(string)
    })))
    lastModifiedDateTime = optional(string)
    status               = optional(any)
    userTimezone         = optional(string)
    visualElements = optional(object({
      odata_type      = optional(string, "#microsoft.graph.visualInfo")
      attribution     = optional(any)
      backgroundColor = optional(string)
      content         = optional(any)
      description     = optional(string)
      displayText     = optional(string)
    }))
  })
  default = null
}

variable "created_date_time" {
  description = "Set by the server. DateTime in UTC when the object was created on the server."
  type        = string
  default     = null
}

variable "expiration_date_time" {
  description = "Optional. UTC DateTime when the activityHistoryItem will undergo hard-delete. Can be set by the client."
  type        = string
  default     = null
}

variable "last_active_date_time" {
  description = "Optional. UTC DateTime when the activityHistoryItem (activity session) was last understood as active or finished - if null, activityHistoryItem status should be Ongoing."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "Set by the server. DateTime in UTC when the object was modified on the server."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.activityHistoryItem"
  nullable    = false
}

variable "started_date_time" {
  description = "Required. UTC DateTime when the activityHistoryItem (activity session) was started. Required for timeline history."
  type        = string
  default     = null
}

variable "status" {
  description = "Set by the server. A status code used to identify valid objects. Values: active, updated, deleted, ignored."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["active", "updated", "deleted", "ignored", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "user_timezone" {
  description = "Optional. The timezone in which the user's device used to generate the activity was located at activity creation time. Values supplied as Olson IDs in order to support cross-platform representation."
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
