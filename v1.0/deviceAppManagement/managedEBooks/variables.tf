variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  nullable    = false

  validation {
    condition     = var.odata_type == null ? true : contains(["#microsoft.graph.iosVppEBook"], var.odata_type)
    error_message = "odata_type must name a concrete Graph type."
  }
}

variable "assignments" {
  description = "The list of assignments for this eBook."
  type = list(object({
    odata_type    = optional(string, "#microsoft.graph.managedEBookAssignment")
    installIntent = optional(string)
    target        = optional(any)
  }))
  default = null

  validation {
    condition     = (var.assignments == null ? true : alltrue([alltrue([for input0 in var.assignments : (input0 == null ? true : alltrue([(input0["installIntent"] == null ? true : alltrue([(input0["installIntent"] == null ? true : contains(["available", "required", "uninstall", "availableWithoutEnrollment"], input0["installIntent"]))]))]))])]))
    error_message = "assignments: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "createdDateTime" {
  description = "The date and time when the eBook file was created."
  type        = string
  default     = null
}

variable "description" {
  description = "Description."
  type        = string
  default     = null
}

variable "deviceStates" {
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

  validation {
    condition     = (var.deviceStates == null ? true : alltrue([alltrue([for input0 in var.deviceStates : (input0 == null ? true : alltrue([(input0["installState"] == null ? true : alltrue([(input0["installState"] == null ? true : contains(["notApplicable", "installed", "failed", "notInstalled", "uninstallFailed", "unknown"], input0["installState"]))]))]))])]))
    error_message = "deviceStates: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "displayName" {
  description = "Name of the eBook."
  type        = string
  default     = null
}

variable "informationUrl" {
  description = "The more information Url."
  type        = string
  default     = null
}

variable "installSummary" {
  description = "Mobile App Install Summary."
  type        = any
  default     = null
}

variable "largeCover" {
  description = "Book cover."
  type = object({
    odata_type = optional(string, "#microsoft.graph.mimeContent")
    type       = optional(string)
    value      = optional(string)
  })
  default = null
}

variable "lastModifiedDateTime" {
  description = "The date and time when the eBook was last modified."
  type        = string
  default     = null
}

variable "privacyInformationUrl" {
  description = "The privacy statement Url."
  type        = string
  default     = null
}

variable "publishedDateTime" {
  description = "The date and time when the eBook was published."
  type        = string
  default     = null
}

variable "publisher" {
  description = "Publisher."
  type        = string
  default     = null
}

variable "userStateSummary" {
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

  validation {
    condition     = (var.userStateSummary == null ? true : alltrue([alltrue([for input0 in var.userStateSummary : (input0 == null ? true : alltrue([(input0["deviceStates"] == null ? true : alltrue([alltrue([for input2 in input0["deviceStates"] : (input2 == null ? true : alltrue([(input2["installState"] == null ? true : alltrue([(input2["installState"] == null ? true : contains(["notApplicable", "installed", "failed", "notInstalled", "uninstallFailed", "unknown"], input2["installState"]))]))]))])]))]))])]))
    error_message = "userStateSummary: nested required attributes must be non-null and enum values must be supported input members."
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
