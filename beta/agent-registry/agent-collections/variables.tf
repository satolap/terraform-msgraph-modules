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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
