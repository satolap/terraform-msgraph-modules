variable "activities" {
  description = "Microsoft Graph activities property."
  type        = any
  default     = null
}

variable "callback_url" {
  description = "Microsoft Graph callbackUrl property."
  type        = string
  default     = null
}

variable "chat_info" {
  description = "Microsoft Graph chatInfo property."
  type        = any
  default     = null
}

variable "meeting_info" {
  description = "Microsoft Graph meetingInfo property."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.multiActivitySubscription"
  nullable    = false
}

variable "user_id" {
  description = "Microsoft Graph userId property."
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
