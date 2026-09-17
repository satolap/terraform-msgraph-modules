variable "site_id" {
  description = "The unique identifier of site"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.site_id)) > 0
    error_message = "site_id must not be empty."
  }
}

variable "associated_hubs_urls" {
  description = "List of canonical URLs for hub sites with which this content type is associated to. This contains all hub sites where this content type is queued to be enforced or is already enforced. Enforcing a content type means that the content type is applied to the lists in the enforced sites."
  type        = list(string)
  default     = null
}

variable "base" {
  description = "Parent contentType from which this content type is derived."
  type        = any
  default     = null
}

variable "base_types" {
  description = "The collection of content types that are ancestors of this content type."
  type = list(object({
    odata_type         = optional(string, "#microsoft.graph.contentType")
    associatedHubsUrls = optional(list(string))
    base               = optional(any)
    baseTypes          = optional(any)
    columnLinks = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.columnLink")
      name       = optional(string)
    })))
    columnPositions = optional(list(object({
      odata_type            = optional(string, "#microsoft.graph.columnDefinition")
      boolean               = optional(any)
      calculated            = optional(any)
      choice                = optional(any)
      columnGroup           = optional(string)
      contentApprovalStatus = optional(any)
      currency              = optional(any)
      dateTime              = optional(any)
      defaultValue          = optional(any)
      description           = optional(string)
      displayName           = optional(string)
      enforceUniqueValues   = optional(bool)
      geolocation           = optional(any)
      hidden                = optional(bool)
      hyperlinkOrPicture    = optional(any)
      indexed               = optional(bool)
      isDeletable           = optional(bool)
      isSealed              = optional(bool)
      isSearchable          = optional(bool)
      lookup                = optional(any)
      name                  = optional(string)
      number                = optional(any)
      personOrGroup         = optional(any)
      propagateChanges      = optional(bool)
      readOnly              = optional(bool)
      required              = optional(bool)
      sourceColumn          = optional(any)
      sourceContentType     = optional(any)
      term                  = optional(any)
      text                  = optional(any)
      thumbnail             = optional(any)
      validation            = optional(any)
    })))
    columns = optional(list(object({
      odata_type            = optional(string, "#microsoft.graph.columnDefinition")
      boolean               = optional(any)
      calculated            = optional(any)
      choice                = optional(any)
      columnGroup           = optional(string)
      contentApprovalStatus = optional(any)
      currency              = optional(any)
      dateTime              = optional(any)
      defaultValue          = optional(any)
      description           = optional(string)
      displayName           = optional(string)
      enforceUniqueValues   = optional(bool)
      geolocation           = optional(any)
      hidden                = optional(bool)
      hyperlinkOrPicture    = optional(any)
      indexed               = optional(bool)
      isDeletable           = optional(bool)
      isSealed              = optional(bool)
      isSearchable          = optional(bool)
      lookup                = optional(any)
      name                  = optional(string)
      number                = optional(any)
      personOrGroup         = optional(any)
      propagateChanges      = optional(bool)
      readOnly              = optional(bool)
      required              = optional(bool)
      sourceColumn          = optional(any)
      sourceContentType     = optional(any)
      term                  = optional(any)
      text                  = optional(any)
      thumbnail             = optional(any)
      validation            = optional(any)
    })))
    description      = optional(string)
    documentSet      = optional(any)
    documentTemplate = optional(any)
    group            = optional(string)
    hidden           = optional(bool)
    inheritedFrom    = optional(any)
    isBuiltIn        = optional(bool)
    name             = optional(string)
    order            = optional(any)
    parentId         = optional(string)
    propagateChanges = optional(bool)
    readOnly         = optional(bool)
    sealed           = optional(bool)
  }))
  default = null
}

variable "column_links" {
  description = "The collection of columns that are required by this content type."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.columnLink")
    name       = optional(string)
  }))
  default = null
}

