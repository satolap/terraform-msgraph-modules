variable "site_id" {
  description = "The unique identifier of site"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.site_id)) > 0
    error_message = "site_id must not be empty."
  }
}

variable "description" {
  description = "Description that gives details on the term usage."
  type        = string
  default     = null
}

variable "display_name" {
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

variable "parent_site_id" {
  description = "ID of the parent site of this group."
  type        = string
  default     = null
}

variable "scope" {
  description = "Returns the type of the group. The possible values are: global, system, and siteCollection."
  type        = any
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
