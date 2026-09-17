variable "application_id" {
  description = "The unique identifier of application"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.application_id)) > 0
    error_message = "application_id must not be empty."
  }
}

variable "data_type" {
  description = "Specifies the data type of the value the extension property can hold. Following values are supported. Binary - 256 bytes maximumBooleanDateTime - Must be specified in ISO 8601 format. Will be stored in UTC.Integer - 32-bit value.LargeInteger - 64-bit value.String - 256 characters maximumNot nullable. For multivalued directory extensions, these limits apply per value in the collection."
  type        = string
  default     = null
}

variable "deleted_date_time" {
  description = "Date and time when this object was deleted. Always null when the object hasn't been deleted."
  type        = string
  default     = null
}

variable "is_multi_valued" {
  description = "Defines the directory extension as a multi-valued property. When true, the directory extension property can store a collection of objects of the dataType; for example, a collection of string types such as 'extensionb7b1c57b532f40b8b5ed4b7a7ba67401jobGroupTracker': ['String 1', 'String 2']. The default value is false. Supports $filter (eq)."
  type        = bool
  default     = null
}

variable "name" {
  description = "Name of the extension property. Not nullable. Supports $filter (eq)."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.extensionProperty"
  nullable    = false
}

variable "target_objects" {
  description = "Following values are supported. Not nullable. UserGroupAdministrativeUnitApplicationDeviceOrganization"
  type        = list(string)
  default     = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["appDisplayName", "id", "isSyncedFromOnPremises"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
