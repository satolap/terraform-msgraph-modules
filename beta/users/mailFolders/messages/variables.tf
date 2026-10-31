variable "user-id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user-id)) > 0
    error_message = "user-id must not be empty."
  }
}

variable "mailFolder-id" {
  description = "The unique identifier of mailFolder"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.mailFolder-id)) > 0
    error_message = "mailFolder-id must not be empty."
  }
}

variable "attachments" {
  description = "The fileAttachment and itemAttachment attachments for the message."
  type        = any
  default     = null
}

variable "bccRecipients" {
  description = "The Bcc: recipients for the message."
  type        = any
  default     = null
}

variable "body" {
  description = "The body of the message. It can be in HTML or text format. Find out about safe HTML in a message body."
  type = object({
    odata_type  = optional(string, "#microsoft.graph.itemBody")
    content     = optional(string)
    contentType = optional(string)
  })
  default = null

  validation {
    condition     = (var.body == null ? true : alltrue([(var.body["contentType"] == null ? true : alltrue([(var.body["contentType"] == null ? true : contains(["text", "html"], var.body["contentType"]))]))]))
    error_message = "body: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "bodyPreview" {
  description = "The first 255 characters of the message body. It is in text format. If the message contains instances of mention, this property would contain a concatenation of these mentions as well."
  type        = string
  default     = null
}

variable "categories" {
  description = "The categories associated with the item."
  type        = list(string)
  default     = null
}

variable "ccRecipients" {
  description = "The Cc: recipients for the message."
  type        = any
  default     = null
}

variable "conversationId" {
  description = "The ID of the conversation the email belongs to."
  type        = string
  default     = null
}

variable "conversationIndex" {
  description = "Indicates the position of the message within the conversation."
  type        = string
  default     = null
}

variable "createdDateTime" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "extensions" {
  description = "The collection of open extensions defined for the message. Nullable."
  type        = any
  default     = null
}

variable "flag" {
  description = "The flag value that indicates the status, start date, due date, or completion date for the message."
  type = object({
    odata_type = optional(string, "#microsoft.graph.followupFlag")
    completedDateTime = optional(object({
      odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
      dateTime   = optional(string)
      timeZone   = optional(string)
    }))
    dueDateTime = optional(object({
      odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
      dateTime   = optional(string)
      timeZone   = optional(string)
    }))
    flagStatus = optional(string)
    startDateTime = optional(object({
      odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
      dateTime   = optional(string)
      timeZone   = optional(string)
    }))
  })
  default = null

  validation {
    condition     = (var.flag == null ? true : alltrue([(var.flag["flagStatus"] == null ? true : alltrue([(var.flag["flagStatus"] == null ? true : contains(["notFlagged", "complete", "flagged"], var.flag["flagStatus"]))]))]))
    error_message = "flag: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "from" {
  description = "The owner of the mailbox from which the message is sent. In most cases, this value is the same as the sender property, except for sharing or delegation scenarios. The value must correspond to the actual mailbox used. Find out more about setting the from and sender properties of a message."
  type        = any
  default     = null
}

variable "hasAttachments" {
  description = "Indicates whether the message has attachments. This property doesn't include inline attachments, so if a message contains only inline attachments, this property is false. To verify the existence of inline attachments, parse the body property to look for a src attribute, such as <IMG src='cid:image001.jpg@01D26CD8.6C05F070'>."
  type        = bool
  default     = null
}

variable "importance" {
  description = "The importance of the message. The possible values are: low, normal, and high."
  type        = string
  default     = null

  validation {
    condition     = var.importance == null ? true : contains(["low", "normal", "high"], var.importance)
    error_message = "importance must be one of the documented enum values."
  }
}

variable "inferenceClassification" {
  description = "The classification of the message for the user, based on inferred relevance or importance, or on an explicit override. The possible values are: focused, other."
  type        = string
  default     = null

  validation {
    condition     = var.inferenceClassification == null ? true : contains(["focused", "other"], var.inferenceClassification)
    error_message = "inferenceClassification must be one of the documented enum values."
  }
}

variable "internetMessageId" {
  description = "The message ID in the format specified by RFC5322. Updatable only if isDraft is true."
  type        = string
  default     = null
}

variable "isDeliveryReceiptRequested" {
  description = "Indicates whether a read receipt is requested for the message."
  type        = bool
  default     = null
}

variable "isDraft" {
  description = "Indicates whether the message is a draft. A message is a draft if it hasn't been sent yet."
  type        = bool
  default     = null
}

variable "isRead" {
  description = "Indicates whether the message has been read."
  type        = bool
  default     = null
}

variable "isReadReceiptRequested" {
  description = "Indicates whether a read receipt is requested for the message."
  type        = bool
  default     = null
}

variable "lastModifiedDateTime" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "mentions" {
  description = "A collection of mentions in the message, ordered by the createdDateTime from the newest to the oldest. By default, a GET /messages does not return this property unless you apply $expand on the property."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.mention")
    application           = optional(string)
    clientReference       = optional(string)
    createdBy             = optional(any)
    createdDateTime       = optional(string)
    deepLink              = optional(string)
    mentionText           = optional(string)
    mentioned             = optional(any)
    serverCreatedDateTime = optional(string)
  }))
  default = null
}

