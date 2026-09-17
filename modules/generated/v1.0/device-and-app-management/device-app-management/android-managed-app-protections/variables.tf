variable "allowed_data_storage_locations" {
  description = "Data storage locations where a user may store managed data."
  type        = list(string)
  default     = null
}

variable "allowed_inbound_data_transfer_sources" {
  description = "Data can be transferred from/to these classes of apps"
  type        = string
  default     = null

  validation {
    condition     = var.allowed_inbound_data_transfer_sources == null ? true : contains(["allApps", "managedApps", "none"], var.allowed_inbound_data_transfer_sources)
    error_message = "allowed_inbound_data_transfer_sources must be one of the documented enum values."
  }
}

variable "allowed_outbound_clipboard_sharing_level" {
  description = "Represents the level to which the device's clipboard may be shared between apps"
  type        = string
  default     = null

  validation {
    condition     = var.allowed_outbound_clipboard_sharing_level == null ? true : contains(["allApps", "managedAppsWithPasteIn", "managedApps", "blocked"], var.allowed_outbound_clipboard_sharing_level)
    error_message = "allowed_outbound_clipboard_sharing_level must be one of the documented enum values."
  }
}

variable "allowed_outbound_data_transfer_destinations" {
  description = "Data can be transferred from/to these classes of apps"
  type        = string
  default     = null

  validation {
    condition     = var.allowed_outbound_data_transfer_destinations == null ? true : contains(["allApps", "managedApps", "none"], var.allowed_outbound_data_transfer_destinations)
    error_message = "allowed_outbound_data_transfer_destinations must be one of the documented enum values."
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
    target     = optional(any)
  }))
  default = null
}

variable "contact_sync_blocked" {
  description = "Indicates whether contacts can be synced to the user's device."
  type        = bool
  default     = null
}

variable "created_date_time" {
  description = "The date and time the policy was created."
  type        = string
  default     = null
}

variable "custom_browser_display_name" {
  description = "Friendly name of the preferred custom browser to open weblink on Android. When this property is configured, ManagedBrowserToOpenLinksRequired should be true."
  type        = string
  default     = null
}

variable "custom_browser_package_id" {
  description = "Unique identifier of the preferred custom browser to open weblink on Android. When this property is configured, ManagedBrowserToOpenLinksRequired should be true."
  type        = string
  default     = null
}

variable "data_backup_blocked" {
  description = "Indicates whether the backup of a managed app's data is blocked."
  type        = bool
  default     = null
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

variable "device_compliance_required" {
  description = "Indicates whether device compliance is required."
  type        = bool
  default     = null
}

variable "disable_app_encryption_if_device_encryption_is_enabled" {
  description = "When this setting is enabled, app level encryption is disabled if device level encryption is enabled"
  type        = bool
  default     = null
}

variable "disable_app_pin_if_device_pin_is_set" {
  description = "Indicates whether use of the app pin is required if the device pin is set."
  type        = bool
  default     = null
}

variable "display_name" {
  description = "Policy display name."
  type        = string
  default     = null
}

variable "encrypt_app_data" {
  description = "Indicates whether application data for managed apps should be encrypted"
  type        = bool
  default     = null
}

variable "fingerprint_blocked" {
  description = "Indicates whether use of the fingerprint reader is allowed in place of a pin if PinRequired is set to True."
  type        = bool
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

variable "managed_browser" {
  description = "Type of managed browser"
  type        = string
  default     = null

  validation {
    condition     = var.managed_browser == null ? true : contains(["notConfigured", "microsoftEdge"], var.managed_browser)
    error_message = "managed_browser must be one of the documented enum values."
  }
}

variable "managed_browser_to_open_links_required" {
  description = "Indicates whether internet links should be opened in the managed browser app, or any custom browser specified by CustomBrowserProtocol (for iOS) or CustomBrowserPackageId/CustomBrowserDisplayName (for Android)"
  type        = bool
  default     = null
}

variable "maximum_pin_retries" {
  description = "Maximum number of incorrect pin retry attempts before the managed app is either blocked or wiped. Valid values 1 to 65535"
  type        = number
  default     = null
}

variable "minimum_pin_length" {
  description = "Minimum pin length required for an app-level pin if PinRequired is set to True"
  type        = number
  default     = null
}

variable "minimum_required_app_version" {
  description = "Versions less than the specified version will block the managed app from accessing company data."
  type        = string
  default     = null
}

variable "minimum_required_os_version" {
  description = "Versions less than the specified version will block the managed app from accessing company data."
  type        = string
  default     = null
}

variable "minimum_required_patch_version" {
  description = "Define the oldest required Android security patch level a user can have to gain secure access to the app."
  type        = string
  default     = null
}

variable "minimum_warning_app_version" {
  description = "Versions less than the specified version will result in warning message on the managed app."
  type        = string
  default     = null
}

variable "minimum_warning_os_version" {
  description = "Versions less than the specified version will result in warning message on the managed app from accessing company data."
  type        = string
  default     = null
}

variable "minimum_warning_patch_version" {
  description = "Define the oldest recommended Android security patch level a user can have for secure access to the app."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.androidManagedAppProtection"
  nullable    = false
}

variable "organizational_credentials_required" {
  description = "Indicates whether organizational credentials are required for app use."
  type        = bool
  default     = null
  sensitive   = true
}

variable "period_before_pin_reset" {
  description = "TimePeriod before the all-level pin must be reset if PinRequired is set to True."
  type        = string
  default     = null
}

variable "period_offline_before_access_check" {
  description = "The period after which access is checked when the device is not connected to the internet."
  type        = string
  default     = null
}

variable "period_offline_before_wipe_is_enforced" {
  description = "The amount of time an app is allowed to remain disconnected from the internet before all managed data it is wiped."
  type        = string
  default     = null
}

variable "period_online_before_access_check" {
  description = "The period after which access is checked when the device is connected to the internet."
  type        = string
  default     = null
}

variable "pin_character_set" {
  description = "Character set which is to be used for a user's app PIN"
  type        = string
  default     = null

  validation {
    condition     = var.pin_character_set == null ? true : contains(["numeric", "alphanumericAndSymbol"], var.pin_character_set)
    error_message = "pin_character_set must be one of the documented enum values."
  }
}

variable "pin_required" {
  description = "Indicates whether an app-level pin is required."
  type        = bool
  default     = null
}

variable "print_blocked" {
  description = "Indicates whether printing is allowed from managed apps."
  type        = bool
  default     = null
}

variable "save_as_blocked" {
  description = "Indicates whether users may use the 'Save As' menu item to save a copy of protected files."
  type        = bool
  default     = null
}

variable "screen_capture_blocked" {
  description = "Indicates whether a managed user can take screen captures of managed apps"
  type        = bool
  default     = null
}

variable "simple_pin_blocked" {
  description = "Indicates whether simplePin is blocked."
  type        = bool
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
