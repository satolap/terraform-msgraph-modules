variable "allowed_combinations" {
  description = "A collection of authentication method modes that are required be used to satify this authentication strength."
  type        = list(string)
  default     = null

  validation {
    condition     = (var.allowed_combinations == null ? true : alltrue([alltrue([for input0 in var.allowed_combinations : (input0 == null ? true : alltrue([(input0 == null ? true : try(alltrue([for value in split(",", input0) : contains(["password", "voice", "hardwareoath", "softwareoath", "sms", "fido2", "windowshelloforbusiness", "microsoftauthenticatorpush", "devicebasedpush", "temporaryaccesspassonetime", "temporaryaccesspassmultiuse", "email", "x509certificatesinglefactor", "x509certificatemultifactor", "federatedsinglefactor", "federatedmultifactor"], lower(trimspace(value)))]), false))]))])]))
    error_message = "allowed_combinations: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "combination_configurations" {
  description = "Settings that may be used to require specific types or instances of an authentication method to be used when authenticating with a specified combination of authentication methods."
  type        = any
  default     = null
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
    condition     = var.policy_type == null ? true : contains(["builtIn", "custom"], var.policy_type)
    error_message = "policy_type must be one of the documented enum values."
  }
}

variable "requirements_satisfied" {
  description = "Microsoft Graph requirementsSatisfied property."
  type        = string
  default     = null

  validation {
    condition     = var.requirements_satisfied == null ? true : try(alltrue([for value in split(",", var.requirements_satisfied) : contains(["none", "mfa"], lower(trimspace(value)))]), false)
    error_message = "requirements_satisfied must be one or more of the documented enum values, separated by commas."
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
