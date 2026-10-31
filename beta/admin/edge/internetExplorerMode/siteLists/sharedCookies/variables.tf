variable "browserSiteList-id" {
  description = "The unique identifier of browserSiteList"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.browserSiteList-id)) > 0
    error_message = "browserSiteList-id must not be empty."
  }
}

variable "comment" {
  description = "The comment for the shared cookie."
  type        = string
  default     = null
}

variable "createdDateTime" {
  description = "The date and time when the shared cookie was created."
  type        = string
  default     = null
}

variable "deletedDateTime" {
  description = "The date and time when the shared cookie was deleted."
  type        = string
  default     = null
}

variable "displayName" {
  description = "The name of the cookie."
  type        = string
  default     = null
}

variable "history" {
  description = "The history of modifications applied to the cookie."
  type = list(object({
    odata_type        = optional(string, "#microsoft.graph.browserSharedCookieHistory")
    comment           = optional(string)
    displayName       = optional(string)
    hostOnly          = optional(bool)
    hostOrDomain      = optional(string)
    lastModifiedBy    = optional(any)
    path              = optional(string)
    publishedDateTime = optional(string)
    sourceEnvironment = optional(string)
  }))
  default = null

  validation {
    condition     = (var.history == null ? true : alltrue([alltrue([for input0 in var.history : (input0 == null ? true : alltrue([(input0["sourceEnvironment"] == null ? true : alltrue([(input0["sourceEnvironment"] == null ? true : contains(["microsoftEdge", "internetExplorer11", "both"], input0["sourceEnvironment"]))]))]))])]))
    error_message = "history: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "hostOnly" {
  description = "Controls whether a cookie is a host-only or domain cookie."
  type        = bool
  default     = null
}

variable "hostOrDomain" {
  description = "The URL of the cookie."
  type        = string
  default     = null
}

variable "lastModifiedBy" {
  description = "The user who last modified the cookie."
  type        = any
  default     = null
}

variable "lastModifiedDateTime" {
  description = "The date and time when the cookie was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.browserSharedCookie"
  nullable    = false
}

variable "path" {
  description = "The path of the cookie."
  type        = string
  default     = null
}

variable "sourceEnvironment" {
  description = "Specifies how the cookies are shared between Microsoft Edge and Internet Explorer"
  type        = string
  default     = null

  validation {
    condition     = var.sourceEnvironment == null ? true : contains(["microsoftEdge", "internetExplorer11", "both"], var.sourceEnvironment)
    error_message = "sourceEnvironment must be one of the documented enum values."
  }
}

variable "status" {
  description = "The status of the cookie"
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["published", "pendingAdd", "pendingEdit", "pendingDelete"], var.status)
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
