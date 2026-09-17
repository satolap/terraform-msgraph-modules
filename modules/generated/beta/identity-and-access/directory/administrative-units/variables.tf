variable "deleted_date_time" {
  description = "Date and time when this object was deleted. Always null when the object hasn't been deleted."
  type        = string
  default     = null
}

variable "deleted_members" {
  description = "Microsoft Graph deletedMembers property."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.directoryObject")
    deletedDateTime = optional(string)
  }))
  default = null
}

variable "description" {
  description = "Microsoft Graph description property."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Microsoft Graph displayName property."
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
  description = "Microsoft Graph isMemberManagementRestricted property."
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
  description = "Microsoft Graph membershipRule property."
  type        = string
  default     = null
}

variable "membership_rule_processing_state" {
  description = "Microsoft Graph membershipRuleProcessingState property."
  type        = string
  default     = null
}

variable "membership_type" {
  description = "Microsoft Graph membershipType property."
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
  description = "Microsoft Graph visibility property."
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
