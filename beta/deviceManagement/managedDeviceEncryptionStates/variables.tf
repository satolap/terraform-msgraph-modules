variable "advancedBitLockerStates" {
  description = "Advanced BitLocker State. Possible values are: success, noUserConsent, osVolumeUnprotected, osVolumeTpmRequired, osVolumeTpmOnlyRequired, osVolumeTpmPinRequired, osVolumeTpmStartupKeyRequired, osVolumeTpmPinStartupKeyRequired, osVolumeEncryptionMethodMismatch, recoveryKeyBackupFailed, fixedDriveNotEncrypted, fixedDriveEncryptionMethodMismatch, loggedOnUserNonAdmin, windowsRecoveryEnvironmentNotConfigured, tpmNotAvailable, tpmNotReady, networkError."
  type        = string
  default     = null

  validation {
    condition     = var.advancedBitLockerStates == null ? true : try(alltrue([for value in split(",", var.advancedBitLockerStates) : contains(["success", "nouserconsent", "osvolumeunprotected", "osvolumetpmrequired", "osvolumetpmonlyrequired", "osvolumetpmpinrequired", "osvolumetpmstartupkeyrequired", "osvolumetpmpinstartupkeyrequired", "osvolumeencryptionmethodmismatch", "recoverykeybackupfailed", "fixeddrivenotencrypted", "fixeddriveencryptionmethodmismatch", "loggedonusernonadmin", "windowsrecoveryenvironmentnotconfigured", "tpmnotavailable", "tpmnotready", "networkerror"], lower(trimspace(value)))]), false)
    error_message = "advancedBitLockerStates must be one or more of the documented enum values, separated by commas."
  }
}

variable "deviceName" {
  description = "Device name"
  type        = string
  default     = null
}

variable "deviceType" {
  description = "Device type."
  type        = string
  default     = null

  validation {
    condition     = var.deviceType == null ? true : contains(["desktop", "windowsRT", "winMO6", "nokia", "windowsPhone", "mac", "winCE", "winEmbedded", "iPhone", "iPad", "iPod", "android", "iSocConsumer", "unix", "macMDM", "holoLens", "surfaceHub", "androidForWork", "androidEnterprise", "blackberry", "palm", "unknown"], var.deviceType)
    error_message = "deviceType must be one of the documented enum values."
  }
}

variable "encryptionPolicySettingState" {
  description = "Encryption policy setting state"
  type        = string
  default     = null

  validation {
    condition     = var.encryptionPolicySettingState == null ? true : contains(["unknown", "notApplicable", "compliant", "remediated", "nonCompliant", "error", "conflict", "notAssigned"], var.encryptionPolicySettingState)
    error_message = "encryptionPolicySettingState must be one of the documented enum values."
  }
}

variable "encryptionReadinessState" {
  description = "Encryption readiness state"
  type        = string
  default     = null

  validation {
    condition     = var.encryptionReadinessState == null ? true : contains(["notReady", "ready"], var.encryptionReadinessState)
    error_message = "encryptionReadinessState must be one of the documented enum values."
  }
}

variable "encryptionState" {
  description = "Encryption state"
  type        = string
  default     = null

  validation {
    condition     = var.encryptionState == null ? true : contains(["notEncrypted", "encrypted"], var.encryptionState)
    error_message = "encryptionState must be one of the documented enum values."
  }
}

variable "fileVaultStates" {
  description = "FileVault State. Possible values are: success, driveEncryptedByUser, userDeferredEncryption, escrowNotEnabled."
  type        = string
  default     = null

  validation {
    condition     = var.fileVaultStates == null ? true : try(alltrue([for value in split(",", var.fileVaultStates) : contains(["success", "driveencryptedbyuser", "userdeferredencryption", "escrownotenabled"], lower(trimspace(value)))]), false)
    error_message = "fileVaultStates must be one or more of the documented enum values, separated by commas."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedDeviceEncryptionState"
  nullable    = false
}

variable "osVersion" {
  description = "Operating system version of the device"
  type        = string
  default     = null
}

variable "policyDetails" {
  description = "Policy Details"
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.encryptionReportPolicyDetails")
    policyId   = optional(string)
    policyName = optional(string)
  }))
  default = null
}

variable "tpmSpecificationVersion" {
  description = "Device TPM Version"
  type        = string
  default     = null
}

variable "userPrincipalName" {
  description = "User name"
  type        = string
  default     = null
}

variable "timeouts" {
  description = "Optional timeouts of the msgraph_resource, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". create, update and delete must be at least \"15s\": after each request the provider waits for consistent reads within the same timeout. Every value defaults to null, which keeps the provider defaults and sends no timeouts block. The reviewed replication retries of this module, where it has any, count against these timeouts."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.read, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : (can(regex("^([0-9]+[hms])+$", t)) ? !can(regex("^(0+[hms])+$", t)) : false)
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : try(sum([for m in regexall("([0-9]+)([hms])", t) : tonumber(m[0]) * lookup({ h = 3600, m = 60, s = 1 }, m[1])]) >= 15, true)
    ])
    error_message = "timeouts.create, timeouts.update and timeouts.delete must be at least \"15s\"."
  }
}

variable "select_response" {
  description = "Opt in to a configured-property GET selection; this narrows response and can remove fields consumers use."
  type        = bool
  default     = false
  nullable    = false
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
