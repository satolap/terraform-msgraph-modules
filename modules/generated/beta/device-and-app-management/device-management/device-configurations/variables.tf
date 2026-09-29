variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  nullable    = false

  validation {
    condition     = var.odata_type == null ? true : contains(["#microsoft.graph.androidCustomConfiguration", "#microsoft.graph.androidDeviceOwnerDerivedCredentialAuthenticationConfiguration", "#microsoft.graph.androidDeviceOwnerEnterpriseWiFiConfiguration", "#microsoft.graph.androidDeviceOwnerGeneralDeviceConfiguration", "#microsoft.graph.androidDeviceOwnerImportedPFXCertificateProfile", "#microsoft.graph.androidDeviceOwnerPkcsCertificateProfile", "#microsoft.graph.androidDeviceOwnerScepCertificateProfile", "#microsoft.graph.androidDeviceOwnerTrustedRootCertificate", "#microsoft.graph.androidDeviceOwnerVpnConfiguration", "#microsoft.graph.androidDeviceOwnerWiFiConfiguration", "#microsoft.graph.androidEasEmailProfileConfiguration", "#microsoft.graph.androidEnterpriseWiFiConfiguration", "#microsoft.graph.androidForWorkCustomConfiguration", "#microsoft.graph.androidForWorkEnterpriseWiFiConfiguration", "#microsoft.graph.androidForWorkGeneralDeviceConfiguration", "#microsoft.graph.androidForWorkGmailEasConfiguration", "#microsoft.graph.androidForWorkImportedPFXCertificateProfile", "#microsoft.graph.androidForWorkNineWorkEasConfiguration", "#microsoft.graph.androidForWorkPkcsCertificateProfile", "#microsoft.graph.androidForWorkScepCertificateProfile", "#microsoft.graph.androidForWorkTrustedRootCertificate", "#microsoft.graph.androidForWorkVpnConfiguration", "#microsoft.graph.androidForWorkWiFiConfiguration", "#microsoft.graph.androidGeneralDeviceConfiguration", "#microsoft.graph.androidImportedPFXCertificateProfile", "#microsoft.graph.androidOmaCpConfiguration", "#microsoft.graph.androidPkcsCertificateProfile", "#microsoft.graph.androidScepCertificateProfile", "#microsoft.graph.androidTrustedRootCertificate", "#microsoft.graph.androidVpnConfiguration", "#microsoft.graph.androidWiFiConfiguration", "#microsoft.graph.androidWorkProfileCustomConfiguration", "#microsoft.graph.androidWorkProfileEnterpriseWiFiConfiguration", "#microsoft.graph.androidWorkProfileGeneralDeviceConfiguration", "#microsoft.graph.androidWorkProfileGmailEasConfiguration", "#microsoft.graph.androidWorkProfileNineWorkEasConfiguration", "#microsoft.graph.androidWorkProfilePkcsCertificateProfile", "#microsoft.graph.androidWorkProfileScepCertificateProfile", "#microsoft.graph.androidWorkProfileTrustedRootCertificate", "#microsoft.graph.androidWorkProfileVpnConfiguration", "#microsoft.graph.androidWorkProfileWiFiConfiguration", "#microsoft.graph.aospDeviceOwnerDeviceConfiguration", "#microsoft.graph.aospDeviceOwnerEnterpriseWiFiConfiguration", "#microsoft.graph.aospDeviceOwnerPkcsCertificateProfile", "#microsoft.graph.aospDeviceOwnerScepCertificateProfile", "#microsoft.graph.aospDeviceOwnerTrustedRootCertificate", "#microsoft.graph.aospDeviceOwnerWiFiConfiguration", "#microsoft.graph.editionUpgradeConfiguration", "#microsoft.graph.iosCustomConfiguration", "#microsoft.graph.iosDerivedCredentialAuthenticationConfiguration", "#microsoft.graph.iosDeviceFeaturesConfiguration", "#microsoft.graph.iosEasEmailProfileConfiguration", "#microsoft.graph.iosEduDeviceConfiguration", "#microsoft.graph.iosEducationDeviceConfiguration", "#microsoft.graph.iosEnterpriseWiFiConfiguration", "#microsoft.graph.iosExpeditedCheckinConfiguration", "#microsoft.graph.iosGeneralDeviceConfiguration", "#microsoft.graph.iosImportedPFXCertificateProfile", "#microsoft.graph.iosPkcsCertificateProfile", "#microsoft.graph.iosScepCertificateProfile", "#microsoft.graph.iosTrustedRootCertificate", "#microsoft.graph.iosUpdateConfiguration", "#microsoft.graph.iosVpnConfiguration", "#microsoft.graph.iosWiFiConfiguration", "#microsoft.graph.iosWiredNetworkConfiguration", "#microsoft.graph.iosikEv2VpnConfiguration", "#microsoft.graph.macOSCustomAppConfiguration", "#microsoft.graph.macOSCustomConfiguration", "#microsoft.graph.macOSDeviceFeaturesConfiguration", "#microsoft.graph.macOSEndpointProtectionConfiguration", "#microsoft.graph.macOSEnterpriseWiFiConfiguration", "#microsoft.graph.macOSExtensionsConfiguration", "#microsoft.graph.macOSGeneralDeviceConfiguration", "#microsoft.graph.macOSImportedPFXCertificateProfile", "#microsoft.graph.macOSPkcsCertificateProfile", "#microsoft.graph.macOSScepCertificateProfile", "#microsoft.graph.macOSSoftwareUpdateConfiguration", "#microsoft.graph.macOSTrustedRootCertificate", "#microsoft.graph.macOSVpnConfiguration", "#microsoft.graph.macOSWiFiConfiguration", "#microsoft.graph.macOSWiredNetworkConfiguration", "#microsoft.graph.sharedPCConfiguration", "#microsoft.graph.unsupportedDeviceConfiguration", "#microsoft.graph.windows10CustomConfiguration", "#microsoft.graph.windows10DeviceFirmwareConfigurationInterface", "#microsoft.graph.windows10EasEmailProfileConfiguration", "#microsoft.graph.windows10EndpointProtectionConfiguration", "#microsoft.graph.windows10EnterpriseModernAppManagementConfiguration", "#microsoft.graph.windows10GeneralConfiguration", "#microsoft.graph.windows10ImportedPFXCertificateProfile", "#microsoft.graph.windows10NetworkBoundaryConfiguration", "#microsoft.graph.windows10PFXImportCertificateProfile", "#microsoft.graph.windows10PkcsCertificateProfile", "#microsoft.graph.windows10SecureAssessmentConfiguration", "#microsoft.graph.windows10TeamGeneralConfiguration", "#microsoft.graph.windows10VpnConfiguration", "#microsoft.graph.windows81GeneralConfiguration", "#microsoft.graph.windows81SCEPCertificateProfile", "#microsoft.graph.windows81TrustedRootCertificate", "#microsoft.graph.windows81VpnConfiguration", "#microsoft.graph.windows81WifiImportConfiguration", "#microsoft.graph.windowsDefenderAdvancedThreatProtectionConfiguration", "#microsoft.graph.windowsDeliveryOptimizationConfiguration", "#microsoft.graph.windowsDomainJoinConfiguration", "#microsoft.graph.windowsHealthMonitoringConfiguration", "#microsoft.graph.windowsIdentityProtectionConfiguration", "#microsoft.graph.windowsKioskConfiguration", "#microsoft.graph.windowsPhone81CustomConfiguration", "#microsoft.graph.windowsPhone81GeneralConfiguration", "#microsoft.graph.windowsPhone81ImportedPFXCertificateProfile", "#microsoft.graph.windowsPhone81SCEPCertificateProfile", "#microsoft.graph.windowsPhone81TrustedRootCertificate", "#microsoft.graph.windowsPhone81VpnConfiguration", "#microsoft.graph.windowsPhoneEASEmailProfileConfiguration", "#microsoft.graph.windowsUpdateForBusinessConfiguration", "#microsoft.graph.windowsWifiConfiguration", "#microsoft.graph.windowsWifiEnterpriseEAPConfiguration", "#microsoft.graph.windowsWiredNetworkConfiguration", "#microsoft.graph.windowsZtdnsConfiguration"], var.odata_type)
    error_message = "odata_type must name a concrete Graph type."
  }
}

