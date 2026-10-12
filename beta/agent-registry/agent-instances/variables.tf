variable "additional_interfaces" {
  description = "Additional interfaces/transports supported by the agent."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.agentInterface")
    transport  = optional(string)
    url        = optional(string)
  }))
  default = null
}

variable "agent_card_manifest" {
  description = "The agent card manifest of the agent instance."
  type        = any
  default     = null
}

variable "agent_identity_blueprint_id" {
  description = "Object ID of the agentIdentityBlueprint object."
  type        = string
  default     = null
}

variable "agent_identity_id" {
  description = "Object ID of the agentIdentity object."
  type        = string
  default     = null
}

variable "collections" {
  description = "The agent collections that the agent instance is a member of."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.agentCollection")
    createdBy            = optional(string)
    createdDateTime      = optional(string)
    description          = optional(string)
    displayName          = optional(string)
    lastModifiedDateTime = optional(string)
    managedBy            = optional(string)
    members = optional(list(object({
      odata_type               = optional(string, "#microsoft.graph.agentInstance")
      additionalInterfaces     = optional(any)
      agentCardManifest        = optional(any)
      agentIdentityBlueprintId = optional(string)
      agentIdentityId          = optional(string)
      collections              = optional(any)
      displayName              = optional(string)
      lastModifiedDateTime     = optional(string)
      managedBy                = optional(string)
      originatingStore         = optional(string)
      ownerIds                 = optional(list(string))
      preferredTransport       = optional(string)
      signatures               = optional(any)
      sourceAgentId            = optional(string)
      url                      = optional(string)
    })))
    originatingStore = optional(string)
    ownerIds         = optional(list(string))
  }))
  default = null
}

variable "display_name" {
  description = "Display name for the agent instance."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "Timestamp of last modification."
  type        = string
  default     = null
}

variable "managed_by" {
  description = "appId (referred to as Application (client) ID on the Microsoft Entra admin center) of the application managing this agent."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.agentInstance"
  nullable    = false
}

variable "originating_store" {
  description = "Name of the store/system where agent originated. For example Copilot Studio."
  type        = string
  default     = null
}

variable "owner_ids" {
  description = "List of object IDs for the owners of the agent instance."
  type        = list(string)
  default     = null
}

variable "preferred_transport" {
  description = "Preferred transport protocol. The possible values are JSONRPC, GRPC, and HTTP+JSON."
  type        = string
  default     = null
}

variable "signatures" {
  description = "Digital signatures for the agent instance."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.agentCardSignature")
    header     = optional(any)
    protected  = optional(string)
    signature  = optional(string)
  }))
  default = null
}

variable "source_agent_id" {
  description = "Identifier of the agent in the original source system."
  type        = string
  default     = null
}

variable "url" {
  description = "Endpoint URL for the agent instance."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["agentUserId", "createdBy", "createdDateTime", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
