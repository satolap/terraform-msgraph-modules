variable "assistant_name" {
  description = "The name of the contact's assistant."
  type        = string
  default     = null
}

variable "birthday" {
  description = "The contact's birthday. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "business_address" {
  description = "The contact's business address."
  type        = any
  default     = null
}

variable "business_home_page" {
  description = "The business home page of the contact."
  type        = string
  default     = null
}

variable "business_phones" {
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

variable "company_name" {
  description = "The name of the contact's company."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "department" {
  description = "The contact's department."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The contact's display name. You can specify the display name in a create or update operation. Note that later updates to other properties may cause an automatically generated value to overwrite the displayName value you have specified. To preserve a pre-existing value, always include it as displayName in an update operation."
  type        = string
  default     = null
}

variable "email_addresses" {
  description = "The contact's email addresses."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.emailAddress")
    address    = optional(string)
    name       = optional(string)
  }))
  default = null
}

variable "file_as" {
  description = "The name the contact is filed under."
  type        = string
  default     = null
}

variable "generation" {
  description = "The contact's suffix."
  type        = string
  default     = null
}

variable "given_name" {
  description = "The contact's given name."
  type        = string
  default     = null
}

variable "home_address" {
  description = "The contact's home address."
  type        = any
  default     = null
}

variable "home_phones" {
  description = "The contact's home phone numbers."
  type        = list(string)
  default     = null
}

variable "im_addresses" {
  description = "The contact's instant messaging (IM) addresses."
  type        = list(string)
  default     = null
}

variable "initials" {
  description = "The contact's initials."
  type        = string
  default     = null
}

variable "job_title" {
  description = "The contact’s job title."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "manager" {
  description = "The name of the contact's manager."
  type        = string
  default     = null
}

variable "middle_name" {
  description = "The contact's middle name."
  type        = string
  default     = null
}

variable "mobile_phone" {
  description = "The contact's mobile phone number."
  type        = string
  default     = null
}

variable "nick_name" {
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

variable "office_location" {
  description = "The location of the contact's office."
  type        = string
  default     = null
}

variable "other_address" {
  description = "Other addresses for the contact."
  type        = any
  default     = null
}

variable "parent_folder_id" {
  description = "The ID of the contact's parent folder."
  type        = string
  default     = null
}

variable "personal_notes" {
  description = "The user's notes about the contact."
  type        = string
  default     = null
}

variable "photo" {
  description = "Optional contact picture. You can get or set a photo for a contact."
  type        = any
  default     = null
}

variable "primary_email_address" {
  description = "The contact's primary email address."
  type        = any
  default     = null
}

variable "profession" {
  description = "The contact's profession."
  type        = string
  default     = null
}

variable "secondary_email_address" {
  description = "The contact's secondary email address."
  type        = any
  default     = null
}

variable "spouse_name" {
  description = "The name of the contact's spouse/partner."
  type        = string
  default     = null
}

variable "surname" {
  description = "The contact's surname."
  type        = string
  default     = null
}

variable "tertiary_email_address" {
  description = "The contact's tertiary email address."
  type        = any
  default     = null
}

variable "title" {
  description = "The contact's title."
  type        = string
  default     = null
}

variable "yomi_company_name" {
  description = "The phonetic Japanese company name of the contact."
  type        = string
  default     = null
}

variable "yomi_given_name" {
  description = "The phonetic Japanese given name (first name) of the contact."
  type        = string
  default     = null
}

variable "yomi_surname" {
  description = "The phonetic Japanese surname (last name)  of the contact."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["changeKey", "extensions", "id", "multiValueExtendedProperties", "singleValueExtendedProperties"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
