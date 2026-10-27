variable "deleted_date_time" {
  description = "Date and time when this object was deleted. Always null when the object hasn't been deleted."
  type        = string
  default     = null
}

variable "deleted_members" {
  description = "Microsoft Graph deletedMembers property."
  type        = any
  default     = null
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
  type        = any
  default     = null
}

variable "is_member_management_restricted" {
  description = "Microsoft Graph isMemberManagementRestricted property."
  type        = bool
  default     = null
}

variable "members" {
  description = "Users and groups that are members of this administrative unit. Supports $expand."
  type        = any
  default     = null
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
    roleMemberInfo       = optional(any)
  }))
  default = null
}

variable "visibility" {
  description = "Microsoft Graph visibility property."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
