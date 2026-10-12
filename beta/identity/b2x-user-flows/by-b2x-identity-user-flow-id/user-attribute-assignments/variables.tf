variable "b2x_identity_user_flow_id" {
  description = "The unique identifier of b2xIdentityUserFlow"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.b2x_identity_user_flow_id)) > 0
    error_message = "b2x_identity_user_flow_id must not be empty."
  }
}

variable "display_name" {
  description = "The display name of the identityUserFlowAttribute within a user flow."
  type        = string
  default     = null
}

variable "is_optional" {
  description = "Determines whether the identityUserFlowAttribute is optional. true means the user doesn't have to provide a value. false means the user can't complete sign-up without providing a value."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.identityUserFlowAttributeAssignment"
  nullable    = false
}

variable "requires_verification" {
  description = "Determines whether the identityUserFlowAttribute requires verification. This is only used for verifying the user's phone number or email address."
  type        = bool
  default     = null
}

variable "user_attribute" {
  description = "The user attribute that you want to add to your user flow."
  type        = any
  default     = null
}

variable "user_attribute_values" {
  description = "The input options for the user flow attribute. Only applicable when the userInputType is radioSingleSelect, dropdownSingleSelect, or checkboxMultiSelect."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.userAttributeValuesItem")
    isDefault  = optional(bool)
    name       = optional(string)
    value      = optional(string)
  }))
  default = null
}

variable "user_input_type" {
  description = "Microsoft Graph userInputType property."
  type        = string
  default     = null

  validation {
    condition     = var.user_input_type == null ? true : contains(["textBox", "dateTimeDropdown", "radioSingleSelect", "dropdownSingleSelect", "emailBox", "checkboxMultiSelect"], var.user_input_type)
    error_message = "user_input_type must be one of the documented enum values."
  }
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
