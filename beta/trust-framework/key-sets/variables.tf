variable "keys" {
  description = "A collection of the keys."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.trustFrameworkKey")
    d          = optional(string)
    dp         = optional(string)
    dq         = optional(string)
    e          = optional(string)
    exp        = optional(number)
    k          = optional(string)
    kid        = optional(string)
    kty        = optional(string)
    n          = optional(string)
    nbf        = optional(number)
    p          = optional(string)
    q          = optional(string)
    qi         = optional(string)
    status     = optional(string)
    use        = optional(string)
    x5c        = optional(list(string))
    x5t        = optional(string)
  }))
  default = null

  validation {
    condition     = (var.keys == null ? true : alltrue([alltrue([for input0 in var.keys : (input0 == null ? true : alltrue([(input0["status"] == null ? true : alltrue([(input0["status"] == null ? true : contains(["enabled", "disabled"], input0["status"]))]))]))])]))
    error_message = "keys: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "keys_v2" {
  description = "A collection of the keys."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.trustFrameworkKey_v2")
    d          = optional(string)
    dp         = optional(string)
    dq         = optional(string)
    e          = optional(string)
    exp        = optional(number)
    k          = optional(string)
    kid        = optional(string)
    kty        = optional(string)
    n          = optional(string)
    nbf        = optional(number)
    p          = optional(string)
    q          = optional(string)
    qi         = optional(string)
    status     = optional(string)
    use        = optional(string)
    x5c        = optional(list(string))
    x5t        = optional(string)
  }))
  default = null

  validation {
    condition     = (var.keys_v2 == null ? true : alltrue([alltrue([for input0 in var.keys_v2 : (input0 == null ? true : alltrue([(input0["status"] == null ? true : alltrue([(input0["status"] == null ? true : contains(["enabled", "disabled"], input0["status"]))]))]))])]))
    error_message = "keys_v2: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.trustFrameworkKeySet"
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
