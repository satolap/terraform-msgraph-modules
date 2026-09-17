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
    status     = optional(any)
    use        = optional(string)
    x5c        = optional(list(string))
    x5t        = optional(string)
  }))
  default = null
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
    status     = optional(any)
    use        = optional(string)
    x5c        = optional(list(string))
    x5t        = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.trustFrameworkKeySet"
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
