variable "category_description" {
  description = "Description of the category header in policy summary."
  type        = string
  default     = null
}

variable "child_category_ids" {
  description = "List of child ids of the category."
  type        = list(string)
  default     = null
}

variable "description" {
  description = "Description of the category. For example: Display"
  type        = string
  default     = null
}

variable "display_name" {
  description = "Name of the category. For example: Device Lock"
  type        = string
  default     = null
}

variable "help_text" {
  description = "Help text of the category. Give more details of the category."
  type        = string
  default     = null
}

variable "name" {
  description = "Name of the item"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagementConfigurationCategory"
  nullable    = false
}

variable "parent_category_id" {
  description = "Direct parent id of the category. If the category is the root, the parent id is same as its id."
  type        = string
  default     = null
}

variable "platforms" {
  description = "Supported platform types."
  type        = string
  default     = null

  validation {
    condition     = var.platforms == null ? true : contains(["none", "android", "iOS", "macOS", "windows10X", "windows10", "linux", "unknownFutureValue", "androidEnterprise", "aosp", "visionOS", "tvOS"], var.platforms)
    error_message = "platforms must be one of the documented enum values."
  }
}

variable "root_category_id" {
  description = "Root id of the category."
  type        = string
  default     = null
}

variable "setting_usage" {
  description = "Supported setting types"
  type        = string
  default     = null

  validation {
    condition     = var.setting_usage == null ? true : contains(["none", "configuration", "compliance", "reusableSetting", "unknownFutureValue"], var.setting_usage)
    error_message = "setting_usage must be one of the documented enum values."
  }
}

variable "technologies" {
  description = "Describes which technology this setting can be deployed with"
  type        = string
  default     = null

  validation {
    condition     = var.technologies == null ? true : contains(["none", "mdm", "windows10XManagement", "configManager", "intuneManagementExtension", "thirdParty", "documentGateway", "appleRemoteManagement", "microsoftSense", "exchangeOnline", "mobileApplicationManagement", "linuxMdm", "enrollment", "endpointPrivilegeManagement", "unknownFutureValue", "windowsOsRecovery", "android", "intuneOpenExtensibility"], var.technologies)
    error_message = "technologies must be one of the documented enum values."
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
