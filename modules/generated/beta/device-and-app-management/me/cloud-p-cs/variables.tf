variable "aad_device_id" {
  description = "The Microsoft Entra device ID of the Cloud PC."
  type        = string
  default     = null
}

variable "connectivity_result" {
  description = "The connectivity health check result of a Cloud PC, including the updated timestamp and whether the Cloud PC can be connected."
  type        = any
  default     = null
}

variable "disk_encryption_state" {
  description = "The disk encryption applied to the Cloud PC. Possible values: notAvailable, notEncrypted, encryptedUsingPlatformManagedKey, encryptedUsingCustomerManagedKey, and unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.disk_encryption_state == null ? true : contains(["notAvailable", "notEncrypted", "encryptedUsingPlatformManagedKey", "encryptedUsingCustomerManagedKey", "unknownFutureValue"], var.disk_encryption_state)
    error_message = "disk_encryption_state must be one of the documented enum values."
  }
}

variable "display_name" {
  description = "The display name of the Cloud PC."
  type        = string
  default     = null
}

variable "grace_period_end_date_time" {
  description = "The date and time when the grace period ends and reprovisioning or deprovisioning happens. Required only if the status is inGracePeriod. The timestamp is shown in ISO 8601 format and Coordinated Universal Time (UTC). For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "image_display_name" {
  description = "Name of the OS image that's on the Cloud PC."
  type        = string
  default     = null
}

variable "last_login_result" {
  description = "The last login result of the Cloud PC. For example, { 'time': '2014-01-01T00:00:00Z'}."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "The last modified date and time of the Cloud PC. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014, is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "last_remote_action_result" {
  description = "The last remote action result of the enterprise Cloud PCs. The supported remote actions are: Reboot, Rename, Reprovision, Restore, Troubleshoot."
  type        = any
  default     = null
}

variable "managed_device_id" {
  description = "The Intune device ID of the Cloud PC."
  type        = string
  default     = null
}

variable "managed_device_name" {
  description = "The Intune device name of the Cloud PC."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.cloudPC"
  nullable    = false
}

variable "on_premises_connection_name" {
  description = "The Azure network connection that is applied during the provisioning of Cloud PCs."
  type        = string
  default     = null
}

variable "os_version" {
  description = "The version of the operating system (OS) to provision on Cloud PCs. The possible values are: windows10, windows11, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.os_version == null ? true : contains(["windows10", "windows11", "unknownFutureValue"], var.os_version)
    error_message = "os_version must be one of the documented enum values."
  }
}

variable "partner_agent_install_results" {
  description = "The results of every partner agent's installation status on Cloud PC."
  type = list(object({
    odata_type          = optional(string, "#microsoft.graph.cloudPcPartnerAgentInstallResult")
    errorMessage        = optional(string)
    isThirdPartyPartner = optional(bool)
    retriable           = optional(bool)
  }))
  default = null
}

variable "power_state" {
  description = "The power state of a Cloud PC. The possible values are: running, poweredOff, unknown. This property only supports shift work Cloud PCs."
  type        = any
  default     = null

  validation {
    condition     = var.power_state == null ? true : contains(["running", "poweredOff", "unknownFutureValue"], var.power_state)
    error_message = "power_state must be one of the documented enum values."
  }
}

variable "provisioned_date_time" {
  description = "The latest provisioned date and time, automatically generated and assigned during the initial provisioning or any subsequent reprovisioning of the Cloud PC. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "provisioning_policy_id" {
  description = "The provisioning policy ID of the Cloud PC."
  type        = string
  default     = null
}

variable "provisioning_policy_name" {
  description = "The provisioning policy that is applied during the provisioning of Cloud PCs."
  type        = string
  default     = null
}

