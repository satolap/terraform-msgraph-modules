variable "allowed_android_device_manufacturers" {
  description = "Semicolon seperated list of device manufacturers allowed, as a string, for the managed app to work."
  type        = string
  default     = null
}

variable "allowed_android_device_models" {
  description = "List of device models allowed, as a string, for the managed app to work."
  type        = list(string)
  default     = null
}

variable "allowed_data_ingestion_locations" {
  description = "Data storage locations where a user may store managed data."
  type        = list(string)
  default     = null
}

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

variable "allowed_outbound_clipboard_sharing_exception_length" {
  description = "Specify the number of characters that may be cut or copied from Org data and accounts to any application. This setting overrides the AllowedOutboundClipboardSharingLevel restriction. Default value of '0' means no exception is allowed. Valid values 0 to 65535"
  type        = number
  default     = null
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

variable "app_action_if_account_is_clocked_out" {
  description = "Defines a managed app behavior, either block or warn, if the user is clocked out (non-working time). Possible values are: block, wipe, warn, blockWhenSettingIsSupported."
  type        = any
  default     = null

  validation {
    condition     = var.app_action_if_account_is_clocked_out == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.app_action_if_account_is_clocked_out)
    error_message = "app_action_if_account_is_clocked_out must be one of the documented enum values."
  }
}

variable "app_action_if_android_device_manufacturer_not_allowed" {
  description = "An admin initiated action to be applied on a managed app."
  type        = string
  default     = null

  validation {
    condition     = var.app_action_if_android_device_manufacturer_not_allowed == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.app_action_if_android_device_manufacturer_not_allowed)
    error_message = "app_action_if_android_device_manufacturer_not_allowed must be one of the documented enum values."
  }
}

variable "app_action_if_android_device_model_not_allowed" {
  description = "An admin initiated action to be applied on a managed app."
  type        = string
  default     = null

  validation {
    condition     = var.app_action_if_android_device_model_not_allowed == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.app_action_if_android_device_model_not_allowed)
    error_message = "app_action_if_android_device_model_not_allowed must be one of the documented enum values."
  }
}

variable "app_action_if_android_safety_net_apps_verification_failed" {
  description = "An admin initiated action to be applied on a managed app."
  type        = string
  default     = null

  validation {
    condition     = var.app_action_if_android_safety_net_apps_verification_failed == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.app_action_if_android_safety_net_apps_verification_failed)
    error_message = "app_action_if_android_safety_net_apps_verification_failed must be one of the documented enum values."
  }
}

variable "app_action_if_android_safety_net_device_attestation_failed" {
  description = "An admin initiated action to be applied on a managed app."
  type        = string
  default     = null

  validation {
    condition     = var.app_action_if_android_safety_net_device_attestation_failed == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.app_action_if_android_safety_net_device_attestation_failed)
    error_message = "app_action_if_android_safety_net_device_attestation_failed must be one of the documented enum values."
  }
}

variable "app_action_if_developer_options_enabled" {
  description = "Defines a managed app behavior, either warn, block, or wipe, if Developer Options are enabled on the Android device. If the admin does not set this action, the default is null, which indicates this setting is not configured."
  type        = any
  default     = null

  validation {
    condition     = var.app_action_if_developer_options_enabled == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.app_action_if_developer_options_enabled)
    error_message = "app_action_if_developer_options_enabled must be one of the documented enum values."
  }
}

variable "app_action_if_device_compliance_required" {
  description = "An admin initiated action to be applied on a managed app."
  type        = string
  default     = null

  validation {
    condition     = var.app_action_if_device_compliance_required == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.app_action_if_device_compliance_required)
    error_message = "app_action_if_device_compliance_required must be one of the documented enum values."
  }
}

variable "app_action_if_device_lock_not_set" {
  description = "An admin initiated action to be applied on a managed app."
  type        = string
  default     = null

  validation {
    condition     = var.app_action_if_device_lock_not_set == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.app_action_if_device_lock_not_set)
    error_message = "app_action_if_device_lock_not_set must be one of the documented enum values."
  }
}

variable "app_action_if_device_passcode_complexity_less_than_high" {
  description = "If the device does not have a passcode of high complexity or higher, trigger the stored action. Possible values are: block, wipe, warn, blockWhenSettingIsSupported."
  type        = any
  default     = null

  validation {
    condition     = var.app_action_if_device_passcode_complexity_less_than_high == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.app_action_if_device_passcode_complexity_less_than_high)
    error_message = "app_action_if_device_passcode_complexity_less_than_high must be one of the documented enum values."
  }
}

