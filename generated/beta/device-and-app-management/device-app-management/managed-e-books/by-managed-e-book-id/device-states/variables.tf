variable "managed_e_book_id" {
  description = "The unique identifier of managedEBook"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.managed_e_book_id)) > 0
    error_message = "managed_e_book_id must not be empty."
  }
}

variable "device_id" {
  description = "Device Id."
  type        = string
  default     = null
}

variable "device_name" {
  description = "Device name."
  type        = string
  default     = null
}

variable "error_code" {
  description = "The error code for install failures."
  type        = string
  default     = null
}

variable "install_state" {
  description = "Possible values for install state."
  type        = string
  default     = null

  validation {
    condition     = var.install_state == null ? true : contains(["notApplicable", "installed", "failed", "notInstalled", "uninstallFailed", "unknown"], var.install_state)
    error_message = "install_state must be one of the documented enum values."
  }
}

variable "last_sync_date_time" {
  description = "Last sync date and time."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceInstallState"
  nullable    = false
}

variable "os_description" {
  description = "OS Description."
  type        = string
  default     = null
}

variable "os_version" {
  description = "OS Version."
  type        = string
  default     = null
}

variable "user_name" {
  description = "Device User Name."
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
