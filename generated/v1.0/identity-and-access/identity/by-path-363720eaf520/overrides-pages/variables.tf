variable "b2x_identity_user_flow_id" {
  description = "The unique identifier of b2xIdentityUserFlow"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.b2x_identity_user_flow_id)) > 0
    error_message = "b2x_identity_user_flow_id must not be empty."
  }
}

variable "user_flow_language_configuration_id" {
  description = "The unique identifier of userFlowLanguageConfiguration"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_flow_language_configuration_id)) > 0
    error_message = "user_flow_language_configuration_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.userFlowLanguagePage"
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
