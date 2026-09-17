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

variable "store_id" {
  description = "The unique identifier of store"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.store_id)) > 0
    error_message = "store_id must not be empty."
  }
}

variable "set_id" {
  description = "The unique identifier of set"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.set_id)) > 0
    error_message = "set_id must not be empty."
  }
}

variable "set_id1" {
  description = "The unique identifier of set"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.set_id1)) > 0
    error_message = "set_id1 must not be empty."
  }
}

variable "term_id" {
  description = "The unique identifier of term"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.term_id)) > 0
    error_message = "term_id must not be empty."
  }
}

variable "children" {
  description = "Children of current term."
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

variable "descriptions" {
  description = "Description about term that is dependent on the languageTag."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.termStore.localizedDescription")
    description = optional(string)
    languageTag = optional(string)
  }))
  default = null
}

variable "labels" {
  description = "Label metadata for a term."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.termStore.localizedLabel")
    isDefault   = optional(bool)
    languageTag = optional(string)
    name        = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.termStore.term"
  nullable    = false
}

variable "properties" {
  description = "Collection of properties on the term."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.keyValue")
    key        = optional(string)
    value      = optional(string)
  }))
  default = null
}

variable "relations" {
  description = "To indicate which terms are related to the current term as either pinned or reused."
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.termStore.relation")
    fromTerm     = optional(any)
    relationship = optional(any)
    set          = optional(any)
    toTerm       = optional(any)
  }))
  default = null
}

variable "set" {
  description = "The [set] in which the term is created."
  type        = any
  default     = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "lastModifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
