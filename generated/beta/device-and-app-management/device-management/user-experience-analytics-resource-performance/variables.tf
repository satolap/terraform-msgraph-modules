variable "average_spike_time_score" {
  description = "AverageSpikeTimeScore of a device or a model type. Valid values 0 to 100"
  type        = number
  default     = null
}

variable "cpu_clock_speed_in_m_hz" {
  description = "The clock speed of the processor, in MHz. Valid values 0 to 1000000"
  type        = any
  default     = null
}

variable "cpu_display_name" {
  description = "The name of the processor on the device, For example, 11th Gen Intel(R) Core(TM) i7."
  type        = string
  default     = null
}

variable "cpu_spike_time_percentage" {
  description = "CPU spike time in percentage. Valid values 0 to 100"
  type        = any
  default     = null
}

variable "cpu_spike_time_percentage_threshold" {
  description = "Threshold of cpuSpikeTimeScore. Valid values 0 to 100"
  type        = any
  default     = null
}

variable "cpu_spike_time_score" {
  description = "The user experience analytics device CPU spike time score. Valid values 0 to 100"
  type        = number
  default     = null
}

variable "device_count" {
  description = "User experience analytics summarized device count."
  type        = number
  default     = null
}

variable "device_id" {
  description = "The id of the device."
  type        = string
  default     = null
}

variable "device_name" {
  description = "The name of the device."
  type        = string
  default     = null
}

variable "device_resource_performance_score" {
  description = "Resource performance score of a specific device. Valid values 0 to 100"
  type        = number
  default     = null
}

variable "disk_type" {
  description = "Microsoft Graph diskType property."
  type        = string
  default     = null

  validation {
    condition     = var.disk_type == null ? true : contains(["unknown", "hdd", "ssd", "unknownFutureValue"], var.disk_type)
    error_message = "disk_type must be one of the documented enum values."
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

variable "machine_type" {
  description = "Indicates if machine is physical or virtual. Possible values are: physical or virtual"
  type        = string
  default     = null

  validation {
    condition     = var.machine_type == null ? true : contains(["unknown", "physical", "virtual", "unknownFutureValue"], var.machine_type)
    error_message = "machine_type must be one of the documented enum values."
  }
}

variable "manufacturer" {
  description = "The user experience analytics device manufacturer."
  type        = string
  default     = null
}

variable "model" {
  description = "The user experience analytics device model."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.userExperienceAnalyticsResourcePerformance"
  nullable    = false
}

variable "ram_spike_time_percentage" {
  description = "RAM spike time in percentage. Valid values 0 to 100"
  type        = any
  default     = null
}

variable "ram_spike_time_percentage_threshold" {
  description = "Threshold of ramSpikeTimeScore. Valid values 0 to 100"
  type        = any
  default     = null
}

variable "ram_spike_time_score" {
  description = "The user experience analytics device RAM spike time score. Valid values 0 to 100"
  type        = number
  default     = null
}

variable "total_processor_core_count" {
  description = "The count of cores of the processor of device. Valid values 0 to 512"
  type        = number
  default     = null
}

variable "total_ram_in_mb" {
  description = "The total RAM of the device, in MB. Valid values 0 to 1000000"
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
