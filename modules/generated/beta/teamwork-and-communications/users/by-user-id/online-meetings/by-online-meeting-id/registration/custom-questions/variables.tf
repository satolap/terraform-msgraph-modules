variable "user_id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_id)) > 0
    error_message = "user_id must not be empty."
  }
}

variable "online_meeting_id" {
  description = "The unique identifier of onlineMeeting"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.online_meeting_id)) > 0
    error_message = "online_meeting_id must not be empty."
  }
}

variable "answer_input_type" {
  description = "Answer input type of the custom registration question."
  type        = any
  default     = null

  validation {
    condition     = var.answer_input_type == null ? true : contains(["text", "radioButton", "unknownFutureValue"], var.answer_input_type)
    error_message = "answer_input_type must be one of the documented enum values."
  }
}

variable "answer_options" {
  description = "Answer options when answerInputType is radioButton."
  type        = list(string)
  default     = null
}

variable "display_name" {
  description = "Display name of the custom registration question."
  type        = string
  default     = null
}

variable "is_required" {
  description = "Indicates whether the question is required. Default value is false."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.meetingRegistrationQuestion"
  nullable    = false
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
