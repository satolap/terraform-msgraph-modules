variable "user_id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_id)) > 0
    error_message = "user_id must not be empty."
  }
}

variable "instances" {
  description = "A collection of setting values for a given windowsSetting."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.windowsSettingInstance")
    createdDateTime      = optional(string)
    expirationDateTime   = optional(string)
    lastModifiedDateTime = optional(string)
    payload              = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.windowsSetting"
  nullable    = false
}

variable "payload_type" {
  description = "The type of setting payloads contained in the instances navigation property."
  type        = string
  default     = null
}

variable "setting_type" {
  description = "Microsoft Graph settingType property."
  type        = string
  default     = null

  validation {
    condition     = var.setting_type == null ? true : contains(["roaming", "backup", "unknownFutureValue"], var.setting_type)
    error_message = "setting_type must be one of the documented enum values."
  }
}

variable "windows_device_id" {
  description = "A unique identifier for the device the setting might belong to if it is of the settingType backup."
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