variable "column_positions" {
  description = "Column order information in a content type."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.columnDefinition")
    boolean               = optional(any)
    calculated            = optional(any)
    choice                = optional(any)
    columnGroup           = optional(string)
    contentApprovalStatus = optional(any)
    currency              = optional(any)
    dateTime              = optional(any)
    defaultValue          = optional(any)
    description           = optional(string)
    displayName           = optional(string)
    enforceUniqueValues   = optional(bool)
    geolocation           = optional(any)
    hidden                = optional(bool)
    hyperlinkOrPicture    = optional(any)
    indexed               = optional(bool)
    isDeletable           = optional(bool)
    isSealed              = optional(bool)
    isSearchable          = optional(bool)
    lookup                = optional(any)
    name                  = optional(string)
    number                = optional(any)
    personOrGroup         = optional(any)
    propagateChanges      = optional(bool)
    readOnly              = optional(bool)
    required              = optional(bool)
    sourceColumn          = optional(any)
    sourceContentType     = optional(any)
    term                  = optional(any)
    text                  = optional(any)
    thumbnail             = optional(any)
    validation            = optional(any)
  }))
  default = null
}

variable "columns" {
  description = "The collection of column definitions for this content type."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.columnDefinition")
    boolean               = optional(any)
    calculated            = optional(any)
    choice                = optional(any)
    columnGroup           = optional(string)
    contentApprovalStatus = optional(any)
    currency              = optional(any)
    dateTime              = optional(any)
    defaultValue          = optional(any)
    description           = optional(string)
    displayName           = optional(string)
    enforceUniqueValues   = optional(bool)
    geolocation           = optional(any)
    hidden                = optional(bool)
    hyperlinkOrPicture    = optional(any)
    indexed               = optional(bool)
    isDeletable           = optional(bool)
    isSealed              = optional(bool)
    isSearchable          = optional(bool)
    lookup                = optional(any)
    name                  = optional(string)
    number                = optional(any)
    personOrGroup         = optional(any)
    propagateChanges      = optional(bool)
    readOnly              = optional(bool)
    required              = optional(bool)
    sourceColumn          = optional(any)
    sourceContentType     = optional(any)
    term                  = optional(any)
    text                  = optional(any)
    thumbnail             = optional(any)
    validation            = optional(any)
  }))
  default = null
}

variable "description" {
  description = "The descriptive text for the item."
  type        = string
  default     = null
}

variable "document_set" {
  description = "Document Set metadata."
  type        = any
  default     = null
}

variable "document_template" {
  description = "Document template metadata. To make sure that documents have consistent content across a site and its subsites, you can associate a Word, Excel, or PowerPoint template with a site content type."
  type        = any
  default     = null
}

variable "group" {
  description = "The name of the group this content type belongs to. Helps organize related content types."
  type        = string
  default     = null
}

variable "hidden" {
  description = "Indicates whether the content type is hidden in the list's 'New' menu."
  type        = bool
  default     = null
}

variable "inherited_from" {
  description = "If this content type is inherited from another scope (like a site), provides a reference to the item where the content type is defined."
  type        = any
  default     = null
}

variable "is_built_in" {
  description = "Specifies if a content type is a built-in content type."
  type        = bool
  default     = null
}

variable "name" {
  description = "The name of the content type."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.contentType"
  nullable    = false
}

variable "order" {
  description = "Specifies the order in which the content type appears in the selection UI."
  type        = any
  default     = null
}

variable "parent_id" {
  description = "The unique identifier of the content type."
  type        = string
  default     = null
}

variable "propagate_changes" {
  description = "If true, any changes made to the content type are pushed to inherited content types and lists that implement the content type."
  type        = bool
  default     = null
}

variable "read_only" {
  description = "If true, the content type can't be modified unless this value is first set to false."
  type        = bool
  default     = null
}

variable "sealed" {
  description = "If true, the content type can't be modified by users or through push-down operations. Only site collection administrators can seal or unseal content types."
  type        = bool
  default     = null
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
