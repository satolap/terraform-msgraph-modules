variable "check_in_id" {
  description = "Identifier for the Reflect check-in."
  type        = string
  default     = null
}

variable "check_in_title" {
  description = "The question or prompt of the Reflect check-in that this response addresses."
  type        = string
  default     = null
}

variable "class_id" {
  description = "ID of the class associated with the Reflect check-in."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "Date and time when the Reflect check-in was created. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "creator_id" {
  description = "ID of the user who created the Reflect check-in."
  type        = string
  default     = null
}

variable "is_closed" {
  description = "Indicates whether the Reflect check-in is closed (true) or open (false)."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.reflectCheckInResponse"
  nullable    = false
}

variable "responder_id" {
  description = "ID of the user who responded to the Reflect check-in."
  type        = string
  default     = null
}

variable "response_emotion" {
  description = "Microsoft Graph responseEmotion property."
  type        = string
  default     = null

  validation {
    condition     = var.response_emotion == null ? true : contains(["none", "confident", "excited", "happy", "motivated", "peaceful", "ambitious", "cheerful", "comfortable", "creative", "determined", "energized", "focused", "fulfilled", "grateful", "included", "inspired", "optimistic", "proud", "successful", "valuable", "annoyed", "bored", "calm", "confused", "glad", "content", "pensive", "reserved", "restless", "shocked", "tired", "angry", "depressed", "exhausted", "lonely", "nervous", "anxious", "apathetic", "concerned", "disappointed", "frightened", "frustrated", "hopeless", "hurt", "jealous", "miserable", "overwhelmed", "skeptical", "stressed", "stuck", "worthless", "awed", "ashamed", "curious", "sensitive", "sad", "unknownFutureValue"], var.response_emotion)
    error_message = "response_emotion must be one of the documented enum values."
  }
}

variable "response_feedback" {
  description = "Microsoft Graph responseFeedback property."
  type        = string
  default     = null

  validation {
    condition     = var.response_feedback == null ? true : contains(["none", "notDetected", "veryUnpleasant", "unpleasant", "neutral", "pleasant", "veryPleasant", "unknownFutureValue"], var.response_feedback)
    error_message = "response_feedback must be one of the documented enum values."
  }
}

variable "submit_date_time" {
  description = "Date and time when the response to the Reflect check-in was submitted. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
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
