variable "anomaly_first_occurrence_date_time" {
  description = "Indicates the first occurrence date and time for the anomaly."
  type        = string
  default     = null
}

variable "anomaly_id" {
  description = "The unique identifier of the anomaly."
  type        = string
  default     = null
}

variable "anomaly_latest_occurrence_date_time" {
  description = "Indicates the latest occurrence date and time for the anomaly."
  type        = string
  default     = null
}

variable "anomaly_name" {
  description = "The name of the anomaly."
  type        = string
  default     = null
}

variable "anomaly_type" {
  description = "Indicates the category of the anomaly. Eg: anomaly type can be device, application, stop error, driver or other."
  type        = string
  default     = null

  validation {
    condition     = var.anomaly_type == null ? true : contains(["device", "application", "stopError", "driver", "other", "unknownFutureValue"], var.anomaly_type)
    error_message = "anomaly_type must be one of the documented enum values."
  }
}

variable "asset_name" {
  description = "The name of the application or module that caused the anomaly."
  type        = string
  default     = null
}

variable "asset_publisher" {
  description = "The publisher of the application or module that caused the anomaly."
  type        = string
  default     = null
}

variable "asset_version" {
  description = "The version of the application or module that caused the anomaly."
  type        = string
  default     = null
}

variable "detection_model_id" {
  description = "The unique identifier of the anomaly detection model."
  type        = string
  default     = null
}

variable "device_impacted_count" {
  description = "The number of devices impacted by the anomaly. Valid values -2147483648 to 2147483647"
  type        = number
  default     = null
}

variable "issue_id" {
  description = "The unique identifier of the anomaly detection model."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.userExperienceAnalyticsAnomaly"
  nullable    = false
}

variable "severity" {
  description = "Indicates the severity of the anomaly. Eg: anomaly severity can be high, medium, low, informational or other."
  type        = string
  default     = null

  validation {
    condition     = var.severity == null ? true : contains(["high", "medium", "low", "informational", "other", "unknownFutureValue"], var.severity)
    error_message = "severity must be one of the documented enum values."
  }
}

variable "state" {
  description = "Indicates the state of the anomaly. Eg: anomaly severity can be new, active, disabled, removed or other."
  type        = string
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["new", "active", "disabled", "removed", "other", "unknownFutureValue"], var.state)
    error_message = "state must be one of the documented enum values."
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
