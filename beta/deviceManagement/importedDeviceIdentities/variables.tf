variable "createdDateTime" {
  description = "Created Date Time of the device"
  type        = string
  default     = null
}

variable "description" {
  description = "The description of the device"
  type        = string
  default     = null
}

variable "enrollmentState" {
  description = "The state of the device in Intune"
  type        = string
  default     = null

  validation {
    condition     = var.enrollmentState == null ? true : contains(["unknown", "enrolled", "pendingReset", "failed", "notContacted", "blocked"], var.enrollmentState)
    error_message = "enrollmentState must be one of the documented enum values."
  }
}

variable "importedDeviceIdentifier" {
  description = "Imported Device Identifier"
  type        = string
  default     = null
}

variable "importedDeviceIdentityType" {
  description = "Type of Imported Device Identity"
  type        = string
  default     = null

  validation {
    condition     = var.importedDeviceIdentityType == null ? true : contains(["unknown", "imei", "serialNumber", "manufacturerModelSerial"], var.importedDeviceIdentityType)
    error_message = "importedDeviceIdentityType must be one of the documented enum values."
  }
}

variable "lastContactedDateTime" {
  description = "Last Contacted Date Time of the device"
  type        = string
  default     = null
}

variable "lastModifiedDateTime" {
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
    condition     = var.platform == null ? true : contains(["unknown", "ios", "android", "windows", "windowsMobile", "macOS", "visionOS", "tvOS"], var.platform)
    error_message = "platform must be one of the documented enum values."
  }
}

variable "timeouts" {
  description = "Optional timeouts of the msgraph_resource, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". create, update and delete must be at least \"15s\": after each request the provider waits for consistent reads within the same timeout. Every value defaults to null, which keeps the provider defaults and sends no timeouts block. The reviewed replication retries of this module, where it has any, count against these timeouts."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.read, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : (can(regex("^([0-9]+[hms])+$", t)) ? !can(regex("^(0+[hms])+$", t)) : false)
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : try(sum([for m in regexall("([0-9]+)([hms])", t) : tonumber(m[0]) * lookup({ h = 3600, m = 60, s = 1 }, m[1])]) >= 15, true)
    ])
    error_message = "timeouts.create, timeouts.update and timeouts.delete must be at least \"15s\"."
  }
}

variable "select_response" {
  description = "Opt in to a configured-property GET selection; this narrows response and can remove fields consumers use."
  type        = bool
  default     = false
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
