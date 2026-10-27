variable "chat_type" {
  description = "Microsoft Graph chatType property."
  type        = string
  default     = null

  validation {
    condition     = var.chat_type == null ? true : contains(["oneOnOne", "group", "meeting"], var.chat_type)
    error_message = "chat_type must be one of the documented enum values."
  }
}

variable "installed_apps" {
  description = "A collection of all the apps in the chat. Nullable."
  type        = any
  default     = null
}

variable "last_message_preview" {
  description = "Preview of the last message sent in the chat. Null if no messages were sent in the chat. Currently, only the list chats operation supports this property."
  type        = any
  default     = null
}

variable "members" {
  description = "A collection of all the members in the chat. Nullable."
  type        = any
  default     = null
}

variable "messages" {
  description = "A collection of all the messages in the chat. Nullable."
  type        = any
  default     = null
}

variable "migration_mode" {
  description = "Indicates whether a chat is in migration mode. This value is null for chats that never entered migration mode. The possible values are: inProgress, completed, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.migration_mode == null ? true : contains(["inProgress", "completed"], var.migration_mode)
    error_message = "migration_mode must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.chat"
  nullable    = false
}

variable "original_created_date_time" {
  description = "Timestamp of the original creation time for the chat. The value is null if the chat never entered migration mode."
  type        = string
  default     = null
}

variable "permission_grants" {
  description = "A collection of permissions granted to apps for the chat."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")
    deletedDateTime = optional(string)
  }))
  default = null
}

variable "pinned_messages" {
  description = "A collection of all the pinned messages in the chat. Nullable."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.pinnedChatMessageInfo")
    message    = optional(any)
  }))
  default = null
}

variable "tabs" {
  description = "A collection of all the tabs in the chat. Nullable."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.teamsTab")
    configuration = optional(object({
      odata_type = optional(string, "#microsoft.graph.teamsTabConfiguration")
      contentUrl = optional(string)
      entityId   = optional(string)
      removeUrl  = optional(string)
      websiteUrl = optional(string)
    }))
    displayName = optional(string)
    teamsApp    = optional(any)
  }))
  default = null
}

