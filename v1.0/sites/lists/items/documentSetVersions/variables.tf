variable "site-id" {
  description = "The unique identifier of site"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.site-id)) > 0
    error_message = "site-id must not be empty."
  }
}

variable "list-id" {
  description = "The unique identifier of list"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.list-id)) > 0
    error_message = "list-id must not be empty."
  }
}

variable "listItem-id" {
  description = "The unique identifier of listItem"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.listItem-id)) > 0
    error_message = "listItem-id must not be empty."
  }
}

variable "comment" {
  description = "Comment about the captured version."
  type        = string
  default     = null
}

variable "createdBy" {
  description = "User who captured the version."
  type        = any
  default     = null
}

variable "createdDateTime" {
  description = "Date and time when this version was created."
  type        = string
  default     = null
}

variable "fields" {
  description = "A collection of the fields and values for this version of the list item."
  type        = any
  default     = null
}

variable "items" {
  description = "Items within the document set that are captured as part of this version."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.documentSetVersionItem")
    itemId     = optional(string)
    title      = optional(string)
    versionId  = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.documentSetVersion"
  nullable    = false
}

variable "shouldCaptureMinorVersion" {
  description = "If true, minor versions of items are also captured; otherwise, only major versions are captured. The default value is false."
  type        = bool
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "lastModifiedBy", "lastModifiedDateTime", "publication"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
