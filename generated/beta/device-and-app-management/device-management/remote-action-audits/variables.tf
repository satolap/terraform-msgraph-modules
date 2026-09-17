variable "action" {
  description = "Remote actions Intune supports."
  type        = string
  default     = null

  validation {
    condition     = var.action == null ? true : contains(["unknown", "factoryReset", "removeCompanyData", "resetPasscode", "remoteLock", "enableLostMode", "disableLostMode", "locateDevice", "rebootNow", "recoverPasscode", "cleanWindowsDevice", "logoutSharedAppleDeviceActiveUser", "quickScan", "fullScan", "windowsDefenderUpdateSignatures", "factoryResetKeepEnrollmentData", "updateDeviceAccount", "automaticRedeployment", "shutDown", "rotateBitLockerKeys", "rotateFileVaultKey", "getFileVaultKey", "setDeviceName", "activateDeviceEsim", "deprovision", "disable", "reenable", "moveDeviceToOrganizationalUnit", "initiateMobileDeviceManagementKeyRecovery", "initiateOnDemandProactiveRemediation", "rotateLocalAdminPassword", "unknownFutureValue", "launchRemoteHelp", "revokeAppleVppLicenses", "removeDeviceFirmwareConfigurationInterfaceManagement", "pauseConfigurationRefresh", "initiateDeviceAttestation", "changeAssignments", "delete", "suspendManagedHomeScreen", "restoreManagedHomeScreen", "triggerEnhancedLogCollection", "cancelEnhancedLogCollection"], var.action)
    error_message = "action must be one of the documented enum values."
  }
}

variable "action_state" {
  description = "Microsoft Graph actionState property."
  type        = string
  default     = null

  validation {
    condition     = var.action_state == null ? true : contains(["none", "pending", "canceled", "active", "done", "failed", "notSupported"], var.action_state)
    error_message = "action_state must be one of the documented enum values."
  }
}

variable "bulk_device_action_id" {
  description = "BulkAction ID"
  type        = string
  default     = null
}

variable "device_action_category" {
  description = "Enum type used for DeviceActionCategory"
  type        = string
  default     = null

  validation {
    condition     = var.device_action_category == null ? true : contains(["single", "bulk"], var.device_action_category)
    error_message = "device_action_category must be one of the documented enum values."
  }
}

variable "device_display_name" {
  description = "Intune device name."
  type        = string
  default     = null
}

variable "device_imei" {
  description = "IMEI of the device."
  type        = string
  default     = null
}

variable "device_owner_user_principal_name" {
  description = "Upn of the device owner."
  type        = string
  default     = null
}

variable "initiated_by_user_principal_name" {
  description = "User who initiated the device action, format is UPN."
  type        = string
  default     = null
}

variable "managed_device_id" {
  description = "Action target."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.remoteActionAudit"
  nullable    = false
}

variable "request_date_time" {
  description = "Time when the action was issued, given in UTC."
  type        = string
  default     = null
}

variable "user_name" {
  description = "[deprecated] Please use InitiatedByUserPrincipalName instead."
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
