variable "assignment_filter_management_type" {
  description = "Supported filter management types whether its devices or apps."
  type        = string
  default     = null

  validation {
    condition     = var.assignment_filter_management_type == null ? true : contains(["devices", "apps", "unknownFutureValue"], var.assignment_filter_management_type)
    error_message = "assignment_filter_management_type must be one of the documented enum values."
  }
}

variable "created_date_time" {
  description = "The creation time of the assignment filter. The value cannot be modified and is automatically populated during new assignment filter process. The timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 would look like this: '2014-01-01T00:00:00Z'."
  type        = string
  default     = null
}

variable "description" {
  description = "Optional description of the Assignment Filter."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The name of the Assignment Filter."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "Last modified time of the Assignment Filter. The timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 would look like this: '2014-01-01T00:00:00Z'"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceAndAppManagementAssignmentFilter"
  nullable    = false
}

variable "payloads" {
  description = "Indicates associated assignments for a specific filter."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.payloadByFilter")
    assignmentFilterType = optional(string)
    groupId              = optional(string)
    payloadId            = optional(string)
    payloadType          = optional(string)
  }))
  default = null
}

variable "platform" {
  description = "Supported platform types."
  type        = string
  default     = null

  validation {
    condition     = var.platform == null ? true : contains(["android", "androidForWork", "iOS", "macOS", "windowsPhone81", "windows81AndLater", "windows10AndLater", "androidWorkProfile", "unknown", "androidAOSP", "androidMobileApplicationManagement", "iOSMobileApplicationManagement", "unknownFutureValue", "windowsMobileApplicationManagement"], var.platform)
    error_message = "platform must be one of the documented enum values."
  }
}

variable "role_scope_tags" {
  description = "Indicates role scope tags assigned for the assignment filter."
  type        = list(string)
  default     = null
}

variable "rule" {
  description = "Rule definition of the assignment filter."
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
