variable "assignment_id" {
  description = "ID of the assignment with which this submission is associated."
  type        = string
  default     = null
}

variable "average_words_per_minute_pace" {
  description = "The average speaking pace of the student, measured in words per minute."
  type        = number
  default     = null
}

variable "class_id" {
  description = "ID of the class this speaker progress is associated with."
  type        = string
  default     = null
}

variable "filler_words_occurrences_count" {
  description = "The number of times the student was flagged by Speaker Coach for using a filler word."
  type        = number
  default     = null
}

variable "incorrect_camera_distance_occurrences_count" {
  description = "The number of times the student was flagged by Speaker Coach for being either too close or too far away from the camera."
  type        = number
  default     = null
}

variable "length_of_submission_in_seconds" {
  description = "The length of the student submission in seconds."
  type        = any
  default     = null
}

variable "lost_eye_contact_occurrences_count" {
  description = "The number of times the student was flagged by Speaker Coach for losing eye contact with the camera."
  type        = number
  default     = null
}

variable "monotone_occurrences_count" {
  description = "The number of times the student was flagged by Speaker Coach for speaking in monotone."
  type        = number
  default     = null
}

variable "non_inclusive_language_occurrences_count" {
  description = "The number of times the student was flagged by Speaker Coach for using non-inclusive or sensitive language."
  type        = number
  default     = null
}

variable "obstructed_view_occurrences_count" {
  description = "The number of times the student was flagged by Speaker Coach for obstructing the view of their face."
  type        = number
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.speakerAssignmentSubmission"
  nullable    = false
}

variable "repetitive_language_occurrences_count" {
  description = "The number of times the student was flagged by Speaker Coach for using repetitive language."
  type        = number
  default     = null
}

variable "student_id" {
  description = "ID of the user this speaker progress is associated with."
  type        = string
  default     = null
}

variable "submission_date_time" {
  description = "Date and time of the submission this speaker progress is associated with. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "submission_id" {
  description = "ID of the submission this speaker progress is associated with."
  type        = string
  default     = null
}

variable "top_filler_words" {
  description = "The filler words used most by the student."
  type        = list(string)
  default     = null
}

variable "top_mispronounced_words" {
  description = "The words mispronounced most by the student."
  type        = list(string)
  default     = null
}

variable "top_non_inclusive_words_and_phrases" {
  description = "The non-inclusive or sensitive words and phrases most used by the student."
  type        = list(string)
  default     = null
}

variable "top_repetitive_words_and_phrases" {
  description = "The words and phrases most repeated by the student."
  type        = list(string)
  default     = null
}

variable "words_spoken_count" {
  description = "Total number of words spoken by the student in the submission."
  type        = number
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
