variable "display_name" {
  description = "Display name of the administrative unit, at most 256 characters. Microsoft Learn does not say that it must be unique."
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.display_name)) > 0
    error_message = "display_name must not be empty."
  }

  validation {
    condition     = length(var.display_name) <= 256
    error_message = "display_name must be at most 256 characters long."
  }
}

variable "description" {
  description = "Description of the administrative unit. It is always sent, as null when unset, because an update keeps the properties that its body omits; whether Microsoft Graph accepts a null description is not verified."
  type        = string
  default     = null
}

variable "visibility" {
  description = "Null for a public unit, the Graph default, or \"HiddenMembership\", which lets only members of the unit list its other members. It can be changed in place. It is always sent, as null when unset, so that removing it is sent to Graph; whether Graph accepts a null visibility is not verified."
  type        = string
  default     = null

  validation {
    condition     = var.visibility == null ? true : var.visibility == "HiddenMembership"
    error_message = "visibility must be null or \"HiddenMembership\"."
  }
}

variable "is_member_management_restricted" {
  description = "Whether the unit is a restricted management administrative unit: only administrators assigned a role at the scope of the unit can modify its member objects, and tenant-level administrators and application permissions cannot. Microsoft Learn says the setting can only be made at creation, so changing it replaces the unit, which gets a new id. Users, devices and security groups can be members of such a unit; Microsoft 365 groups, mail-enabled security groups and distribution groups cannot."
  type        = bool
  default     = false
  nullable    = false
}

variable "membership_type" {
  description = "\"Assigned\" for members that member_ids or an administrator adds, or \"Dynamic\" for members that membership_rule selects. It can be changed in place. A dynamic unit holds users or devices, not both, and no groups."
  type        = string
  default     = "Assigned"
  nullable    = false

  validation {
    condition     = contains(["Assigned", "Dynamic"], var.membership_type)
    error_message = "membership_type must be \"Assigned\" or \"Dynamic\"."
  }
}

variable "membership_rule" {
  description = "The dynamic membership rule, in the syntax of dynamic membership groups, such as (user.department -eq \"Sales\"). Required when membership_type is \"Dynamic\" and rejected otherwise."
  type        = string
  default     = null

  validation {
    condition     = var.membership_rule == null ? true : length(trimspace(var.membership_rule)) > 0
    error_message = "membership_rule must not be empty when set."
  }
}

variable "membership_rule_processing_state" {
  description = "\"On\" to process the dynamic membership rule or \"Paused\" to stop updating the members. Null sends \"On\" for a dynamic unit. Rejected when membership_type is \"Assigned\"."
  type        = string
  default     = null

  validation {
    condition     = var.membership_rule_processing_state == null ? true : contains(["On", "Paused"], var.membership_rule_processing_state)
    error_message = "membership_rule_processing_state must be null, \"On\" or \"Paused\"."
  }
}

variable "member_ids" {
  description = "Object IDs of the users, groups and devices that are the members of the unit; a device is named by its object ID, not its deviceId. Null leaves the members unmanaged and creates no member resource. A list, including an empty one, is authoritative: the module adds the IDs that are missing and removes every other member. The list itself must be known at plan time; the IDs in it can come from resources that the same apply creates. Rejected when membership_type is \"Dynamic\". The module uses the IDs in lower case."
  type        = list(string)
  default     = null

  validation {
    condition = var.member_ids == null ? true : alltrue([
      for id in var.member_ids : can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", id))
    ])
    error_message = "member_ids must hold the object IDs of users, groups or devices, each a GUID."
  }

  validation {
    condition     = var.member_ids == null ? true : try(length(distinct([for id in var.member_ids : lower(id)])) == length(var.member_ids), false)
    error_message = "member_ids must name each object once; IDs that differ only in case name the same object."
  }
}

variable "scoped_role_members" {
  description = "Microsoft Entra role assignments that are limited to this unit, one scopedRoleMembership per entry, keyed by a name that you choose (Microsoft Learn: Add a scopedRoleMember). The keys must be known at plan time; role_id and member_id can be IDs of objects that the same apply creates. role_id is the object ID of the activated directoryRole, not the ID of its role template or role definition; member_id is the object ID of the user that holds the role. Learn documents no update, so changing a pair replaces that assignment. The map is not authoritative: an assignment that an administrator added is neither read nor removed. Each administrator needs Microsoft Entra ID P1. Null is treated as an empty map and assigns nothing. Renaming a key replaces the assignment."
  type = map(object({
    role_id   = string
    member_id = string
  }))
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for m in values(var.scoped_role_members) : can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", try(m.role_id, "")))
    ])
    error_message = "scoped_role_members role_id must be the object ID of a directory role, a GUID."
  }

  validation {
    condition = alltrue([
      for m in values(var.scoped_role_members) : can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", try(m.member_id, "")))
    ])
    error_message = "scoped_role_members member_id must be the object ID of the member, a GUID."
  }

  validation {
    condition     = try(length(distinct([for m in values(var.scoped_role_members) : "${lower(m.role_id)}/${lower(m.member_id)}"])) == length(var.scoped_role_members), false)
    error_message = "scoped_role_members must name each role and member pair once; IDs that differ only in case name the same pair."
  }
}

variable "name_pattern" {
  description = "Regular expression (RE2 syntax, not anchored unless it says so) that display_name must match, such as the pattern of a naming convention. When it is set and display_name does not match, the plan fails. Null, the default, accepts any display_name."
  type        = string
  default     = null

  validation {
    condition     = var.name_pattern == null || can(regexall(var.name_pattern, ""))
    error_message = "name_pattern must be a valid regular expression (RE2 syntax)."
  }
}
