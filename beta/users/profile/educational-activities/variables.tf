variable "user_id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_id)) > 0
    error_message = "user_id must not be empty."
  }
}

variable "allowed_audiences" {
  description = "The audiences that are able to see the values contained within the associated entity. The possible values are: me, family, contacts, groupMembers, organization, federatedOrganizations, everyone, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.allowed_audiences == null ? true : try(alltrue([for value in split(",", var.allowed_audiences) : contains(["me", "family", "contacts", "groupmembers", "organization", "federatedorganizations", "everyone", "unknownfuturevalue"], lower(trimspace(value)))]), false)
    error_message = "allowed_audiences must be one or more of the documented enum values, separated by commas."
  }
}

variable "completion_month_year" {
  description = "The month and year the user graduated or completed the activity."
  type        = string
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

variable "end_month_year" {
  description = "The month and year the user completed the educational activity referenced."
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

variable "institution" {
  description = "Contains details of the institution studied at."
  type = object({
    odata_type  = optional(string, "#microsoft.graph.institutionData")
    description = optional(string)
    displayName = optional(string)
    location = optional(object({
      odata_type      = optional(string, "#microsoft.graph.physicalAddress")
      city            = optional(string)
      countryOrRegion = optional(string)
      postOfficeBox   = optional(string)
      postalCode      = optional(string)
      state           = optional(string)
      street          = optional(string)
      type            = optional(string)
    }))
    webUrl = optional(string)
  })
  default = null
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
  default     = "#microsoft.graph.educationalActivity"
  nullable    = false
}

variable "program" {
  description = "Contains extended information about the program or course."
  type = object({
    odata_type    = optional(string, "#microsoft.graph.educationalActivityDetail")
    abbreviation  = optional(string)
    activities    = optional(list(string))
    awards        = optional(list(string))
    description   = optional(string)
    displayName   = optional(string)
    fieldsOfStudy = optional(list(string))
    grade         = optional(string)
    notes         = optional(string)
    webUrl        = optional(string)
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

variable "start_month_year" {
  description = "The month and year the user commenced the activity referenced."
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
