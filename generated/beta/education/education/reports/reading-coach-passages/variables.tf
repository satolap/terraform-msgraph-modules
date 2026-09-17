variable "is_reading_completed" {
  description = "Indicates if the reading passage was completed."
  type        = bool
  default     = null
}

variable "language_tag" {
  description = "The language of the reading passage."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.readingCoachPassage"
  nullable    = false
}

variable "practice_words" {
  description = "The list of challenging words for the student that they can practice further."
  type        = list(string)
  default     = null
}

variable "practiced_at_date_time" {
  description = "The date and time when the Reading Coach passage was practiced. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "story_type" {
  description = "Microsoft Graph storyType property."
  type        = string
  default     = null

  validation {
    condition     = var.story_type == null ? true : contains(["aiGenerated", "readWorks", "userProvided", "unknownFutureValue"], var.story_type)
    error_message = "story_type must be one of the documented enum values."
  }
}

variable "student_id" {
  description = "ID of the student that practiced the reading passage."
  type        = string
  default     = null
}

variable "time_spent_reading_in_seconds" {
  description = "The time the student spent reading in seconds."
  type        = any
  default     = null
}

variable "words_accuracy_percentage" {
  description = "The percentage of words that the student read correctly."
  type        = any
  default     = null
}

variable "words_per_minute" {
  description = "The rate the student read at in words per minute."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
