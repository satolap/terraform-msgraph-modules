variable "allow_unmanaged_settings" {
  description = "Allow unmanaged setting templates"
  type        = bool
  default     = null
}

variable "base_id" {
  description = "Template base identifier"
  type        = string
  default     = null
}

variable "description" {
  description = "Template description"
  type        = string
  default     = null
}

variable "disable_entra_group_policy_assignment" {
  description = "Indicates whether assignments to Entra security groups is disabled"
  type        = bool
  default     = null
}

variable "display_name" {
  description = "Template display name"
  type        = string
  default     = null
}

variable "display_version" {
  description = "Description of template version"
  type        = string
  default     = null
}

variable "lifecycle_state" {
  description = "Describes current lifecycle state of a template"
  type        = string
  default     = null

  validation {
    condition     = var.lifecycle_state == null ? true : contains(["invalid", "draft", "active", "superseded", "deprecated", "retired"], var.lifecycle_state)
    error_message = "lifecycle_state must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagementConfigurationPolicyTemplate"
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

variable "setting_templates" {
  description = "Setting templates"
  type = list(object({
    odata_type              = optional(string, "#microsoft.graph.deviceManagementConfigurationSettingTemplate")
    settingDefinitions      = optional(any)
    settingInstanceTemplate = optional(any)
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

variable "template_family" {
  description = "Describes the TemplateFamily for the Template entity"
  type        = string
  default     = null

  validation {
    condition     = var.template_family == null ? true : contains(["none", "endpointSecurityAntivirus", "endpointSecurityDiskEncryption", "endpointSecurityFirewall", "endpointSecurityEndpointDetectionAndResponse", "endpointSecurityAttackSurfaceReduction", "endpointSecurityAccountProtection", "endpointSecurityApplicationControl", "endpointSecurityEndpointPrivilegeManagement", "enrollmentConfiguration", "appQuietTime", "baseline", "unknownFutureValue", "deviceConfigurationScripts", "deviceConfigurationPolicies", "windowsOsRecoveryPolicies", "companyPortal", "windowsRecoveryAndRemediationConfiguration", "maintenanceWindows"], var.template_family)
    error_message = "template_family must be one of the documented enum values."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "settingTemplateCount", "version"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
