variable "description" {
  description = "Indicates the description of the role assignment. For example: 'All administrators, employees and scope tags associated with the Houston office.' Max length is 1024 characters."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Indicates the display name of the role assignment. For example: 'Houston administrators and users'. Max length is 128 characters."
  type        = string
  default     = null
}

variable "members" {
  description = "Indicates the list of role member security group Entra IDs. For example: {dec942f4-6777-4998-96b4-522e383b08e2}."
  type        = list(string)
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceAndAppManagementRoleAssignment"
  nullable    = false
}

variable "resource_scopes" {
  description = "Indicates the list of resource scope security group Entra IDs. For example: {dec942f4-6777-4998-96b4-522e383b08e2}."
  type        = list(string)
  default     = null
}

variable "role_definition" {
  description = "Indicates the role definition for this role assignment."
  type        = any
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
