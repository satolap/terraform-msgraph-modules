variable "user_id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_id)) > 0
    error_message = "user_id must not be empty."
  }
}

variable "display_icon" {
  description = "The icon displayed for the section."
  type        = any
  default     = null
}

variable "display_name" {
  description = "The display name of the section. Required. Maximum length is 50 characters. Display names are case-sensitive and must be unique within a user's sections. The following names are reserved for system-defined sections and can't be used when creating a user-defined section: RecentChats, QuickViews, TeamsAndChannels, MutedChats, MeetingChats, EngageCommunities."
  type        = string
  default     = null
}

variable "is_expanded" {
  description = "Indicates whether the section is expanded in the user interface. The default value is true."
  type        = bool
  default     = null
}

variable "items" {
  description = "The items (chats, channels, meetings, or communities) organized within the section."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.teamworkSectionItem")
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.teamworkSection"
  nullable    = false
}

variable "sort_type" {
  description = "The sort order of items in the section. The valid values depend on the sectionType. The possible values are: mostRecent, unreadThenMostRecent, nameAlphabetical, userDefinedCustomOrder, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.sort_type == null ? true : contains(["mostRecent", "unreadThenMostRecent", "nameAlphabetical", "userDefinedCustomOrder", "unknownFutureValue"], var.sort_type)
    error_message = "sort_type must be one of the documented enum values."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "isHierarchicalViewEnabled", "lastModifiedDateTime", "sectionType"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
