variable "display_name" {
  description = "The display name that appears in Viva Learning. Required."
  type        = string
  default     = null
}

variable "is_course_activity_sync_enabled" {
  description = "Indicates whether a provider can ingest learning course activity records. The default value is false. Set to true to make learningCourseActivities available for this provider."
  type        = bool
  default     = null
}

variable "learning_contents" {
  description = "Learning catalog items for the provider."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.learningContent")
    additionalTags       = optional(list(string))
    contentWebUrl        = optional(string)
    contributors         = optional(list(string))
    createdDateTime      = optional(string)
    description          = optional(string)
    duration             = optional(string)
    externalId           = optional(string)
    format               = optional(string)
    isActive             = optional(bool)
    isPremium            = optional(bool)
    isSearchable         = optional(bool)
    languageTag          = optional(string)
    lastModifiedDateTime = optional(string)
    level                = optional(any)
    numberOfPages        = optional(number)
    skillTags            = optional(list(string))
    sourceName           = optional(string)
    thumbnailWebUrl      = optional(string)
    title                = optional(string)
  }))
  default = null
}

variable "learning_course_activities" {
  description = "Microsoft Graph learningCourseActivities property."
  type = list(object({
    odata_type               = optional(string, "#microsoft.graph.learningCourseActivity")
    completedDateTime        = optional(string)
    completionPercentage     = optional(number)
    externalcourseActivityId = optional(string)
    learnerUserId            = optional(string)
    learningContentId        = optional(string)
    learningProviderId       = optional(string)
    status                   = optional(any)
  }))
  default = null
}

variable "login_web_url" {
  description = "Authentication URL to access the courses for the provider. Optional."
  type        = string
  default     = null
}

variable "long_logo_web_url_for_dark_theme" {
  description = "The long logo URL for the dark mode that needs to be a publicly accessible image. This image would be saved to the blob storage of Viva Learning for rendering within the Viva Learning app. Required."
  type        = string
  default     = null
}

variable "long_logo_web_url_for_light_theme" {
  description = "The long logo URL for the light mode that needs to be a publicly accessible image. This image would be saved to the blob storage of Viva Learning for rendering  within the Viva Learning app. Required."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.learningProvider"
  nullable    = false
}

variable "square_logo_web_url_for_dark_theme" {
  description = "The square logo URL for the dark mode that needs to be a publicly accessible image. This image would be saved to the blob storage of Viva Learning for rendering within the Viva Learning app. Required."
  type        = string
  default     = null
}

variable "square_logo_web_url_for_light_theme" {
  description = "The square logo URL for the light mode that needs to be a publicly accessible image. This image would be saved to the blob storage of Viva Learning for rendering within the Viva Learning app. Required."
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
