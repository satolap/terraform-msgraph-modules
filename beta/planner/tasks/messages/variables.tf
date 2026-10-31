variable "plannerTask-id" {
  description = "The unique identifier of plannerTask"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.plannerTask-id)) > 0
    error_message = "plannerTask-id must not be empty."
  }
}

variable "content" {
  description = "The content of the chat message. Supports plain text and sanitized HTML."
  type        = string
  default     = null
}

variable "createdBy" {
  description = "The identity of the user who created the message."
  type        = any
  default     = null
}

variable "createdDateTime" {
  description = "The date and time when the message was created. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "deletedDateTime" {
  description = "Microsoft Graph deletedDateTime property."
  type        = string
  default     = null
}

variable "editedDateTime" {
  description = "Microsoft Graph editedDateTime property."
  type        = string
  default     = null
}

variable "mentions" {
  description = "The list of mentions in the message."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.plannerTaskChatMention")
    mentionType = optional(string)
    mentioned   = optional(string)
    position    = optional(number)
  }))
  default = null

  validation {
    condition     = (var.mentions == null ? true : alltrue([alltrue([for input0 in var.mentions : (input0 == null ? true : alltrue([(input0["mentionType"] == null ? true : alltrue([(input0["mentionType"] == null ? true : contains(["user", "application"], input0["mentionType"]))]))]))])]))
    error_message = "mentions: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "messageType" {
  description = "Microsoft Graph messageType property."
  type        = string
  default     = null

  validation {
    condition     = var.messageType == null ? true : contains(["richTextHtml", "plainText"], var.messageType)
    error_message = "messageType must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.plannerTaskChatMessage"
  nullable    = false
}

variable "parentEntityId" {
  description = "The ID of the parent plannerTask that this message belongs to."
  type        = string
  default     = null
}

variable "reactions" {
  description = "The reactions on the message."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.plannerTaskChatReaction")
    reactionEvents = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.plannerTaskChatReactionEvent")
      createdBy       = optional(any)
      createdDateTime = optional(string)
    })))
    reactionType = optional(string)
  }))
  default = null
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
