variable "on_premises_publishing_profile_id" {
  description = "The unique identifier of onPremisesPublishingProfile"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.on_premises_publishing_profile_id)) > 0
    error_message = "on_premises_publishing_profile_id must not be empty."
  }
}

variable "display_name" {
  description = "Display name of the onPremisesAgentGroup."
  type        = string
  default     = null
}

variable "is_default" {
  description = "Indicates if the onPremisesAgentGroup is the default agent group. Only a single agent group can be the default onPremisesAgentGroup and is set by the system."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.onPremisesAgentGroup"
  nullable    = false
}

variable "publishing_type" {
  description = "Microsoft Graph publishingType property."
  type        = string
  default     = null

  validation {
    condition     = var.publishing_type == null ? true : contains(["applicationProxy", "exchangeOnline", "authentication", "provisioning", "intunePfx", "oflineDomainJoin", "unknownFutureValue", "privateAccess"], var.publishing_type)
    error_message = "publishing_type must be one of the documented enum values."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["agents", "id", "publishedResources"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