variable "provisioning_type" {
  description = "The type of licenses to be used when provisioning Cloud PCs using this policy. The possible values are: dedicated, shared, unknownFutureValue, sharedByUser, sharedByEntraGroup, reserve. Use the Prefer: include-unknown-enum-members request header to get the following values from this evolvable enum: sharedByUser, sharedByEntraGroup, reserve. The default value is dedicated. The shared member is deprecated and will stop returning on April 30, 2027; going forward, use the sharedByUser member."
  type        = any
  default     = null

  validation {
    condition     = var.provisioning_type == null ? true : contains(["dedicated", "shared", "unknownFutureValue", "sharedByUser", "sharedByEntraGroup", "reserve"], var.provisioning_type)
    error_message = "provisioning_type must be one of the documented enum values."
  }
}

variable "service_plan_id" {
  description = "The service plan ID of the Cloud PC."
  type        = string
  default     = null
}

variable "service_plan_name" {
  description = "The service plan name of the Cloud PC."
  type        = string
  default     = null
}

variable "service_plan_type" {
  description = "The service plan type of the Cloud PC."
  type        = any
  default     = null

  validation {
    condition     = var.service_plan_type == null ? true : contains(["enterprise", "business", "unknownFutureValue"], var.service_plan_type)
    error_message = "service_plan_type must be one of the documented enum values."
  }
}

variable "shared_device_detail" {
  description = "Indicates the Cloud PC device details associated with the frontline shared service plan, including the user's UPN and the session start date and time."
  type        = any
  default     = null
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["notProvisioned", "provisioning", "provisioned", "inGracePeriod", "deprovisioning", "failed", "provisionedWithWarnings", "resizing", "restoring", "pendingProvision", "unknownFutureValue", "movingRegion", "resizePendingLicense", "updatingSingleSignOn", "modifyingSingleSignOn", "refreshPolicyConfiguration", "preparing", "failoverInProgress", "failbackInProgress"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "status_detail" {
  description = "Indicates the detailed status associated with Cloud PC, including error/warning code, error/warning message, additionalInformation. For example, { 'code': 'internalServerError', 'message': 'There was an error during the Cloud PC upgrade. Please contact support.', 'additionalInformation': null }."
  type        = any
  default     = null
}

variable "status_details" {
  description = "The details of the Cloud PC status. For example, { 'code': 'internalServerError', 'message': 'There was an error during the Cloud PC upgrade. Please contact support.', 'additionalInformation': null }. This property is deprecated and will no longer be supported effective August 31, 2024. Use statusDetail instead."
  type        = any
  default     = null
}

variable "user_account_type" {
  description = "The account type of the user on provisioned Cloud PCs. The possible values are: standardUser, administrator, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.user_account_type == null ? true : contains(["standardUser", "administrator", "unknownFutureValue"], var.user_account_type)
    error_message = "user_account_type must be one of the documented enum values."
  }
}

variable "user_experience_type" {
  description = "Specifies the type of cloud object the end user can access. The possible values are: cloudPc, cloudApp, unknownFutureValue. When set to cloudPc, it indicates that the end user can access the entire desktop. When set to cloudApp, it indicates that the end user can only access cloud apps published under the associated provisioning policy. Since the cloud app experience also creates Cloud PC devices that appear in the Cloud PC device list, this property helps differentiate them. The default value is cloudPc. This property is defined in the provisioning policy."
  type        = any
  default     = null

  validation {
    condition     = var.user_experience_type == null ? true : contains(["cloudPc", "cloudApp", "unknownFutureValue"], var.user_experience_type)
    error_message = "user_experience_type must be one of the documented enum values."
  }
}

variable "user_principal_name" {
  description = "The user principal name (UPN) of the user assigned to the Cloud PC."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["allotmentDisplayName", "connectionSetting", "connectionSettings", "deviceRegionName", "disasterRecoveryCapability", "frontlineCloudPcAvailability", "groupDetail", "id", "isDisasterRecoveryActive", "lastLogoffDateTime", "productType", "provisioningConfiguration", "scopeIds", "userDetail"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
