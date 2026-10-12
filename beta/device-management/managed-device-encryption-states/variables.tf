variable "advanced_bit_locker_states" {
  description = "Advanced BitLocker State. Possible values are: success, noUserConsent, osVolumeUnprotected, osVolumeTpmRequired, osVolumeTpmOnlyRequired, osVolumeTpmPinRequired, osVolumeTpmStartupKeyRequired, osVolumeTpmPinStartupKeyRequired, osVolumeEncryptionMethodMismatch, recoveryKeyBackupFailed, fixedDriveNotEncrypted, fixedDriveEncryptionMethodMismatch, loggedOnUserNonAdmin, windowsRecoveryEnvironmentNotConfigured, tpmNotAvailable, tpmNotReady, networkError."
  type        = string
  default     = null

  validation {
    condition     = var.advanced_bit_locker_states == null ? true : try(alltrue([for value in split(",", var.advanced_bit_locker_states) : contains(["success", "nouserconsent", "osvolumeunprotected", "osvolumetpmrequired", "osvolumetpmonlyrequired", "osvolumetpmpinrequired", "osvolumetpmstartupkeyrequired", "osvolumetpmpinstartupkeyrequired", "osvolumeencryptionmethodmismatch", "recoverykeybackupfailed", "fixeddrivenotencrypted", "fixeddriveencryptionmethodmismatch", "loggedonusernonadmin", "windowsrecoveryenvironmentnotconfigured", "tpmnotavailable", "tpmnotready", "networkerror"], lower(trimspace(value)))]), false)
    error_message = "advanced_bit_locker_states must be one or more of the documented enum values, separated by commas."
  }
}

variable "device_name" {
  description = "Device name"
  type        = string
  default     = null
}

variable "device_type" {
  description = "Device type."
  type        = string
  default     = null

  validation {
    condition     = var.device_type == null ? true : contains(["desktop", "windowsRT", "winMO6", "nokia", "windowsPhone", "mac", "winCE", "winEmbedded", "iPhone", "iPad", "iPod", "android", "iSocConsumer", "unix", "macMDM", "holoLens", "surfaceHub", "androidForWork", "androidEnterprise", "blackberry", "palm", "unknown"], var.device_type)
    error_message = "device_type must be one of the documented enum values."
  }
}

variable "encryption_policy_setting_state" {
  description = "Encryption policy setting state"
  type        = string
  default     = null

  validation {
    condition     = var.encryption_policy_setting_state == null ? true : contains(["unknown", "notApplicable", "compliant", "remediated", "nonCompliant", "error", "conflict", "notAssigned"], var.encryption_policy_setting_state)
    error_message = "encryption_policy_setting_state must be one of the documented enum values."
  }
}

variable "encryption_readiness_state" {
  description = "Encryption readiness state"
  type        = string
  default     = null

  validation {
    condition     = var.encryption_readiness_state == null ? true : contains(["notReady", "ready"], var.encryption_readiness_state)
    error_message = "encryption_readiness_state must be one of the documented enum values."
  }
}

variable "encryption_state" {
  description = "Encryption state"
  type        = string
  default     = null

  validation {
    condition     = var.encryption_state == null ? true : contains(["notEncrypted", "encrypted"], var.encryption_state)
    error_message = "encryption_state must be one of the documented enum values."
  }
}

variable "file_vault_states" {
  description = "FileVault State. Possible values are: success, driveEncryptedByUser, userDeferredEncryption, escrowNotEnabled."
  type        = string
  default     = null

  validation {
    condition     = var.file_vault_states == null ? true : try(alltrue([for value in split(",", var.file_vault_states) : contains(["success", "driveencryptedbyuser", "userdeferredencryption", "escrownotenabled"], lower(trimspace(value)))]), false)
    error_message = "file_vault_states must be one or more of the documented enum values, separated by commas."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedDeviceEncryptionState"
  nullable    = false
}

variable "os_version" {
  description = "Operating system version of the device"
  type        = string
  default     = null
}

variable "policy_details" {
  description = "Policy Details"
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.encryptionReportPolicyDetails")
    policyId   = optional(string)
    policyName = optional(string)
  }))
  default = null
}

variable "tpm_specification_version" {
  description = "Device TPM Version"
  type        = string
  default     = null
}

variable "user_principal_name" {
  description = "User name"
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
