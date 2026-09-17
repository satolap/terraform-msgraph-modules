variable "action_required_by_date_time" {
  description = "The expected deadline of the action for the message."
  type        = string
  default     = null
}

variable "attachments" {
  description = "A collection of serviceAnnouncementAttachments."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.serviceAnnouncementAttachment")
    content              = optional(string)
    contentType          = optional(string)
    lastModifiedDateTime = optional(string)
    name                 = optional(string)
    size                 = optional(number)
  }))
  default = null
}

variable "attachments_archive" {
  description = "The zip file of all attachments for a message."
  type        = string
  default     = null
}

variable "body" {
  description = "Microsoft Graph body property."
  type = object({
    odata_type  = optional(string, "#microsoft.graph.itemBody")
    content     = optional(string)
    contentType = optional(any)
  })
  default = null
}

variable "category" {
  description = "Microsoft Graph category property."
  type        = string
  default     = null

  validation {
    condition     = var.category == null ? true : contains(["preventOrFixIssue", "planForChange", "stayInformed", "unknownFutureValue"], var.category)
    error_message = "category must be one of the documented enum values."
  }
}

variable "details" {
  description = "Extra details about service event. This property doesn't support filters."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.keyValuePair")
    name       = optional(string)
    value      = optional(string)
  }))
  default = null
}

variable "end_date_time" {
  description = "The end time of the service event."
  type        = string
  default     = null
}

variable "has_attachments" {
  description = "Indicates whether the message has any attachment."
  type        = bool
  default     = null
}

variable "is_major_change" {
  description = "Indicates whether the message describes a major update for the service."
  type        = bool
  default     = null
}

variable "last_modified_date_time" {
  description = "The last modified time of the service event."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.serviceUpdateMessage"
  nullable    = false
}

variable "services" {
  description = "The affected services by the service message."
  type        = list(string)
  default     = null
}

variable "severity" {
  description = "Microsoft Graph severity property."
  type        = string
  default     = null

  validation {
    condition     = var.severity == null ? true : contains(["normal", "high", "critical", "unknownFutureValue"], var.severity)
    error_message = "severity must be one of the documented enum values."
  }
}

variable "start_date_time" {
  description = "The start time of the service event."
  type        = string
  default     = null
}

variable "tags" {
  description = "A collection of tags for the service message. Tags are provided by the service team/support team who post the message to tell whether this message contains privacy data, or whether this message is for a service new feature update, and so on."
  type        = list(string)
  default     = null
}

variable "title" {
  description = "The title of the service event."
  type        = string
  default     = null
}

variable "view_point" {
  description = "Represents user viewpoints data of the service message. This data includes message status such as whether the user has archived, read, or marked the message as favorite. This property is null when accessed with application permissions."
  type        = any
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
