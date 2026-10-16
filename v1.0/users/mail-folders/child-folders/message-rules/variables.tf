variable "user_id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_id)) > 0
    error_message = "user_id must not be empty."
  }
}

variable "mail_folder_id" {
  description = "The unique identifier of mailFolder"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.mail_folder_id)) > 0
    error_message = "mail_folder_id must not be empty."
  }
}

variable "mail_folder_id1" {
  description = "The unique identifier of mailFolder"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.mail_folder_id1)) > 0
    error_message = "mail_folder_id1 must not be empty."
  }
}

variable "actions" {
  description = "Actions to be taken on a message when the corresponding conditions are fulfilled."
  type = object({
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
  })
  default = null
}

variable "conditions" {
  description = "Conditions that when fulfilled trigger the corresponding actions for that rule."
  type = object({
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
  })
  default = null
}

variable "display_name" {
  description = "The display name of the rule."
  type        = string
  default     = null
}

variable "exceptions" {
  description = "Exception conditions for the rule."
  type = object({
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
  })
  default = null
}

variable "is_enabled" {
  description = "Indicates whether the rule is enabled to be applied to messages."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.messageRule"
  nullable    = false
}

variable "sequence" {
  description = "Indicates the order in which the rule is executed, among other rules."
  type        = number
  default     = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["hasError", "id", "isReadOnly"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
