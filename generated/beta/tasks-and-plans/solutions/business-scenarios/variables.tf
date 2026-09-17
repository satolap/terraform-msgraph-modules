variable "created_by" {
  description = "The identity of the user who created the scenario."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The date and time when the scenario was created. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Display name of the scenario."
  type        = string
  default     = null
}

variable "last_modified_by" {
  description = "The identity of the user who last modified the scenario."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time when the scenario was last modified. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.businessScenario"
  nullable    = false
}

variable "owner_app_ids" {
  description = "Identifiers of applications that are authorized to work with this scenario."
  type        = list(string)
  default     = null
}

variable "planner" {
  description = "Planner content related to the scenario."
  type        = any
  default     = null
}

variable "unique_name" {
  description = "Unique name of the scenario. To avoid conflicts, the recommended value for the unique name is a reverse domain name format, owned by the author of the scenario. For example, a scenario authored by Contoso.com would have a unique name that starts with com.contoso."
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
