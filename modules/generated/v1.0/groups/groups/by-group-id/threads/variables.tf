variable "group_id" {
  description = "The unique identifier of group"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.group_id)) > 0
    error_message = "group_id must not be empty."
  }
}

variable "cc_recipients" {
  description = "The Cc: recipients for the thread. Requires $select to retrieve."
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.recipient")
    emailAddress = optional(any)
  }))
  default = null
}

variable "has_attachments" {
  description = "Indicates whether any of the posts within this thread has at least one attachment. Returned by default."
  type        = bool
  default     = null
}

variable "is_locked" {
  description = "Indicates if the thread is locked. Returned by default."
  type        = bool
  default     = null
}

variable "last_delivered_date_time" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z.Returned by default."
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
    odata_type      = optional(string, "#microsoft.graph.post")
    body            = optional(any)
    categories      = optional(list(string))
    createdDateTime = optional(string)
    from = optional(object({
      odata_type   = optional(string, "#microsoft.graph.recipient")
      emailAddress = optional(any)
    }))
    hasAttachments       = optional(bool)
    lastModifiedDateTime = optional(string)
    newParticipants = optional(list(object({
      odata_type   = optional(string, "#microsoft.graph.recipient")
      emailAddress = optional(any)
    })))
    receivedDateTime = optional(string)
    sender           = optional(any)
  }))
  default = null
}

variable "preview" {
  description = "A short summary from the body of the latest post in this conversation. Returned by default."
  type        = string
  default     = null
}

variable "to_recipients" {
  description = "The To: recipients for the thread. Requires $select to retrieve."
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.recipient")
    emailAddress = optional(any)
  }))
  default = null
}

variable "topic" {
  description = "The topic of the conversation. This property can be set when the conversation is created, but it cannot be updated. Returned by default."
  type        = string
  default     = null
}

variable "unique_senders" {
  description = "All the users that sent a message to this thread. Returned by default."
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
