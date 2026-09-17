variable "allowed_combinations" {
  description = "A collection of authentication method modes that are required be used to satify this authentication strength."
  type        = list(string)
  default     = null
}

variable "combination_configurations" {
  description = "Settings that may be used to require specific types or instances of an authentication method to be used when authenticating with a specified combination of authentication methods."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.authenticationCombinationConfiguration")
    appliesToCombinations = optional(list(string))
  }))
  default = null
}

variable "created_date_time" {
  description = "The datetime when this policy was created."
  type        = string
  default     = null
}

variable "description" {
  description = "The human-readable description of this policy."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The human-readable display name of this policy. Supports $filter (eq, ne, not , and in)."
  type        = string
  default     = null
}

variable "modified_date_time" {
  description = "The datetime when this policy was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.authenticationStrengthPolicy"
  nullable    = false
}

variable "policy_type" {
  description = "Microsoft Graph policyType property."
  type        = string
  default     = null

  validation {
    condition     = var.policy_type == null ? true : contains(["builtIn", "custom", "unknownFutureValue"], var.policy_type)
    error_message = "policy_type must be one of the documented enum values."
  }
}

variable "requirements_satisfied" {
  description = "Microsoft Graph requirementsSatisfied property."
  type        = string
  default     = null

  validation {
    condition     = var.requirements_satisfied == null ? true : contains(["none", "mfa", "unknownFutureValue"], var.requirements_satisfied)
    error_message = "requirements_satisfied must be one of the documented enum values."
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
