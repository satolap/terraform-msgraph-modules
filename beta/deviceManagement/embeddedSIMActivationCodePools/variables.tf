variable "activationCodeCount" {
  description = "The total count of activation codes which belong to this pool."
  type        = number
  default     = null
}

variable "activationCodes" {
  description = "The activation codes which belong to this pool. This navigation property is used to post activation codes to Intune but cannot be used to read activation codes from Intune."
  type = list(object({
    odata_type                      = optional(string, "#microsoft.graph.embeddedSIMActivationCode")
    integratedCircuitCardIdentifier = optional(string)
    matchingIdentifier              = optional(string)
    smdpPlusServerAddress           = optional(string)
  }))
  default = null
}

variable "assignments" {
  description = "Navigational property to a list of targets to which this pool is assigned."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.embeddedSIMActivationCodePoolAssignment")
    target     = optional(any)
  }))
  default = null
}

variable "createdDateTime" {
  description = "The time the embedded SIM activation code pool was created. Generated service side."
  type        = string
  default     = null
}

variable "deviceStates" {
  description = "Navigational property to a list of device states for this pool."
  type = list(object({
    odata_type                               = optional(string, "#microsoft.graph.embeddedSIMDeviceState")
    createdDateTime                          = optional(string)
    deviceName                               = optional(string)
    lastSyncDateTime                         = optional(string)
    modifiedDateTime                         = optional(string)
    state                                    = optional(string)
    stateDetails                             = optional(string)
    universalIntegratedCircuitCardIdentifier = optional(string)
    userName                                 = optional(string)
  }))
  default = null

  validation {
    condition     = (var.deviceStates == null ? true : alltrue([alltrue([for input0 in var.deviceStates : (input0 == null ? true : alltrue([(input0["state"] == null ? true : alltrue([(input0["state"] == null ? true : contains(["notEvaluated", "failed", "installing", "installed", "deleting", "error", "deleted", "removedByUser"], input0["state"]))]))]))])]))
    error_message = "deviceStates: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "displayName" {
  description = "The admin defined name of the embedded SIM activation code pool."
  type        = string
  default     = null
}

variable "modifiedDateTime" {
  description = "The time the embedded SIM activation code pool was last modified. Updated service side."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.embeddedSIMActivationCodePool"
  nullable    = false
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
