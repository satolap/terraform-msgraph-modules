variable "team_id" {
  description = "The unique identifier of team"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.team_id)) > 0
    error_message = "team_id must not be empty."
  }
}

variable "all_members" {
  description = "A collection of membership records associated with the channel. It includes both direct and indirect members of shared channels."
  type        = any
  default     = null
}

variable "description" {
  description = "Optional textual description for the channel."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Channel name as it appears to the user in Microsoft Teams. The maximum length is 50 characters."
  type        = string
  default     = null
}

variable "enabled_apps" {
  description = "A collection of enabled apps in the channel."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.teamsApp")
    appDefinitions = optional(list(object({
      odata_type                = optional(string, "#microsoft.graph.teamsAppDefinition")
      allowedInstallationScopes = optional(string)
      authorization = optional(object({
        odata_type            = optional(string, "#microsoft.graph.teamsAppAuthorization")
        clientAppId           = optional(string)
        requiredPermissionSet = optional(any)
      }))
      azureADAppId         = optional(string)
      bot                  = optional(any)
      colorIcon            = optional(any)
      createdBy            = optional(any)
      dashboardCards       = optional(any)
      description          = optional(string)
      displayName          = optional(string)
      lastModifiedDateTime = optional(string)
      outlineIcon          = optional(any)
      publishingState      = optional(string)
      shortdescription     = optional(string)
      teamsAppId           = optional(string)
      version              = optional(string)
    })))
    displayName = optional(string)
    externalId  = optional(string)
  }))
  default = null

  validation {
    condition     = (var.enabled_apps == null ? true : alltrue([alltrue([for input0 in var.enabled_apps : (input0 == null ? true : alltrue([(input0["appDefinitions"] == null ? true : alltrue([alltrue([for input2 in input0["appDefinitions"] : (input2 == null ? true : alltrue([(input2["allowedInstallationScopes"] == null ? true : alltrue([(input2["allowedInstallationScopes"] == null ? true : try(alltrue([for value in split(",", input2["allowedInstallationScopes"]) : contains(["team", "groupchat", "personal"], lower(trimspace(value)))]), false))])), (input2["publishingState"] == null ? true : alltrue([(input2["publishingState"] == null ? true : contains(["submitted", "rejected", "published"], input2["publishingState"]))]))]))])]))]))])]))
    error_message = "enabled_apps: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "files_folder" {
  description = "Metadata for the location where the channel's files are stored."
  type        = any
  default     = null
}

variable "is_favorite_by_default" {
  description = "Indicates whether the channel should be marked as recommended for all members of the team to show in their channel list. Note: All recommended channels automatically show in the channels list for education and frontline worker users. The property can only be set programmatically via the Create team method. The default value is false."
  type        = bool
  default     = null
}

variable "joined_users" {
  description = "Microsoft Graph joinedUsers property."
  type        = any
  default     = null
}

variable "layout_type" {
  description = "The layout type of the channel. It can be set during creation and updated later. The possible values are: post, chat, unknownFutureValue. The default value is post. Channels with the post layout use a traditional post‑reply conversation format, and channels with the chat layout provide a chat‑like threading experience similar to group chats."
  type        = string
  default     = null

  validation {
    condition     = var.layout_type == null ? true : contains(["post", "chat"], var.layout_type)
    error_message = "layout_type must be one of the documented enum values."
  }
}

variable "members" {
  description = "A collection of membership records associated with the channel."
  type        = any
  default     = null
}

variable "membership_type" {
  description = "The type of the channel. Can be set during creation and can't be changed. The possible values are: standard, private, unknownFutureValue, shared. The default value is standard. Use the Prefer: include-unknown-enum-members request header to get the following members in this evolvable enum: shared."
  type        = string
  default     = null

  validation {
    condition     = var.membership_type == null ? true : contains(["standard", "private"], var.membership_type)
    error_message = "membership_type must be one of the documented enum values."
  }
}

variable "messages" {
  description = "A collection of all the messages in the channel. Nullable."
  type        = any
  default     = null
}

variable "migration_mode" {
  description = "Indicates whether a channel is in migration mode. This value is null for channels that never entered migration mode. The possible values are: inProgress, completed, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.migration_mode == null ? true : contains(["inProgress", "completed"], var.migration_mode)
    error_message = "migration_mode must be one of the documented enum values."
  }
}

variable "moderation_settings" {
  description = "Settings to configure channel moderation to control who can start new posts and reply to posts in that channel."
  type = object({
    odata_type                    = optional(string, "#microsoft.graph.channelModerationSettings")
    allowNewMessageFromBots       = optional(bool)
    allowNewMessageFromConnectors = optional(bool)
    replyRestriction              = optional(string)
    userNewMessageRestriction     = optional(string)
  })
  default = null

  validation {
    condition     = (var.moderation_settings == null ? true : alltrue([(var.moderation_settings["replyRestriction"] == null ? true : alltrue([(var.moderation_settings["replyRestriction"] == null ? true : contains(["everyone", "authorAndModerators"], var.moderation_settings["replyRestriction"]))])), (var.moderation_settings["userNewMessageRestriction"] == null ? true : alltrue([(var.moderation_settings["userNewMessageRestriction"] == null ? true : contains(["everyone", "everyoneExceptGuests", "moderators"], var.moderation_settings["userNewMessageRestriction"]))]))]))
    error_message = "moderation_settings: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.channel"
  nullable    = false
}

variable "original_created_date_time" {
  description = "Timestamp of the original creation time for the channel. The value is null if the channel never entered migration mode."
  type        = string
  default     = null
}

variable "shared_with_teams" {
  description = "A collection of teams with which a channel is shared."
  type = list(object({
    odata_type     = optional(string, "#microsoft.graph.sharedWithChannelTeamInfo")
    allowedMembers = optional(any)
    displayName    = optional(string)
    isHostTeam     = optional(bool)
    team           = optional(any)
    tenantId       = optional(string)
  }))
  default = null
}

variable "summary" {
  description = "Contains summary information about the channel, including number of guests, members, owners, and an indicator for members from other tenants. The summary property is only returned if it appears in the $select clause of the Get channel method."
  type = object({
    odata_type                 = optional(string, "#microsoft.graph.channelSummary")
    guestsCount                = optional(number)
    hasMembersFromOtherTenants = optional(bool)
    membersCount               = optional(number)
    ownersCount                = optional(number)
  })
  default = null
}

variable "tabs" {
  description = "A collection of all the tabs in the channel."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.teamsTab")
    configuration = optional(object({
      odata_type = optional(string, "#microsoft.graph.teamsTabConfiguration")
      contentUrl = optional(string)
      entityId   = optional(string)
      removeUrl  = optional(string)
      websiteUrl = optional(string)
    }))
    displayName    = optional(string)
    messageId      = optional(string)
    sortOrderIndex = optional(string)
    teamsApp       = optional(any)
    teamsAppId     = optional(string)
  }))
  default = null
}

variable "tenant_id" {
  description = "The ID of the Microsoft Entra tenant."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "email", "id", "isArchived", "planner", "webUrl"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
