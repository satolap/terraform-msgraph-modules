variable "user_id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_id)) > 0
    error_message = "user_id must not be empty."
  }
}

variable "child_folder_count" {
  description = "The number of immediate child mailFolders in the current mailFolder."
  type        = number
  default     = null
}

variable "child_folders" {
  description = "The collection of child folders in the mailFolder."
  type        = any
  default     = null
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
    odata_type = optional(string, "#microsoft.graph.messageRule")
    actions = optional(object({
      odata_type            = optional(string, "#microsoft.graph.messageRuleActions")
      assignCategories      = optional(list(string))
      copyToFolder          = optional(string)
      delete                = optional(bool)
      forwardAsAttachmentTo = optional(any)
      forwardTo             = optional(any)
      markAsRead            = optional(bool)
      markImportance        = optional(string)
      moveToFolder          = optional(string)
      permanentDelete       = optional(bool)
      redirectTo            = optional(any)
      stopProcessingRules   = optional(bool)
    }))
    conditions = optional(object({
      odata_type             = optional(string, "#microsoft.graph.messageRulePredicates")
      bodyContains           = optional(list(string))
      bodyOrSubjectContains  = optional(list(string))
      categories             = optional(list(string))
      fromAddresses          = optional(any)
      hasAttachments         = optional(bool)
      headerContains         = optional(list(string))
      importance             = optional(string)
      isApprovalRequest      = optional(bool)
      isAutomaticForward     = optional(bool)
      isAutomaticReply       = optional(bool)
      isEncrypted            = optional(bool)
      isMeetingRequest       = optional(bool)
      isMeetingResponse      = optional(bool)
      isNonDeliveryReport    = optional(bool)
      isPermissionControlled = optional(bool)
      isReadReceipt          = optional(bool)
      isSigned               = optional(bool)
      isVoicemail            = optional(bool)
      messageActionFlag      = optional(string)
      notSentToMe            = optional(bool)
      recipientContains      = optional(list(string))
      senderContains         = optional(list(string))
      sensitivity            = optional(string)
      sentCcMe               = optional(bool)
      sentOnlyToMe           = optional(bool)
      sentToAddresses        = optional(any)
      sentToMe               = optional(bool)
      sentToOrCcMe           = optional(bool)
      subjectContains        = optional(list(string))
      withinSizeRange = optional(object({
        odata_type  = optional(string, "#microsoft.graph.sizeRange")
        maximumSize = optional(number)
        minimumSize = optional(number)
      }))
    }))
    displayName = optional(string)
    exceptions = optional(object({
      odata_type             = optional(string, "#microsoft.graph.messageRulePredicates")
      bodyContains           = optional(list(string))
      bodyOrSubjectContains  = optional(list(string))
      categories             = optional(list(string))
      fromAddresses          = optional(any)
      hasAttachments         = optional(bool)
      headerContains         = optional(list(string))
      importance             = optional(string)
      isApprovalRequest      = optional(bool)
      isAutomaticForward     = optional(bool)
      isAutomaticReply       = optional(bool)
      isEncrypted            = optional(bool)
      isMeetingRequest       = optional(bool)
      isMeetingResponse      = optional(bool)
      isNonDeliveryReport    = optional(bool)
      isPermissionControlled = optional(bool)
      isReadReceipt          = optional(bool)
      isSigned               = optional(bool)
      isVoicemail            = optional(bool)
      messageActionFlag      = optional(string)
      notSentToMe            = optional(bool)
      recipientContains      = optional(list(string))
      senderContains         = optional(list(string))
      sensitivity            = optional(string)
      sentCcMe               = optional(bool)
      sentOnlyToMe           = optional(bool)
      sentToAddresses        = optional(any)
      sentToMe               = optional(bool)
      sentToOrCcMe           = optional(bool)
      subjectContains        = optional(list(string))
      withinSizeRange = optional(object({
        odata_type  = optional(string, "#microsoft.graph.sizeRange")
        maximumSize = optional(number)
        minimumSize = optional(number)
      }))
    }))
    isEnabled = optional(bool)
    sequence  = optional(number)
  }))
  default = null
}

variable "messages" {
  description = "The collection of messages in the mailFolder."
  type        = any
  default     = null
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
    status           = optional(string)
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
