variable "browserSiteList-id" {
  description = "The unique identifier of browserSiteList"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.browserSiteList-id)) > 0
    error_message = "browserSiteList-id must not be empty."
  }
}

variable "allowRedirect" {
  description = "Controls the behavior of redirected sites. If true, indicates that the site will open in Internet Explorer 11 or Microsoft Edge even if the site is navigated to as part of a HTTP or meta refresh redirection chain."
  type        = bool
  default     = null
}

variable "comment" {
  description = "The comment for the site."
  type        = string
  default     = null
}

variable "compatibilityMode" {
  description = "Controls what compatibility setting is used for specific sites or domains"
  type        = string
  default     = null

  validation {
    condition     = var.compatibilityMode == null ? true : contains(["default", "internetExplorer8Enterprise", "internetExplorer7Enterprise", "internetExplorer11", "internetExplorer10", "internetExplorer9", "internetExplorer8", "internetExplorer7", "internetExplorer5"], var.compatibilityMode)
    error_message = "compatibilityMode must be one of the documented enum values."
  }
}

variable "createdDateTime" {
  description = "The date and time when the site was created."
  type        = string
  default     = null
}

variable "deletedDateTime" {
  description = "The date and time when the site was deleted."
  type        = string
  default     = null
}

variable "history" {
  description = "The history of modifications applied to the site."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.browserSiteHistory")
    allowRedirect     = optional(bool)
    comment           = optional(string)
    compatibilityMode = optional(string)
    lastModifiedBy    = optional(any)
    mergeType         = optional(string)
    publishedDateTime = optional(string)
    targetEnvironment = optional(string)
  }))
  default = null

  validation {
    condition     = (var.history == null ? true : alltrue([alltrue([for input0 in var.history : (input0 == null ? true : alltrue([(input0["compatibilityMode"] == null ? true : alltrue([(input0["compatibilityMode"] == null ? true : contains(["default", "internetExplorer8Enterprise", "internetExplorer7Enterprise", "internetExplorer11", "internetExplorer10", "internetExplorer9", "internetExplorer8", "internetExplorer7", "internetExplorer5"], input0["compatibilityMode"]))])), (input0["mergeType"] == null ? true : alltrue([(input0["mergeType"] == null ? true : contains(["noMerge", "default"], input0["mergeType"]))])), (input0["targetEnvironment"] == null ? true : alltrue([(input0["targetEnvironment"] == null ? true : contains(["internetExplorerMode", "internetExplorer11", "microsoftEdge", "configurable", "none"], input0["targetEnvironment"]))]))]))])]))
    error_message = "history: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "lastModifiedBy" {
  description = "The user who last modified the site."
  type        = any
  default     = null
}

variable "lastModifiedDateTime" {
  description = "The date and time when the site was last modified."
  type        = string
  default     = null
}

variable "mergeType" {
  description = "The merge type of the site"
  type        = string
  default     = null

  validation {
    condition     = var.mergeType == null ? true : contains(["noMerge", "default"], var.mergeType)
    error_message = "mergeType must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.browserSite"
  nullable    = false
}

variable "status" {
  description = "Status of the site."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["published", "pendingAdd", "pendingEdit", "pendingDelete"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "targetEnvironment" {
  description = "The target environment that the site should open in."
  type        = string
  default     = null

  validation {
    condition     = var.targetEnvironment == null ? true : contains(["internetExplorerMode", "internetExplorer11", "microsoftEdge", "configurable", "none"], var.targetEnvironment)
    error_message = "targetEnvironment must be one of the documented enum values."
  }
}

variable "webUrl" {
  description = "The URL of the site."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
