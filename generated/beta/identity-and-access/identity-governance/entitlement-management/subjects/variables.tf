variable "alt_sec_id" {
  description = "Not Supported."
  type        = string
  default     = null
}

variable "cleanup_scheduled_date_time" {
  description = "The date and time the subject is marked to be blocked from sign in or deleted. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time."
  type        = string
  default     = null
}

variable "connected_organization_id" {
  description = "The identifier of the connected organization of the subject."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the subject."
  type        = string
  default     = null
}

variable "email" {
  description = "The email address of the subject."
  type        = string
  default     = null
}

variable "object_id" {
  description = "The object identifier of the subject. null if the subject isn't yet a user in the tenant. Alternate key."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.accessPackageSubject"
  nullable    = false
}

variable "on_premises_security_identifier" {
  description = "A string representation of the principal's security identifier, if known, or null if the subject doesn't have a security identifier."
  type        = string
  default     = null
}

variable "principal_name" {
  description = "The principal name, if known, of the subject."
  type        = string
  default     = null
}

variable "subject_lifecycle" {
  description = "The lifecycle of the subject user, if a guest. The possible values are: notDefined, notGoverned, governed, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.subject_lifecycle == null ? true : contains(["notDefined", "notGoverned", "governed", "unknownFutureValue"], var.subject_lifecycle)
    error_message = "subject_lifecycle must be one of the documented enum values."
  }
}

variable "type" {
  description = "The resource type of the subject."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["connectedOrganization", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
