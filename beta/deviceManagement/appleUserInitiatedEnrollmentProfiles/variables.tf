variable "assignments" {
  description = "The list of assignments for this profile."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.appleEnrollmentProfileAssignment")
    target     = optional(any)
  }))
  default = null
}

variable "availableEnrollmentTypeOptions" {
  description = "List of available enrollment type options"
  type = list(object({
    odata_type     = optional(string, "#microsoft.graph.appleOwnerTypeEnrollmentType")
    enrollmentType = optional(string)
    ownerType      = optional(string)
  }))
  default = null

  validation {
    condition     = (var.availableEnrollmentTypeOptions == null ? true : alltrue([alltrue([for input0 in var.availableEnrollmentTypeOptions : (input0 == null ? true : alltrue([(input0["enrollmentType"] == null ? true : alltrue([(input0["enrollmentType"] == null ? true : contains(["unknown", "device", "user", "accountDrivenUserEnrollment", "webDeviceEnrollment"], input0["enrollmentType"]))])), (input0["ownerType"] == null ? true : alltrue([(input0["ownerType"] == null ? true : contains(["unknown", "company", "personal"], input0["ownerType"]))]))]))])]))
    error_message = "availableEnrollmentTypeOptions: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "createdDateTime" {
  description = "Profile creation time"
  type        = string
  default     = null
}

variable "defaultEnrollmentType" {
  description = "The default profile enrollment type."
  type        = string
  default     = null

  validation {
    condition     = var.defaultEnrollmentType == null ? true : contains(["unknown", "device", "user", "accountDrivenUserEnrollment", "webDeviceEnrollment"], var.defaultEnrollmentType)
    error_message = "defaultEnrollmentType must be one of the documented enum values."
  }
}

variable "description" {
  description = "Description of the profile"
  type        = string
  default     = null
}

variable "displayName" {
  description = "Name of the profile"
  type        = string
  default     = null
}

variable "lastModifiedDateTime" {
  description = "Profile last modified time"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.appleUserInitiatedEnrollmentProfile"
  nullable    = false
}

variable "platform" {
  description = "Supported platform types."
  type        = string
  default     = null

  validation {
    condition     = var.platform == null ? true : contains(["android", "androidForWork", "iOS", "macOS", "windowsPhone81", "windows81AndLater", "windows10AndLater", "androidWorkProfile", "unknown", "androidAOSP", "androidMobileApplicationManagement", "iOSMobileApplicationManagement"], var.platform)
    error_message = "platform must be one of the documented enum values."
  }
}

variable "priority" {
  description = "Priority, 0 is highest"
  type        = number
  default     = null
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
