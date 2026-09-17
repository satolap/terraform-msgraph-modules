variable "user_id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_id)) > 0
    error_message = "user_id must not be empty."
  }
}

variable "managed_device_identifier" {
  description = "Device identifier created or collected by Intune."
  type        = string
  default     = null
}

variable "mobile_app_list" {
  description = "The list of payload intents and states for the tenant."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.mobileAppIntentAndStateDetail")
    applicationId   = optional(string)
    displayName     = optional(string)
    displayVersion  = optional(string)
    installState    = optional(string)
    mobileAppIntent = optional(string)
    supportedDeviceTypes = optional(list(object({
      odata_type                    = optional(string, "#microsoft.graph.mobileAppSupportedDeviceType")
      maximumOperatingSystemVersion = optional(string)
      minimumOperatingSystemVersion = optional(string)
      type                          = optional(string)
    })))
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.mobileAppIntentAndState"
  nullable    = false
}

variable "user_id_2" {
  description = "Identifier for the user that tried to enroll the device."
  type        = string
  default     = null
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
