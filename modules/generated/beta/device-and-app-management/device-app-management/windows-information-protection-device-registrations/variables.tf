variable "device_mac_address" {
  description = "Device Mac address."
  type        = string
  default     = null
}

variable "device_name" {
  description = "Device name."
  type        = string
  default     = null
}

variable "device_registration_id" {
  description = "Device identifier for this device registration record."
  type        = string
  default     = null
}

variable "device_type" {
  description = "Device type, for example, Windows laptop VS Windows phone."
  type        = string
  default     = null
}

variable "last_check_in_date_time" {
  description = "Last checkin time of the device."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.windowsInformationProtectionDeviceRegistration"
  nullable    = false
}

variable "user_id" {
  description = "UserId associated with this device registration record."
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
