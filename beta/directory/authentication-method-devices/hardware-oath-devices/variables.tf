variable "assign_to" {
  description = "Assign the hardware OATH token to a user."
  type        = any
  default     = null
}

variable "assigned_to" {
  description = "User the token is assigned to. Nullable. Supports $filter (eq)."
  type        = any
  default     = null
}

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
    hashFunction          = optional(string)
    manufacturer          = optional(string)
    model                 = optional(string)
    secretKey             = optional(string)
    serialNumber          = optional(string)
    status                = optional(string)
    timeIntervalInSeconds = optional(number)
  }))
  default   = null
  sensitive = true

  validation {
    condition     = (var.hardware_oath_devices == null ? true : alltrue([alltrue([for input0 in var.hardware_oath_devices : (input0 == null ? true : alltrue([(input0["hashFunction"] == null ? true : alltrue([(input0["hashFunction"] == null ? true : contains(["hmacsha1", "hmacsha256"], input0["hashFunction"]))])), (input0["status"] == null ? true : alltrue([(input0["status"] == null ? true : contains(["available", "assigned", "activated", "failedActivation"], input0["status"]))]))]))])]))
    error_message = "hardware_oath_devices: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "hash_function" {
  description = "Hash function of the hardrware token. The possible values are: hmacsha1 or hmacsha256. Default value is: hmacsha1. Supports $filter (eq)."
  type        = string
  default     = null

  validation {
    condition     = var.hash_function == null ? true : contains(["hmacsha1", "hmacsha256"], var.hash_function)
    error_message = "hash_function must be one of the documented enum values."
  }
}

variable "manufacturer" {
  description = "Manufacturer name of the hardware token. Supports $filter (eq)."
  type        = string
  default     = null
}

variable "model" {
  description = "Model name of the hardware token. Supports $filter (eq)."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.hardwareOathTokenAuthenticationMethodDevice"
  nullable    = false
}

variable "secret_key" {
  description = "Secret key of the specific hardware token, provided by the vendor."
  type        = string
  default     = null
  sensitive   = true
}

variable "serial_number" {
  description = "Serial number of the specific hardware token, often found on the back of the device. Supports $select and $filter (eq)."
  type        = string
  default     = null
}

variable "status" {
  description = "Status of the hardware OATH token.The possible values are: available, assigned, activated, failedActivation. Supports $filter(eq)."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["available", "assigned", "activated", "failedActivation"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "time_interval_in_seconds" {
  description = "Refresh interval of the 6-digit verification code, in seconds. The possible values are: 30 or 60. Supports $filter (eq)."
  type        = number
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "lastUsedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
