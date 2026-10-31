variable "user-id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user-id)) > 0
    error_message = "user-id must not be empty."
  }
}

variable "assistantName" {
  description = "The name of the contact's assistant."
  type        = string
  default     = null
}

variable "birthday" {
  description = "The contact's birthday. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "businessAddress" {
  description = "The contact's business address."
  type = object({
    odata_type      = optional(string, "#microsoft.graph.physicalAddress")
    city            = optional(string)
    countryOrRegion = optional(string)
    postalCode      = optional(string)
    state           = optional(string)
    street          = optional(string)
  })
  default = null
}

variable "businessHomePage" {
  description = "The business home page of the contact."
  type        = string
  default     = null
}

variable "businessPhones" {
  description = "The contact's business phone numbers."
  type        = list(string)
  default     = null
}

variable "categories" {
  description = "The categories associated with the item"
  type        = list(string)
  default     = null
}

variable "children" {
  description = "The names of the contact's children."
  type        = list(string)
  default     = null
}

variable "companyName" {
  description = "The name of the contact's company."
  type        = string
  default     = null
}

variable "createdDateTime" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "department" {
  description = "The contact's department."
  type        = string
  default     = null
}

variable "displayName" {
  description = "The contact's display name. You can specify the display name in a create or update operation. Note that later updates to other properties may cause an automatically generated value to overwrite the displayName value you have specified. To preserve a pre-existing value, always include it as displayName in an update operation."
  type        = string
  default     = null
}

variable "emailAddresses" {
  description = "The contact's email addresses."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.emailAddress")
    address    = optional(string)
    name       = optional(string)
  }))
  default = null
}

variable "fileAs" {
  description = "The name the contact is filed under."
  type        = string
  default     = null
}

variable "generation" {
  description = "The contact's suffix."
  type        = string
  default     = null
}

variable "givenName" {
  description = "The contact's given name."
  type        = string
  default     = null
}

variable "homeAddress" {
  description = "The contact's home address."
  type = object({
    odata_type      = optional(string, "#microsoft.graph.physicalAddress")
    city            = optional(string)
    countryOrRegion = optional(string)
    postalCode      = optional(string)
    state           = optional(string)
    street          = optional(string)
  })
  default = null
}

variable "homePhones" {
  description = "The contact's home phone numbers."
  type        = list(string)
  default     = null
}

variable "imAddresses" {
  description = "The contact's instant messaging (IM) addresses."
  type        = list(string)
  default     = null
}

variable "initials" {
  description = "The contact's initials."
  type        = string
  default     = null
}

variable "jobTitle" {
  description = "The contact’s job title."
  type        = string
  default     = null
}

variable "lastModifiedDateTime" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "manager" {
  description = "The name of the contact's manager."
  type        = string
  default     = null
}

variable "middleName" {
  description = "The contact's middle name."
  type        = string
  default     = null
}

variable "mobilePhone" {
  description = "The contact's mobile phone number."
  type        = string
  default     = null
}

variable "nickName" {
  description = "The contact's nickname."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.contact"
  nullable    = false
}

variable "officeLocation" {
  description = "The location of the contact's office."
  type        = string
  default     = null
}

variable "otherAddress" {
  description = "Other addresses for the contact."
  type = object({
    odata_type      = optional(string, "#microsoft.graph.physicalAddress")
    city            = optional(string)
    countryOrRegion = optional(string)
    postalCode      = optional(string)
    state           = optional(string)
    street          = optional(string)
  })
  default = null
}

variable "parentFolderId" {
  description = "The ID of the contact's parent folder."
  type        = string
  default     = null
}

variable "personalNotes" {
  description = "The user's notes about the contact."
  type        = string
  default     = null
}

variable "photo" {
  description = "Optional contact picture. You can get or set a photo for a contact."
  type        = any
  default     = null
}

variable "primaryEmailAddress" {
  description = "The contact's primary email address."
  type = object({
    odata_type = optional(string, "#microsoft.graph.emailAddress")
    address    = optional(string)
    name       = optional(string)
  })
  default = null
}

variable "profession" {
  description = "The contact's profession."
  type        = string
  default     = null
}

variable "secondaryEmailAddress" {
  description = "The contact's secondary email address."
  type = object({
    odata_type = optional(string, "#microsoft.graph.emailAddress")
    address    = optional(string)
    name       = optional(string)
  })
  default = null
}

variable "spouseName" {
  description = "The name of the contact's spouse/partner."
  type        = string
  default     = null
}

variable "surname" {
  description = "The contact's surname."
  type        = string
  default     = null
}

variable "tertiaryEmailAddress" {
  description = "The contact's tertiary email address."
  type = object({
    odata_type = optional(string, "#microsoft.graph.emailAddress")
    address    = optional(string)
    name       = optional(string)
  })
  default = null
}

variable "title" {
  description = "The contact's title."
  type        = string
  default     = null
}

variable "yomiCompanyName" {
  description = "The phonetic Japanese company name of the contact."
  type        = string
  default     = null
}

variable "yomiGivenName" {
  description = "The phonetic Japanese given name (first name) of the contact."
  type        = string
  default     = null
}

variable "yomiSurname" {
  description = "The phonetic Japanese surname (last name)  of the contact."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["changeKey", "extensions", "id", "multiValueExtendedProperties", "singleValueExtendedProperties"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
