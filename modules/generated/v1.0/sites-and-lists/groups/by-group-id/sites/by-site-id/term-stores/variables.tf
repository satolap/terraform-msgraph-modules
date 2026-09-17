variable "group_id" {
  description = "The unique identifier of group"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.group_id)) > 0
    error_message = "group_id must not be empty."
  }
}

variable "site_id" {
  description = "The unique identifier of site"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.site_id)) > 0
    error_message = "site_id must not be empty."
  }
}

variable "default_language_tag" {
  description = "Default language of the term store."
  type        = string
  default     = null
}

variable "groups" {
  description = "Collection of all groups available in the term store."
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.termStore.group")
    description  = optional(string)
    displayName  = optional(string)
    parentSiteId = optional(string)
    scope        = optional(any)
    sets = optional(list(object({
      odata_type     = optional(string, "#microsoft.graph.termStore.set")
      children       = optional(any)
      description    = optional(string)
      localizedNames = optional(any)
      parentGroup    = optional(any)
      properties     = optional(any)
      relations      = optional(any)
      terms          = optional(any)
    })))
  }))
  default = null
}

variable "language_tags" {
  description = "List of languages for the term store."
  type        = list(string)
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.termStore.store"
  nullable    = false
}

variable "sets" {
  description = "Collection of all sets available in the term store. This relationship can only be used to load a specific term set."
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
      scope        = optional(any)
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
      relationship = optional(any)
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
