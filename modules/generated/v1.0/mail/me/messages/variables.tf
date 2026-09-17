variable "attachments" {
  description = "The fileAttachment and itemAttachment attachments for the message."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.attachment")
    contentType          = optional(string)
    isInline             = optional(bool)
    lastModifiedDateTime = optional(string)
    name                 = optional(string)
    size                 = optional(number)
  }))
  default = null
}

variable "bcc_recipients" {
  description = "The Bcc: recipients for the message."
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.recipient")
    emailAddress = optional(any)
  }))
  default = null
}

variable "body" {
  description = "The body of the message. It can be in HTML or text format. Find out about safe HTML in a message body."
  type        = any
  default     = null
}

variable "body_preview" {
  description = "The first 255 characters of the message body. It is in text format."
  type        = string
  default     = null
}

variable "categories" {
  description = "The categories associated with the item"
  type        = list(string)
  default     = null
}

variable "cc_recipients" {
  description = "The Cc: recipients for the message."
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.recipient")
    emailAddress = optional(any)
  }))
  default = null
}

variable "conversation_id" {
  description = "The ID of the conversation the email belongs to."
  type        = string
  default     = null
}

variable "conversation_index" {
  description = "Indicates the position of the message within the conversation."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "extensions" {
  description = "The collection of open extensions defined for the message. Nullable."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.extension")
  }))
  default = null
}

variable "flag" {
  description = "Indicates the status, start date, due date, or completion date for the message."
  type        = any
  default     = null
}

variable "from" {
  description = "The owner of the mailbox from which the message is sent. In most cases, this value is the same as the sender property, except for sharing or delegation scenarios. The value must correspond to the actual mailbox used. Find out more about setting the from and sender properties of a message."
  type        = any
  default     = null
}

variable "has_attachments" {
  description = "Indicates whether the message has attachments. This property doesn't include inline attachments, so if a message contains only inline attachments, this property is false. To verify the existence of inline attachments, parse the body property to look for a src attribute, such as <IMG src='cid:image001.jpg@01D26CD8.6C05F070'>."
  type        = bool
  default     = null
}

variable "importance" {
  description = "The importance of the message. The possible values are: low, normal, and high."
  type        = any
  default     = null

  validation {
    condition     = var.importance == null ? true : contains(["low", "normal", "high"], var.importance)
    error_message = "importance must be one of the documented enum values."
  }
}

variable "inference_classification" {
  description = "The classification of the message for the user, based on inferred relevance or importance, or on an explicit override. The possible values are: focused or other."
  type        = any
  default     = null

  validation {
    condition     = var.inference_classification == null ? true : contains(["focused", "other"], var.inference_classification)
    error_message = "inference_classification must be one of the documented enum values."
  }
}

variable "internet_message_id" {
  description = "The message ID in the format specified by RFC2822."
  type        = string
  default     = null
}

variable "is_delivery_receipt_requested" {
  description = "Indicates whether a read receipt is requested for the message."
  type        = bool
  default     = null
}

variable "is_draft" {
  description = "Indicates whether the message is a draft. A message is a draft if it hasn't been sent yet."
  type        = bool
  default     = null
}

variable "is_read" {
  description = "Indicates whether the message has been read."
  type        = bool
  default     = null
}

variable "is_read_receipt_requested" {
  description = "Indicates whether a read receipt is requested for the message."
  type        = bool
  default     = null
}

variable "last_modified_date_time" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "multi_value_extended_properties" {
  description = "The collection of multi-value extended properties defined for the message. Nullable."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.multiValueLegacyExtendedProperty")
    value      = optional(list(string))
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.message"
  nullable    = false
}

variable "parent_folder_id" {
  description = "The unique identifier for the message's parent mailFolder."
  type        = string
  default     = null
}

variable "received_date_time" {
  description = "The date and time the message was received.  The date and time information uses ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "reply_to" {
  description = "The email addresses to use when replying."
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.recipient")
    emailAddress = optional(any)
  }))
  default = null
}

variable "sender" {
  description = "The account that is used to generate the message. In most cases, this value is the same as the from property. You can set this property to a different value when sending a message from a shared mailbox, for a shared calendar, or as a delegate. In any case, the value must correspond to the actual mailbox used. Find out more about setting the from and sender properties of a message."
  type        = any
  default     = null
}

variable "sent_date_time" {
  description = "The date and time the message was sent.  The date and time information uses ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "single_value_extended_properties" {
  description = "The collection of single-value extended properties defined for the message. Nullable."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.singleValueLegacyExtendedProperty")
    value      = optional(string)
  }))
  default = null
}

variable "subject" {
  description = "The subject of the message."
  type        = string
  default     = null
}

variable "to_recipients" {
  description = "The To: recipients for the message."
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.recipient")
    emailAddress = optional(any)
  }))
  default = null
}

variable "unique_body" {
  description = "The part of the body of the message that is unique to the current message. uniqueBody is not returned by default but can be retrieved for a given message by use of the ?$select=uniqueBody query. It can be in HTML or text format."
  type        = any
  default     = null
}

variable "web_link" {
  description = "The URL to open the message in Outlook on the web.You can append an ispopout argument to the end of the URL to change how the message is displayed. If ispopout is not present or if it is set to 1, then the message is shown in a popout window. If ispopout is set to 0, the browser shows the message in the Outlook on the web review pane.The message opens in the browser if you are signed in to your mailbox via Outlook on the web. You are prompted to sign in if you are not already signed in with the browser.This URL cannot be accessed from within an iFrame.NOTE: When using this URL to access a message from a mailbox with delegate permissions, both the signed-in user and the target mailbox must be in the same database region. For example, an error is returned when a user with a mailbox in the EUR (Europe) region attempts to access messages from a mailbox in the NAM (North America) region."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["changeKey", "id", "internetMessageHeaders"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
