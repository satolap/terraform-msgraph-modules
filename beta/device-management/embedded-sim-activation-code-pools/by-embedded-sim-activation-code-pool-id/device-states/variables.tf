variable "embedded_sim_activation_code_pool_id" {
  description = "The unique identifier of embeddedSIMActivationCodePool"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.embedded_sim_activation_code_pool_id)) > 0
    error_message = "embedded_sim_activation_code_pool_id must not be empty."
  }
}

variable "created_date_time" {
  description = "The time the embedded SIM device status was created. Generated service side."
  type        = string
  default     = null
}

variable "device_name" {
  description = "Device name to which the subscription was provisioned e.g. DESKTOP-JOE"
  type        = string
  default     = null
}

variable "last_sync_date_time" {
  description = "The time the embedded SIM device last checked in. Updated service side."
  type        = string
  default     = null
}

variable "modified_date_time" {
  description = "The time the embedded SIM device status was last modified. Updated service side."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.embeddedSIMDeviceState"
  nullable    = false
}

variable "state" {
  description = "Describes the various states for an embedded SIM activation code."
  type        = string
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["notEvaluated", "failed", "installing", "installed", "deleting", "error", "deleted", "removedByUser"], var.state)
    error_message = "state must be one of the documented enum values."
  }
}

variable "state_details" {
  description = "String description of the provisioning state."
  type        = string
  default     = null
}

variable "universal_integrated_circuit_card_identifier" {
  description = "The Universal Integrated Circuit Card Identifier (UICCID) identifying the hardware onto which a profile is to be deployed."
  type        = string
  default     = null
}

variable "user_name" {
  description = "Username which the subscription was provisioned to e.g. joe@contoso.com"
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
