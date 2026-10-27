variable "device_compliance_policy_id" {
  description = "The unique identifier of deviceCompliancePolicy"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.device_compliance_policy_id)) > 0
    error_message = "device_compliance_policy_id must not be empty."
  }
}

variable "compliant_device_count" {
  description = "Device Compliant count for the setting"
  type        = number
  default     = null
}

variable "conflict_device_count" {
  description = "Device conflict error count for the setting"
  type        = number
  default     = null
}

variable "error_device_count" {
  description = "Device error count for the setting"
  type        = number
  default     = null
}

variable "instance_path" {
  description = "Name of the InstancePath for the setting"
  type        = string
  default     = null
}

variable "non_compliant_device_count" {
  description = "Device NonCompliant count for the setting"
  type        = number
  default     = null
}

variable "not_applicable_device_count" {
  description = "Device Not Applicable count for the setting"
  type        = number
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.settingStateDeviceSummary"
  nullable    = false
}

variable "remediated_device_count" {
  description = "Device Compliant count for the setting"
  type        = number
  default     = null
}

variable "setting_name" {
  description = "Name of the setting"
  type        = string
  default     = null
}

variable "unknown_device_count" {
  description = "Device Unkown count for the setting"
  type        = number
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
