variable "expiration_date_time" {
  description = "Microsoft Graph expirationDateTime property."
  type        = string
  default     = null
}

variable "is_elevated" {
  description = "Microsoft Graph isElevated property."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.privilegedRoleAssignment"
  nullable    = false
}

variable "result_message" {
  description = "Microsoft Graph resultMessage property."
  type        = string
  default     = null
}

variable "role_id" {
  description = "Microsoft Graph roleId property."
  type        = string
  default     = null
}

variable "role_info" {
  description = "Microsoft Graph roleInfo property."
  type        = any
  default     = null
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
