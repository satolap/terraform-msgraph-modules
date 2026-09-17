variable "activation_url" {
  description = "Required. URL used to launch the activity in the best native experience represented by the appId. Might launch a web-based app if no native app exists."
  type        = string
  default     = null
}

variable "activity_source_host" {
  description = "Required. URL for the domain representing the cross-platform identity mapping for the app. Mapping is stored either as a JSON file hosted on the domain or configurable via Windows Dev Center. The JSON file is named cross-platform-app-identifiers and is hosted at root of your HTTPS domain, either at the top level domain or include a sub domain. For example: https://contoso.com or https://myapp.contoso.com but NOT https://myapp.contoso.com/somepath. You must have a unique file and domain (or sub domain) per cross-platform app identity. For example, a separate file and domain is needed for Word vs. PowerPoint."
  type        = string
  default     = null
}

variable "app_activity_id" {
  description = "Required. The unique activity ID in the context of the app - supplied by caller and immutable thereafter."
  type        = string
  default     = null
}

variable "app_display_name" {
  description = "Optional. Short text description of the app used to generate the activity for use in cases when the app is not installed on the user’s local device."
  type        = string
  default     = null
}

variable "content_info" {
  description = "Optional. A custom piece of data - JSON-LD extensible description of content according to schema.org syntax."
  type        = any
  default     = null
}

variable "content_url" {
  description = "Optional. Used in the event the content can be rendered outside of a native or web-based app experience (for example, a pointer to an item in an RSS feed)."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "Set by the server. DateTime in UTC when the object was created on the server."
  type        = string
  default     = null
}

variable "expiration_date_time" {
  description = "Set by the server. DateTime in UTC when the object expired on the server."
  type        = string
  default     = null
}

variable "fallback_url" {
  description = "Optional. URL used to launch the activity in a web-based app, if available."
  type        = string
  default     = null
}

variable "history_items" {
  description = "Optional. NavigationProperty/Containment; navigation property to the activity's activityHistoryItems."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.activityHistoryItem")
    activeDurationSeconds = optional(number)
    activity = optional(object({
      odata_type           = optional(string, "#microsoft.graph.userActivity")
      activationUrl        = optional(string)
      activitySourceHost   = optional(string)
      appActivityId        = optional(string)
      appDisplayName       = optional(string)
      contentInfo          = optional(any)
      contentUrl           = optional(string)
      createdDateTime      = optional(string)
      expirationDateTime   = optional(string)
      fallbackUrl          = optional(string)
      historyItems         = optional(any)
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
    }))
    createdDateTime      = optional(string)
    expirationDateTime   = optional(string)
    lastActiveDateTime   = optional(string)
    lastModifiedDateTime = optional(string)
    startedDateTime      = optional(string)
    status               = optional(any)
    userTimezone         = optional(string)
  }))
  default = null
}

variable "last_modified_date_time" {
  description = "Set by the server. DateTime in UTC when the object was modified on the server."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.userActivity"
  nullable    = false
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
  description = "Optional. The timezone in which the user's device used to generate the activity was located at activity creation time; values supplied as Olson IDs in order to support cross-platform representation."
  type        = string
  default     = null
}

variable "visual_elements" {
  description = "Microsoft Graph visualElements property."
  type = object({
    odata_type      = optional(string, "#microsoft.graph.visualInfo")
    attribution     = optional(any)
    backgroundColor = optional(string)
    content         = optional(any)
    description     = optional(string)
    displayText     = optional(string)
  })
  default = null
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
