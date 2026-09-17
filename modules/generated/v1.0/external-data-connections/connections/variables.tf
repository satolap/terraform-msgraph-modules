variable "activity_settings" {
  description = "Collects configurable settings related to activities involving connector content."
  type        = any
  default     = null
}

variable "configuration" {
  description = "Specifies additional application IDs that are allowed to manage the connection and to index content in the connection. Optional."
  type        = any
  default     = null
}

variable "connector_id" {
  description = "The Teams app ID. Optional."
  type        = string
  default     = null
}

variable "content_category" {
  description = "Microsoft Graph contentCategory property."
  type        = string
  default     = null

  validation {
    condition     = var.content_category == null ? true : contains(["uncategorized", "knowledgeBase", "wikis", "fileRepository", "qna", "crm", "dashboard", "people", "media", "email", "messaging", "meetingTranscripts", "taskManagement", "learningManagement", "unknownFutureValue"], var.content_category)
    error_message = "content_category must be one of the documented enum values."
  }
}

variable "description" {
  description = "Description of the connection displayed in the Microsoft 365 admin center. Optional."
  type        = string
  default     = null
}

variable "groups" {
  description = "Microsoft Graph groups property."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.externalConnectors.externalGroup")
    description = optional(string)
    displayName = optional(string)
    members = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.externalConnectors.identity")
      type       = optional(any)
    })))
  }))
  default = null
}

variable "items" {
  description = "Microsoft Graph items property."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.externalConnectors.externalItem")
    acl = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.externalConnectors.acl")
      accessType = optional(string)
      type       = optional(string)
      value      = optional(string)
    })))
    activities = optional(list(object({
      odata_type    = optional(string, "#microsoft.graph.externalConnectors.externalActivity")
      performedBy   = optional(any)
      startDateTime = optional(string)
      type          = optional(string)
    })))
    content                    = optional(any)
    informationProtectionLabel = optional(any)
    properties                 = optional(any)
  }))
  default = null
}

variable "name" {
  description = "The display name of the connection to be displayed in the Microsoft 365 admin center. Maximum length of 128 characters. Required."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.externalConnectors.externalConnection"
  nullable    = false
}

variable "operations" {
  description = "Microsoft Graph operations property."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.externalConnectors.connectionOperation")
    error      = optional(any)
    status     = optional(any)
  }))
  default = null
}

variable "schema" {
  description = "Microsoft Graph schema property."
  type        = any
  default     = null
}

variable "search_settings" {
  description = "The settings configuring the search experience for content in this connection, such as the display templates for search results."
  type        = any
  default     = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "state"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
