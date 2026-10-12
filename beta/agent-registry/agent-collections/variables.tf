variable "created_by" {
  description = "Object ID of the user or app that created the agent instance."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "Timestamp when agent collection was created."
  type        = string
  default     = null
}

variable "description" {
  description = "Description / purpose of the collection."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Friendly name of the collection."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "Timestamp of last update."
  type        = string
  default     = null
}

variable "managed_by" {
  description = "appId (referred to as Application (client) ID on the Microsoft Entra admin center) of the service principal managing this agent."
  type        = string
  default     = null
}

variable "members" {
  description = "List of agent instances that are members of this collection. Supports $expand."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.agentInstance")
    additionalInterfaces = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.agentInterface")
      transport  = optional(string)
      url        = optional(string)
    })))
    agentCardManifest        = optional(any)
    agentIdentityBlueprintId = optional(string)
    agentIdentityId          = optional(string)
    collections = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.agentCollection")
      createdBy            = optional(string)
      createdDateTime      = optional(string)
      description          = optional(string)
      displayName          = optional(string)
      lastModifiedDateTime = optional(string)
      managedBy            = optional(string)
      members              = optional(any)
      originatingStore     = optional(string)
      ownerIds             = optional(list(string))
    })))
    displayName          = optional(string)
    lastModifiedDateTime = optional(string)
    managedBy            = optional(string)
    originatingStore     = optional(string)
    ownerIds             = optional(list(string))
    preferredTransport   = optional(string)
    signatures = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.agentCardSignature")
      header     = optional(any)
      protected  = optional(string)
      signature  = optional(string)
    })))
    sourceAgentId = optional(string)
    url           = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.agentCollection"
  nullable    = false
}

variable "originating_store" {
  description = "Source system/store where the collection originated. For example Copilot Studio."
  type        = string
  default     = null
}

variable "owner_ids" {
  description = "List of object IDs for the owners of the agent instance."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
