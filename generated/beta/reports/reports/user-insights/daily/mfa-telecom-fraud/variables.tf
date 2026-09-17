variable "captcha_failure_count" {
  description = "Microsoft Graph captchaFailureCount property."
  type        = number
  default     = null
}

variable "captcha_not_triggered_user_count" {
  description = "Microsoft Graph captchaNotTriggeredUserCount property."
  type        = number
  default     = null
}

variable "captcha_shown_user_count" {
  description = "Microsoft Graph captchaShownUserCount property."
  type        = number
  default     = null
}

variable "captcha_success_count" {
  description = "Microsoft Graph captchaSuccessCount property."
  type        = number
  default     = null
}

variable "fact_date" {
  description = "Microsoft Graph factDate property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.mfaTelecomFraudMetric"
  nullable    = false
}

variable "telecom_blocked_user_count" {
  description = "Microsoft Graph telecomBlockedUserCount property."
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
