variable "access_rules" {
  description = "The list of device access rules in Exchange. The access rules apply globally to the entire Exchange organization"
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.deviceManagementExchangeAccessRule")
    accessLevel = optional(string)
    deviceClass = optional(any)
  }))
  default = null
}

variable "conditional_access_settings" {
  description = "The Exchange on premises conditional access settings. On premises conditional access will require devices to be both enrolled and compliant for mail access"
  type        = any
  default     = null
}

variable "default_access_level" {
  description = "Access Level in Exchange."
  type        = string
  default     = null

  validation {
    condition     = var.default_access_level == null ? true : contains(["none", "allow", "block", "quarantine"], var.default_access_level)
    error_message = "default_access_level must be one of the documented enum values."
  }
}

variable "known_device_classes" {
  description = "The list of device classes known to Exchange"
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.deviceManagementExchangeDeviceClass")
    name       = optional(string)
    type       = optional(string)
  }))
  default = null
}

variable "notification_content" {
  description = "Notification text that will be sent to users quarantined by this policy. This is UTF8 encoded byte array HTML."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagementExchangeOnPremisesPolicy"
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
