variable "user-id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user-id)) > 0
    error_message = "user-id must not be empty."
  }
}

variable "allowedAudiences" {
  description = "The audiences that are able to see the values contained within the associated entity. The possible values are: me, family, contacts, groupMembers, organization, federatedOrganizations, everyone, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.allowedAudiences == null ? true : try(alltrue([for value in split(",", var.allowedAudiences) : contains(["me", "family", "contacts", "groupmembers", "organization", "federatedorganizations", "everyone"], lower(trimspace(value)))]), false)
    error_message = "allowedAudiences must be one or more of the documented enum values, separated by commas."
  }
}

variable "completionMonthYear" {
  description = "The month and year the user graduated or completed the activity."
  type        = string
  default     = null
}

variable "createdBy" {
  description = "Provides the identifier of the user and/or application that created the entity."
  type        = any
  default     = null
}

variable "createdDateTime" {
  description = "Provides the dateTimeOffset for when the entity was created."
  type        = string
  default     = null
}

variable "endMonthYear" {
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

  validation {
    condition     = (var.institution == null ? true : alltrue([(var.institution["location"] == null ? true : alltrue([(var.institution["location"]["type"] == null ? true : alltrue([(var.institution["location"]["type"] == null ? true : contains(["unknown", "home", "business", "other"], var.institution["location"]["type"]))]))]))]))
    error_message = "institution: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "isSearchable" {
  description = "Microsoft Graph isSearchable property."
  type        = bool
  default     = null
}

variable "lastModifiedBy" {
  description = "Provides the identifier of the user and/or application that last modified the entity."
  type        = any
  default     = null
}

variable "lastModifiedDateTime" {
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

variable "startMonthYear" {
  description = "The month and year the user commenced the activity referenced."
  type        = string
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
