variable "assignments" {
  description = "Policy assignments"
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.deviceManagementConfigurationPolicyAssignment")
    source     = optional(string)
    sourceId   = optional(string)
    target     = optional(any)
  }))
  default = null
}

variable "creation_source" {
  description = "Policy creation source"
  type        = string
  default     = null
}

variable "description" {
  description = "Policy description"
  type        = string
  default     = null
}

variable "name" {
  description = "Policy name"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagementCompliancePolicy"
  nullable    = false
}

variable "platforms" {
  description = "Supported platform types."
  type        = string
  default     = null

  validation {
    condition     = var.platforms == null ? true : try(alltrue([for value in split(",", var.platforms) : contains(["none", "android", "ios", "macos", "windows10x", "windows10", "linux", "unknownfuturevalue", "androidenterprise", "aosp", "visionos", "tvos"], lower(trimspace(value)))]), false)
    error_message = "platforms must be one or more of the documented enum values, separated by commas."
  }
}

variable "role_scope_tag_ids" {
  description = "List of Scope Tags for this Entity instance."
  type        = list(string)
  default     = null
}

variable "scheduled_actions_for_rule" {
  description = "The list of scheduled action for this rule"
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.deviceManagementComplianceScheduledActionForRule")
    ruleName   = optional(string)
    scheduledActionConfigurations = optional(list(object({
      odata_type                = optional(string, "#microsoft.graph.deviceManagementComplianceActionItem")
      actionType                = optional(string)
      gracePeriodHours          = optional(number)
      notificationMessageCCList = optional(list(string))
      notificationTemplateId    = optional(string)
    })))
  }))
  default = null
}

variable "settings" {
  description = "Policy settings"
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.deviceManagementConfigurationSetting")
    settingInstance = optional(any)
  }))
  default = null
}

variable "technologies" {
  description = "Describes which technology this setting can be deployed with"
  type        = string
  default     = null

  validation {
    condition     = var.technologies == null ? true : try(alltrue([for value in split(",", var.technologies) : contains(["none", "mdm", "windows10xmanagement", "configmanager", "intunemanagementextension", "thirdparty", "documentgateway", "appleremotemanagement", "microsoftsense", "exchangeonline", "mobileapplicationmanagement", "linuxmdm", "enrollment", "endpointprivilegemanagement", "unknownfuturevalue", "windowsosrecovery", "android", "intuneopenextensibility"], lower(trimspace(value)))]), false)
    error_message = "technologies must be one or more of the documented enum values, separated by commas."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "isAssigned", "lastModifiedDateTime", "settingCount"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
