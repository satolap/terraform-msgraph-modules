variable "device_compliance_policy_id" {
  description = "The unique identifier of deviceCompliancePolicy"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.device_compliance_policy_id)) > 0
    error_message = "device_compliance_policy_id must not be empty."
  }
}

variable "device_compliance_scheduled_action_for_rule_id" {
  description = "The unique identifier of deviceComplianceScheduledActionForRule"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.device_compliance_scheduled_action_for_rule_id)) > 0
    error_message = "device_compliance_scheduled_action_for_rule_id must not be empty."
  }
}

variable "action_type" {
  description = "Scheduled Action Type Enum"
  type        = string
  default     = null

  validation {
    condition     = var.action_type == null ? true : contains(["noAction", "notification", "block", "retire", "wipe", "removeResourceAccessProfiles", "pushNotification"], var.action_type)
    error_message = "action_type must be one of the documented enum values."
  }
}

variable "grace_period_hours" {
  description = "Number of hours to wait till the action will be enforced. Valid values 0 to 8760"
  type        = number
  default     = null
}

variable "notification_message_cc_list" {
  description = "A list of group IDs to speicify who to CC this notification message to."
  type        = list(string)
  default     = null
}

variable "notification_template_id" {
  description = "What notification Message template to use"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceComplianceActionItem"
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
