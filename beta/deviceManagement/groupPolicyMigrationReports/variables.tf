variable "createdDateTime" {
  description = "The date and time at which the GroupPolicyMigrationReport was created."
  type        = string
  default     = null
}

variable "displayName" {
  description = "The name of Group Policy Object from the GPO Xml Content"
  type        = string
  default     = null
}

variable "groupPolicyCreatedDateTime" {
  description = "The date and time at which the GroupPolicyMigrationReport was created."
  type        = string
  default     = null
}

variable "groupPolicyLastModifiedDateTime" {
  description = "The date and time at which the GroupPolicyMigrationReport was last modified."
  type        = string
  default     = null
}

variable "groupPolicyObjectId" {
  description = "The Group Policy Object GUID from GPO Xml content"
  type        = string
  default     = null
}

variable "groupPolicySettingMappings" {
  description = "A list of group policy settings to MDM/Intune mappings."
  type = list(object({
    odata_type                = optional(string, "#microsoft.graph.groupPolicySettingMapping")
    admxSettingDefinitionId   = optional(string)
    childIdList               = optional(list(string))
    intuneSettingDefinitionId = optional(string)
    intuneSettingUriList      = optional(list(string))
    isMdmSupported            = optional(bool)
    mdmCspName                = optional(string)
    mdmMinimumOSVersion       = optional(number)
    mdmSettingUri             = optional(string)
    mdmSupportedState         = optional(string)
    parentId                  = optional(string)
    settingCategory           = optional(string)
    settingDisplayName        = optional(string)
    settingDisplayValue       = optional(string)
    settingDisplayValueType   = optional(string)
    settingName               = optional(string)
    settingScope              = optional(string)
    settingType               = optional(string)
    settingValue              = optional(string)
    settingValueDisplayUnits  = optional(string)
    settingValueType          = optional(string)
  }))
  default = null

  validation {
    condition     = (var.groupPolicySettingMappings == null ? true : alltrue([alltrue([for input0 in var.groupPolicySettingMappings : (input0 == null ? true : alltrue([(input0["mdmSupportedState"] == null ? true : alltrue([(input0["mdmSupportedState"] == null ? true : contains(["unknown", "supported", "unsupported", "deprecated"], input0["mdmSupportedState"]))])), (input0["settingScope"] == null ? true : alltrue([(input0["settingScope"] == null ? true : contains(["unknown", "device", "user"], input0["settingScope"]))])), (input0["settingType"] == null ? true : alltrue([(input0["settingType"] == null ? true : contains(["unknown", "policy", "account", "securityOptions", "userRightsAssignment", "auditSetting", "windowsFirewallSettings", "appLockerRuleCollection", "dataSourcesSettings", "devicesSettings", "driveMapSettings", "environmentVariables", "filesSettings", "folderOptions", "folders", "iniFiles", "internetOptions", "localUsersAndGroups", "networkOptions", "networkShares", "ntServices", "powerOptions", "printers", "regionalOptionsSettings", "registrySettings", "scheduledTasks", "shortcutSettings", "startMenuSettings"], input0["settingType"]))]))]))])]))
    error_message = "groupPolicySettingMappings: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "lastModifiedDateTime" {
  description = "The date and time at which the GroupPolicyMigrationReport was last modified."
  type        = string
  default     = null
}

variable "migrationReadiness" {
  description = "Indicates if the Group Policy Object file is covered and ready for Intune migration."
  type        = string
  default     = null

  validation {
    condition     = var.migrationReadiness == null ? true : contains(["none", "partial", "complete", "error", "notApplicable"], var.migrationReadiness)
    error_message = "migrationReadiness must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.groupPolicyMigrationReport"
  nullable    = false
}

variable "ouDistinguishedName" {
  description = "The distinguished name of the OU."
  type        = string
  default     = null
}

variable "roleScopeTagIds" {
  description = "The list of scope tags for the configuration."
  type        = list(string)
  default     = null
}

variable "supportedSettingsCount" {
  description = "The number of Group Policy Settings supported by Intune."
  type        = number
  default     = null
}

variable "supportedSettingsPercent" {
  description = "The Percentage of Group Policy Settings supported by Intune."
  type        = number
  default     = null
}

variable "targetedInActiveDirectory" {
  description = "The Targeted in AD property from GPO Xml Content"
  type        = bool
  default     = null
}

variable "totalSettingsCount" {
  description = "The total number of Group Policy Settings from GPO file."
  type        = number
  default     = null
}

variable "unsupportedGroupPolicyExtensions" {
  description = "A list of unsupported group policy extensions inside the Group Policy Object."
  type = list(object({
    odata_type    = optional(string, "#microsoft.graph.unsupportedGroupPolicyExtension")
    extensionType = optional(string)
    namespaceUrl  = optional(string)
    nodeName      = optional(string)
    settingScope  = optional(string)
  }))
  default = null

  validation {
    condition     = (var.unsupportedGroupPolicyExtensions == null ? true : alltrue([alltrue([for input0 in var.unsupportedGroupPolicyExtensions : (input0 == null ? true : alltrue([(input0["settingScope"] == null ? true : alltrue([(input0["settingScope"] == null ? true : contains(["unknown", "device", "user"], input0["settingScope"]))]))]))])]))
    error_message = "unsupportedGroupPolicyExtensions: nested required attributes must be non-null and enum values must be supported input members."
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
