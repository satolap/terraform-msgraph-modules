variable "addressable_user_name" {
  description = "Addressable user name."
  type        = string
  default     = null
}

variable "azure_active_directory_device_id" {
  description = "AAD Device ID - to be deprecated"
  type        = string
  default     = null
}

variable "azure_ad_device_id" {
  description = "AAD Device ID"
  type        = string
  default     = null
}

variable "deployment_profile" {
  description = "Deployment profile currently assigned to the Windows autopilot device."
  type        = any
  default     = null
}

variable "deployment_profile_assigned_date_time" {
  description = "Profile set time of the Windows autopilot device."
  type        = string
  default     = null
}

variable "deployment_profile_assignment_detailed_status" {
  description = "Microsoft Graph deploymentProfileAssignmentDetailedStatus property."
  type        = string
  default     = null

  validation {
    condition     = var.deployment_profile_assignment_detailed_status == null ? true : contains(["none", "hardwareRequirementsNotMet", "surfaceHubProfileNotSupported", "holoLensProfileNotSupported", "windowsPcProfileNotSupported", "surfaceHub2SProfileNotSupported", "unknownFutureValue"], var.deployment_profile_assignment_detailed_status)
    error_message = "deployment_profile_assignment_detailed_status must be one of the documented enum values."
  }
}

variable "deployment_profile_assignment_status" {
  description = "Microsoft Graph deploymentProfileAssignmentStatus property."
  type        = string
  default     = null

  validation {
    condition     = var.deployment_profile_assignment_status == null ? true : contains(["unknown", "assignedInSync", "assignedOutOfSync", "assignedUnkownSyncState", "notAssigned", "pending", "failed"], var.deployment_profile_assignment_status)
    error_message = "deployment_profile_assignment_status must be one of the documented enum values."
  }
}

variable "device_account_password" {
  description = "Surface Hub Device Account Password"
  type        = string
  default     = null
  sensitive   = true
}

variable "device_account_upn" {
  description = "Surface Hub Device Account Upn"
  type        = string
  default     = null
}

variable "device_friendly_name" {
  description = "Surface Hub Device Friendly Name"
  type        = string
  default     = null
}

variable "display_name" {
  description = "Display Name"
  type        = string
  default     = null
}

variable "enrollment_state" {
  description = "Microsoft Graph enrollmentState property."
  type        = string
  default     = null

  validation {
    condition     = var.enrollment_state == null ? true : contains(["unknown", "enrolled", "pendingReset", "failed", "notContacted", "blocked"], var.enrollment_state)
    error_message = "enrollment_state must be one of the documented enum values."
  }
}

variable "group_tag" {
  description = "Group Tag of the Windows autopilot device."
  type        = string
  default     = null
}

variable "intended_deployment_profile" {
  description = "Deployment profile intended to be assigned to the Windows autopilot device."
  type        = any
  default     = null
}

variable "last_contacted_date_time" {
  description = "Intune Last Contacted Date Time of the Windows autopilot device."
  type        = string
  default     = null
}

variable "managed_device_id" {
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

variable "product_key" {
  description = "Product Key of the Windows autopilot device."
  type        = string
  default     = null
}

variable "purchase_order_identifier" {
  description = "Purchase Order Identifier of the Windows autopilot device."
  type        = string
  default     = null
}

variable "remediation_state" {
  description = "Device remediation status, indicating whether or not hardware has been changed for an Autopilot-registered device."
  type        = string
  default     = null

  validation {
    condition     = var.remediation_state == null ? true : contains(["unknown", "noRemediationRequired", "automaticRemediationRequired", "manualRemediationRequired", "unknownFutureValue"], var.remediation_state)
    error_message = "remediation_state must be one of the documented enum values."
  }
}

variable "remediation_state_last_modified_date_time" {
  description = "RemediationState set time of Autopilot device."
  type        = string
  default     = null
}

variable "resource_name" {
  description = "Resource Name."
  type        = string
  default     = null
}

variable "serial_number" {
  description = "Serial number of the Windows autopilot device."
  type        = string
  default     = null
}

variable "sku_number" {
  description = "SKU Number"
  type        = string
  default     = null
}

variable "system_family" {
  description = "System Family"
  type        = string
  default     = null
}

variable "user_principal_name" {
  description = "User Principal Name."
  type        = string
  default     = null
}

variable "userless_enrollment_status" {
  description = "Userless enrollment block status, indicating whether the next device enrollment will be blocked."
  type        = string
  default     = null

  validation {
    condition     = var.userless_enrollment_status == null ? true : contains(["unknown", "allowed", "blocked", "unknownFutureValue"], var.userless_enrollment_status)
    error_message = "userless_enrollment_status must be one of the documented enum values."
  }
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