variable "assignments" {
  description = "The list of assignments for the device configuration profile."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.deviceConfigurationAssignment")
    intent     = optional(string)
    target     = optional(any)
  }))
  default = null
}

variable "created_date_time" {
  description = "DateTime the object was created."
  type        = string
  default     = null
}

variable "description" {
  description = "Admin provided description of the Device Configuration."
  type        = string
  default     = null
}

variable "device_management_applicability_rule_device_mode" {
  description = "The device mode applicability rule for this Policy."
  type = object({
    odata_type = optional(string, "#microsoft.graph.deviceManagementApplicabilityRuleDeviceMode")
    deviceMode = optional(string)
    name       = optional(string)
    ruleType   = optional(string)
  })
  default = null
}

variable "device_management_applicability_rule_os_edition" {
  description = "The OS edition applicability for this Policy."
  type = object({
    odata_type     = optional(string, "#microsoft.graph.deviceManagementApplicabilityRuleOsEdition")
    name           = optional(string)
    osEditionTypes = optional(list(string))
    ruleType       = optional(string)
  })
  default = null
}

variable "device_management_applicability_rule_os_version" {
  description = "The OS version applicability rule for this Policy."
  type = object({
    odata_type   = optional(string, "#microsoft.graph.deviceManagementApplicabilityRuleOsVersion")
    maxOSVersion = optional(string)
    minOSVersion = optional(string)
    name         = optional(string)
    ruleType     = optional(string)
  })
  default = null
}

