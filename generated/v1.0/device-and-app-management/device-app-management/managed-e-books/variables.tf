variable "assignments" {
  description = "The list of assignments for this eBook."
  type = list(object({
    odata_type    = optional(string, "#microsoft.graph.managedEBookAssignment")
    installIntent = optional(string)
    target        = optional(any)
  }))
  default = null
}

variable "created_date_time" {
  description = "The date and time when the eBook file was created."
  type        = string
  default     = null
}

variable "description" {
  description = "Description."
  type        = string
  default     = null
}

variable "device_states" {
  description = "The list of installation states for this eBook."
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

variable "display_name" {
  description = "Name of the eBook."
  type        = string
  default     = null
}

variable "information_url" {
  description = "The more information Url."
  type        = string
  default     = null
}

variable "install_summary" {
  description = "Mobile App Install Summary."
  type        = any
  default     = null
}

variable "large_cover" {
  description = "Book cover."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time when the eBook was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedEBook"
  nullable    = false
}

variable "privacy_information_url" {
  description = "The privacy statement Url."
  type        = string
  default     = null
}

variable "published_date_time" {
  description = "The date and time when the eBook was published."
  type        = string
  default     = null
}

variable "publisher" {
  description = "Publisher."
  type        = string
  default     = null
}

variable "user_state_summary" {
  description = "The list of installation states for this eBook."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.userInstallStateSummary")
    deviceStates = optional(list(object({
      odata_type       = optional(string, "#microsoft.graph.deviceInstallState")
      deviceId         = optional(string)
      deviceName       = optional(string)
      errorCode        = optional(string)
      installState     = optional(string)
      lastSyncDateTime = optional(string)
      osDescription    = optional(string)
      osVersion        = optional(string)
      userName         = optional(string)
    })))
    failedDeviceCount       = optional(number)
    installedDeviceCount    = optional(number)
    notInstalledDeviceCount = optional(number)
    userName                = optional(string)
  }))
  default = null
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
