variable "allowed_inbound_data_transfer_source_apps" {
  description = "Windows MAM data transfer locations"
  type        = string
  default     = null

  validation {
    condition     = var.allowed_inbound_data_transfer_source_apps == null ? true : contains(["none", "oneDriveForBusiness", "unknownFutureValue"], var.allowed_inbound_data_transfer_source_apps)
    error_message = "allowed_inbound_data_transfer_source_apps must be one of the documented enum values."
  }
}

variable "allowed_inbound_data_transfer_sources" {
  description = "Data can be transferred from/to these classes of apps"
  type        = string
  default     = null

  validation {
    condition     = var.allowed_inbound_data_transfer_sources == null ? true : contains(["allApps", "none", "selectedApps", "unknownFutureValue"], var.allowed_inbound_data_transfer_sources)
    error_message = "allowed_inbound_data_transfer_sources must be one of the documented enum values."
  }
}

variable "allowed_outbound_clipboard_sharing_level" {
  description = "Represents the level to which the device's clipboard may be shared between apps"
  type        = string
  default     = null

  validation {
    condition     = var.allowed_outbound_clipboard_sharing_level == null ? true : contains(["anyDestinationAnySource", "none", "unknownFutureValue"], var.allowed_outbound_clipboard_sharing_level)
    error_message = "allowed_outbound_clipboard_sharing_level must be one of the documented enum values."
  }
}

variable "allowed_outbound_data_transfer_destination_apps" {
  description = "Windows MAM data transfer locations"
  type        = string
  default     = null

  validation {
    condition     = var.allowed_outbound_data_transfer_destination_apps == null ? true : contains(["none", "oneDriveForBusiness", "unknownFutureValue"], var.allowed_outbound_data_transfer_destination_apps)
    error_message = "allowed_outbound_data_transfer_destination_apps must be one of the documented enum values."
  }
}

variable "allowed_outbound_data_transfer_destinations" {
  description = "Data can be transferred from/to these classes of apps"
  type        = string
  default     = null

  validation {
    condition     = var.allowed_outbound_data_transfer_destinations == null ? true : contains(["allApps", "none", "selectedApps", "unknownFutureValue"], var.allowed_outbound_data_transfer_destinations)
    error_message = "allowed_outbound_data_transfer_destinations must be one of the documented enum values."
  }
}

variable "app_action_if_unable_to_authenticate_user" {
  description = "If set, it will specify what action to take in the case where the user is unable to checkin because their authentication token is invalid. This happens when the user is deleted or disabled in AAD. Some possible values are block or wipe. If this property is not set, no action will be taken. Possible values are: block, wipe, warn, blockWhenSettingIsSupported."
  type        = any
  default     = null

  validation {
    condition     = var.app_action_if_unable_to_authenticate_user == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.app_action_if_unable_to_authenticate_user)
    error_message = "app_action_if_unable_to_authenticate_user must be one of the documented enum values."
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

variable "deployed_app_count" {
  description = "Indicates the total number of applications for which the current policy is deployed."
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
  description = "When TRUE, indicates that the policy is deployed to some inclusion groups. When FALSE, indicates that the policy is not deployed to any inclusion groups. Default value is FALSE."
  type        = bool
  default     = null
}

variable "last_modified_date_time" {
  description = "Last time the policy was modified."
  type        = string
  default     = null
}

variable "maximum_allowed_device_threat_level" {
  description = "The maxium threat level allowed for an app to be compliant."
  type        = string
  default     = null

  validation {
    condition     = var.maximum_allowed_device_threat_level == null ? true : contains(["notConfigured", "secured", "low", "medium", "high"], var.maximum_allowed_device_threat_level)
    error_message = "maximum_allowed_device_threat_level must be one of the documented enum values."
  }
}

variable "maximum_required_os_version" {
  description = "Versions bigger than the specified version will block the managed app from accessing company data. For example: '8.1.0' or '13.1.1'."
  type        = string
  default     = null
}

variable "maximum_warning_os_version" {
  description = "Versions bigger than the specified version will result in warning message on the managed app from accessing company data. For example: '8.1.0' or '13.1.1'."
  type        = string
  default     = null
}

variable "maximum_wipe_os_version" {
  description = "Versions bigger than the specified version will wipe the managed app and the associated company data. For example: '8.1.0' or '13.1.1'."
  type        = string
  default     = null
}

variable "minimum_required_app_version" {
  description = "Versions less than the specified version will block the managed app from accessing company data. For example: '8.1.0' or '13.1.1'."
  type        = string
  default     = null
}

variable "minimum_required_os_version" {
  description = "Versions less than the specified version will block the managed app from accessing company data. For example: '8.1.0' or '13.1.1'."
  type        = string
  default     = null
}

variable "minimum_required_sdk_version" {
  description = "Versions less than the specified version will block the managed app from accessing company data. For example: '8.1.0' or '13.1.1'."
  type        = string
  default     = null
}

variable "minimum_warning_app_version" {
  description = "Versions less than the specified version will result in warning message on the managed app from accessing company data. For example: '8.1.0' or '13.1.1'."
  type        = string
  default     = null
}

variable "minimum_warning_os_version" {
  description = "Versions less than the specified version will result in warning message on the managed app from accessing company data. For example: '8.1.0' or '13.1.1'."
  type        = string
  default     = null
}

variable "minimum_wipe_app_version" {
  description = "Versions less than the specified version will wipe the managed app and the associated company data. For example: '8.1.0' or '13.1.1'."
  type        = string
  default     = null
}

variable "minimum_wipe_os_version" {
  description = "Versions less than the specified version will wipe the managed app and the associated company data. For example: '8.1.0' or '13.1.1'."
  type        = string
  default     = null
}

variable "minimum_wipe_sdk_version" {
  description = "Versions less than the specified version will wipe the managed app and the associated company data. For example: '8.1.0' or '13.1.1'."
  type        = string
  default     = null
}

variable "mobile_threat_defense_remediation_action" {
  description = "An admin initiated action to be applied on a managed app."
  type        = string
  default     = null

  validation {
    condition     = var.mobile_threat_defense_remediation_action == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.mobile_threat_defense_remediation_action)
    error_message = "mobile_threat_defense_remediation_action must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.windowsManagedAppProtection"
  nullable    = false
}

variable "period_offline_before_access_check" {
  description = "The period after which access is checked when the device is not connected to the internet. For example, PT5M indicates that the interval is 5 minutes in duration. A timespan value of PT0S indicates that access will be blocked immediately when the device is not connected to the internet."
  type        = string
  default     = null
}

variable "period_offline_before_wipe_is_enforced" {
  description = "The amount of time an app is allowed to remain disconnected from the internet before all managed data it is wiped. For example, P5D indicates that the interval is 5 days in duration. A timespan value of PT0S indicates that managed data will never be wiped when the device is not connected to the internet."
  type        = string
  default     = null
}

variable "print_blocked" {
  description = "When TRUE, indicates that printing is blocked from managed apps. When FALSE, indicates that printing is allowed from managed apps. Default value is FALSE."
  type        = bool
  default     = null
}

variable "role_scope_tag_ids" {
  description = "List of Scope Tags for this Entity instance."
  type        = list(string)
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
