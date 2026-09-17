variable "managed_e_book_id" {
  description = "The unique identifier of managedEBook"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.managed_e_book_id)) > 0
    error_message = "managed_e_book_id must not be empty."
  }
}

variable "device_states" {
  description = "The install state of the eBook."
  type = list(object({
    odata_type       = optional(string, "#microsoft.graph.deviceInstallState")
    deviceId         = optional(string)
    deviceName       = optional(string)
    errorCode        = optional(string)
    installState     = optional(string)
    lastSyncDateTime = optional(string)
    osDescription    = optional(string)
    osVersion        = optional(string)
    userName         = optional(string)
  }))
  default = null
}

variable "failed_device_count" {
  description = "Failed Device Count."
  type        = number
  default     = null
}

variable "installed_device_count" {
  description = "Installed Device Count."
  type        = number
  default     = null
}

variable "not_installed_device_count" {
  description = "Not installed device count."
  type        = number
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.userInstallStateSummary"
  nullable    = false
}

variable "user_name" {
  description = "User name."
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
