variable "user_experience_analytics_work_from_anywhere_metric_id" {
  description = "The unique identifier of userExperienceAnalyticsWorkFromAnywhereMetric"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_experience_analytics_work_from_anywhere_metric_id)) > 0
    error_message = "user_experience_analytics_work_from_anywhere_metric_id must not be empty."
  }
}

variable "health_status" {
  description = "Microsoft Graph healthStatus property."
  type        = string
  default     = null

  validation {
    condition     = var.health_status == null ? true : contains(["unknown", "insufficientData", "needsAttention", "meetingGoals", "unknownFutureValue"], var.health_status)
    error_message = "health_status must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.userExperienceAnalyticsWorkFromAnywhereDevice"
  nullable    = false
}

variable "upgrade_eligibility" {
  description = "Work From Anywhere windows device upgrade eligibility status."
  type        = string
  default     = null

  validation {
    condition     = var.upgrade_eligibility == null ? true : contains(["upgraded", "unknown", "notCapable", "capable", "unknownFutureValue"], var.upgrade_eligibility)
    error_message = "upgrade_eligibility must be one of the documented enum values."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["autoPilotProfileAssigned", "autoPilotRegistered", "azureAdDeviceId", "azureAdJoinType", "azureAdRegistered", "cloudIdentityScore", "cloudManagementScore", "cloudProvisioningScore", "compliancePolicySetToIntune", "deviceId", "deviceName", "id", "isCloudManagedGatewayEnabled", "managedBy", "manufacturer", "model", "osCheckFailed", "osDescription", "osVersion", "otherWorkloadsSetToIntune", "ownership", "processor64BitCheckFailed", "processorCoreCountCheckFailed", "processorFamilyCheckFailed", "processorSpeedCheckFailed", "ramCheckFailed", "secureBootCheckFailed", "serialNumber", "storageCheckFailed", "tenantAttached", "tpmCheckFailed", "windowsScore", "workFromAnywhereScore"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
