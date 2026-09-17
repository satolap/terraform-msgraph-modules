variable "activation_code_count" {
  description = "The total count of activation codes which belong to this pool."
  type        = number
  default     = null
}

variable "activation_codes" {
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
    target = optional(object({
      odata_type                                 = optional(string, "#microsoft.graph.deviceAndAppManagementAssignmentTarget")
      deviceAndAppManagementAssignmentFilterId   = optional(string)
      deviceAndAppManagementAssignmentFilterType = optional(string)
    }))
  }))
  default = null
}

variable "created_date_time" {
  description = "The time the embedded SIM activation code pool was created. Generated service side."
  type        = string
  default     = null
}

variable "device_states" {
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
}

variable "display_name" {
  description = "The admin defined name of the embedded SIM activation code pool."
  type        = string
  default     = null
}

variable "modified_date_time" {
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
