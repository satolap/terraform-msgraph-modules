variable "application_name" {
  description = "Application Name"
  type        = string
  default     = null
}

variable "application_type" {
  description = "Possible types of Application"
  type        = string
  default     = null

  validation {
    condition     = var.application_type == null ? true : contains(["universal", "desktop"], var.application_type)
    error_message = "application_type must be one of the documented enum values."
  }
}

variable "device_count" {
  description = "Device Count"
  type        = number
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.windowsInformationProtectionAppLearningSummary"
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
