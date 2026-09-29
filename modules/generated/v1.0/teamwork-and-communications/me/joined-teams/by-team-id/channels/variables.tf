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
  description = "A collection of membership records associated with the channel, including both direct and indirect members of shared channels."
  type        = any
  default     = null
}

variable "description" {
  description = "Optional textual description for the channel."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Channel name as it will appear to the user in Microsoft Teams. The maximum length is 50 characters."
  type        = string
  default     = null
}

variable "enabled_apps" {
  description = "A collection of enabled apps in the channel."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.teamsApp")
    appDefinitions = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.teamsAppDefinition")
      authorization = optional(object({
        odata_type            = optional(string, "#microsoft.graph.teamsAppAuthorization")
        clientAppId           = optional(string)
        requiredPermissionSet = optional(any)
      }))
      bot                  = optional(any)
      createdBy            = optional(any)
      description          = optional(string)
      displayName          = optional(string)
      lastModifiedDateTime = optional(string)
      publishingState      = optional(string)
      shortDescription     = optional(string)
      teamsAppId           = optional(string)
      version              = optional(string)
    })))
    displayName = optional(string)
    externalId  = optional(string)
  }))
  default = null
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

variable "layout_type" {
  description = "The layout type of the channel. It can be set during creation and updated later. The possible values are: post, chat, unknownFutureValue. The default value is post. Channels with the post layout use a traditional post‑reply conversation format, and channels with the chat layout provide a chat‑like threading experience similar to group chats."
  type        = string
  default     = null

  validation {
    condition     = var.layout_type == null ? true : contains(["post", "chat", "unknownFutureValue"], var.layout_type)
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
    condition     = var.membership_type == null ? true : contains(["standard", "private", "unknownFutureValue", "shared"], var.membership_type)
    error_message = "membership_type must be one of the documented enum values."
  }
}

variable "messages" {
  description = "A collection of all the messages in the channel. A navigation property. Nullable."
  type        = any
  default     = null
}

variable "migration_mode" {
  description = "Indicates whether a channel is in migration mode. This value is null for channels that never entered migration mode. The possible values are: inProgress, completed, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.migration_mode == null ? true : contains(["inProgress", "completed", "unknownFutureValue"], var.migration_mode)
    error_message = "migration_mode must be one of the documented enum values."
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
  description = "Contains summary information about the channel, including number of owners, members, guests, and an indicator for members from other tenants. The summary property will only be returned if it is specified in the $select clause of the Get channel method."
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
  description = "A collection of all the tabs in the channel. A navigation property."
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

variable "tenant_id" {
  description = "The ID of the Microsoft Entra tenant."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "email", "id", "isArchived", "webUrl"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
