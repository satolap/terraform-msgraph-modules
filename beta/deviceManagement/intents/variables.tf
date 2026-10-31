variable "assignments" {
  description = "Collection of assignments"
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.deviceManagementIntentAssignment")
    target     = optional(any)
  }))
  default = null
}

variable "categories" {
  description = "Collection of setting categories within the intent"
  type = list(object({
    odata_type         = optional(string, "#microsoft.graph.deviceManagementIntentSettingCategory")
    displayName        = optional(string)
    hasRequiredSetting = optional(bool)
    settingDefinitions = optional(any)
    settings           = optional(any)
  }))
  default = null
}

variable "description" {
  description = "The user given description"
  type        = string
  default     = null
}

variable "deviceSettingStateSummaries" {
  description = "Collection of settings and their states and counts of devices that belong to corresponding state for all settings within the intent"
  type = list(object({
    odata_type         = optional(string, "#microsoft.graph.deviceManagementIntentDeviceSettingStateSummary")
    compliantCount     = optional(number)
    conflictCount      = optional(number)
    errorCount         = optional(number)
    nonCompliantCount  = optional(number)
    notApplicableCount = optional(number)
    remediatedCount    = optional(number)
    settingName        = optional(string)
  }))
  default = null
}

variable "deviceStateSummary" {
  description = "A summary of device states and counts of devices that belong to corresponding state for all devices that the intent is applied to"
  type        = any
  default     = null
}

variable "deviceStates" {
  description = "Collection of states of all devices that the intent is applied to"
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.deviceManagementIntentDeviceState")
    deviceDisplayName    = optional(string)
    deviceId             = optional(string)
    lastReportedDateTime = optional(string)
    state                = optional(string)
    userName             = optional(string)
    userPrincipalName    = optional(string)
  }))
  default = null

  validation {
    condition     = (var.deviceStates == null ? true : alltrue([alltrue([for input0 in var.deviceStates : (input0 == null ? true : alltrue([(input0["state"] == null ? true : alltrue([(input0["state"] == null ? true : contains(["unknown", "notApplicable", "compliant", "remediated", "nonCompliant", "error", "conflict", "notAssigned"], input0["state"]))]))]))])]))
    error_message = "deviceStates: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "displayName" {
  description = "The user given display name"
  type        = string
  default     = null
}

variable "isAssigned" {
  description = "Signifies whether or not the intent is assigned to users"
  type        = bool
  default     = null
}

variable "isMigratingToConfigurationPolicy" {
  description = "Signifies whether or not the intent is being migrated to the configurationPolicies endpoint"
  type        = bool
  default     = null
}

variable "lastModifiedDateTime" {
  description = "When the intent was last modified"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagementIntent"
  nullable    = false
}

variable "roleScopeTagIds" {
  description = "List of Scope Tags for this Entity instance."
  type        = list(string)
  default     = null
}

variable "settings" {
  description = "Collection of all settings to be applied"
  type        = any
  default     = null
}

variable "templateId" {
  description = "The ID of the template this intent was created from (if any)"
  type        = string
  default     = null
}

variable "userStateSummary" {
  description = "A summary of user states and counts of users that belong to corresponding state for all users that the intent is applied to"
  type        = any
  default     = null
}

variable "userStates" {
  description = "Collection of states of all users that the intent is applied to"
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.deviceManagementIntentUserState")
    deviceCount          = optional(number)
    lastReportedDateTime = optional(string)
    state                = optional(string)
    userName             = optional(string)
    userPrincipalName    = optional(string)
  }))
  default = null

  validation {
    condition     = (var.userStates == null ? true : alltrue([alltrue([for input0 in var.userStates : (input0 == null ? true : alltrue([(input0["state"] == null ? true : alltrue([(input0["state"] == null ? true : contains(["unknown", "notApplicable", "compliant", "remediated", "nonCompliant", "error", "conflict", "notAssigned"], input0["state"]))]))]))])]))
    error_message = "userStates: nested required attributes must be non-null and enum values must be supported input members."
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
