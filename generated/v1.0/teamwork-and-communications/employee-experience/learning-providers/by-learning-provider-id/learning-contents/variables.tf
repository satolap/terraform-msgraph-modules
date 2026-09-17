variable "learning_provider_id" {
  description = "The unique identifier of learningProvider"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.learning_provider_id)) > 0
    error_message = "learning_provider_id must not be empty."
  }
}

variable "additional_tags" {
  description = "Keywords, topics, and other tags associated with the learning content. Optional."
  type        = list(string)
  default     = null
}

variable "content_web_url" {
  description = "The content web URL for the learning content. Required."
  type        = string
  default     = null
}

variable "contributors" {
  description = "The authors, creators, or contributors of the learning content. Optional."
  type        = list(string)
  default     = null
}

variable "created_date_time" {
  description = "The date and time when the learning content was created. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z. Optional."
  type        = string
  default     = null
}

variable "description" {
  description = "The description or summary for the learning content. Optional."
  type        = string
  default     = null
}

variable "duration" {
  description = "The duration of the learning content in seconds. The value is represented in ISO 8601 format for durations. Optional."
  type        = string
  default     = null
}

variable "external_id" {
  description = "Unique external content ID for the learning content. Required."
  type        = string
  default     = null
}

variable "format" {
  description = "The format of the learning content. For example, Course, Video, Book, Book Summary, Audiobook Summary. Optional."
  type        = string
  default     = null
}

variable "is_active" {
  description = "Indicates whether the content is active or not. Inactive content doesn't show up in the UI. The default value is true. Optional."
  type        = bool
  default     = null
}

variable "is_premium" {
  description = "Indicates whether the learning content requires the user to sign-in on the learning provider platform or not. The default value is false. Optional."
  type        = bool
  default     = null
}

variable "is_searchable" {
  description = "Indicates whether the learning content is searchable or not. The default value is true. Optional."
  type        = bool
  default     = null
}

variable "language_tag" {
  description = "The language of the learning content, for example, en-us or fr-fr. Required."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time when the learning content was last modified. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z. Optional."
  type        = string
  default     = null
}

variable "level" {
  description = "The difficulty level of the learning content. The possible values are: Beginner, Intermediate, Advanced, unknownFutureValue. Optional."
  type        = any
  default     = null

  validation {
    condition     = var.level == null ? true : contains(["beginner", "intermediate", "advanced", "unknownFutureValue"], var.level)
    error_message = "level must be one of the documented enum values."
  }
}

variable "number_of_pages" {
  description = "The number of pages of the learning content, for example, 9. Optional."
  type        = number
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.learningContent"
  nullable    = false
}

variable "skill_tags" {
  description = "The skills tags associated with the learning content. Optional."
  type        = list(string)
  default     = null
}

variable "source_name" {
  description = "The source name of the learning content, such as LinkedIn Learning or Coursera. Optional."
  type        = string
  default     = null
}

variable "thumbnail_web_url" {
  description = "The URL of learning content thumbnail image. Optional."
  type        = string
  default     = null
}

variable "title" {
  description = "The title of the learning content. Required."
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
