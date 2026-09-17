variable "description" {
  description = "reusable setting description supplied by user."
  type        = string
  default     = null
}

variable "display_name" {
  description = "reusable setting display name supplied by user."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagementReusablePolicySetting"
  nullable    = false
}

variable "setting_definition_id" {
  description = "setting definition id associated with this reusable setting."
  type        = string
  default     = null
}

variable "setting_instance" {
  description = "reusable setting configuration instance"
  type        = any
  default     = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "lastModifiedDateTime", "referencingConfigurationPolicies", "referencingConfigurationPolicyCount", "version"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
