variable "assigned_user_principal_name" {
  description = "UPN of the user the device will be assigned"
  type        = string
  default     = null
}

variable "group_tag" {
  description = "Group Tag of the Windows autopilot device."
  type        = string
  default     = null
}

variable "hardware_identifier" {
  description = "Hardware Blob of the Windows autopilot device."
  type        = string
  default     = null
}

variable "import_id" {
  description = "The Import Id of the Windows autopilot device."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.importedWindowsAutopilotDeviceIdentity"
  nullable    = false
}

variable "product_key" {
  description = "Product Key of the Windows autopilot device."
  type        = string
  default     = null
}

variable "serial_number" {
  description = "Serial number of the Windows autopilot device."
  type        = string
  default     = null
}

variable "state" {
  description = "Current state of the imported device."
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
