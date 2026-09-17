variable "device_compliance_policy_setting_state_summary_id" {
  description = "The unique identifier of deviceCompliancePolicySettingStateSummary"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.device_compliance_policy_setting_state_summary_id)) > 0
    error_message = "device_compliance_policy_setting_state_summary_id must not be empty."
  }
}

variable "compliance_grace_period_expiration_date_time" {
  description = "The DateTime when device compliance grace period expires"
  type        = string
  default     = null
}

variable "device_id" {
  description = "The Device Id that is being reported"
  type        = string
  default     = null
}

variable "device_model" {
  description = "The device model that is being reported"
  type        = string
  default     = null
}

variable "device_name" {
  description = "The Device Name that is being reported"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceComplianceSettingState"
  nullable    = false
}

variable "setting" {
  description = "The setting class name and property name."
  type        = string
  default     = null
}

variable "setting_name" {
  description = "The Setting Name that is being reported"
  type        = string
  default     = null
}

variable "state" {
  description = "Microsoft Graph state property."
  type        = string
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["unknown", "notApplicable", "compliant", "remediated", "nonCompliant", "error", "conflict", "notAssigned"], var.state)
    error_message = "state must be one of the documented enum values."
  }
}

variable "user_email" {
  description = "The User email address that is being reported"
  type        = string
  default     = null
}

variable "user_id" {
  description = "The user Id that is being reported"
  type        = string
  default     = null
}

variable "user_name" {
  description = "The User Name that is being reported"
  type        = string
  default     = null
}

variable "user_principal_name" {
  description = "The User PrincipalName that is being reported"
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
