variable "display_name" {
  description = "Display name of the agreement. The display name is used for internal tracking of the agreement but isn't shown to end users who view the agreement. Supports $filter (eq)."
  type        = string
  default     = null
}

variable "file" {
  description = "Default PDF linked to this agreement."
  type        = any
  default     = null
}

variable "files" {
  description = "PDFs linked to this agreement. Note: This property is in the process of being deprecated. Use the  file property instead."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.agreementFileLocalization")
    createdDateTime = optional(string)
    displayName     = optional(string)
    isMajorVersion  = optional(bool)
  }))
  default = null
}

variable "is_per_device_acceptance_required" {
  description = "This setting enables you to require end users to accept this agreement on every device that they're accessing it from. The end user is required to register their device in Microsoft Entra ID, if they haven't already done so. Supports $filter (eq)."
  type        = bool
  default     = null
}

variable "is_viewing_before_acceptance_required" {
  description = "Indicates whether the user has to expand the agreement before accepting. Supports $filter (eq)."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.agreement"
  nullable    = false
}

variable "terms_expiration" {
  description = "Expiration schedule and frequency of agreement for all users.  Supports $filter (eq)."
  type = object({
    odata_type    = optional(string, "#microsoft.graph.termsExpiration")
    frequency     = optional(string)
    startDateTime = optional(string)
  })
  default = null
}

variable "user_reaccept_required_frequency" {
  description = "The duration after which the user must reaccept the terms of use. The value is represented in ISO 8601 format for durations."
  type        = string
  default     = null
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["acceptances", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
