variable "expirationDateTime" {
  description = "Time that the exported report expires."
  type        = string
  default     = null
}

variable "filter" {
  description = "Filters applied on the report. The maximum length allowed for this property is 2000 characters."
  type        = string
  default     = null
}

variable "format" {
  description = "Possible values for the file format of a report to be exported."
  type        = string
  default     = null

  validation {
    condition     = var.format == null ? true : contains(["csv", "pdf", "json"], var.format)
    error_message = "format must be one of the documented enum values."
  }
}

variable "localizationType" {
  description = "Configures how the requested export job is localized."
  type        = string
  default     = null

  validation {
    condition     = var.localizationType == null ? true : contains(["localizedValuesAsAdditionalColumn", "replaceLocalizableValues"], var.localizationType)
    error_message = "localizationType must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagementExportJob"
  nullable    = false
}

variable "reportName" {
  description = "Name of the report. The maximum length allowed for this property is 2000 characters."
  type        = string
  default     = null
}

variable "requestDateTime" {
  description = "Time that the exported report was requested."
  type        = string
  default     = null
}

variable "select" {
  description = "Columns selected from the report. The maximum number of allowed columns names is 256. The maximum length allowed for each column name in this property is 1000 characters."
  type        = list(string)
  default     = null
}

variable "snapshotId" {
  description = "A snapshot is an identifiable subset of the dataset represented by the ReportName. A sessionId or CachedReportConfiguration id can be used here. If a sessionId is specified, Filter, Select, and OrderBy are applied to the data represented by the sessionId. Filter, Select, and OrderBy cannot be specified together with a CachedReportConfiguration id. The maximum length allowed for this property is 128 characters."
  type        = string
  default     = null
}

variable "status" {
  description = "Possible statuses associated with a generated report."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["unknown", "notStarted", "inProgress", "completed", "failed"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "url" {
  description = "Temporary location of the exported report."
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
