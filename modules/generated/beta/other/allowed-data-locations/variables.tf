variable "app_id" {
  description = "Microsoft Graph appId property."
  type        = string
  default     = null
}

variable "domain" {
  description = "Microsoft Graph domain property."
  type        = string
  default     = null
}

variable "is_default" {
  description = "Microsoft Graph isDefault property."
  type        = bool
  default     = null
}

variable "location" {
  description = "Microsoft Graph location property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.allowedDataLocation"
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
