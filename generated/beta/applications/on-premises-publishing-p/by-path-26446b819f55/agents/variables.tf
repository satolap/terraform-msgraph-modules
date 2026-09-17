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

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.onPremisesAgent"
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

variable "supported_publishing_types" {
  description = "The possible values are: applicationProxy, exchangeOnline, authentication, provisioning, intunePfx, oflineDomainJoin, unknownFutureValue, privateAccess. Use the Prefer: include-unknown-enum-members request header to get the following values from this evolvable enum: privateAccess."
  type        = list(string)
  default     = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["agentGroups", "externalIp", "id", "machineName"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
