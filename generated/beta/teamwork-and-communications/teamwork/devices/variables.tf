variable "activity" {
  description = "The activity properties that change based on the device usage."
  type        = any
  default     = null
}

variable "activity_state" {
  description = "The activity state of the device. The possible values are: unknown, busy, idle, unavailable, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.activity_state == null ? true : contains(["unknown", "busy", "idle", "unavailable", "unknownFutureValue"], var.activity_state)
    error_message = "activity_state must be one of the documented enum values."
  }
}

variable "company_asset_tag" {
  description = "The company asset tag assigned by the admin on the device."
  type        = string
  default     = null
}

variable "configuration" {
  description = "The configuration properties of the device."
  type        = any
  default     = null
}

variable "created_by" {
  description = "Identity of the user who enrolled the device to the tenant."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The UTC date and time when the device was enrolled to the tenant."
  type        = string
  default     = null
}

variable "current_user" {
  description = "The signed-in user on the device."
  type        = any
  default     = null
}

variable "device_type" {
  description = "Microsoft Graph deviceType property."
  type        = string
  default     = null

  validation {
    condition     = var.device_type == null ? true : contains(["unknown", "ipPhone", "teamsRoom", "surfaceHub", "collaborationBar", "teamsDisplay", "touchConsole", "lowCostPhone", "teamsPanel", "sip", "unknownFutureValue"], var.device_type)
    error_message = "device_type must be one of the documented enum values."
  }
}

variable "hardware_detail" {
  description = "Microsoft Graph hardwareDetail property."
  type = object({
    odata_type   = optional(string, "#microsoft.graph.teamworkHardwareDetail")
    macAddresses = optional(list(string))
    manufacturer = optional(string)
    model        = optional(string)
    serialNumber = optional(string)
    uniqueId     = optional(string)
  })
  default = null
}

variable "health" {
  description = "The health properties of the device."
  type        = any
  default     = null
}

variable "health_status" {
  description = "The health status of the device. The possible values are: unknown, offline, critical, nonUrgent, healthy, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.health_status == null ? true : contains(["unknown", "offline", "critical", "nonUrgent", "healthy", "unknownFutureValue"], var.health_status)
    error_message = "health_status must be one of the documented enum values."
  }
}

variable "last_modified_by" {
  description = "Identity of the user who last modified the device details."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "The UTC date and time when the device detail was last modified."
  type        = string
  default     = null
}

variable "notes" {
  description = "The notes added by the admin to the device."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.teamworkDevice"
  nullable    = false
}

variable "operations" {
  description = "The async operations on the device."
  type = list(object({
    odata_type         = optional(string, "#microsoft.graph.teamworkDeviceOperation")
    completedDateTime  = optional(string)
    createdBy          = optional(any)
    createdDateTime    = optional(string)
    error              = optional(any)
    lastActionBy       = optional(any)
    lastActionDateTime = optional(string)
    operationType      = optional(string)
    startedDateTime    = optional(string)
    status             = optional(string)
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
