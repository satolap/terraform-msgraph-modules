variable "childFolderCount" {
  description = "The number of immediate child mailFolders in the current mailFolder."
  type        = number
  default     = null
}

variable "childFolders" {
  description = "The collection of child folders in the mailFolder."
  type        = any
  default     = null
}

variable "displayName" {
  description = "The mailFolder's display name."
  type        = string
  default     = null
}

variable "isHidden" {
  description = "Indicates whether the mailFolder is hidden. This property can be set only when creating the folder. Find more information in Hidden mail folders."
  type        = bool
  default     = null
}

variable "messageRules" {
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

  validation {
    condition     = (var.messageRules == null ? true : alltrue([alltrue([for input0 in var.messageRules : (input0 == null ? true : alltrue([(input0["actions"] == null ? true : alltrue([(input0["actions"]["markImportance"] == null ? true : alltrue([(input0["actions"]["markImportance"] == null ? true : contains(["low", "normal", "high"], input0["actions"]["markImportance"]))]))])), (input0["conditions"] == null ? true : alltrue([(input0["conditions"]["importance"] == null ? true : alltrue([(input0["conditions"]["importance"] == null ? true : contains(["low", "normal", "high"], input0["conditions"]["importance"]))])), (input0["conditions"]["messageActionFlag"] == null ? true : alltrue([(input0["conditions"]["messageActionFlag"] == null ? true : contains(["any", "call", "doNotForward", "followUp", "fyi", "forward", "noResponseNecessary", "read", "reply", "replyToAll", "review"], input0["conditions"]["messageActionFlag"]))])), (input0["conditions"]["sensitivity"] == null ? true : alltrue([(input0["conditions"]["sensitivity"] == null ? true : contains(["normal", "personal", "private", "confidential"], input0["conditions"]["sensitivity"]))]))])), (input0["exceptions"] == null ? true : alltrue([(input0["exceptions"]["importance"] == null ? true : alltrue([(input0["exceptions"]["importance"] == null ? true : contains(["low", "normal", "high"], input0["exceptions"]["importance"]))])), (input0["exceptions"]["messageActionFlag"] == null ? true : alltrue([(input0["exceptions"]["messageActionFlag"] == null ? true : contains(["any", "call", "doNotForward", "followUp", "fyi", "forward", "noResponseNecessary", "read", "reply", "replyToAll", "review"], input0["exceptions"]["messageActionFlag"]))])), (input0["exceptions"]["sensitivity"] == null ? true : alltrue([(input0["exceptions"]["sensitivity"] == null ? true : contains(["normal", "personal", "private", "confidential"], input0["exceptions"]["sensitivity"]))]))]))]))])]))
    error_message = "messageRules: nested required attributes must be non-null and enum values must be supported input members."
  }
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

  validation {
    condition     = (var.operations == null ? true : alltrue([alltrue([for input0 in var.operations : (input0 == null ? true : alltrue([(input0["status"] == null ? true : alltrue([(input0["status"] == null ? true : contains(["notStarted", "running", "succeeded", "failed"], input0["status"]))]))]))])]))
    error_message = "operations: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "parentFolderId" {
  description = "The unique identifier for the mailFolder's parent mailFolder."
  type        = string
  default     = null
}

variable "totalItemCount" {
  description = "The number of items in the mailFolder."
  type        = number
  default     = null
}

variable "unreadItemCount" {
  description = "The number of items in the mailFolder marked as unread."
  type        = number
  default     = null
}

variable "userConfigurations" {
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

  validation {
    condition     = (var.userConfigurations == null ? true : alltrue([alltrue([for input0 in var.userConfigurations : (input0 == null ? true : alltrue([(input0["structuredData"] == null ? true : alltrue([alltrue([for input2 in input0["structuredData"] : (input2 == null ? true : alltrue([(input2["keyEntry"] == null ? true : alltrue([(input2["keyEntry"]["type"] == null ? true : alltrue([(input2["keyEntry"]["type"] == null ? true : contains(["dateTime", "boolean", "byte", "string", "integer32", "unsignedInteger32", "integer64", "unsignedInteger64", "stringArray", "byteArray"], input2["keyEntry"]["type"]))]))])), (input2["valueEntry"] == null ? true : alltrue([(input2["valueEntry"]["type"] == null ? true : alltrue([(input2["valueEntry"]["type"] == null ? true : contains(["dateTime", "boolean", "byte", "string", "integer32", "unsignedInteger32", "integer64", "unsignedInteger64", "stringArray", "byteArray"], input2["valueEntry"]["type"]))]))]))]))])]))]))])]))
    error_message = "userConfigurations: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "wellKnownName" {
  description = "The well-known folder name for the folder. The possible values are listed above. This property is only set for default folders created by Outlook. For other folders, this property is null."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "multiValueExtendedProperties", "singleValueExtendedProperties"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
