variable "windows_setting_id" {
  description = "The unique identifier of windowsSetting"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.windows_setting_id)) > 0
    error_message = "windows_setting_id must not be empty."
  }
}

variable "created_date_time" {
  description = "Set by the server. Represents the dateTime in UTC when the object was created on the server."
  type        = string
  default     = null
}

variable "expiration_date_time" {
  description = "Set by the server. The object expires at the specified dateTime in UTC, making it unavailable after that time."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "Set by the server if not provided in the request from the Windows client device. Refers to the user's Windows device that modified the object at the specified dateTime in UTC."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.windowsSettingInstance"
  nullable    = false
}

variable "payload" {
  description = "Base64-encoded JSON setting value."
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
