variable "deleted_date_time" {
  description = "Date and time when this object was deleted. Always null when the object hasn't been deleted."
  type        = string
  default     = null
}

variable "description" {
  description = "An optional description for the administrative unit. Supports $filter (eq, ne, in, startsWith), $search."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Display name for the administrative unit. Maximum length is 256 characters. Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values), $search, and $orderby."
  type        = string
  default     = null
}

variable "extensions" {
  description = "The collection of open extensions defined for this administrative unit. Nullable."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.extension")
  }))
  default = null
}

variable "is_member_management_restricted" {
  description = "true if members of this administrative unit should be treated as sensitive, which requires specific permissions to manage. If not set, the default value is null and the default behavior is false. Use this property to define administrative units with roles that don't inherit from tenant-level administrators, and where the management of individual member objects is limited to administrators scoped to a restricted management administrative unit. This property is immutable and can't be changed later.  For more information on how to work with restricted management administrative units, see Restricted management administrative units in Microsoft Entra ID."
  type        = bool
  default     = null
}

variable "members" {
  description = "Users and groups that are members of this administrative unit. Supports $expand."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.directoryObject")
    deletedDateTime = optional(string)
  }))
  default = null
}

variable "membership_rule" {
  description = "The dynamic membership rule for the administrative unit. For more information about the rules you can use for dynamic administrative units and dynamic groups, see Manage rules for dynamic membership groups in Microsoft Entra ID."
  type        = string
  default     = null
}

variable "membership_rule_processing_state" {
  description = "Controls whether the dynamic membership rule is actively processed. Set to On to activate the dynamic membership rule, or Paused to stop updating membership dynamically."
  type        = string
  default     = null
}

variable "membership_type" {
  description = "Indicates the membership type for the administrative unit. The possible values are: dynamic, assigned. If not set, the default value is null and the default behavior is assigned."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.administrativeUnit"
  nullable    = false
}

variable "scoped_role_members" {
  description = "Scoped-role members of this administrative unit."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.scopedRoleMembership")
    administrativeUnitId = optional(string)
    roleId               = optional(string)
    roleMemberInfo = optional(object({
      odata_type  = optional(string, "#microsoft.graph.identity")
      displayName = optional(string)
      id          = optional(string)
    }))
  }))
  default = null
}

variable "visibility" {
  description = "Controls whether the administrative unit and its members are hidden or public. Can be set to HiddenMembership. If not set, the default value is null and the default behavior is public. When set to HiddenMembership, only members of the administrative unit can list other members of the administrative unit."
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
