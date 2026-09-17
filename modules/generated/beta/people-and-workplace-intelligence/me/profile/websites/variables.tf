variable "allowed_audiences" {
  description = "The audiences that are able to see the values contained within the associated entity. The possible values are: me, family, contacts, groupMembers, organization, federatedOrganizations, everyone, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.allowed_audiences == null ? true : contains(["me", "family", "contacts", "groupMembers", "organization", "federatedOrganizations", "everyone", "unknownFutureValue"], var.allowed_audiences)
    error_message = "allowed_audiences must be one of the documented enum values."
  }
}

variable "categories" {
  description = "Contains categories a user has associated with the website (for example, personal, recipes)."
  type        = list(string)
  default     = null
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

variable "description" {
  description = "Contains a description of the website."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Contains a friendly name for the website."
  type        = string
  default     = null
}

variable "graph_source" {
  description = "Where the values within an entity originated if synced from another service."
  type        = any
  default     = null
}

variable "inference" {
  description = "Contains inference detail if the entity is inferred by the creating or modifying application."
  type        = any
  default     = null
}

variable "is_searchable" {
  description = "Microsoft Graph isSearchable property."
  type        = bool
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

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.personWebsite"
  nullable    = false
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

variable "thumbnail_url" {
  description = "Microsoft Graph thumbnailUrl property."
  type        = string
  default     = null
}

variable "web_url" {
  description = "Contains a link to the website itself."
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
