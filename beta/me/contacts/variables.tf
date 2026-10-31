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

variable "categories" {
  description = "The categories associated with the item."
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
  description = "The contact's display name. You can specify the display name in a create or update operation. Later updates to other properties might cause an automatically generated value to overwrite the displayName value you specified. To preserve a pre-existing value, always include it as displayName in an update operation."
  type        = string
  default     = null
}

variable "emailAddresses" {
  description = "The contact's email addresses."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.typedEmailAddress")
    address    = optional(string)
    name       = optional(string)
    otherLabel = optional(string)
    type       = optional(string)
  }))
  default = null

  validation {
    condition     = (var.emailAddresses == null ? true : alltrue([alltrue([for input0 in var.emailAddresses : (input0 == null ? true : alltrue([(input0["type"] == null ? true : alltrue([(input0["type"] == null ? true : contains(["unknown", "work", "personal", "main", "other"], input0["type"]))]))]))])]))
    error_message = "emailAddresses: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "extensions" {
  description = "The collection of open extensions defined for the contact. Nullable."
  type        = any
  default     = null
}

variable "fileAs" {
  description = "The name the contact is filed under."
  type        = string
  default     = null
}

variable "flag" {
  description = "The flag value that indicates the status, start date, due date, or completion date for the contact."
  type = object({
    odata_type = optional(string, "#microsoft.graph.followupFlag")
    completedDateTime = optional(object({
      odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
      dateTime   = optional(string)
      timeZone   = optional(string)
    }))
    dueDateTime = optional(object({
      odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
      dateTime   = optional(string)
      timeZone   = optional(string)
    }))
    flagStatus = optional(string)
    startDateTime = optional(object({
      odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
      dateTime   = optional(string)
      timeZone   = optional(string)
    }))
  })
  default = null

  validation {
    condition     = (var.flag == null ? true : alltrue([(var.flag["flagStatus"] == null ? true : alltrue([(var.flag["flagStatus"] == null ? true : contains(["notFlagged", "complete", "flagged"], var.flag["flagStatus"]))]))]))
    error_message = "flag: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "gender" {
  description = "The contact's gender."
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

variable "isFavorite" {
  description = "Microsoft Graph isFavorite property."
  type        = bool
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

variable "phones" {
  description = "Phone numbers associated with the contact, for example, home phone, mobile phone, and business phone."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.phone")
    number     = optional(string)
    type       = optional(string)
  }))
  default = null

  validation {
    condition     = (var.phones == null ? true : alltrue([alltrue([for input0 in var.phones : (input0 == null ? true : alltrue([(input0["type"] == null ? true : alltrue([(input0["type"] == null ? true : contains(["home", "business", "mobile", "other", "assistant", "homeFax", "businessFax", "otherFax", "pager", "radio"], input0["type"]))]))]))])]))
    error_message = "phones: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "photo" {
  description = "Optional contact picture. You can get or set a photo for a contact."
  type        = any
  default     = null
}

variable "postalAddresses" {
  description = "Addresses associated with the contact, for example, home address and business address."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.physicalAddress")
    city            = optional(string)
    countryOrRegion = optional(string)
    postOfficeBox   = optional(string)
    postalCode      = optional(string)
    state           = optional(string)
    street          = optional(string)
    type            = optional(string)
  }))
  default = null

  validation {
    condition     = (var.postalAddresses == null ? true : alltrue([alltrue([for input0 in var.postalAddresses : (input0 == null ? true : alltrue([(input0["type"] == null ? true : alltrue([(input0["type"] == null ? true : contains(["unknown", "home", "business", "other"], input0["type"]))]))]))])]))
    error_message = "postalAddresses: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "primaryEmailAddress" {
  description = "The primary email address of the contact."
  type        = any
  default     = null
}

variable "profession" {
  description = "The contact's profession."
  type        = string
  default     = null
}

variable "secondaryEmailAddress" {
  description = "The secondary email address of the contact."
  type        = any
  default     = null
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
  description = "The tertiary email address of the contact."
  type        = any
  default     = null
}

variable "title" {
  description = "The contact's title."
  type        = string
  default     = null
}

variable "websites" {
  description = "Web sites associated with the contact."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.website")
    address     = optional(string)
    displayName = optional(string)
    type        = optional(string)
  }))
  default = null

  validation {
    condition     = (var.websites == null ? true : alltrue([alltrue([for input0 in var.websites : (input0 == null ? true : alltrue([(input0["type"] == null ? true : alltrue([(input0["type"] == null ? true : contains(["other", "home", "work", "blog", "profile"], input0["type"]))]))]))])]))
    error_message = "websites: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "weddingAnniversary" {
  description = "The contact's wedding anniversary."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["changeKey", "id", "multiValueExtendedProperties", "singleValueExtendedProperties"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
