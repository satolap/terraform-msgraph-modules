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

variable "hash_function" {
  description = "Hash function of the hardrware token. The possible values are: hmacsha1 or hmacsha256. Default value is: hmacsha1. Supports $filter (eq)."
  type        = any
  default     = null

  validation {
    condition     = var.hash_function == null ? true : contains(["hmacsha1", "hmacsha256", "unknownFutureValue"], var.hash_function)
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
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["available", "assigned", "activated", "failedActivation", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "time_interval_in_seconds" {
  description = "Refresh interval of the 6-digit verification code, in seconds. The possible values are: 30 or 60. Supports $filter (eq)."
  type        = number
  default     = null
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
