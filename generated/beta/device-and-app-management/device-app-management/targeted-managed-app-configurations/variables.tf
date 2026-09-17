variable "app_group_type" {
  description = "Indicates a collection of apps to target which can be one of several pre-defined lists of apps or a manually selected list of apps"
  type        = string
  default     = null

  validation {
    condition     = var.app_group_type == null ? true : contains(["selectedPublicApps", "allCoreMicrosoftApps", "allMicrosoftApps", "allApps"], var.app_group_type)
    error_message = "app_group_type must be one of the documented enum values."
  }
}

variable "apps" {
  description = "List of apps to which the policy is deployed."
  type = list(object({
    odata_type          = optional(string, "#microsoft.graph.managedMobileApp")
    mobileAppIdentifier = optional(any)
    version             = optional(string)
  }))
  default = null
}

variable "assignments" {
  description = "Navigation property to list of inclusion and exclusion groups to which the policy is deployed."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.targetedManagedAppPolicyAssignment")
    source     = optional(string)
    sourceId   = optional(string)
    target     = optional(any)
  }))
  default = null
}

variable "created_date_time" {
  description = "The date and time the policy was created."
  type        = string
  default     = null
}

variable "custom_settings" {
  description = "A set of string key and string value pairs to be sent to apps for users to whom the configuration is scoped, unalterned by this service"
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.keyValuePair")
    name       = optional(string)
    value      = optional(string)
  }))
  default = null
}

variable "deployed_app_count" {
  description = "Count of apps to which the current policy is deployed."
  type        = number
  default     = null
}

variable "deployment_summary" {
  description = "Navigation property to deployment summary of the configuration."
  type        = any
  default     = null
}

variable "description" {
  description = "The policy's description."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Policy display name."
  type        = string
  default     = null
}

variable "graph_version" {
  description = "Version of the entity."
  type        = string
  default     = null
}

variable "is_assigned" {
  description = "Indicates if the policy is deployed to any inclusion groups or not."
  type        = bool
  default     = null
}

variable "last_modified_date_time" {
  description = "Last time the policy was modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.targetedManagedAppConfiguration"
  nullable    = false
}

variable "role_scope_tag_ids" {
  description = "List of Scope Tags for this Entity instance."
  type        = list(string)
  default     = null
}

variable "settings" {
  description = "List of settings contained in this App Configuration policy"
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.deviceManagementConfigurationSetting")
    settingInstance = optional(object({
      odata_type                       = optional(string, "#microsoft.graph.deviceManagementConfigurationSettingInstance")
      settingDefinitionId              = optional(string)
      settingInstanceTemplateReference = optional(any)
    }))
  }))
  default = null
}

variable "targeted_app_management_levels" {
  description = "Management levels for apps"
  type        = string
  default     = null

  validation {
    condition     = var.targeted_app_management_levels == null ? true : contains(["unspecified", "unmanaged", "mdm", "androidEnterprise", "androidEnterpriseDedicatedDevicesWithAzureAdSharedMode", "androidOpenSourceProjectUserAssociated", "androidOpenSourceProjectUserless", "unknownFutureValue"], var.targeted_app_management_levels)
    error_message = "targeted_app_management_levels must be one of the documented enum values."
  }
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