variable "targeted_messages" {
  description = "A collection of targeted messages in the chat that are visible only to specific users. Nullable. You can't expand this relationship using $expand. Targeted messages can also be retrieved via the userTeamwork: getAllTargetedMessages API."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.targetedChatMessage")
    attachments = optional(list(object({
      odata_type   = optional(string, "#microsoft.graph.chatMessageAttachment")
      content      = optional(string)
      contentType  = optional(string)
      contentUrl   = optional(string)
      name         = optional(string)
      teamsAppId   = optional(string)
      thumbnailUrl = optional(string)
    })))
    body = optional(object({
      odata_type  = optional(string, "#microsoft.graph.itemBody")
      content     = optional(string)
      contentType = optional(string)
    }))
    channelIdentity = optional(object({
      odata_type = optional(string, "#microsoft.graph.channelIdentity")
      channelId  = optional(string)
      teamId     = optional(string)
    }))
    chatId          = optional(string)
    createdDateTime = optional(string)
    from = optional(object({
      odata_type  = optional(string, "#microsoft.graph.chatMessageFromIdentitySet")
      application = optional(any)
      device      = optional(any)
      user        = optional(any)
    }))
    hostedContents = optional(list(object({
      odata_type   = optional(string, "#microsoft.graph.chatMessageHostedContent")
      contentBytes = optional(string)
      contentType  = optional(string)
    })))
    importance = optional(string)
    locale     = optional(string)
    mentions = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.chatMessageMention")
      id          = optional(number)
      mentionText = optional(string)
      mentioned = optional(object({
        odata_type   = optional(string, "#microsoft.graph.chatMessageMentionedIdentitySet")
        application  = optional(any)
        conversation = optional(any)
        device       = optional(any)
        user         = optional(any)
      }))
    })))
    messageHistory = optional(list(object({
      odata_type       = optional(string, "#microsoft.graph.chatMessageHistoryItem")
      actions          = optional(string)
      modifiedDateTime = optional(string)
      reaction = optional(object({
        odata_type         = optional(string, "#microsoft.graph.chatMessageReaction")
        createdDateTime    = optional(string)
        displayName        = optional(string)
        reactionContentUrl = optional(string)
        reactionType       = optional(string)
        user               = optional(any)
      }))
    })))
    messageType = optional(string)
    policyViolation = optional(object({
      odata_type        = optional(string, "#microsoft.graph.chatMessagePolicyViolation")
      dlpAction         = optional(string)
      justificationText = optional(string)
      policyTip = optional(object({
        odata_type                   = optional(string, "#microsoft.graph.chatMessagePolicyViolationPolicyTip")
        complianceUrl                = optional(string)
        generalText                  = optional(string)
        matchedConditionDescriptions = optional(list(string))
      }))
      userAction     = optional(string)
      verdictDetails = optional(string)
    }))
    reactions = optional(list(object({
      odata_type         = optional(string, "#microsoft.graph.chatMessageReaction")
      createdDateTime    = optional(string)
      displayName        = optional(string)
      reactionContentUrl = optional(string)
      reactionType       = optional(string)
      user = optional(object({
        odata_type  = optional(string, "#microsoft.graph.chatMessageReactionIdentitySet")
        application = optional(any)
        device      = optional(any)
        user        = optional(any)
      }))
    })))
    recipient = optional(any)
    replies   = optional(any)
    subject   = optional(string)
    summary   = optional(string)
  }))
  default = null

  validation {
    condition     = (var.targeted_messages == null ? true : alltrue([alltrue([for input0 in var.targeted_messages : (input0 == null ? true : alltrue([(input0["body"] == null ? true : alltrue([(input0["body"]["contentType"] == null ? true : alltrue([(input0["body"]["contentType"] == null ? true : contains(["text", "html"], input0["body"]["contentType"]))]))])), (input0["importance"] == null ? true : alltrue([(input0["importance"] == null ? true : contains(["normal", "high", "urgent"], input0["importance"]))])), (input0["messageHistory"] == null ? true : alltrue([alltrue([for input2 in input0["messageHistory"] : (input2 == null ? true : alltrue([(input2["actions"] == null ? true : alltrue([(input2["actions"] == null ? true : try(alltrue([for value in split(",", input2["actions"]) : contains(["reactionadded", "reactionremoved", "actionundefined"], lower(trimspace(value)))]), false))]))]))])])), (input0["messageType"] == null ? true : alltrue([(input0["messageType"] == null ? true : contains(["message", "chatEvent", "typing"], input0["messageType"]))])), (input0["policyViolation"] == null ? true : alltrue([(input0["policyViolation"]["dlpAction"] == null ? true : alltrue([(input0["policyViolation"]["dlpAction"] == null ? true : try(alltrue([for value in split(",", input0["policyViolation"]["dlpAction"]) : contains(["none", "notifysender", "blockaccess", "blockaccessexternal"], lower(trimspace(value)))]), false))])), (input0["policyViolation"]["userAction"] == null ? true : alltrue([(input0["policyViolation"]["userAction"] == null ? true : try(alltrue([for value in split(",", input0["policyViolation"]["userAction"]) : contains(["none", "override", "reportfalsepositive"], lower(trimspace(value)))]), false))])), (input0["policyViolation"]["verdictDetails"] == null ? true : alltrue([(input0["policyViolation"]["verdictDetails"] == null ? true : try(alltrue([for value in split(",", input0["policyViolation"]["verdictDetails"]) : contains(["none", "allowfalsepositiveoverride", "allowoverridewithoutjustification", "allowoverridewithjustification"], lower(trimspace(value)))]), false))]))]))]))])]))
    error_message = "targeted_messages: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "topic" {
  description = "(Optional) Subject or topic for the chat. Only available for group chats."
  type        = string
  default     = null
}

variable "viewpoint" {
  description = "Represents caller-specific information about the chat, such as the last message read date and time. This property is populated only when the request is made in a delegated context."
  type = object({
    odata_type              = optional(string, "#microsoft.graph.chatViewpoint")
    isHidden                = optional(bool)
    lastMessageReadDateTime = optional(string)
  })
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "isHiddenForAllMembers", "lastUpdatedDateTime", "onlineMeetingInfo", "tenantId", "webUrl"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
