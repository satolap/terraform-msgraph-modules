variable "address" {
  description = "The office address of the external user profile."
  type = object({
    odata_type      = optional(string, "#microsoft.graph.physicalOfficeAddress")
    city            = optional(string)
    countryOrRegion = optional(string)
    officeLocation  = optional(string)
    postalCode      = optional(string)
    state           = optional(string)
    street          = optional(string)
  })
  default = null
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
  default     = "#microsoft.graph.pendingExternalUserProfile"
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdBy", "createdDateTime", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
