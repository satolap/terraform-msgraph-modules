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

variable "role_scope_tag_ids" {
  description = "Indicates the set of role scope tag IDs for the role assignment. These scope tags will limit the visibility of any Intune resources to those that match any of the scope tags in this collection."
  type        = list(string)
  default     = null
}

variable "role_scope_tags" {
  description = "Indicates the set of scope tags for the role assignment. These scope tags will limit the visibility of any Intune resources to those that match any of the scope tags in this collection."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.roleScopeTag")
    assignments = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.roleScopeTagAutoAssignment")
      target     = optional(any)
    })))
    description = optional(string)
    displayName = optional(string)
  }))
  default = null
}

variable "scope_members" {
  description = "Indicates the list of role scope member security groups Entra IDs. For example, {dec942f4-6777-4998-96b4-522e383b08e2}."
  type        = list(string)
  default     = null
}

variable "scope_type" {
  description = "Specifies the type of scope for a Role Assignment."
  type        = string
  default     = null

  validation {
    condition     = var.scope_type == null ? true : contains(["resourceScope", "allDevices", "allLicensedUsers", "allDevicesAndLicensedUsers", "unknownFutureValue"], var.scope_type)
    error_message = "scope_type must be one of the documented enum values."
  }
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
