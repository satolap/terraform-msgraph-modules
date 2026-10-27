variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  nullable    = false

  validation {
    condition     = var.odata_type == null ? true : contains(["#microsoft.graph.androidCompliancePolicy", "#microsoft.graph.androidWorkProfileCompliancePolicy", "#microsoft.graph.iosCompliancePolicy", "#microsoft.graph.macOSCompliancePolicy", "#microsoft.graph.windows10CompliancePolicy", "#microsoft.graph.windows10MobileCompliancePolicy", "#microsoft.graph.windows81CompliancePolicy", "#microsoft.graph.windowsPhone81CompliancePolicy"], var.odata_type)
    error_message = "odata_type must name a concrete Graph type."
  }
}

variable "assignments" {
  description = "The collection of assignments for this compliance policy."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.deviceCompliancePolicyAssignment")
    target     = optional(any)
  }))
  default = null
}

variable "created_date_time" {
  description = "DateTime the object was created."
  type        = string
  default     = null
}

variable "description" {
  description = "Admin provided description of the Device Configuration."
  type        = string
  default     = null
}

variable "device_setting_state_summaries" {
  description = "Compliance Setting State Device Summary"
  type = list(object({
    odata_type               = optional(string, "#microsoft.graph.settingStateDeviceSummary")
    compliantDeviceCount     = optional(number)
    conflictDeviceCount      = optional(number)
    errorDeviceCount         = optional(number)
    instancePath             = optional(string)
    nonCompliantDeviceCount  = optional(number)
    notApplicableDeviceCount = optional(number)
    remediatedDeviceCount    = optional(number)
    settingName              = optional(string)
    unknownDeviceCount       = optional(number)
  }))
  default = null
}

variable "device_status_overview" {
  description = "Device compliance devices status overview"
  type        = any
  default     = null
}

variable "device_statuses" {
  description = "List of DeviceComplianceDeviceStatus."
  type = list(object({
    odata_type                              = optional(string, "#microsoft.graph.deviceComplianceDeviceStatus")
    complianceGracePeriodExpirationDateTime = optional(string)
    deviceDisplayName                       = optional(string)
    deviceModel                             = optional(string)
    lastReportedDateTime                    = optional(string)
    status                                  = optional(string)
    userName                                = optional(string)
    userPrincipalName                       = optional(string)
  }))
  default = null

  validation {
    condition     = (var.device_statuses == null ? true : alltrue([alltrue([for input0 in var.device_statuses : (input0 == null ? true : alltrue([(input0["status"] == null ? true : alltrue([(input0["status"] == null ? true : contains(["unknown", "notApplicable", "compliant", "remediated", "nonCompliant", "error", "conflict", "notAssigned"], input0["status"]))]))]))])]))
    error_message = "device_statuses: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "display_name" {
  description = "Admin provided name of the device configuration."
  type        = string
  default     = null
}

variable "graph_version" {
  description = "Version of the device configuration."
  type        = number
  default     = null
}

variable "last_modified_date_time" {
  description = "DateTime the object was last modified."
  type        = string
  default     = null
}

variable "scheduled_actions_for_rule" {
  description = "The list of scheduled action per rule for this compliance policy. This is a required property when creating any individual per-platform compliance policies."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.deviceComplianceScheduledActionForRule")
    ruleName   = optional(string)
    scheduledActionConfigurations = optional(list(object({
      odata_type                = optional(string, "#microsoft.graph.deviceComplianceActionItem")
      actionType                = optional(string)
      gracePeriodHours          = optional(number)
      notificationMessageCCList = optional(list(string))
      notificationTemplateId    = optional(string)
    })))
  }))
  default = null

  validation {
    condition     = (var.scheduled_actions_for_rule == null ? true : alltrue([alltrue([for input0 in var.scheduled_actions_for_rule : (input0 == null ? true : alltrue([(input0["scheduledActionConfigurations"] == null ? true : alltrue([alltrue([for input2 in input0["scheduledActionConfigurations"] : (input2 == null ? true : alltrue([(input2["actionType"] == null ? true : alltrue([(input2["actionType"] == null ? true : contains(["noAction", "notification", "block", "retire", "wipe", "removeResourceAccessProfiles", "pushNotification"], input2["actionType"]))]))]))])]))]))])]))
    error_message = "scheduled_actions_for_rule: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "user_status_overview" {
  description = "Device compliance users status overview"
  type        = any
  default     = null
}

variable "user_statuses" {
  description = "List of DeviceComplianceUserStatus."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.deviceComplianceUserStatus")
    devicesCount         = optional(number)
    lastReportedDateTime = optional(string)
    status               = optional(string)
    userDisplayName      = optional(string)
    userPrincipalName    = optional(string)
  }))
  default = null

  validation {
    condition     = (var.user_statuses == null ? true : alltrue([alltrue([for input0 in var.user_statuses : (input0 == null ? true : alltrue([(input0["status"] == null ? true : alltrue([(input0["status"] == null ? true : contains(["unknown", "notApplicable", "compliant", "remediated", "nonCompliant", "error", "conflict", "notAssigned"], input0["status"]))]))]))])]))
    error_message = "user_statuses: nested required attributes must be non-null and enum values must be supported input members."
  }
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
