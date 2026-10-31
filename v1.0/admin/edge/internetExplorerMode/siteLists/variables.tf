variable "description" {
  description = "The description of the site list."
  type        = string
  default     = null
}

variable "displayName" {
  description = "The name of the site list."
  type        = string
  default     = null
}

variable "lastModifiedBy" {
  description = "The user who last modified the site list."
  type        = any
  default     = null
}

variable "lastModifiedDateTime" {
  description = "The date and time when the site list was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.browserSiteList"
  nullable    = false
}

variable "publishedBy" {
  description = "The user who published the site list."
  type        = any
  default     = null
}

variable "publishedDateTime" {
  description = "The date and time when the site list was published."
  type        = string
  default     = null
}

variable "revision" {
  description = "The current revision of the site list."
  type        = string
  default     = null
}

variable "sharedCookies" {
  description = "A collection of shared cookies defined for the site list."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.browserSharedCookie")
    comment         = optional(string)
    createdDateTime = optional(string)
    deletedDateTime = optional(string)
    displayName     = optional(string)
    history = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.browserSharedCookieHistory")
      comment           = optional(string)
      displayName       = optional(string)
      hostOnly          = optional(bool)
      hostOrDomain      = optional(string)
      lastModifiedBy    = optional(any)
      path              = optional(string)
      publishedDateTime = optional(string)
      sourceEnvironment = optional(string)
    })))
    hostOnly             = optional(bool)
    hostOrDomain         = optional(string)
    lastModifiedBy       = optional(any)
    lastModifiedDateTime = optional(string)
    path                 = optional(string)
    sourceEnvironment    = optional(string)
    status               = optional(string)
  }))
  default = null

  validation {
    condition     = (var.sharedCookies == null ? true : alltrue([alltrue([for input0 in var.sharedCookies : (input0 == null ? true : alltrue([(input0["history"] == null ? true : alltrue([alltrue([for input2 in input0["history"] : (input2 == null ? true : alltrue([(input2["sourceEnvironment"] == null ? true : alltrue([(input2["sourceEnvironment"] == null ? true : contains(["microsoftEdge", "internetExplorer11", "both"], input2["sourceEnvironment"]))]))]))])])), (input0["sourceEnvironment"] == null ? true : alltrue([(input0["sourceEnvironment"] == null ? true : contains(["microsoftEdge", "internetExplorer11", "both"], input0["sourceEnvironment"]))])), (input0["status"] == null ? true : alltrue([(input0["status"] == null ? true : contains(["published", "pendingAdd", "pendingEdit", "pendingDelete"], input0["status"]))]))]))])]))
    error_message = "sharedCookies: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "sites" {
  description = "A collection of sites defined for the site list."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.browserSite")
    allowRedirect     = optional(bool)
    comment           = optional(string)
    compatibilityMode = optional(string)
    createdDateTime   = optional(string)
    deletedDateTime   = optional(string)
    history = optional(list(object({
      odata_type        = optional(string, "#microsoft.graph.browserSiteHistory")
      allowRedirect     = optional(bool)
      comment           = optional(string)
      compatibilityMode = optional(string)
      lastModifiedBy    = optional(any)
      mergeType         = optional(string)
      publishedDateTime = optional(string)
      targetEnvironment = optional(string)
    })))
    lastModifiedBy       = optional(any)
    lastModifiedDateTime = optional(string)
    mergeType            = optional(string)
    status               = optional(string)
    targetEnvironment    = optional(string)
    webUrl               = optional(string)
  }))
  default = null

  validation {
    condition     = (var.sites == null ? true : alltrue([alltrue([for input0 in var.sites : (input0 == null ? true : alltrue([(input0["compatibilityMode"] == null ? true : alltrue([(input0["compatibilityMode"] == null ? true : contains(["default", "internetExplorer8Enterprise", "internetExplorer7Enterprise", "internetExplorer11", "internetExplorer10", "internetExplorer9", "internetExplorer8", "internetExplorer7", "internetExplorer5"], input0["compatibilityMode"]))])), (input0["history"] == null ? true : alltrue([alltrue([for input2 in input0["history"] : (input2 == null ? true : alltrue([(input2["compatibilityMode"] == null ? true : alltrue([(input2["compatibilityMode"] == null ? true : contains(["default", "internetExplorer8Enterprise", "internetExplorer7Enterprise", "internetExplorer11", "internetExplorer10", "internetExplorer9", "internetExplorer8", "internetExplorer7", "internetExplorer5"], input2["compatibilityMode"]))])), (input2["mergeType"] == null ? true : alltrue([(input2["mergeType"] == null ? true : contains(["noMerge", "default"], input2["mergeType"]))])), (input2["targetEnvironment"] == null ? true : alltrue([(input2["targetEnvironment"] == null ? true : contains(["internetExplorerMode", "internetExplorer11", "microsoftEdge", "configurable", "none"], input2["targetEnvironment"]))]))]))])])), (input0["mergeType"] == null ? true : alltrue([(input0["mergeType"] == null ? true : contains(["noMerge", "default"], input0["mergeType"]))])), (input0["status"] == null ? true : alltrue([(input0["status"] == null ? true : contains(["published", "pendingAdd", "pendingEdit", "pendingDelete"], input0["status"]))])), (input0["targetEnvironment"] == null ? true : alltrue([(input0["targetEnvironment"] == null ? true : contains(["internetExplorerMode", "internetExplorer11", "microsoftEdge", "configurable", "none"], input0["targetEnvironment"]))]))]))])]))
    error_message = "sites: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "status" {
  description = "Status of the site list. Can be either \"draft\", \"pending\", or \"published\""
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["draft", "published", "pending"], var.status)
    error_message = "status must be one of the documented enum values."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
