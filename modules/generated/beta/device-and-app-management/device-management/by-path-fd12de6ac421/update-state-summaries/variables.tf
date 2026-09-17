variable "mac_os_software_update_account_summary_id" {
  description = "The unique identifier of macOSSoftwareUpdateAccountSummary"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.mac_os_software_update_account_summary_id)) > 0
    error_message = "mac_os_software_update_account_summary_id must not be empty."
  }
}

variable "mac_os_software_update_category_summary_id" {
  description = "The unique identifier of macOSSoftwareUpdateCategorySummary"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.mac_os_software_update_category_summary_id)) > 0
    error_message = "mac_os_software_update_category_summary_id must not be empty."
  }
}

variable "display_name" {
  description = "Human readable name of the software update"
  type        = string
  default     = null
}

variable "last_updated_date_time" {
  description = "Last date time the report for this device and product key was updated."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.macOSSoftwareUpdateStateSummary"
  nullable    = false
}

variable "product_key" {
  description = "Product key of the software update."
  type        = string
  default     = null
}

variable "state" {
  description = "MacOS Software Update State"
  type        = string
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["success", "downloading", "downloaded", "installing", "idle", "available", "scheduled", "downloadFailed", "downloadInsufficientSpace", "downloadInsufficientPower", "downloadInsufficientNetwork", "installInsufficientSpace", "installInsufficientPower", "installFailed", "commandFailed"], var.state)
    error_message = "state must be one of the documented enum values."
  }
}

variable "update_category" {
  description = "MacOS Software Update Category"
  type        = string
  default     = null

  validation {
    condition     = var.update_category == null ? true : contains(["critical", "configurationDataFile", "firmware", "other"], var.update_category)
    error_message = "update_category must be one of the documented enum values."
  }
}

variable "update_version" {
  description = "Version of the software update"
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
