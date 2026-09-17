variable "child_folder_count" {
  description = "The number of immediate child mailFolders in the current mailFolder."
  type        = number
  default     = null
}

variable "child_folders" {
  description = "The collection of child folders in the mailFolder."
  type = list(object({
    odata_type       = optional(string, "#microsoft.graph.mailFolder")
    childFolderCount = optional(number)
    childFolders     = optional(any)
    displayName      = optional(string)
    isHidden         = optional(bool)
    messageRules = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.messageRule")
      actions     = optional(any)
      conditions  = optional(any)
      displayName = optional(string)
      exceptions  = optional(any)
      isEnabled   = optional(bool)
      sequence    = optional(number)
    })))
    messages = optional(list(object({
      odata_type                    = optional(string, "#microsoft.graph.message")
      attachments                   = optional(any)
      bccRecipients                 = optional(any)
      body                          = optional(any)
      bodyPreview                   = optional(string)
      categories                    = optional(list(string))
      ccRecipients                  = optional(any)
      conversationId                = optional(string)
      conversationIndex             = optional(string)
      createdDateTime               = optional(string)
      extensions                    = optional(any)
      flag                          = optional(any)
      from                          = optional(any)
      hasAttachments                = optional(bool)
      importance                    = optional(any)
      inferenceClassification       = optional(any)
      internetMessageId             = optional(string)
      isDeliveryReceiptRequested    = optional(bool)
      isDraft                       = optional(bool)
      isRead                        = optional(bool)
      isReadReceiptRequested        = optional(bool)
      lastModifiedDateTime          = optional(string)
      mentions                      = optional(any)
      mentionsPreview               = optional(any)
      multiValueExtendedProperties  = optional(any)
      parentFolderId                = optional(string)
      receivedDateTime              = optional(string)
      replyTo                       = optional(any)
      sender                        = optional(any)
      sentDateTime                  = optional(string)
      singleValueExtendedProperties = optional(any)
      subject                       = optional(string)
      toRecipients                  = optional(any)
      uniqueBody                    = optional(any)
      unsubscribeData               = optional(list(string))
      unsubscribeEnabled            = optional(bool)
      webLink                       = optional(string)
    })))
    operations = optional(list(object({
      odata_type       = optional(string, "#microsoft.graph.mailFolderOperation")
      resourceLocation = optional(string)
      status           = optional(any)
    })))
    parentFolderId  = optional(string)
    totalItemCount  = optional(number)
    unreadItemCount = optional(number)
    userConfigurations = optional(list(object({
      odata_type     = optional(string, "#microsoft.graph.userConfiguration")
      binaryData     = optional(string)
      structuredData = optional(any)
      xmlData        = optional(string)
    })))
    wellKnownName = optional(string)
  }))
  default = null
}

variable "display_name" {
  description = "The mailFolder's display name."
  type        = string
  default     = null
}

variable "is_hidden" {
  description = "Indicates whether the mailFolder is hidden. This property can be set only when creating the folder. Find more information in Hidden mail folders."
  type        = bool
  default     = null
}

variable "message_rules" {
  description = "The collection of rules that apply to the user's Inbox folder."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.messageRule")
    actions     = optional(any)
    conditions  = optional(any)
    displayName = optional(string)
    exceptions  = optional(any)
    isEnabled   = optional(bool)
    sequence    = optional(number)
  }))
  default = null
}

variable "messages" {
  description = "The collection of messages in the mailFolder."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.message")
    attachments = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.attachment")
      contentType          = optional(string)
      isInline             = optional(bool)
      lastModifiedDateTime = optional(string)
      name                 = optional(string)
      size                 = optional(number)
    })))
    bccRecipients = optional(list(object({
      odata_type   = optional(string, "#microsoft.graph.recipient")
      emailAddress = optional(any)
    })))
    body        = optional(any)
    bodyPreview = optional(string)
    categories  = optional(list(string))
    ccRecipients = optional(list(object({
      odata_type   = optional(string, "#microsoft.graph.recipient")
      emailAddress = optional(any)
    })))
    conversationId    = optional(string)
    conversationIndex = optional(string)
    createdDateTime   = optional(string)
    extensions = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.extension")
    })))
    flag                       = optional(any)
    from                       = optional(any)
    hasAttachments             = optional(bool)
    importance                 = optional(any)
    inferenceClassification    = optional(any)
    internetMessageId          = optional(string)
    isDeliveryReceiptRequested = optional(bool)
    isDraft                    = optional(bool)
    isRead                     = optional(bool)
    isReadReceiptRequested     = optional(bool)
    lastModifiedDateTime       = optional(string)
    mentions = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.mention")
      application     = optional(string)
      clientReference = optional(string)
      createdBy       = optional(any)
      createdDateTime = optional(string)
      deepLink        = optional(string)
      mentionText     = optional(string)
      mentioned = optional(object({
        odata_type = optional(string, "#microsoft.graph.emailAddress")
        address    = optional(string)
        name       = optional(string)
      }))
      serverCreatedDateTime = optional(string)
    })))
    mentionsPreview = optional(any)
    multiValueExtendedProperties = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.multiValueLegacyExtendedProperty")
      value      = optional(list(string))
    })))
    parentFolderId   = optional(string)
    receivedDateTime = optional(string)
    replyTo = optional(list(object({
      odata_type   = optional(string, "#microsoft.graph.recipient")
      emailAddress = optional(any)
    })))
    sender       = optional(any)
    sentDateTime = optional(string)
    singleValueExtendedProperties = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.singleValueLegacyExtendedProperty")
      value      = optional(string)
    })))
    subject = optional(string)
    toRecipients = optional(list(object({
      odata_type   = optional(string, "#microsoft.graph.recipient")
      emailAddress = optional(any)
    })))
    uniqueBody         = optional(any)
    unsubscribeData    = optional(list(string))
    unsubscribeEnabled = optional(bool)
    webLink            = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.mailFolder"
  nullable    = false
}

variable "operations" {
  description = "The collection of long-running operations in the mailFolder."
  type = list(object({
    odata_type       = optional(string, "#microsoft.graph.mailFolderOperation")
    resourceLocation = optional(string)
    status           = optional(any)
  }))
  default = null
}

variable "parent_folder_id" {
  description = "The unique identifier for the mailFolder's parent mailFolder."
  type        = string
  default     = null
}

variable "total_item_count" {
  description = "The number of items in the mailFolder."
  type        = number
  default     = null
}

variable "unread_item_count" {
  description = "The number of items in the mailFolder marked as unread."
  type        = number
  default     = null
}

variable "user_configurations" {
  description = "The user configuration objects associated to the mailFolder."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.userConfiguration")
    binaryData = optional(string)
    structuredData = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.structuredDataEntry")
      keyEntry = optional(object({
        odata_type = optional(string, "#microsoft.graph.structuredDataEntryTypedValue")
        type       = optional(string)
        values     = optional(any)
      }))
      valueEntry = optional(object({
        odata_type = optional(string, "#microsoft.graph.structuredDataEntryTypedValue")
        type       = optional(string)
        values     = optional(any)
      }))
    })))
    xmlData = optional(string)
  }))
  default = null
}

variable "well_known_name" {
  description = "The well-known folder name for the folder. The possible values are listed above. This property is only set for default folders created by Outlook. For other folders, this property is null."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "multiValueExtendedProperties", "singleValueExtendedProperties"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
