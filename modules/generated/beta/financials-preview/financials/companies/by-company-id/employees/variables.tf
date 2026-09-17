variable "company_id" {
  description = "The unique identifier of company"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.company_id)) > 0
    error_message = "company_id must not be empty."
  }
}

variable "address" {
  description = "Microsoft Graph address property."
  type        = any
  default     = null
}

variable "birth_date" {
  description = "Microsoft Graph birthDate property."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Microsoft Graph displayName property."
  type        = string
  default     = null
}

variable "email" {
  description = "Microsoft Graph email property."
  type        = string
  default     = null
}

variable "employment_date" {
  description = "Microsoft Graph employmentDate property."
  type        = string
  default     = null
}

variable "given_name" {
  description = "Microsoft Graph givenName property."
  type        = string
  default     = null
}

variable "id" {
  description = "Microsoft Graph id property."
  type        = string
  default     = null
}

variable "job_title" {
  description = "Microsoft Graph jobTitle property."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "Microsoft Graph lastModifiedDateTime property."
  type        = string
  default     = null
}

variable "middle_name" {
  description = "Microsoft Graph middleName property."
  type        = string
  default     = null
}

variable "mobile_phone" {
  description = "Microsoft Graph mobilePhone property."
  type        = string
  default     = null
}

variable "number" {
  description = "Microsoft Graph number property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.employee"
  nullable    = false
}

variable "personal_email" {
  description = "Microsoft Graph personalEmail property."
  type        = string
  default     = null
}

variable "phone_number" {
  description = "Microsoft Graph phoneNumber property."
  type        = string
  default     = null
}

variable "picture" {
  description = "Microsoft Graph picture property."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.picture")
    content     = optional(string)
    contentType = optional(string)
    height      = optional(number)
    id          = optional(string)
    width       = optional(number)
  }))
  default = null
}

variable "statistics_group_code" {
  description = "Microsoft Graph statisticsGroupCode property."
  type        = string
  default     = null
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null
}

variable "surname" {
  description = "Microsoft Graph surname property."
  type        = string
  default     = null
}

variable "termination_date" {
  description = "Microsoft Graph terminationDate property."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains([], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