variable "mentionsPreview" {
  description = "Information about mentions in the message. When processing a GET /messages request, the server sets this property and includes it in the response by default. The server returns null if there are no mentions in the message. Optional."
  type = object({
    odata_type = optional(string, "#microsoft.graph.mentionsPreview")
  })
  default = null
}

variable "multiValueExtendedProperties" {
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

variable "parentFolderId" {
  description = "The unique identifier for the message's parent mailFolder."
  type        = string
  default     = null
}

variable "receivedDateTime" {
  description = "The date and time the message was received.  The date and time information uses ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "replyTo" {
  description = "The email addresses to use when replying."
  type        = any
  default     = null
}

variable "sender" {
  description = "The account that is actually used to generate the message. In most cases, this value is the same as the from property. You can set this property to a different value when sending a message from a shared mailbox, for a shared calendar, or as a delegate. In any case, the value must correspond to the actual mailbox used. Find out more about setting the from and sender properties of a message."
  type        = any
  default     = null
}

variable "sentDateTime" {
  description = "The date and time the message was sent.  The date and time information uses ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "singleValueExtendedProperties" {
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

variable "toRecipients" {
  description = "The To: recipients for the message."
  type        = any
  default     = null
}

variable "uniqueBody" {
  description = "The part of the body of the message that is unique to the current message. uniqueBody is not returned by default but can be retrieved for a given message by use of the ?$select=uniqueBody query. It can be in HTML or text format."
  type = object({
    odata_type  = optional(string, "#microsoft.graph.itemBody")
    content     = optional(string)
    contentType = optional(string)
  })
  default = null

  validation {
    condition     = (var.uniqueBody == null ? true : alltrue([(var.uniqueBody["contentType"] == null ? true : alltrue([(var.uniqueBody["contentType"] == null ? true : contains(["text", "html"], var.uniqueBody["contentType"]))]))]))
    error_message = "uniqueBody: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "unsubscribeData" {
  description = "The valid entries parsed from the List-Unsubscribe header.  This is the data for the mail command in the List-Unsubscribe header if UnsubscribeEnabled property is true."
  type        = list(string)
  default     = null
}

variable "unsubscribeEnabled" {
  description = "Indicates whether the message is enabled for unsubscribe.  Its valueTrue if the list-Unsubscribe header conforms to rfc-2369."
  type        = bool
  default     = null
}

variable "webLink" {
  description = "The URL to open the message in Outlook on the web.You can append an ispopout argument to the end of the URL to change how the message is displayed. If ispopout is not present or if it is set to 1, then the message is shown in a popout window. If ispopout is set to 0, the browser shows the message in the Outlook on the web review pane.The message opens in the browser if you are signed in to your mailbox via Outlook on the web. You are prompted to sign in if you are not already signed in with the browser.This URL cannot be accessed from within an iFrame."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["changeKey", "id", "internetMessageHeaders"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
