variable "mac_os_software_update_account_summary_id" {
  description = "The unique identifier of macOSSoftwareUpdateAccountSummary"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.mac_os_software_update_account_summary_id)) > 0
    error_message = "mac_os_software_update_account_summary_id must not be empty."
  }
}

variable "device_id" {
  description = "The device ID."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The name of the report"
  type        = string
  default     = null
}

variable "failed_update_count" {
  description = "Number of failed updates on the device"
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
  default     = "#microsoft.graph.macOSSoftwareUpdateCategorySummary"
  nullable    = false
}

variable "successful_update_count" {
  description = "Number of successful updates on the device"
  type        = number
  default     = null
}

variable "total_update_count" {
  description = "Number of total updates on the device"
  type        = number
  default     = null
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

variable "update_state_summaries" {
  description = "Summary of the update states."
  type = list(object({
    odata_type          = optional(string, "#microsoft.graph.macOSSoftwareUpdateStateSummary")
    displayName         = optional(string)
    lastUpdatedDateTime = optional(string)
    productKey          = optional(string)
    state               = optional(string)
    updateCategory      = optional(string)
    updateVersion       = optional(string)
  }))
  default = null

  validation {
    condition     = (var.update_state_summaries == null ? true : alltrue([alltrue([for input0 in var.update_state_summaries : (input0 == null ? true : alltrue([(input0["state"] == null ? true : alltrue([(input0["state"] == null ? true : contains(["success", "downloading", "downloaded", "installing", "idle", "available", "scheduled", "downloadFailed", "downloadInsufficientSpace", "downloadInsufficientPower", "downloadInsufficientNetwork", "installInsufficientSpace", "installInsufficientPower", "installFailed", "commandFailed"], input0["state"]))])), (input0["updateCategory"] == null ? true : alltrue([(input0["updateCategory"] == null ? true : contains(["critical", "configurationDataFile", "firmware", "other"], input0["updateCategory"]))]))]))])]))
    error_message = "update_state_summaries: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "user_id" {
  description = "The user ID."
  type        = string
  default     = null
}

variable "timeouts" {
  description = "Optional timeouts of the msgraph_resource, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". create, update and delete must be at least \"15s\": after each request the provider waits for consistent reads within the same timeout. Every value defaults to null, which keeps the provider defaults and sends no timeouts block. The reviewed replication retries of this module, where it has any, count against these timeouts."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.read, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : (can(regex("^([0-9]+[hms])+$", t)) ? !can(regex("^(0+[hms])+$", t)) : false)
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : try(sum([for m in regexall("([0-9]+)([hms])", t) : tonumber(m[0]) * lookup({ h = 3600, m = 60, s = 1 }, m[1])]) >= 15, true)
    ])
    error_message = "timeouts.create, timeouts.update and timeouts.delete must be at least \"15s\"."
  }
}

variable "select_response" {
  description = "Opt in to a configured-property GET selection; this narrows response and can remove fields consumers use."
  type        = bool
  default     = false
  nullable    = false
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
