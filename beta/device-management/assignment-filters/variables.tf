variable "assignment_filter_management_type" {
  description = "Supported filter management types whether its devices or apps."
  type        = string
  default     = null

  validation {
    condition     = var.assignment_filter_management_type == null ? true : contains(["devices", "apps"], var.assignment_filter_management_type)
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

  validation {
    condition     = (var.payloads == null ? true : alltrue([alltrue([for input0 in var.payloads : (input0 == null ? true : alltrue([(input0["assignmentFilterType"] == null ? true : alltrue([(input0["assignmentFilterType"] == null ? true : contains(["none", "include", "exclude"], input0["assignmentFilterType"]))])), (input0["payloadType"] == null ? true : alltrue([(input0["payloadType"] == null ? true : contains(["unknown", "deviceConfigurationAndCompliance", "application", "androidEnterpriseApp", "enrollmentConfiguration", "groupPolicyConfiguration", "zeroTouchDeploymentDeviceConfigProfile", "androidEnterpriseConfiguration", "deviceFirmwareConfigurationInterfacePolicy", "resourceAccessPolicy", "win32app", "deviceManagmentConfigurationAndCompliancePolicy"], input0["payloadType"]))]))]))])]))
    error_message = "payloads: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "platform" {
  description = "Supported platform types."
  type        = string
  default     = null

  validation {
    condition     = var.platform == null ? true : contains(["android", "androidForWork", "iOS", "macOS", "windowsPhone81", "windows81AndLater", "windows10AndLater", "androidWorkProfile", "unknown", "androidAOSP", "androidMobileApplicationManagement", "iOSMobileApplicationManagement"], var.platform)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["evaluationMode", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
