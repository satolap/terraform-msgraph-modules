variable "allowed_audiences" {
  description = "The audiences that are able to see the values contained within the associated entity. The possible values are: me, family, contacts, groupMembers, organization, federatedOrganizations, everyone, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.allowed_audiences == null ? true : try(alltrue([for value in split(",", var.allowed_audiences) : contains(["me", "family", "contacts", "groupmembers", "organization", "federatedorganizations", "everyone", "unknownfuturevalue"], lower(trimspace(value)))]), false)
    error_message = "allowed_audiences must be one or more of the documented enum values, separated by commas."
  }
}

variable "created_by" {
  description = "Provides the identifier of the user and/or application that created the entity."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "Provides the dateTimeOffset for when the entity was created."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Provides an ordered rendering of firstName and lastName depending on the locale of the user or their device."
  type        = string
  default     = null
}

variable "first" {
  description = "First name of the user."
  type        = string
  default     = null
}

variable "graph_source" {
  description = "Where the values within an entity originated if synced from another service."
  type = object({
    odata_type = optional(string, "#microsoft.graph.personDataSources")
    type       = optional(list(string))
  })
  default = null
}

variable "inference" {
  description = "Contains inference detail if the entity is inferred by the creating or modifying application."
  type = object({
    odata_type              = optional(string, "#microsoft.graph.inferenceData")
    confidenceScore         = optional(any)
    userHasVerifiedAccuracy = optional(bool)
  })
  default = null
}

variable "initials" {
  description = "Initials of the user."
  type        = string
  default     = null
}

variable "is_searchable" {
  description = "Microsoft Graph isSearchable property."
  type        = bool
  default     = null
}

variable "language_tag" {
  description = "Contains the name for the language (en-US, no-NB, en-AU) following IETF BCP47 format."
  type        = string
  default     = null
}

variable "last" {
  description = "Last name of the user."
  type        = string
  default     = null
}

variable "last_modified_by" {
  description = "Provides the identifier of the user and/or application that last modified the entity."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "Provides the dateTimeOffset for when the entity was created."
  type        = string
  default     = null
}

variable "maiden" {
  description = "Maiden name of the user."
  type        = string
  default     = null
}

variable "middle" {
  description = "Middle name of the user."
  type        = string
  default     = null
}

variable "nickname" {
  description = "Nickname of the user."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.personName"
  nullable    = false
}

variable "pronunciation" {
  description = "Guidance on how to pronounce the users name."
  type = object({
    odata_type  = optional(string, "#microsoft.graph.personNamePronounciation")
    displayName = optional(string)
    first       = optional(string)
    last        = optional(string)
    maiden      = optional(string)
    middle      = optional(string)
  })
  default = null
}

variable "sources" {
  description = "Where the values within an entity originated if synced from another source."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.profileSourceAnnotation")
    isDefaultSource = optional(bool)
    properties      = optional(list(string))
    sourceId        = optional(string)
  }))
  default = null
}

variable "suffix" {
  description = "Designators used after the users name (eg: PhD.)"
  type        = string
  default     = null
}

variable "title" {
  description = "Honorifics used to prefix a users name (eg: Dr, Sir, Madam, Mrs.)"
  type        = string
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
