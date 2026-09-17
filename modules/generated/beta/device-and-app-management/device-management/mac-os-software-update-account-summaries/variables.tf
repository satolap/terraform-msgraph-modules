variable "category_summaries" {
  description = "Summary of the updates by category."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.macOSSoftwareUpdateCategorySummary")
    deviceId              = optional(string)
    displayName           = optional(string)
    failedUpdateCount     = optional(number)
    lastUpdatedDateTime   = optional(string)
    successfulUpdateCount = optional(number)
    totalUpdateCount      = optional(number)
    updateCategory        = optional(string)
    updateStateSummaries = optional(list(object({
      odata_type          = optional(string, "#microsoft.graph.macOSSoftwareUpdateStateSummary")
      displayName         = optional(string)
      lastUpdatedDateTime = optional(string)
      productKey          = optional(string)
      state               = optional(string)
      updateCategory      = optional(string)
      updateVersion       = optional(string)
    })))
    userId = optional(string)
  }))
  default = null
}

variable "device_id" {
  description = "The device ID."
  type        = string
  default     = null
}

variable "device_name" {
  description = "The device name."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The name of the report"
  type        = string
  default     = null
}

variable "failed_update_count" {
  description = "Number of failed updates on the device."
  type        = number
  default     = null
}

variable "last_updated_date_time" {
  description = "Last date time the report for this device was updated."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.macOSSoftwareUpdateAccountSummary"
  nullable    = false
}

variable "os_version" {
  description = "The OS version."
  type        = string
  default     = null
}

variable "successful_update_count" {
  description = "Number of successful updates on the device."
  type        = number
  default     = null
}

variable "total_update_count" {
  description = "Number of total updates on the device."
  type        = number
  default     = null
}

variable "user_id" {
  description = "The user ID."
  type        = string
  default     = null
}

variable "user_principal_name" {
  description = "The user principal name"
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
