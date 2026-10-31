variable "addressableUserName" {
  description = "Addressable user name."
  type        = string
  default     = null
}

variable "azureActiveDirectoryDeviceId" {
  description = "AAD Device ID - to be deprecated"
  type        = string
  default     = null
}

variable "azureAdDeviceId" {
  description = "AAD Device ID"
  type        = string
  default     = null
}

variable "deploymentProfile" {
  description = "Deployment profile currently assigned to the Windows autopilot device."
  type        = any
  default     = null
}

variable "deploymentProfileAssignedDateTime" {
  description = "Profile set time of the Windows autopilot device."
  type        = string
  default     = null
}

variable "deploymentProfileAssignmentDetailedStatus" {
  description = "Profile assignment detailed status of the Windows autopilot device."
  type        = string
  default     = null

  validation {
    condition     = var.deploymentProfileAssignmentDetailedStatus == null ? true : contains(["none", "hardwareRequirementsNotMet", "surfaceHubProfileNotSupported", "holoLensProfileNotSupported", "windowsPcProfileNotSupported", "surfaceHub2SProfileNotSupported"], var.deploymentProfileAssignmentDetailedStatus)
    error_message = "deploymentProfileAssignmentDetailedStatus must be one of the documented enum values."
  }
}

variable "deploymentProfileAssignmentStatus" {
  description = "Profile assignment status of the Windows autopilot device."
  type        = string
  default     = null

  validation {
    condition     = var.deploymentProfileAssignmentStatus == null ? true : contains(["unknown", "assignedInSync", "assignedOutOfSync", "assignedUnkownSyncState", "notAssigned", "pending", "failed"], var.deploymentProfileAssignmentStatus)
    error_message = "deploymentProfileAssignmentStatus must be one of the documented enum values."
  }
}

variable "deviceAccountPassword" {
  description = "Surface Hub Device Account Password"
  type        = string
  default     = null
  sensitive   = true
}

variable "deviceAccountUpn" {
  description = "Surface Hub Device Account Upn"
  type        = string
  default     = null
}

variable "deviceFriendlyName" {
  description = "Surface Hub Device Friendly Name"
  type        = string
  default     = null
}

variable "displayName" {
  description = "Display Name"
  type        = string
  default     = null
}

variable "enrollmentState" {
  description = "Intune enrollment state of the Windows autopilot device."
  type        = string
  default     = null

  validation {
    condition     = var.enrollmentState == null ? true : contains(["unknown", "enrolled", "pendingReset", "failed", "notContacted", "blocked"], var.enrollmentState)
    error_message = "enrollmentState must be one of the documented enum values."
  }
}

variable "groupTag" {
  description = "Group Tag of the Windows autopilot device."
  type        = string
  default     = null
}

variable "intendedDeploymentProfile" {
  description = "Deployment profile intended to be assigned to the Windows autopilot device."
  type        = any
  default     = null
}

variable "lastContactedDateTime" {
  description = "Intune Last Contacted Date Time of the Windows autopilot device."
  type        = string
  default     = null
}

variable "managedDeviceId" {
  description = "Managed Device ID"
  type        = string
  default     = null
}

variable "manufacturer" {
  description = "Oem manufacturer of the Windows autopilot device."
  type        = string
  default     = null
}

variable "model" {
  description = "Model name of the Windows autopilot device."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.windowsAutopilotDeviceIdentity"
  nullable    = false
}

variable "productKey" {
  description = "Product Key of the Windows autopilot device."
  type        = string
  default     = null
}

variable "purchaseOrderIdentifier" {
  description = "Purchase Order Identifier of the Windows autopilot device."
  type        = string
  default     = null
}

variable "remediationState" {
  description = "Device remediation status, indicating whether or not hardware has been changed for an Autopilot-registered device."
  type        = string
  default     = null

  validation {
    condition     = var.remediationState == null ? true : contains(["unknown", "noRemediationRequired", "automaticRemediationRequired", "manualRemediationRequired"], var.remediationState)
    error_message = "remediationState must be one of the documented enum values."
  }
}

variable "remediationStateLastModifiedDateTime" {
  description = "RemediationState set time of Autopilot device."
  type        = string
  default     = null
}

variable "resourceName" {
  description = "Resource Name."
  type        = string
  default     = null
}

variable "serialNumber" {
  description = "Serial number of the Windows autopilot device."
  type        = string
  default     = null
}

variable "skuNumber" {
  description = "SKU Number"
  type        = string
  default     = null
}

variable "systemFamily" {
  description = "System Family"
  type        = string
  default     = null
}

variable "userPrincipalName" {
  description = "User Principal Name."
  type        = string
  default     = null
}

variable "userlessEnrollmentStatus" {
  description = "Userless enrollment block status, indicating whether the next device enrollment will be blocked."
  type        = string
  default     = null

  validation {
    condition     = var.userlessEnrollmentStatus == null ? true : contains(["unknown", "allowed", "blocked"], var.userlessEnrollmentStatus)
    error_message = "userlessEnrollmentStatus must be one of the documented enum values."
  }
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
