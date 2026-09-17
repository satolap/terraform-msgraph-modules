variable "editions" {
  description = "Represents an edition of a particular Windows product."
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.windowsUpdates.edition")
    deviceFamily = optional(string)
    isInService  = optional(bool)
    servicingPeriods = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.windowsUpdates.servicingPeriod")
      name       = optional(string)
    })))
  }))
  default = null
}

variable "known_issues" {
  description = "Represents a known issue related to a Windows product."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.windowsUpdates.knownIssue")
    description = optional(string)
    knownIssueHistories = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.windowsUpdates.knownIssueHistoryItem")
      body = optional(object({
        odata_type  = optional(string, "#microsoft.graph.windowsUpdates.itemBody")
        content     = optional(string)
        contentType = optional(any)
      }))
    })))
    originatingKnowledgeBaseArticle = optional(any)
    resolvedDateTime                = optional(string)
    resolvingKnowledgeBaseArticle   = optional(any)
    safeguardHoldIds                = optional(list(number))
    startDateTime                   = optional(string)
    status                          = optional(string)
    title                           = optional(string)
    webViewUrl                      = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.windowsUpdates.product"
  nullable    = false
}

variable "revisions" {
  description = "Represents a product revision."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.windowsUpdates.productRevision")
    catalogEntry         = optional(any)
    knowledgeBaseArticle = optional(any)
    osBuild = optional(object({
      odata_type = optional(string, "#microsoft.graph.windowsUpdates.buildVersionDetails")
    }))
  }))
  default = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["friendlyNames", "groupName", "id", "name"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
