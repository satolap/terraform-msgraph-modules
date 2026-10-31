variable "site-id" {
  description = "The unique identifier of site"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.site-id)) > 0
    error_message = "site-id must not be empty."
  }
}

variable "description" {
  description = "Provides a user-visible description of the item. Optional."
  type        = string
  default     = null
}

variable "name" {
  description = "The name of the item. Read-write."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.baseSitePage"
  nullable    = false
}

variable "pageLayout" {
  description = "The name of the page layout of the page. The possible values are: microsoftReserved, article, home, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.pageLayout == null ? true : contains(["microsoftReserved", "article", "home"], var.pageLayout)
    error_message = "pageLayout must be one of the documented enum values."
  }
}

variable "parentReference" {
  description = "Parent information, if the item has a parent. Read-write."
  type = object({
    odata_type = optional(string, "#microsoft.graph.itemReference")
    driveType  = optional(string)
    shareId    = optional(string)
    siteId     = optional(string)
  })
  default = null
}

variable "publishingState" {
  description = "The publishing status and the MM.mm version of the page."
  type = object({
    odata_type   = optional(string, "#microsoft.graph.publicationFacet")
    checkedOutBy = optional(any)
  })
  default = null
}

variable "title" {
  description = "Title of the sitePage."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdBy", "createdByUser", "createdDateTime", "eTag", "id", "lastModifiedBy", "lastModifiedByUser", "lastModifiedDateTime", "webUrl"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
