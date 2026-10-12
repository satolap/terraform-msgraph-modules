variable "ios_lob_app_provisioning_configuration_id" {
  description = "The unique identifier of iosLobAppProvisioningConfiguration"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.ios_lob_app_provisioning_configuration_id)) > 0
    error_message = "ios_lob_app_provisioning_configuration_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.mobileAppProvisioningConfigGroupAssignment"
  nullable    = false
}

variable "target_group_id" {
  description = "The ID of the AAD group in which the app provisioning configuration is being targeted."
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
