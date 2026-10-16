variable "mobile_app_id" {
  description = "The unique identifier of mobileApp"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.mobile_app_id)) > 0
    error_message = "mobile_app_id must not be empty."
  }
}

variable "intent" {
  description = "Possible values for the install intent chosen by the admin."
  type        = string
  default     = null

  validation {
    condition     = var.intent == null ? true : contains(["available", "required", "uninstall", "availableWithoutEnrollment"], var.intent)
    error_message = "intent must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.mobileAppAssignment"
  nullable    = false
}

variable "settings" {
  description = "The settings for target assignment defined by the admin."
  type        = any
  default     = null
}

variable "target" {
  description = "The target group assignment defined by the admin."
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
