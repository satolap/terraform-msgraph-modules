variable "created_date_time" {
  description = "Created Date Time of the device"
  type        = string
  default     = null
}

variable "description" {
  description = "The description of the device"
  type        = string
  default     = null
}

variable "enrollment_state" {
  description = "Microsoft Graph enrollmentState property."
  type        = string
  default     = null

  validation {
    condition     = var.enrollment_state == null ? true : contains(["unknown", "enrolled", "pendingReset", "failed", "notContacted", "blocked"], var.enrollment_state)
    error_message = "enrollment_state must be one of the documented enum values."
  }
}

variable "imported_device_identifier" {
  description = "Imported Device Identifier"
  type        = string
  default     = null
}

variable "imported_device_identity_type" {
  description = "Microsoft Graph importedDeviceIdentityType property."
  type        = string
  default     = null

  validation {
    condition     = var.imported_device_identity_type == null ? true : contains(["unknown", "imei", "serialNumber", "manufacturerModelSerial"], var.imported_device_identity_type)
    error_message = "imported_device_identity_type must be one of the documented enum values."
  }
}

variable "last_contacted_date_time" {
  description = "Last Contacted Date Time of the device"
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "Last Modified DateTime of the description"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.importedDeviceIdentity"
  nullable    = false
}

variable "platform" {
  description = "Supported platform types for policies."
  type        = string
  default     = null

  validation {
    condition     = var.platform == null ? true : contains(["unknown", "ios", "android", "windows", "windowsMobile", "macOS", "visionOS", "tvOS", "unknownFutureValue"], var.platform)
    error_message = "platform must be one of the documented enum values."
  }
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
