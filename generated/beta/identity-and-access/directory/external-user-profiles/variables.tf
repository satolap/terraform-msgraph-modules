variable "address" {
  description = "The office address of the external user profile."
  type        = any
  default     = null
}

variable "company_name" {
  description = "The company name of the external user profile. Supports $filter (eq, startswith)."
  type        = string
  default     = null
}

variable "deleted_date_time" {
  description = "Date and time when this object was deleted. Always null when the object hasn't been deleted."
  type        = string
  default     = null
}

variable "department" {
  description = "The department of the external user profile."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the external user profile."
  type        = string
  default     = null
}

variable "is_discoverable" {
  description = "Represents whether the external user profile is discoverable in the directory. When true, this external profile shows up in Teams search."
  type        = bool
  default     = null
}

variable "is_enabled" {
  description = "Represents whether the external user profile is enabled in the directory. This property is peer to the accountEnabled property on the user object."
  type        = bool
  default     = null
}

variable "job_title" {
  description = "The job title of the external user profile."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.externalUserProfile"
  nullable    = false
}

variable "phone_number" {
  description = "The phone number of the external user profile. Must be in E164 format."
  type        = string
  default     = null
}

variable "supervisor_id" {
  description = "The object ID of the supervisor of the external user profile. Supports $filter (eq, startswith)."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdBy", "createdDateTime", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
