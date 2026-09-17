variable "deployment_settings" {
  description = "The Zebra FOTA deployment complex type that describes the settings required to create a FOTA deployment."
  type = object({
    odata_type                               = optional(string, "#microsoft.graph.zebraFotaDeploymentSettings")
    batteryRuleMinimumBatteryLevelPercentage = optional(number)
    batteryRuleRequireCharger                = optional(bool)
    deviceModel                              = optional(string)
    downloadRuleNetworkType                  = optional(string)
    downloadRuleStartDateTime                = optional(string)
    firmwareTargetArtifactDescription        = optional(string)
    firmwareTargetBoardSupportPackageVersion = optional(string)
    firmwareTargetOsVersion                  = optional(string)
    firmwareTargetPatch                      = optional(string)
    installRuleStartDateTime                 = optional(string)
    installRuleWindowEndTime                 = optional(string)
    installRuleWindowStartTime               = optional(string)
    scheduleDurationInDays                   = optional(number)
    scheduleMode                             = optional(string)
    timeZoneOffsetInMinutes                  = optional(number)
    updateType                               = optional(string)
  })
  default = null
}

variable "deployment_status" {
  description = "Represents the deployment status from Zebra. The status is a high level status of the deployment as opposed being a detailed status per device."
  type        = any
  default     = null
}

variable "description" {
  description = "A human readable description of the deployment."
  type        = string
  default     = null
}

variable "display_name" {
  description = "A human readable name of the deployment."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.zebraFotaDeployment"
  nullable    = false
}

variable "role_scope_tag_ids" {
  description = "List of Scope Tags for this Entity instance"
  type        = list(string)
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
