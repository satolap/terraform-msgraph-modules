variable "device_management_compliance_policy_id" {
  description = "The unique identifier of deviceManagementCompliancePolicy"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.device_management_compliance_policy_id)) > 0
    error_message = "device_management_compliance_policy_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagementComplianceScheduledActionForRule"
  nullable    = false
}

variable "rule_name" {
  description = "Name of the rule which this scheduled action applies to."
  type        = string
  default     = null
}

variable "scheduled_action_configurations" {
  description = "The list of scheduled action configurations for this compliance policy. This collection can contain a maximum of 100 elements."
  type = list(object({
    odata_type                = optional(string, "#microsoft.graph.deviceManagementComplianceActionItem")
    actionType                = optional(string)
    gracePeriodHours          = optional(number)
    notificationMessageCCList = optional(list(string))
    notificationTemplateId    = optional(string)
  }))
  default = null
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
