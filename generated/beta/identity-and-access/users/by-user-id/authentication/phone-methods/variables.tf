variable "user_id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_id)) > 0
    error_message = "user_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.phoneAuthenticationMethod"
  nullable    = false
}

variable "phone_number" {
  description = "The phone number to text or call for authentication. Phone numbers use the format '+<country code> <number>x<extension>', with extension optional. For example, +1 5555551234 or +1 5555551234x123 are valid. Numbers are rejected when creating/updating if they don't match the required format."
  type        = string
  default     = null
}

variable "phone_type" {
  description = "The type of this phone. The possible values are: mobile, alternateMobile, or office."
  type        = any
  default     = null

  validation {
    condition     = var.phone_type == null ? true : contains(["mobile", "alternateMobile", "office", "unknownFutureValue"], var.phone_type)
    error_message = "phone_type must be one of the documented enum values."
  }
}

variable "sms_sign_in_state" {
  description = "Whether a phone is ready to be used for SMS sign-in or not. The possible values are: notSupported, notAllowedByPolicy, notEnabled, phoneNumberNotUnique, ready, or notConfigured, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.sms_sign_in_state == null ? true : contains(["notSupported", "notAllowedByPolicy", "notEnabled", "phoneNumberNotUnique", "ready", "notConfigured", "unknownFutureValue"], var.sms_sign_in_state)
    error_message = "sms_sign_in_state must be one of the documented enum values."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "lastUsedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
