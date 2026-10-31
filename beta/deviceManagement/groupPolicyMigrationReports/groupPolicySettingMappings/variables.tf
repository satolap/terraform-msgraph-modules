variable "groupPolicyMigrationReport-id" {
  description = "The unique identifier of groupPolicyMigrationReport"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.groupPolicyMigrationReport-id)) > 0
    error_message = "groupPolicyMigrationReport-id must not be empty."
  }
}

variable "admxSettingDefinitionId" {
  description = "Admx Group Policy Id"
  type        = string
  default     = null
}

variable "childIdList" {
  description = "List of Child Ids of the group policy setting."
  type        = list(string)
  default     = null
}

variable "intuneSettingDefinitionId" {
  description = "The Intune Setting Definition Id"
  type        = string
  default     = null
}

variable "intuneSettingUriList" {
  description = "The list of Intune Setting URIs this group policy setting maps to"
  type        = list(string)
  default     = null
}

variable "isMdmSupported" {
  description = "Indicates if the setting is supported by Intune or not"
  type        = bool
  default     = null
}

variable "mdmCspName" {
  description = "The CSP name this group policy setting maps to."
  type        = string
  default     = null
}

variable "mdmMinimumOSVersion" {
  description = "The minimum OS version this mdm setting supports."
  type        = number
  default     = null
}

variable "mdmSettingUri" {
  description = "The MDM CSP URI this group policy setting maps to."
  type        = string
  default     = null
}

variable "mdmSupportedState" {
  description = "Mdm Support Status of the setting."
  type        = string
  default     = null

  validation {
    condition     = var.mdmSupportedState == null ? true : contains(["unknown", "supported", "unsupported", "deprecated"], var.mdmSupportedState)
    error_message = "mdmSupportedState must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.groupPolicySettingMapping"
  nullable    = false
}

variable "parentId" {
  description = "Parent Id of the group policy setting."
  type        = string
  default     = null
}

variable "settingCategory" {
  description = "The category the group policy setting is in."
  type        = string
  default     = null
}

variable "settingDisplayName" {
  description = "The display name of this group policy setting."
  type        = string
  default     = null
}

variable "settingDisplayValue" {
  description = "The display value of this group policy setting."
  type        = string
  default     = null
}

variable "settingDisplayValueType" {
  description = "The display value type of this group policy setting."
  type        = string
  default     = null
}

variable "settingName" {
  description = "The name of this group policy setting."
  type        = string
  default     = null
}

variable "settingScope" {
  description = "Scope of the group policy setting."
  type        = string
  default     = null

  validation {
    condition     = var.settingScope == null ? true : contains(["unknown", "device", "user"], var.settingScope)
    error_message = "settingScope must be one of the documented enum values."
  }
}

variable "settingType" {
  description = "Setting type of the group policy."
  type        = string
  default     = null

  validation {
    condition     = var.settingType == null ? true : contains(["unknown", "policy", "account", "securityOptions", "userRightsAssignment", "auditSetting", "windowsFirewallSettings", "appLockerRuleCollection", "dataSourcesSettings", "devicesSettings", "driveMapSettings", "environmentVariables", "filesSettings", "folderOptions", "folders", "iniFiles", "internetOptions", "localUsersAndGroups", "networkOptions", "networkShares", "ntServices", "powerOptions", "printers", "regionalOptionsSettings", "registrySettings", "scheduledTasks", "shortcutSettings", "startMenuSettings"], var.settingType)
    error_message = "settingType must be one of the documented enum values."
  }
}

variable "settingValue" {
  description = "The value of this group policy setting."
  type        = string
  default     = null
}

variable "settingValueDisplayUnits" {
  description = "The display units of this group policy setting value"
  type        = string
  default     = null
}

variable "settingValueType" {
  description = "The value type of this group policy setting."
  type        = string
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
