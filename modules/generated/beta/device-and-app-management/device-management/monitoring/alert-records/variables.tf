variable "alert_impact" {
  description = "The impact of the alert event. Consists of a list of key-value pair and a number followed by the aggregation type. For example, 6 affectedCloudPcCount means that 6 Cloud PCs are affected. 12 affectedCloudPcPercentage means 12% of Cloud PCs are affected. The list of key-value pair indicates the details of the alert impact."
  type        = any
  default     = null
}

variable "alert_rule_id" {
  description = "The corresponding ID of the alert rule."
  type        = string
  default     = null
}

variable "alert_rule_template" {
  description = "The rule template of the alert event. The possible values are: cloudPcProvisionScenario, cloudPcImageUploadScenario, cloudPcOnPremiseNetworkConnectionCheckScenario, unknownFutureValue, cloudPcInGracePeriodScenario, cloudPcFrontlineInsufficientLicensesScenario, cloudPcInaccessibleScenario, cloudPcFrontlineConcurrencyScenario, cloudPcUserSettingsPersistenceScenario, cloudPcDeprovisionFailedScenario. Use the Prefer: include-unknown-enum-members request header to get the following values from this evolvable enum: cloudPcInGracePeriodScenario, cloudPcFrontlineInsufficientLicensesScenario, cloudPcInaccessibleScenario, cloudPcFrontlineConcurrencyScenario, cloudPcUserSettingsPersistenceScenario, cloudPcDeprovisionFailedScenario."
  type        = any
  default     = null

  validation {
    condition     = var.alert_rule_template == null ? true : contains(["cloudPcProvisionScenario", "cloudPcImageUploadScenario", "cloudPcOnPremiseNetworkConnectionCheckScenario", "unknownFutureValue", "cloudPcInGracePeriodScenario", "cloudPcFrontlineInsufficientLicensesScenario", "cloudPcInaccessibleScenario", "cloudPcFrontlineConcurrencyScenario", "cloudPcUserSettingsPersistenceScenario", "cloudPcDeprovisionFailedScenario"], var.alert_rule_template)
    error_message = "alert_rule_template must be one of the documented enum values."
  }
}

variable "detected_date_time" {
  description = "The date and time when the alert event was detected. The Timestamp type represents date and time information using ISO 8601 format. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the alert record."
  type        = string
  default     = null
}

variable "last_updated_date_time" {
  description = "The date and time when the alert record was last updated. The Timestamp type represents date and time information using ISO 8601 format. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagement.alertRecord"
  nullable    = false
}

variable "resolved_date_time" {
  description = "The date and time when the alert event was resolved. The Timestamp type represents date and time information using ISO 8601 format. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "severity" {
  description = "The severity of the alert event. The possible values are: unknown, informational, warning, critical, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.severity == null ? true : contains(["unknown", "informational", "warning", "critical", "unknownFutureValue"], var.severity)
    error_message = "severity must be one of the documented enum values."
  }
}

variable "status" {
  description = "The status of the alert record. The possible values are: active, resolved, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["active", "resolved", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
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