variable "device_setting_state_summaries" {
  description = "Device Configuration Setting State Device Summary"
  type = list(object({
    odata_type               = optional(string, "#microsoft.graph.settingStateDeviceSummary")
    compliantDeviceCount     = optional(number)
    conflictDeviceCount      = optional(number)
    errorDeviceCount         = optional(number)
    instancePath             = optional(string)
    nonCompliantDeviceCount  = optional(number)
    notApplicableDeviceCount = optional(number)
    remediatedDeviceCount    = optional(number)
    settingName              = optional(string)
    unknownDeviceCount       = optional(number)
  }))
  default = null
}

variable "device_status_overview" {
  description = "Device Configuration devices status overview"
  type        = any
  default     = null
}

variable "device_statuses" {
  description = "Device configuration installation status by device."
  type = list(object({
    odata_type                              = optional(string, "#microsoft.graph.deviceConfigurationDeviceStatus")
    complianceGracePeriodExpirationDateTime = optional(string)
    deviceDisplayName                       = optional(string)
    deviceModel                             = optional(string)
    lastReportedDateTime                    = optional(string)
    platform                                = optional(number)
    status                                  = optional(string)
    userName                                = optional(string)
    userPrincipalName                       = optional(string)
  }))
  default = null
}

variable "display_name" {
  description = "Admin provided name of the device configuration."
  type        = string
  default     = null
}

variable "graph_version" {
  description = "Version of the device configuration."
  type        = number
  default     = null
}

variable "group_assignments" {
  description = "The list of group assignments for the device configuration profile."
  type = list(object({
    odata_type          = optional(string, "#microsoft.graph.deviceConfigurationGroupAssignment")
    deviceConfiguration = optional(any)
    excludeGroup        = optional(bool)
    targetGroupId       = optional(string)
  }))
  default = null
}

variable "last_modified_date_time" {
  description = "DateTime the object was last modified."
  type        = string
  default     = null
}

variable "role_scope_tag_ids" {
  description = "List of Scope Tags for this Entity instance."
  type        = list(string)
  default     = null
}

variable "user_status_overview" {
  description = "Device Configuration users status overview"
  type        = any
  default     = null
}

variable "user_statuses" {
  description = "Device configuration installation status by user."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.deviceConfigurationUserStatus")
    devicesCount         = optional(number)
    lastReportedDateTime = optional(string)
    status               = optional(string)
    userDisplayName      = optional(string)
    userPrincipalName    = optional(string)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "supportsScopeTags"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
