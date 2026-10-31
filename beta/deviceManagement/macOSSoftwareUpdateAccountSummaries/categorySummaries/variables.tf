variable "macOSSoftwareUpdateAccountSummary-id" {
  description = "The unique identifier of macOSSoftwareUpdateAccountSummary"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.macOSSoftwareUpdateAccountSummary-id)) > 0
    error_message = "macOSSoftwareUpdateAccountSummary-id must not be empty."
  }
}

variable "deviceId" {
  description = "The device ID."
  type        = string
  default     = null
}

variable "displayName" {
  description = "The name of the report"
  type        = string
  default     = null
}

variable "failedUpdateCount" {
  description = "Number of failed updates on the device"
  type        = number
  default     = null
}

variable "lastUpdatedDateTime" {
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

variable "successfulUpdateCount" {
  description = "Number of successful updates on the device"
  type        = number
  default     = null
}

variable "totalUpdateCount" {
  description = "Number of total updates on the device"
  type        = number
  default     = null
}

variable "updateCategory" {
  description = "MacOS Software Update Category"
  type        = string
  default     = null

  validation {
    condition     = var.updateCategory == null ? true : contains(["critical", "configurationDataFile", "firmware", "other"], var.updateCategory)
    error_message = "updateCategory must be one of the documented enum values."
  }
}

variable "updateStateSummaries" {
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
    condition     = (var.updateStateSummaries == null ? true : alltrue([alltrue([for input0 in var.updateStateSummaries : (input0 == null ? true : alltrue([(input0["state"] == null ? true : alltrue([(input0["state"] == null ? true : contains(["success", "downloading", "downloaded", "installing", "idle", "available", "scheduled", "downloadFailed", "downloadInsufficientSpace", "downloadInsufficientPower", "downloadInsufficientNetwork", "installInsufficientSpace", "installInsufficientPower", "installFailed", "commandFailed"], input0["state"]))])), (input0["updateCategory"] == null ? true : alltrue([(input0["updateCategory"] == null ? true : contains(["critical", "configurationDataFile", "firmware", "other"], input0["updateCategory"]))]))]))])]))
    error_message = "updateStateSummaries: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "userId" {
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