variable "app_action_if_device_passcode_complexity_less_than_low" {
  description = "If the device does not have a passcode of low complexity or higher, trigger the stored action. Possible values are: block, wipe, warn, blockWhenSettingIsSupported."
  type        = any
  default     = null

  validation {
    condition     = var.app_action_if_device_passcode_complexity_less_than_low == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.app_action_if_device_passcode_complexity_less_than_low)
    error_message = "app_action_if_device_passcode_complexity_less_than_low must be one of the documented enum values."
  }
}

variable "app_action_if_device_passcode_complexity_less_than_medium" {
  description = "If the device does not have a passcode of medium complexity or higher, trigger the stored action. Possible values are: block, wipe, warn, blockWhenSettingIsSupported."
  type        = any
  default     = null

  validation {
    condition     = var.app_action_if_device_passcode_complexity_less_than_medium == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.app_action_if_device_passcode_complexity_less_than_medium)
    error_message = "app_action_if_device_passcode_complexity_less_than_medium must be one of the documented enum values."
  }
}

variable "app_action_if_maximum_pin_retries_exceeded" {
  description = "An admin initiated action to be applied on a managed app."
  type        = string
  default     = null

  validation {
    condition     = var.app_action_if_maximum_pin_retries_exceeded == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.app_action_if_maximum_pin_retries_exceeded)
    error_message = "app_action_if_maximum_pin_retries_exceeded must be one of the documented enum values."
  }
}

variable "app_action_if_samsung_knox_attestation_required" {
  description = "Defines the behavior of a managed app when Samsung Knox Attestation is required. Possible values are null, warn, block & wipe. If the admin does not set this action, the default is null, which indicates this setting is not configured. Possible values are: block, wipe, warn, blockWhenSettingIsSupported."
  type        = any
  default     = null

  validation {
    condition     = var.app_action_if_samsung_knox_attestation_required == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.app_action_if_samsung_knox_attestation_required)
    error_message = "app_action_if_samsung_knox_attestation_required must be one of the documented enum values."
  }
}

variable "app_action_if_unable_to_authenticate_user" {
  description = "If set, it will specify what action to take in the case where the user is unable to checkin because their authentication token is invalid. This happens when the user is deleted or disabled in AAD. Possible values are: block, wipe, warn, blockWhenSettingIsSupported."
  type        = any
  default     = null

  validation {
    condition     = var.app_action_if_unable_to_authenticate_user == null ? true : contains(["block", "wipe", "warn", "blockWhenSettingIsSupported"], var.app_action_if_unable_to_authenticate_user)
    error_message = "app_action_if_unable_to_authenticate_user must be one of the documented enum values."
  }
}

variable "app_group_type" {
  description = "Indicates a collection of apps to target which can be one of several pre-defined lists of apps or a manually selected list of apps"
  type        = string
  default     = null

  validation {
    condition     = var.app_group_type == null ? true : contains(["selectedPublicApps", "allCoreMicrosoftApps", "allMicrosoftApps", "allApps"], var.app_group_type)
    error_message = "app_group_type must be one of the documented enum values."
  }
}

variable "approved_keyboards" {
  description = "If Keyboard Restriction is enabled, only keyboards in this approved list will be allowed. A key should be Android package id for a keyboard and value should be a friendly name"
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.keyValuePair")
    name       = optional(string)
    value      = optional(string)
  }))
  default = null
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

variable "biometric_authentication_blocked" {
  description = "Indicates whether use of the biometric authentication is allowed in place of a pin if PinRequired is set to True."
  type        = bool
  default     = null
}

variable "block_after_company_portal_update_deferral_in_days" {
  description = "Maximum number of days Company Portal update can be deferred on the device or app access will be blocked."
  type        = number
  default     = null
}

variable "block_data_ingestion_into_organization_documents" {
  description = "Indicates whether a user can bring data into org documents."
  type        = bool
  default     = null
}

variable "connect_to_vpn_on_launch" {
  description = "Whether the app should connect to the configured VPN on launch."
  type        = bool
  default     = null
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

variable "custom_dialer_app_display_name" {
  description = "Friendly name of a custom dialer app to click-to-open a phone number on Android."
  type        = string
  default     = null
}

variable "custom_dialer_app_package_id" {
  description = "PackageId of a custom dialer app to click-to-open a phone number on Android."
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

variable "device_lock_required" {
  description = "Defines if any kind of lock must be required on android device"
  type        = bool
  default     = null
}

variable "dialer_restriction_level" {
  description = "The classes of apps that are allowed to click-to-open a phone number, for making phone calls or sending text messages."
  type        = string
  default     = null

  validation {
    condition     = var.dialer_restriction_level == null ? true : contains(["allApps", "managedApps", "customApp", "blocked"], var.dialer_restriction_level)
    error_message = "dialer_restriction_level must be one of the documented enum values."
  }
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

variable "exempted_app_packages" {
  description = "App packages in this list will be exempt from the policy and will be able to receive data from managed apps."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.keyValuePair")
    name       = optional(string)
    value      = optional(string)
  }))
  default = null
}

