variable "ediscoveryCase-id" {
  description = "The unique identifier of ediscoveryCase"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.ediscoveryCase-id)) > 0
    error_message = "ediscoveryCase-id must not be empty."
  }
}

variable "childSelectability" {
  description = "Indicates whether a single or multiple child tags can be associated with a document. The possible values are: One, Many.  This value controls whether the UX presents the tags as checkboxes or a radio button group."
  type        = string
  default     = null

  validation {
    condition     = var.childSelectability == null ? true : contains(["One", "Many"], var.childSelectability)
    error_message = "childSelectability must be one of the documented enum values."
  }
}

variable "childTags" {
  description = "Returns the tags that are a child of a tag."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.security.ediscoveryReviewTag")
    childSelectability   = optional(string)
    childTags            = optional(any)
    createdBy            = optional(any)
    description          = optional(string)
    displayName          = optional(string)
    lastModifiedDateTime = optional(string)
    parent               = optional(any)
  }))
  default = null

  validation {
    condition     = (var.childTags == null ? true : alltrue([alltrue([for input0 in var.childTags : (input0 == null ? true : alltrue([(input0["childSelectability"] == null ? true : alltrue([(input0["childSelectability"] == null ? true : contains(["One", "Many"], input0["childSelectability"]))]))]))])]))
    error_message = "childTags: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "createdBy" {
  description = "Microsoft Graph createdBy property."
  type        = any
  default     = null
}

variable "description" {
  description = "Microsoft Graph description property."
  type        = string
  default     = null
}

variable "displayName" {
  description = "Microsoft Graph displayName property."
  type        = string
  default     = null
}

variable "lastModifiedDateTime" {
  description = "Microsoft Graph lastModifiedDateTime property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.ediscoveryReviewTag"
  nullable    = false
}

variable "parent" {
  description = "Returns the parent tag of the specified tag."
  type        = any
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
