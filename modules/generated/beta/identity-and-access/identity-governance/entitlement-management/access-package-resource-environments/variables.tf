variable "connection_info" {
  description = "Connection information of an environment used to connect to a resource."
  type        = any
  default     = null
}

variable "created_by" {
  description = "The display name of the user that created this object."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "The date and time that this object was created. The DateTimeOffset type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "description" {
  description = "The description of this object."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of this object."
  type        = string
  default     = null
}

variable "is_default_environment" {
  description = "Determines whether this is default environment or not. It is set to true for all static origin systems, such as Microsoft Entra groups and Microsoft Entra Applications."
  type        = bool
  default     = null
}

variable "modified_by" {
  description = "The display name of the entity that last modified this object."
  type        = string
  default     = null
}

variable "modified_date_time" {
  description = "The date and time that this object was last modified. The DateTimeOffset type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.accessPackageResourceEnvironment"
  nullable    = false
}

variable "origin_id" {
  description = "The unique identifier of this environment in the origin system."
  type        = string
  default     = null
}

variable "origin_system" {
  description = "The type of the resource in the origin system, that is, SharePointOnline. Requires $filter (eq)."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["accessPackageResources", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
