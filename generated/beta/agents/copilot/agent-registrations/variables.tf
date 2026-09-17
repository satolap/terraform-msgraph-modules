variable "agent_card" {
  description = "Flexible Json manifest containing agent card information following public manifest\nspecifications. Can include displayName, description, iconUrl, version, provider,\ncapabilities, skills, security, and other manifest-defined fields."
  type        = any
  default     = null
}

variable "agent_identity_blueprint_id" {
  description = "Agent identity blueprint identifier."
  type        = string
  default     = null
}

variable "agent_identity_id" {
  description = "Entra agent identity identifier."
  type        = string
  default     = null
}

variable "created_by" {
  description = "The unique identifier of the user or app who created the agent registration."
  type        = string
  default     = null
}

variable "description" {
  description = "The agent description providing an overview of its purpose and capabilities."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Display name for the agent instance."
  type        = string
  default     = null
}

variable "last_published_by" {
  description = "The unique identifier of the last person to publish the agent."
  type        = string
  default     = null
}

variable "managed_by_app_id" {
  description = "Application identifier managing this agent."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.agentRegistration"
  nullable    = false
}

variable "originating_store" {
  description = "Name of the store/system where the agent originated."
  type        = string
  default     = null
}

variable "owner_ids" {
  description = "List of owner identifiers  for the agent in case of user registering agent. Either owners or managedby is required"
  type        = list(string)
  default     = null
}

variable "source_agent_id" {
  description = "Original agent identifier from source system."
  type        = string
  default     = null
}

variable "source_created_date_time" {
  description = "The date and time when the agent instance was created from source."
  type        = string
  default     = null
}

variable "source_last_modified_date_time" {
  description = "The date and time when the agent instance was last modified from source."
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
