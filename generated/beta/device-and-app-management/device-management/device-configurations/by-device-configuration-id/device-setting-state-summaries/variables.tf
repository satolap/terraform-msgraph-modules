variable "device_configuration_id" {
  description = "The unique identifier of deviceConfiguration"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.device_configuration_id)) > 0
    error_message = "device_configuration_id must not be empty."
  }
}

variable "compliant_device_count" {
  description = "Device Compliant count for the setting"
  type        = number
  default     = null
}

variable "conflict_device_count" {
  description = "Device conflict error count for the setting"
  type        = number
  default     = null
}

variable "error_device_count" {
  description = "Device error count for the setting"
  type        = number
  default     = null
}

variable "instance_path" {
  description = "Name of the InstancePath for the setting"
  type        = string
  default     = null
}

variable "non_compliant_device_count" {
  description = "Device NonCompliant count for the setting"
  type        = number
  default     = null
}

variable "not_applicable_device_count" {
  description = "Device Not Applicable count for the setting"
  type        = number
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.settingStateDeviceSummary"
  nullable    = false
}

variable "remediated_device_count" {
  description = "Device Compliant count for the setting"
  type        = number
  default     = null
}

variable "setting_name" {
  description = "Name of the setting"
  type        = string
  default     = null
}

variable "unknown_device_count" {
  description = "Device Unkown count for the setting"
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
