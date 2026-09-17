variable "accuracy_score" {
  description = "Accuracy score of the reading progress."
  type        = any
  default     = null
}

variable "action" {
  description = "Indicates whether the submission is an attempt by the student or a miscue edit done by the educator. The possible values are Attempt and EditMiscue."
  type        = string
  default     = null
}

variable "assignment_id" {
  description = "ID of the assignment with which this submission is associated."
  type        = string
  default     = null
}

variable "challenging_words" {
  description = "List of words that the student found challenging during the reading session."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.challengingWord")
    count      = optional(number)
    word       = optional(string)
  }))
  default = null
}

variable "class_id" {
  description = "ID of the class this reading progress is associated with."
  type        = string
  default     = null
}

variable "insertions" {
  description = "Insertions of the reading progress."
  type        = number
  default     = null
}

variable "mispronunciations" {
  description = "Mispronunciations of the reading progress."
  type        = number
  default     = null
}

variable "missed_exclamation_marks" {
  description = "Number of exclamation marks missed in the reading passage."
  type        = number
  default     = null
}

variable "missed_periods" {
  description = "Number of periods missed in the reading passage."
  type        = number
  default     = null
}

variable "missed_question_marks" {
  description = "Number of question marks missed in the reading passage."
  type        = number
  default     = null
}

variable "missed_shorts" {
  description = "Number of short words missed during the reading session."
  type        = number
  default     = null
}

variable "monotone_score" {
  description = "Score that reflects the student's use of intonation and expression. Lower scores indicate more monotone reading."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.readingAssignmentSubmission"
  nullable    = false
}

variable "omissions" {
  description = "Omissions of the reading progress."
  type        = number
  default     = null
}

variable "repetitions" {
  description = "Number of times the student repeated words or phrases during the reading session."
  type        = number
  default     = null
}

variable "self_corrections" {
  description = "Number of times the student self-corrected their reading errors."
  type        = number
  default     = null
}

variable "student_id" {
  description = "ID of the user this reading progress is associated with."
  type        = string
  default     = null
}

variable "submission_date_time" {
  description = "Date and time of the submission this reading progress is associated with. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "submission_id" {
  description = "ID of the submission this reading progress is associated with."
  type        = string
  default     = null
}

variable "unexpected_pauses" {
  description = "Number of unexpected pauses made during the reading session."
  type        = number
  default     = null
}

variable "word_count" {
  description = "Words count of the reading progress."
  type        = number
  default     = null
}

variable "words_per_minute" {
  description = "Words per minute of the reading progress."
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
