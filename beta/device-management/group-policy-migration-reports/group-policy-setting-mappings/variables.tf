variable "group_policy_migration_report_id" {
  description = "The unique identifier of groupPolicyMigrationReport"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.group_policy_migration_report_id)) > 0
    error_message = "group_policy_migration_report_id must not be empty."
  }
}

variable "admx_setting_definition_id" {
  description = "Admx Group Policy Id"
  type        = string
  default     = null
}

variable "child_id_list" {
  description = "List of Child Ids of the group policy setting."
  type        = list(string)
  default     = null
}

variable "intune_setting_definition_id" {
  description = "The Intune Setting Definition Id"
  type        = string
  default     = null
}

variable "intune_setting_uri_list" {
  description = "The list of Intune Setting URIs this group policy setting maps to"
  type        = list(string)
  default     = null
}

variable "is_mdm_supported" {
  description = "Indicates if the setting is supported by Intune or not"
  type        = bool
  default     = null
}

variable "mdm_csp_name" {
  description = "The CSP name this group policy setting maps to."
  type        = string
  default     = null
}

variable "mdm_minimum_os_version" {
  description = "The minimum OS version this mdm setting supports."
  type        = number
  default     = null
}

variable "mdm_setting_uri" {
  description = "The MDM CSP URI this group policy setting maps to."
  type        = string
  default     = null
}

variable "mdm_supported_state" {
  description = "Mdm Support Status of the setting."
  type        = string
  default     = null

  validation {
    condition     = var.mdm_supported_state == null ? true : contains(["unknown", "supported", "unsupported", "deprecated"], var.mdm_supported_state)
    error_message = "mdm_supported_state must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.groupPolicySettingMapping"
  nullable    = false
}

variable "parent_id" {
  description = "Parent Id of the group policy setting."
  type        = string
  default     = null
}

variable "setting_category" {
  description = "The category the group policy setting is in."
  type        = string
  default     = null
}

variable "setting_display_name" {
  description = "The display name of this group policy setting."
  type        = string
  default     = null
}

variable "setting_display_value" {
  description = "The display value of this group policy setting."
  type        = string
  default     = null
}

variable "setting_display_value_type" {
  description = "The display value type of this group policy setting."
  type        = string
  default     = null
}

variable "setting_name" {
  description = "The name of this group policy setting."
  type        = string
  default     = null
}

variable "setting_scope" {
  description = "Scope of the group policy setting."
  type        = string
  default     = null

  validation {
    condition     = var.setting_scope == null ? true : contains(["unknown", "device", "user"], var.setting_scope)
    error_message = "setting_scope must be one of the documented enum values."
  }
}

variable "setting_type" {
  description = "Setting type of the group policy."
  type        = string
  default     = null

  validation {
    condition     = var.setting_type == null ? true : contains(["unknown", "policy", "account", "securityOptions", "userRightsAssignment", "auditSetting", "windowsFirewallSettings", "appLockerRuleCollection", "dataSourcesSettings", "devicesSettings", "driveMapSettings", "environmentVariables", "filesSettings", "folderOptions", "folders", "iniFiles", "internetOptions", "localUsersAndGroups", "networkOptions", "networkShares", "ntServices", "powerOptions", "printers", "regionalOptionsSettings", "registrySettings", "scheduledTasks", "shortcutSettings", "startMenuSettings"], var.setting_type)
    error_message = "setting_type must be one of the documented enum values."
  }
}

variable "setting_value" {
  description = "The value of this group policy setting."
  type        = string
  default     = null
}

variable "setting_value_display_units" {
  description = "The display units of this group policy setting value"
  type        = string
  default     = null
}

variable "setting_value_type" {
  description = "The value type of this group policy setting."
  type        = string
  default     = null
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
