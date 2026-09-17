variable "last_check_in_date_time" {
  description = "Last checkin time of the device that was targeted by this wipe action."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.windowsInformationProtectionWipeAction"
  nullable    = false
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["none", "pending", "canceled", "active", "done", "failed", "notSupported"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "targeted_device_mac_address" {
  description = "Targeted device Mac address."
  type        = string
  default     = null
}

variable "targeted_device_name" {
  description = "Targeted device name."
  type        = string
  default     = null
}

variable "targeted_device_registration_id" {
  description = "The DeviceRegistrationId being targeted by this wipe action."
  type        = string
  default     = null
}

variable "targeted_user_id" {
  description = "The UserId being targeted by this wipe action."
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
