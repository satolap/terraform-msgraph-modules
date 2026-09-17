variable "display_name" {
  description = "Optional name given to the hardware OATH device."
  type        = string
  default     = null
}

variable "hardware_oath_devices" {
  description = "Exposes the hardware OATH method in the directory."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.hardwareOathTokenAuthenticationMethodDevice")
    assignTo              = optional(any)
    assignedTo            = optional(any)
    displayName           = optional(string)
    hardwareOathDevices   = optional(any)
    hashFunction          = optional(any)
    manufacturer          = optional(string)
    model                 = optional(string)
    secretKey             = optional(string)
    serialNumber          = optional(string)
    status                = optional(any)
    timeIntervalInSeconds = optional(number)
  }))
  default   = null
  sensitive = true
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.authenticationMethodDevice"
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
