variable "alert_rule_template" {
  description = "The rule template of the alert event. The possible values are: cloudPcProvisionScenario, cloudPcImageUploadScenario, cloudPcOnPremiseNetworkConnectionCheckScenario, unknownFutureValue, cloudPcInGracePeriodScenario, cloudPcFrontlineInsufficientLicensesScenario, cloudPcInaccessibleScenario, cloudPcFrontlineConcurrencyScenario, cloudPcUserSettingsPersistenceScenario, cloudPcDeprovisionFailedScenario.  Use the Prefer: include-unknown-enum-members request header to get the following values from this evolvable enum: cloudPcInGracePeriodScenario, cloudPcFrontlineInsufficientLicensesScenario, cloudPcInaccessibleScenario, cloudPcFrontlineConcurrencyScenario, cloudPcUserSettingsPersistenceScenario, cloudPcDeprovisionFailedScenario."
  type        = any
  default     = null

  validation {
    condition     = var.alert_rule_template == null ? true : contains(["cloudPcProvisionScenario", "cloudPcImageUploadScenario", "cloudPcOnPremiseNetworkConnectionCheckScenario", "unknownFutureValue", "cloudPcInGracePeriodScenario", "cloudPcFrontlineInsufficientLicensesScenario", "cloudPcInaccessibleScenario", "cloudPcFrontlineConcurrencyScenario", "cloudPcUserSettingsPersistenceScenario", "cloudPcDeprovisionFailedScenario"], var.alert_rule_template)
    error_message = "alert_rule_template must be one of the documented enum values."
  }
}

variable "conditions" {
  description = "The conditions that determine when to send alerts. For example, you can configure a condition to send an alert when provisioning fails for six or more Cloud PCs."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.deviceManagement.ruleCondition")
    aggregation       = optional(any)
    conditionCategory = optional(any)
    operator          = optional(any)
    relationshipType  = optional(any)
    thresholdValue    = optional(string)
  }))
  default = null
}

variable "description" {
  description = "The rule description."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the rule."
  type        = string
  default     = null
}

variable "enabled" {
  description = "The status of the rule that indicates whether the rule is enabled or disabled. If true, the rule is enabled; otherwise, the rule is disabled."
  type        = bool
  default     = null
}

variable "is_system_rule" {
  description = "Indicates whether the rule is a system rule. If true, the rule is a system rule; otherwise, the rule is a custom-defined rule and can be edited. System rules are built in and only a few properties can be edited."
  type        = bool
  default     = null
}

variable "notification_channels" {
  description = "The notification channels of the rule selected by the user."
  type = list(object({
    odata_type              = optional(string, "#microsoft.graph.deviceManagement.notificationChannel")
    notificationChannelType = optional(any)
    notificationReceivers = optional(list(object({
      odata_type         = optional(string, "#microsoft.graph.deviceManagement.notificationReceiver")
      contactInformation = optional(string)
      locale             = optional(string)
    })))
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagement.alertRule"
  nullable    = false
}

variable "severity" {
  description = "The severity of the rule. The possible values are: unknown, informational, warning, critical, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.severity == null ? true : contains(["unknown", "informational", "warning", "critical", "unknownFutureValue"], var.severity)
    error_message = "severity must be one of the documented enum values."
  }
}

variable "threshold" {
  description = "The conditions that determine when to send alerts. For example, you can configure a condition to send an alert when provisioning fails for six or more Cloud PCs. This property is deprecated. Use conditions instead."
  type        = any
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
