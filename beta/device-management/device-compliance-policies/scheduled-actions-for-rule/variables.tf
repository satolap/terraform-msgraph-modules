variable "device_compliance_policy_id" {
  description = "The unique identifier of deviceCompliancePolicy"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.device_compliance_policy_id)) > 0
    error_message = "device_compliance_policy_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceComplianceScheduledActionForRule"
  nullable    = false
}

variable "rule_name" {
  description = "Name of the rule which this scheduled action applies to. Currently scheduled actions are created per policy instead of per rule, thus RuleName is always set to default value PasswordRequired."
  type        = string
  default     = null
}

variable "scheduled_action_configurations" {
  description = "The list of scheduled action configurations for this compliance policy. Compliance policy must have one and only one block scheduled action."
  type = list(object({
    odata_type                = optional(string, "#microsoft.graph.deviceComplianceActionItem")
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
