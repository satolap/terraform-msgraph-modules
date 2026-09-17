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
    settingDefinitions = optional(list(object({
      odata_type       = optional(string, "#microsoft.graph.deviceManagementSettingDefinition")
      constraints      = optional(any)
      dependencies     = optional(any)
      description      = optional(string)
      displayName      = optional(string)
      documentationUrl = optional(string)
      headerSubtitle   = optional(string)
      headerTitle      = optional(string)
      isTopLevel       = optional(bool)
      keywords         = optional(list(string))
      placeholderText  = optional(string)
      valueType        = optional(string)
    })))
    settings = optional(list(object({
      odata_type   = optional(string, "#microsoft.graph.deviceManagementSettingInstance")
      definitionId = optional(string)
      valueJson    = optional(string)
    })))
  }))
  default = null
}

variable "description" {
  description = "The user given description"
  type        = string
  default     = null
}

variable "device_setting_state_summaries" {
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

variable "device_state_summary" {
  description = "A summary of device states and counts of devices that belong to corresponding state for all devices that the intent is applied to"
  type        = any
  default     = null
}

variable "device_states" {
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
}

variable "display_name" {
  description = "The user given display name"
  type        = string
  default     = null
}

variable "is_assigned" {
  description = "Signifies whether or not the intent is assigned to users"
  type        = bool
  default     = null
}

variable "is_migrating_to_configuration_policy" {
  description = "Signifies whether or not the intent is being migrated to the configurationPolicies endpoint"
  type        = bool
  default     = null
}

variable "last_modified_date_time" {
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

variable "role_scope_tag_ids" {
  description = "List of Scope Tags for this Entity instance."
  type        = list(string)
  default     = null
}

variable "settings" {
  description = "Collection of all settings to be applied"
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.deviceManagementSettingInstance")
    definitionId = optional(string)
    valueJson    = optional(string)
  }))
  default = null
}

variable "template_id" {
  description = "The ID of the template this intent was created from (if any)"
  type        = string
  default     = null
}

variable "user_state_summary" {
  description = "A summary of user states and counts of users that belong to corresponding state for all users that the intent is applied to"
  type        = any
  default     = null
}

variable "user_states" {
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
