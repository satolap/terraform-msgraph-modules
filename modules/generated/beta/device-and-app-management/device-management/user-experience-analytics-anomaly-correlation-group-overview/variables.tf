variable "anomaly_correlation_group_count" {
  description = "Indicates the number of correlation groups in the anomaly. Valid values -2147483648 to 2147483647"
  type        = number
  default     = null
}

variable "anomaly_id" {
  description = "The unique identifier of the anomaly. Anomaly details such as name and type can be found in the UserExperienceAnalyticsAnomalySeverityOverview entity."
  type        = string
  default     = null
}

variable "correlation_group_anomalous_device_count" {
  description = "Indicates the total number of devices affected by the anomaly in the correlation group. Valid values -2147483648 to 2147483647"
  type        = number
  default     = null
}

variable "correlation_group_at_risk_device_count" {
  description = "Indicates the total number of devices at risk in the correlation group. Valid values -2147483648 to 2147483647"
  type        = number
  default     = null
}

variable "correlation_group_device_count" {
  description = "Indicates the total number of devices in a correlation group. Valid values -2147483648 to 2147483647"
  type        = number
  default     = null
}

variable "correlation_group_features" {
  description = "Describes the features of a device that are shared between all devices in a correlation group."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.userExperienceAnalyticsAnomalyCorrelationGroupFeature")
    deviceFeatureType = optional(string)
    values            = optional(list(string))
  }))
  default = null
}

variable "correlation_group_id" {
  description = "The unique identifier for the correlation group which will uniquely identify one of the correlation group within an anomaly. The correlation Id can be mapped to the correlation group name by concatinating the correlation group features. Example of correlation group name which is the indicative of concatenated features names are  for names, Contoso manufacture 4.4.1 and Windows 11.22621.1485."
  type        = string
  default     = null
}

variable "correlation_group_prevalence" {
  description = "Indicates the level of prevalence of the correlation group features in the anomaly. Possible values are: high, medium or low"
  type        = string
  default     = null

  validation {
    condition     = var.correlation_group_prevalence == null ? true : contains(["high", "medium", "low", "unknownFutureValue"], var.correlation_group_prevalence)
    error_message = "correlation_group_prevalence must be one of the documented enum values."
  }
}

variable "correlation_group_prevalence_percentage" {
  description = "The percentage of the devices in the correlation group that are anomalous. Valid values -1.79769313486232E+308 to 1.79769313486232E+308"
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.userExperienceAnalyticsAnomalyCorrelationGroupOverview"
  nullable    = false
}

variable "total_device_count" {
  description = "Indicates the total number of devices in the tenant. Valid values -2147483648 to 2147483647"
  type        = number
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
