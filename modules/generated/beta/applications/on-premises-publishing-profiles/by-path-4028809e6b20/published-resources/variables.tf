variable "on_premises_publishing_profile_id" {
  description = "The unique identifier of onPremisesPublishingProfile"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.on_premises_publishing_profile_id)) > 0
    error_message = "on_premises_publishing_profile_id must not be empty."
  }
}

variable "on_premises_agent_group_id" {
  description = "The unique identifier of onPremisesAgentGroup"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.on_premises_agent_group_id)) > 0
    error_message = "on_premises_agent_group_id must not be empty."
  }
}

variable "display_name" {
  description = "Display Name of the publishedResource."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.publishedResource"
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

variable "resource_name" {
  description = "Name of the publishedResource."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["agentGroups", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
