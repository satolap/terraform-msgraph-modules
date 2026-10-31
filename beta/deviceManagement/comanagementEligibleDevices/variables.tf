variable "clientRegistrationStatus" {
  description = "Device registration status."
  type        = string
  default     = null

  validation {
    condition     = var.clientRegistrationStatus == null ? true : contains(["notRegistered", "registered", "revoked", "keyConflict", "approvalPending", "certificateReset", "notRegisteredPendingEnrollment", "unknown"], var.clientRegistrationStatus)
    error_message = "clientRegistrationStatus must be one of the documented enum values."
  }
}

variable "deviceName" {
  description = "DeviceName"
  type        = string
  default     = null
}

variable "deviceType" {
  description = "Device type."
  type        = string
  default     = null

  validation {
    condition     = var.deviceType == null ? true : contains(["desktop", "windowsRT", "winMO6", "nokia", "windowsPhone", "mac", "winCE", "winEmbedded", "iPhone", "iPad", "iPod", "android", "iSocConsumer", "unix", "macMDM", "holoLens", "surfaceHub", "androidForWork", "androidEnterprise", "windows10x", "androidnGMS", "chromeOS", "linux", "visionOS", "tvOS", "blackberry", "palm", "unknown", "cloudPC"], var.deviceType)
    error_message = "deviceType must be one of the documented enum values."
  }
}

variable "entitySource" {
  description = "EntitySource"
  type        = number
  default     = null
}

variable "managementAgents" {
  description = "Management agent type."
  type        = string
  default     = null

  validation {
    condition     = var.managementAgents == null ? true : contains(["eas", "mdm", "easMdm", "intuneClient", "easIntuneClient", "configurationManagerClient", "configurationManagerClientMdm", "configurationManagerClientMdmEas", "unknown", "jamf", "googleCloudDevicePolicyController", "microsoft365ManagedMdm", "msSense", "intuneAosp", "google"], var.managementAgents)
    error_message = "managementAgents must be one of the documented enum values."
  }
}

variable "managementState" {
  description = "Management state of device in Microsoft Intune."
  type        = string
  default     = null

  validation {
    condition     = var.managementState == null ? true : contains(["managed", "retirePending", "retireFailed", "wipePending", "wipeFailed", "unhealthy", "deletePending", "retireIssued", "wipeIssued", "wipeCanceled", "retireCanceled", "discovered"], var.managementState)
    error_message = "managementState must be one of the documented enum values."
  }
}

variable "manufacturer" {
  description = "Manufacturer"
  type        = string
  default     = null
}

variable "mdmStatus" {
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

variable "osDescription" {
  description = "OSDescription"
  type        = string
  default     = null
}

variable "osVersion" {
  description = "OSVersion"
  type        = string
  default     = null
}

variable "ownerType" {
  description = "Owner type of device."
  type        = string
  default     = null

  validation {
    condition     = var.ownerType == null ? true : contains(["unknown", "company", "personal"], var.ownerType)
    error_message = "ownerType must be one of the documented enum values."
  }
}

variable "referenceId" {
  description = "ReferenceId"
  type        = string
  default     = null
}

variable "serialNumber" {
  description = "SerialNumber"
  type        = string
  default     = null
}

variable "status" {
  description = "ComanagementEligibleStatus"
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["comanaged", "eligible", "eligibleButNotAzureAdJoined", "needsOsUpdate", "ineligible", "scheduledForEnrollment"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "upn" {
  description = "UPN"
  type        = string
  default     = null
}

variable "userEmail" {
  description = "UserEmail"
  type        = string
  default     = null
}

variable "userId" {
  description = "UserId"
  type        = string
  default     = null
}

variable "userName" {
  description = "UserName"
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
