variable "client_registration_status" {
  description = "Device registration status."
  type        = string
  default     = null

  validation {
    condition     = var.client_registration_status == null ? true : contains(["notRegistered", "registered", "revoked", "keyConflict", "approvalPending", "certificateReset", "notRegisteredPendingEnrollment", "unknown"], var.client_registration_status)
    error_message = "client_registration_status must be one of the documented enum values."
  }
}

variable "device_name" {
  description = "DeviceName"
  type        = string
  default     = null
}

variable "device_type" {
  description = "Device type."
  type        = string
  default     = null

  validation {
    condition     = var.device_type == null ? true : contains(["desktop", "windowsRT", "winMO6", "nokia", "windowsPhone", "mac", "winCE", "winEmbedded", "iPhone", "iPad", "iPod", "android", "iSocConsumer", "unix", "macMDM", "holoLens", "surfaceHub", "androidForWork", "androidEnterprise", "windows10x", "androidnGMS", "chromeOS", "linux", "visionOS", "tvOS", "blackberry", "palm", "unknown", "cloudPC"], var.device_type)
    error_message = "device_type must be one of the documented enum values."
  }
}

variable "entity_source" {
  description = "EntitySource"
  type        = number
  default     = null
}

variable "management_agents" {
  description = "Management agent type."
  type        = string
  default     = null

  validation {
    condition     = var.management_agents == null ? true : contains(["eas", "mdm", "easMdm", "intuneClient", "easIntuneClient", "configurationManagerClient", "configurationManagerClientMdm", "configurationManagerClientMdmEas", "unknown", "jamf", "googleCloudDevicePolicyController", "microsoft365ManagedMdm", "msSense", "intuneAosp", "google", "unknownFutureValue"], var.management_agents)
    error_message = "management_agents must be one of the documented enum values."
  }
}

variable "management_state" {
  description = "Management state of device in Microsoft Intune."
  type        = string
  default     = null

  validation {
    condition     = var.management_state == null ? true : contains(["managed", "retirePending", "retireFailed", "wipePending", "wipeFailed", "unhealthy", "deletePending", "retireIssued", "wipeIssued", "wipeCanceled", "retireCanceled", "discovered", "unknownFutureValue"], var.management_state)
    error_message = "management_state must be one of the documented enum values."
  }
}

variable "manufacturer" {
  description = "Manufacturer"
  type        = string
  default     = null
}

variable "mdm_status" {
  description = "MDMStatus"
  type        = string
  default     = null
}

variable "model" {
  description = "Model"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.comanagementEligibleDevice"
  nullable    = false
}

variable "os_description" {
  description = "OSDescription"
  type        = string
  default     = null
}

variable "os_version" {
  description = "OSVersion"
  type        = string
  default     = null
}

variable "owner_type" {
  description = "Owner type of device."
  type        = string
  default     = null

  validation {
    condition     = var.owner_type == null ? true : contains(["unknown", "company", "personal"], var.owner_type)
    error_message = "owner_type must be one of the documented enum values."
  }
}

variable "reference_id" {
  description = "ReferenceId"
  type        = string
  default     = null
}

variable "serial_number" {
  description = "SerialNumber"
  type        = string
  default     = null
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["comanaged", "eligible", "eligibleButNotAzureAdJoined", "needsOsUpdate", "ineligible", "scheduledForEnrollment", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "upn" {
  description = "UPN"
  type        = string
  default     = null
}

variable "user_email" {
  description = "UserEmail"
  type        = string
  default     = null
}

variable "user_id" {
  description = "UserId"
  type        = string
  default     = null
}

variable "user_name" {
  description = "UserName"
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
