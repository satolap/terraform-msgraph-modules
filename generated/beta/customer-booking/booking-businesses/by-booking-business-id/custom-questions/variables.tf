variable "booking_business_id" {
  description = "The unique identifier of bookingBusiness"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.booking_business_id)) > 0
    error_message = "booking_business_id must not be empty."
  }
}

variable "answer_input_type" {
  description = "The expected answer type. The possible values are: text, radioButton, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.answer_input_type == null ? true : contains(["text", "radioButton", "unknownFutureValue"], var.answer_input_type)
    error_message = "answer_input_type must be one of the documented enum values."
  }
}

variable "answer_options" {
  description = "List of possible answer values."
  type        = list(string)
  default     = null
}

variable "created_date_time" {
  description = "The date, time and timezone when the custom question was created."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Display name of this entity."
  type        = string
  default     = null
}

variable "last_updated_date_time" {
  description = "The date, time and timezone when the custom question was last updated."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.bookingCustomQuestion"
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
