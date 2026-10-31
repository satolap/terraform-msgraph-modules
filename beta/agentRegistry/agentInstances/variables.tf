variable "additionalInterfaces" {
  description = "Additional interfaces/transports supported by the agent."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.agentInterface")
    transport  = optional(string)
    url        = optional(string)
  }))
  default = null
}

variable "agentCardManifest" {
  description = "The agent card manifest of the agent instance."
  type        = any
  default     = null
}

variable "agentIdentityBlueprintId" {
  description = "Object ID of the agentIdentityBlueprint object."
  type        = string
  default     = null
}

variable "agentIdentityId" {
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

variable "displayName" {
  description = "Display name for the agent instance."
  type        = string
  default     = null
}

variable "lastModifiedDateTime" {
  description = "Timestamp of last modification."
  type        = string
  default     = null
}

variable "managedBy" {
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

variable "originatingStore" {
  description = "Name of the store/system where agent originated. For example Copilot Studio."
  type        = string
  default     = null
}

variable "ownerIds" {
  description = "List of object IDs for the owners of the agent instance."
  type        = list(string)
  default     = null
}

variable "preferredTransport" {
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

variable "sourceAgentId" {
  description = "Identifier of the agent in the original source system."
  type        = string
  default     = null
}

variable "url" {
  description = "Endpoint URL for the agent instance."
  type        = string
  default     = null
}

variable "timeouts" {
  description = "Optional timeouts of the msgraph_resource, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". create, update and delete must be at least \"15s\": after each request the provider waits for consistent reads within the same timeout. Every value defaults to null, which keeps the provider defaults and sends no timeouts block. The reviewed replication retries of this module, where it has any, count against these timeouts."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.read, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : (can(regex("^([0-9]+[hms])+$", t)) ? !can(regex("^(0+[hms])+$", t)) : false)
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : try(sum([for m in regexall("([0-9]+)([hms])", t) : tonumber(m[0]) * lookup({ h = 3600, m = 60, s = 1 }, m[1])]) >= 15, true)
    ])
    error_message = "timeouts.create, timeouts.update and timeouts.delete must be at least \"15s\"."
  }
}

variable "select_response" {
  description = "Opt in to a configured-property GET selection; this narrows response and can remove fields consumers use."
  type        = bool
  default     = false
  nullable    = false
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
