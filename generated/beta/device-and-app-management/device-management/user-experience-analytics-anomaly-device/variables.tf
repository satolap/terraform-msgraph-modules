variable "anomaly_id" {
  description = "The unique identifier of the anomaly."
  type        = string
  default     = null
}

variable "anomaly_on_device_first_occurrence_date_time" {
  description = "Indicates the first occurance date and time for the anomaly on the device."
  type        = string
  default     = null
}

variable "anomaly_on_device_latest_occurrence_date_time" {
  description = "Indicates the latest occurance date and time for the anomaly on the device."
  type        = string
  default     = null
}

variable "correlation_group_id" {
  description = "The unique identifier of the correlation group."
  type        = string
  default     = null
}

variable "device_id" {
  description = "The unique identifier of the device."
  type        = string
  default     = null
}

variable "device_manufacturer" {
  description = "The manufacturer name of the device."
  type        = string
  default     = null
}

variable "device_model" {
  description = "The model name of the device."
  type        = string
  default     = null
}

variable "device_name" {
  description = "The name of the device."
  type        = string
  default     = null
}

variable "device_status" {
  description = "Indicates the status of the device in the correlation group. Eg: Device status can be anomalous, affected, at risk."
  type        = string
  default     = null

  validation {
    condition     = var.device_status == null ? true : contains(["anomalous", "affected", "atRisk", "unknownFutureValue"], var.device_status)
    error_message = "device_status must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.userExperienceAnalyticsAnomalyDevice"
  nullable    = false
}

variable "os_name" {
  description = "The name of the OS installed on the device."
  type        = string
  default     = null
}

variable "os_version" {
  description = "The OS version installed on the device."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
