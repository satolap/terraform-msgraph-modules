variable "created_date_time" {
  description = "The date and time at which the GroupPolicyMigrationReport was created."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The name of Group Policy Object from the GPO Xml Content"
  type        = string
  default     = null
}

variable "group_policy_created_date_time" {
  description = "The date and time at which the GroupPolicyMigrationReport was created."
  type        = string
  default     = null
}

variable "group_policy_last_modified_date_time" {
  description = "The date and time at which the GroupPolicyMigrationReport was last modified."
  type        = string
  default     = null
}

variable "group_policy_object_id" {
  description = "The Group Policy Object GUID from GPO Xml content"
  type        = string
  default     = null
}

variable "group_policy_setting_mappings" {
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
}

variable "last_modified_date_time" {
  description = "The date and time at which the GroupPolicyMigrationReport was last modified."
  type        = string
  default     = null
}

variable "migration_readiness" {
  description = "Indicates if the Group Policy Object file is covered and ready for Intune migration."
  type        = string
  default     = null

  validation {
    condition     = var.migration_readiness == null ? true : contains(["none", "partial", "complete", "error", "notApplicable"], var.migration_readiness)
    error_message = "migration_readiness must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.groupPolicyMigrationReport"
  nullable    = false
}

variable "ou_distinguished_name" {
  description = "The distinguished name of the OU."
  type        = string
  default     = null
}

variable "role_scope_tag_ids" {
  description = "The list of scope tags for the configuration."
  type        = list(string)
  default     = null
}

variable "supported_settings_count" {
  description = "The number of Group Policy Settings supported by Intune."
  type        = number
  default     = null
}

variable "supported_settings_percent" {
  description = "The Percentage of Group Policy Settings supported by Intune."
  type        = number
  default     = null
}

variable "targeted_in_active_directory" {
  description = "The Targeted in AD property from GPO Xml Content"
  type        = bool
  default     = null
}

variable "total_settings_count" {
  description = "The total number of Group Policy Settings from GPO file."
  type        = number
  default     = null
}

variable "unsupported_group_policy_extensions" {
  description = "A list of unsupported group policy extensions inside the Group Policy Object."
  type = list(object({
    odata_type    = optional(string, "#microsoft.graph.unsupportedGroupPolicyExtension")
    extensionType = optional(string)
    namespaceUrl  = optional(string)
    nodeName      = optional(string)
    settingScope  = optional(string)
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
