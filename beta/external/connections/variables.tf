variable "activitySettings" {
  description = "Collects configurable settings related to activities involving connector content."
  type = object({
    odata_type         = optional(string, "#microsoft.graph.externalConnectors.activitySettings")
    urlToItemResolvers = optional(any)
  })
  default = null
}

variable "complianceSettings" {
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

  validation {
    condition     = (var.complianceSettings == null ? true : alltrue([(var.complianceSettings["eDiscoveryResultTemplates"] == null ? true : alltrue([alltrue([for input1 in var.complianceSettings["eDiscoveryResultTemplates"] : (input1 == null ? true : alltrue([(input1["rules"] == null ? true : alltrue([alltrue([for input3 in input1["rules"] : (input3 == null ? true : alltrue([(input3["operation"] == null ? true : alltrue([(input3["operation"] == null ? true : contains(["null", "equals", "notEquals", "contains", "notContains", "lessThan", "greaterThan", "startsWith"], input3["operation"]))])), (input3["valuesJoinedBy"] == null ? true : alltrue([(input3["valuesJoinedBy"] == null ? true : contains(["or", "and"], input3["valuesJoinedBy"]))]))]))])]))]))])]))]))
    error_message = "complianceSettings: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "configuration" {
  description = "Specifies additional application IDs that are allowed to manage the connection and to index content in the connection. Optional."
  type = object({
    odata_type       = optional(string, "#microsoft.graph.externalConnectors.configuration")
    authorizedAppIds = optional(list(string))
  })
  default = null
}

variable "connectorId" {
  description = "The Teams App ID. Optional."
  type        = string
  default     = null
}

variable "contentCategory" {
  description = "Microsoft Graph contentCategory property."
  type        = string
  default     = null

  validation {
    condition     = var.contentCategory == null ? true : contains(["uncategorized", "knowledgeBase", "wikis", "fileRepository", "qna", "crm", "dashboard", "people", "media", "email", "messaging", "meetingTranscripts", "taskManagement", "learningManagement"], var.contentCategory)
    error_message = "contentCategory must be one of the documented enum values."
  }
}

variable "description" {
  description = "Description of the connection displayed in the Microsoft 365 admin center. Optional."
  type        = string
  default     = null
}

variable "enabledContentExperiences" {
  description = "The list of content experiences the connection will participate in. Possible values are search."
  type        = string
  default     = null

  validation {
    condition     = var.enabledContentExperiences == null ? true : try(alltrue([for value in split(",", var.enabledContentExperiences) : contains(["search", "compliance"], lower(trimspace(value)))]), false)
    error_message = "enabledContentExperiences must be one or more of the documented enum values, separated by commas."
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

  validation {
    condition     = (var.groups == null ? true : alltrue([alltrue([for input0 in var.groups : (input0 == null ? true : alltrue([(input0["members"] == null ? true : alltrue([alltrue([for input2 in input0["members"] : (input2 == null ? true : alltrue([(input2["type"] == null ? true : alltrue([(input2["type"] == null ? true : contains(["user", "group", "externalGroup"], input2["type"]))]))]))])]))]))])]))
    error_message = "groups: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "ingestedItemsCount" {
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

  validation {
    condition     = (var.items == null ? true : alltrue([alltrue([for input0 in var.items : (input0 == null ? true : alltrue([(input0["acl"] == null ? true : alltrue([alltrue([for input2 in input0["acl"] : (input2 == null ? true : alltrue([(input2["accessType"] == null ? true : alltrue([(input2["accessType"] == null ? true : contains(["grant", "deny"], input2["accessType"]))])), (input2["identitySource"] == null ? true : alltrue([(input2["identitySource"] == null ? true : contains(["azureActiveDirectory", "external"], input2["identitySource"]))])), (input2["type"] == null ? true : alltrue([(input2["type"] == null ? true : contains(["user", "group", "everyone", "everyoneExceptGuests", "externalGroup"], input2["type"]))]))]))])])), (input0["content"] == null ? true : alltrue([(input0["content"]["type"] == null ? true : alltrue([(input0["content"]["type"] == null ? true : contains(["text", "html"], input0["content"]["type"]))]))]))]))])]))
    error_message = "items: nested required attributes must be non-null and enum values must be supported input members."
  }
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

  validation {
    condition     = (var.operations == null ? true : alltrue([alltrue([for input0 in var.operations : (input0 == null ? true : alltrue([(input0["status"] == null ? true : alltrue([(input0["status"] == null ? true : contains(["unspecified", "inprogress", "completed", "failed"], input0["status"]))]))]))])]))
    error_message = "operations: nested required attributes must be non-null and enum values must be supported input members."
  }
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

variable "searchSettings" {
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

  validation {
    condition     = (var.searchSettings == null ? true : alltrue([(var.searchSettings["searchResultTemplates"] == null ? true : alltrue([alltrue([for input1 in var.searchSettings["searchResultTemplates"] : (input1 == null ? true : alltrue([(input1["rules"] == null ? true : alltrue([alltrue([for input3 in input1["rules"] : (input3 == null ? true : alltrue([(input3["operation"] == null ? true : alltrue([(input3["operation"] == null ? true : contains(["null", "equals", "notEquals", "contains", "notContains", "lessThan", "greaterThan", "startsWith"], input3["operation"]))])), (input3["valuesJoinedBy"] == null ? true : alltrue([(input3["valuesJoinedBy"] == null ? true : contains(["or", "and"], input3["valuesJoinedBy"]))]))]))])]))]))])]))]))
    error_message = "searchSettings: nested required attributes must be non-null and enum values must be supported input members."
  }
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "state"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
