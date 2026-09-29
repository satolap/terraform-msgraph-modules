variable "activity_settings" {
  description = "Collects configurable settings related to activities involving connector content."
  type = object({
    odata_type         = optional(string, "#microsoft.graph.externalConnectors.activitySettings")
    urlToItemResolvers = optional(any)
  })
  default = null
}

variable "compliance_settings" {
  description = "Microsoft Graph complianceSettings property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.externalConnectors.complianceSettings")
    eDiscoveryResultTemplates = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.externalConnectors.displayTemplate")
      id         = optional(string)
      layout     = optional(any)
      priority   = optional(number)
      rules = optional(list(object({
        odata_type     = optional(string, "#microsoft.graph.externalConnectors.propertyRule")
        operation      = optional(string)
        property       = optional(string)
        values         = optional(any)
        valuesJoinedBy = optional(string)
      })))
    })))
  })
  default = null
}

variable "configuration" {
  description = "Specifies additional application IDs that are allowed to manage the connection and to index content in the connection. Optional."
  type = object({
    odata_type       = optional(string, "#microsoft.graph.externalConnectors.configuration")
    authorizedAppIds = optional(list(string))
  })
  default = null
}

variable "connector_id" {
  description = "The Teams App ID. Optional."
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

variable "enabled_content_experiences" {
  description = "The list of content experiences the connection will participate in. Possible values are search."
  type        = string
  default     = null

  validation {
    condition     = var.enabled_content_experiences == null ? true : try(alltrue([for value in split(",", var.enabled_content_experiences) : contains(["search", "compliance", "unknownfuturevalue"], lower(trimspace(value)))]), false)
    error_message = "enabled_content_experiences must be one or more of the documented enum values, separated by commas."
  }
}

variable "groups" {
  description = "Microsoft Graph groups property."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.externalConnectors.externalGroup")
    description = optional(string)
    displayName = optional(string)
    members = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.externalConnectors.identity")
      type       = optional(string)
    })))
  }))
  default = null
}

variable "ingested_items_count" {
  description = "The number of items ingested into a connection. This value is refreshed every 15 minutes. If the connection state is draft, then ingestedItemsCount will be null."
  type        = number
  default     = null
}

variable "items" {
  description = "Microsoft Graph items property."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.externalConnectors.externalItem")
    acl = optional(list(object({
      odata_type     = optional(string, "#microsoft.graph.externalConnectors.acl")
      accessType     = optional(string)
      identitySource = optional(string)
      type           = optional(string)
      value          = optional(string)
    })))
    activities = optional(any)
    content = optional(object({
      odata_type = optional(string, "#microsoft.graph.externalConnectors.externalItemContent")
      type       = optional(string)
      value      = optional(string)
    }))
    informationProtectionLabel = optional(object({
      odata_type         = optional(string, "#microsoft.graph.externalConnectors.externalItemInformationProtectionLabel")
      sensitivityLabelId = optional(string)
    }))
    properties = optional(any)
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
    error = optional(object({
      odata_type = optional(string, "#microsoft.graph.publicError")
      code       = optional(string)
      details = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.publicErrorDetail")
        code       = optional(string)
        message    = optional(string)
        target     = optional(string)
      })))
      innerError = optional(object({
        odata_type = optional(string, "#microsoft.graph.publicInnerError")
        code       = optional(string)
        details    = optional(any)
        message    = optional(string)
        target     = optional(string)
      }))
      message = optional(string)
      target  = optional(string)
    }))
    status = optional(string)
  }))
  default = null
}

variable "quota" {
  description = "Microsoft Graph quota property."
  type        = any
  default     = null
}

variable "schema" {
  description = "Microsoft Graph schema property."
  type        = any
  default     = null
}

variable "search_settings" {
  description = "The settings configuring the search experience for content in this connection, such as the display templates for search results."
  type = object({
    odata_type = optional(string, "#microsoft.graph.externalConnectors.searchSettings")
    searchResultTemplates = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.externalConnectors.displayTemplate")
      id         = optional(string)
      layout     = optional(any)
      priority   = optional(number)
      rules = optional(list(object({
        odata_type     = optional(string, "#microsoft.graph.externalConnectors.propertyRule")
        operation      = optional(string)
        property       = optional(string)
        values         = optional(any)
        valuesJoinedBy = optional(string)
      })))
    })))
  })
  default = null
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
