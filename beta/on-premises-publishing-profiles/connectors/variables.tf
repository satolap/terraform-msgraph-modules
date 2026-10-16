variable "on_premises_publishing_profile_id" {
  description = "The unique identifier of onPremisesPublishingProfile"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.on_premises_publishing_profile_id)) > 0
    error_message = "on_premises_publishing_profile_id must not be empty."
  }
}

variable "machine_name" {
  description = "The name of the computer on which the connector is installed and runs on."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.connector"
  nullable    = false
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["active", "inactive"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["externalIp", "id", "memberOf", "version"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
