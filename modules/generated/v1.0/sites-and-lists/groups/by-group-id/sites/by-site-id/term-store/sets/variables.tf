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

variable "children" {
  description = "Children terms of set in term [store]."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.termStore.term")
    children   = optional(any)
    descriptions = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.termStore.localizedDescription")
      description = optional(string)
      languageTag = optional(string)
    })))
    labels = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.termStore.localizedLabel")
      isDefault   = optional(bool)
      languageTag = optional(string)
      name        = optional(string)
    })))
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
    set = optional(any)
  }))
  default = null
}

variable "description" {
  description = "Description that gives details on the term usage."
  type        = string
  default     = null
}

variable "localized_names" {
  description = "Name of the set for each languageTag."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.termStore.localizedName")
    languageTag = optional(string)
    name        = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.termStore.set"
  nullable    = false
}

variable "parent_group" {
  description = "Microsoft Graph parentGroup property."
  type = object({
    odata_type   = optional(string, "#microsoft.graph.termStore.group")
    description  = optional(string)
    displayName  = optional(string)
    parentSiteId = optional(string)
    scope        = optional(any)
    sets = optional(list(object({
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
      parentGroup = optional(any)
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
    })))
  })
  default = null
}

variable "properties" {
  description = "Custom properties for the set."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.keyValue")
    key        = optional(string)
    value      = optional(string)
  }))
  default = null
}

variable "relations" {
  description = "Indicates which terms have been pinned or reused directly under the set."
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.termStore.relation")
    fromTerm     = optional(any)
    relationship = optional(any)
    set          = optional(any)
    toTerm       = optional(any)
  }))
  default = null
}

variable "terms" {
  description = "All the terms under the set."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.termStore.term")
    children   = optional(any)
    descriptions = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.termStore.localizedDescription")
      description = optional(string)
      languageTag = optional(string)
    })))
    labels = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.termStore.localizedLabel")
      isDefault   = optional(bool)
      languageTag = optional(string)
      name        = optional(string)
    })))
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
    set = optional(any)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
