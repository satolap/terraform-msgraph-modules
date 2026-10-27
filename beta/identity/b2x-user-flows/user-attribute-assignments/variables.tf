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
