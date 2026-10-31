variable "group-id" {
  description = "The unique identifier of group"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.group-id)) > 0
    error_message = "group-id must not be empty."
  }
}

variable "ccRecipients" {
  description = "The Cc: recipients for the thread. Returned only on $select."
  type        = any
  default     = null
}

variable "hasAttachments" {
  description = "Indicates whether any of the posts within this thread has at least one attachment. Returned by default."
  type        = bool
  default     = null
}

variable "isLocked" {
  description = "Indicates if the thread is locked. Returned by default."
  type        = bool
  default     = null
}

variable "lastDeliveredDateTime" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z. Returned by default."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.conversationThread"
  nullable    = false
}

variable "posts" {
  description = "Microsoft Graph posts property."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.post")
    body = optional(object({
      odata_type  = optional(string, "#microsoft.graph.itemBody")
      content     = optional(string)
      contentType = optional(string)
    }))
    categories           = optional(list(string))
    createdDateTime      = optional(string)
    from                 = optional(any)
    hasAttachments       = optional(bool)
    importance           = optional(string)
    lastModifiedDateTime = optional(string)
    mentions = optional(list(object({
      odata_type            = optional(string, "#microsoft.graph.mention")
      application           = optional(string)
      clientReference       = optional(string)
      createdBy             = optional(any)
      createdDateTime       = optional(string)
      deepLink              = optional(string)
      mentionText           = optional(string)
      mentioned             = optional(any)
      serverCreatedDateTime = optional(string)
    })))
    newParticipants  = optional(any)
    receivedDateTime = optional(string)
    sender           = optional(any)
  }))
  default = null

  validation {
    condition     = (var.posts == null ? true : alltrue([alltrue([for input0 in var.posts : (input0 == null ? true : alltrue([(input0["body"] == null ? true : alltrue([(input0["body"]["contentType"] == null ? true : alltrue([(input0["body"]["contentType"] == null ? true : contains(["text", "html"], input0["body"]["contentType"]))]))])), (input0["importance"] == null ? true : alltrue([(input0["importance"] == null ? true : contains(["low", "normal", "high"], input0["importance"]))]))]))])]))
    error_message = "posts: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "preview" {
  description = "A short summary from the body of the latest post in this conversation. Returned by default."
  type        = string
  default     = null
}

variable "toRecipients" {
  description = "The To: recipients for the thread. Returned only on $select."
  type        = any
  default     = null
}

variable "topic" {
  description = "The topic of the conversation. This property can be set when the conversation is created, but it cannot be updated. Returned by default."
  type        = string
  default     = null
}

variable "uniqueSenders" {
  description = "All the users that sent a message to this thread. Returned by default."
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
