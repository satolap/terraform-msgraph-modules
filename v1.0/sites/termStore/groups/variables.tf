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
  description = "Description that gives details on the term usage."
  type        = string
  default     = null
}

variable "displayName" {
  description = "Name of the group."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.termStore.group"
  nullable    = false
}

variable "parentSiteId" {
  description = "ID of the parent site of this group."
  type        = string
  default     = null
}

variable "scope" {
  description = "Returns the type of the group. The possible values are: global, system, and siteCollection."
  type        = string
  default     = null

  validation {
    condition     = var.scope == null ? true : contains(["global", "system", "siteCollection"], var.scope)
    error_message = "scope must be one of the documented enum values."
  }
}

variable "sets" {
  description = "All sets under the group in a term [store]."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.termStore.set")
    children = optional(list(object({
      odata_type   = optional(string, "#microsoft.graph.termStore.term")
      children     = optional(any)
      descriptions = optional(any)
      labels       = optional(any)
      properties   = optional(any)
      relations    = optional(any)
      set          = optional(any)
    })))
    description = optional(string)
    localizedNames = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.termStore.localizedName")
      languageTag = optional(string)
      name        = optional(string)
    })))
    parentGroup = optional(object({
      odata_type   = optional(string, "#microsoft.graph.termStore.group")
      description  = optional(string)
      displayName  = optional(string)
      parentSiteId = optional(string)
      scope        = optional(string)
      sets         = optional(any)
    }))
    properties = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.keyValue")
      key        = optional(string)
      value      = optional(string)
    })))
    relations = optional(list(object({
      odata_type   = optional(string, "#microsoft.graph.termStore.relation")
      fromTerm     = optional(any)
      relationship = optional(string)
      set          = optional(any)
      toTerm       = optional(any)
    })))
    terms = optional(list(object({
      odata_type   = optional(string, "#microsoft.graph.termStore.term")
      children     = optional(any)
      descriptions = optional(any)
      labels       = optional(any)
      properties   = optional(any)
      relations    = optional(any)
      set          = optional(any)
    })))
  }))
  default = null

  validation {
    condition     = (var.sets == null ? true : alltrue([alltrue([for input0 in var.sets : (input0 == null ? true : alltrue([(input0["parentGroup"] == null ? true : alltrue([(input0["parentGroup"]["scope"] == null ? true : alltrue([(input0["parentGroup"]["scope"] == null ? true : contains(["global", "system", "siteCollection"], input0["parentGroup"]["scope"]))]))])), (input0["relations"] == null ? true : alltrue([alltrue([for input2 in input0["relations"] : (input2 == null ? true : alltrue([(input2["relationship"] == null ? true : alltrue([(input2["relationship"] == null ? true : contains(["pin", "reuse"], input2["relationship"]))]))]))])]))]))])]))
    error_message = "sets: nested required attributes must be non-null and enum values must be supported input members."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