variable "fingerprint_and_biometric_enabled" {
  description = "If null, this setting will be ignored. If false both fingerprints and biometrics will not be enabled. If true, both fingerprints and biometrics will be enabled."
  type        = bool
  default     = null
}

variable "fingerprint_blocked" {
  description = "Indicates whether use of the fingerprint reader is allowed in place of a pin if PinRequired is set to True."
  type        = bool
  default     = null
}

variable "grace_period_to_block_apps_during_off_clock_hours" {
  description = "A grace period before blocking app access during off clock hours."
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

variable "keyboards_restricted" {
  description = "Indicates if keyboard restriction is enabled. If enabled list of approved keyboards must be provided as well."
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

variable "maximum_allowed_device_threat_level" {
  description = "The maxium threat level allowed for an app to be compliant."
  type        = string
  default     = null

  validation {
    condition     = var.maximum_allowed_device_threat_level == null ? true : contains(["notConfigured", "secured", "low", "medium", "high"], var.maximum_allowed_device_threat_level)
    error_message = "maximum_allowed_device_threat_level must be one of the documented enum values."
  }
}

variable "maximum_pin_retries" {
  description = "Maximum number of incorrect pin retry attempts before the managed app is either blocked or wiped. Valid values 1 to 65535"
  type        = number
  default     = null
}

variable "maximum_required_os_version" {
  description = "Versions bigger than the specified version will block the managed app from accessing company data."
  type        = string
  default     = null
}

variable "maximum_warning_os_version" {
  description = "Versions bigger than the specified version will block the managed app from accessing company data."
  type        = string
  default     = null
}

variable "maximum_wipe_os_version" {
  description = "Versions bigger than the specified version will block the managed app from accessing company data."
  type        = string
  default     = null
}

variable "messaging_redirect_app_display_name" {
  description = "When a specific app redirection is enforced by protectedMessagingRedirectAppType in an App Protection Policy, this value defines the app name which is allowed to be used."
  type        = string
  default     = null
}

variable "messaging_redirect_app_package_id" {
  description = "When a specific app redirection is enforced by protectedMessagingRedirectAppType in an App Protection Policy, this value defines the app package id which is allowed to be used."
  type        = string
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

variable "minimum_required_company_portal_version" {
  description = "Minimum version of the Company portal that must be installed on the device or app access will be blocked"
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

variable "minimum_warning_company_portal_version" {
  description = "Minimum version of the Company portal that must be installed on the device or the user will receive a warning"
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

variable "minimum_wipe_app_version" {
  description = "Versions less than or equal to the specified version will wipe the managed app and the associated company data."
  type        = string
  default     = null
}

variable "minimum_wipe_company_portal_version" {
  description = "Minimum version of the Company portal that must be installed on the device or the company data on the app will be wiped"
  type        = string
  default     = null
}

variable "minimum_wipe_os_version" {
  description = "Versions less than or equal to the specified version will wipe the managed app and the associated company data."
  type        = string
  default     = null
}

variable "minimum_wipe_patch_version" {
  description = "Android security patch level  less than or equal to the specified value will wipe the managed app and the associated company data."
  type        = string
  default     = null
}

variable "mobile_threat_defense_partner_priority" {
  description = "Indicates how to prioritize which Mobile Threat Defense (MTD) partner is enabled for a given platform, when more than one is enabled. An app can only be actively using a single Mobile Threat Defense partner. When NULL, Microsoft Defender will be given preference. Otherwise setting the value to defenderOverThirdPartyPartner or thirdPartyPartnerOverDefender will make explicit which partner to prioritize. Possible values are: null, defenderOverThirdPartyPartner, thirdPartyPartnerOverDefender and unknownFutureValue. Default value is null. Possible values are: defenderOverThirdPartyPartner, thirdPartyPartnerOverDefender, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.mobile_threat_defense_partner_priority == null ? true : contains(["defenderOverThirdPartyPartner", "thirdPartyPartnerOverDefender", "unknownFutureValue"], var.mobile_threat_defense_partner_priority)
    error_message = "mobile_threat_defense_partner_priority must be one of the documented enum values."
  }
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

variable "notification_restriction" {
  description = "Restrict managed app notification"
  type        = string
  default     = null

  validation {
    condition     = var.notification_restriction == null ? true : contains(["allow", "blockOrganizationalData", "block"], var.notification_restriction)
    error_message = "notification_restriction must be one of the documented enum values."
  }
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

variable "pin_required_instead_of_biometric_timeout" {
  description = "Timeout in minutes for an app pin instead of non biometrics passcode"
  type        = string
  default     = null
}

variable "previous_pin_block_count" {
  description = "Requires a pin to be unique from the number specified in this property. Valid values 0 to 24"
  type        = number
  default     = null
}

variable "print_blocked" {
  description = "Indicates whether printing is allowed from managed apps."
  type        = bool
  default     = null
}

variable "protected_messaging_redirect_app_type" {
  description = "Defines how app messaging redirection is protected by an App Protection Policy. Default is anyApp."
  type        = string
  default     = null

  validation {
    condition     = var.protected_messaging_redirect_app_type == null ? true : contains(["anyApp", "anyManagedApp", "specificApps", "blocked"], var.protected_messaging_redirect_app_type)
    error_message = "protected_messaging_redirect_app_type must be one of the documented enum values."
  }
}

variable "purview_content_evaluation_required" {
  description = "Specifies whether Microsoft Purview Data Loss Prevention (DLP) content evaluation is required before data sharing."
  type        = string
  default     = null

  validation {
    condition     = var.purview_content_evaluation_required == null ? true : contains(["notRequired", "requiredWhenOnline", "required", "unknownFutureValue"], var.purview_content_evaluation_required)
    error_message = "purview_content_evaluation_required must be one of the documented enum values."
  }
}

variable "require_class3_biometrics" {
  description = "Require user to apply Class 3 Biometrics on their Android device."
  type        = bool
  default     = null
}

variable "require_pin_after_biometric_change" {
  description = "A PIN prompt will override biometric prompts if class 3 biometrics are updated on the device."
  type        = bool
  default     = null
}

variable "required_android_safety_net_apps_verification_type" {
  description = "An admin enforced Android SafetyNet Device Attestation requirement on a managed app."
  type        = string
  default     = null

  validation {
    condition     = var.required_android_safety_net_apps_verification_type == null ? true : contains(["none", "enabled"], var.required_android_safety_net_apps_verification_type)
    error_message = "required_android_safety_net_apps_verification_type must be one of the documented enum values."
  }
}

variable "required_android_safety_net_device_attestation_type" {
  description = "An admin enforced Android SafetyNet Device Attestation requirement on a managed app."
  type        = string
  default     = null

  validation {
    condition     = var.required_android_safety_net_device_attestation_type == null ? true : contains(["none", "basicIntegrity", "basicIntegrityAndDeviceCertification"], var.required_android_safety_net_device_attestation_type)
    error_message = "required_android_safety_net_device_attestation_type must be one of the documented enum values."
  }
}

variable "required_android_safety_net_evaluation_type" {
  description = "An admin enforced Android SafetyNet evaluation type requirement on a managed app."
  type        = string
  default     = null

  validation {
    condition     = var.required_android_safety_net_evaluation_type == null ? true : contains(["basic", "hardwareBacked"], var.required_android_safety_net_evaluation_type)
    error_message = "required_android_safety_net_evaluation_type must be one of the documented enum values."
  }
}

variable "role_scope_tag_ids" {
  description = "List of Scope Tags for this Entity instance."
  type        = list(string)
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

variable "targeted_app_management_levels" {
  description = "Management levels for apps"
  type        = string
  default     = null

  validation {
    condition     = var.targeted_app_management_levels == null ? true : contains(["unspecified", "unmanaged", "mdm", "androidEnterprise", "androidEnterpriseDedicatedDevicesWithAzureAdSharedMode", "androidOpenSourceProjectUserAssociated", "androidOpenSourceProjectUserless", "unknownFutureValue"], var.targeted_app_management_levels)
    error_message = "targeted_app_management_levels must be one of the documented enum values."
  }
}

variable "warn_after_company_portal_update_deferral_in_days" {
  description = "Maximum number of days Company Portal update can be deferred on the device or the user will receive the warning"
  type        = number
  default     = null
}

variable "wipe_after_company_portal_update_deferral_in_days" {
  description = "Maximum number of days Company Portal update can be deferred on the device or the company data on the app will be wiped"
  type        = number
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
