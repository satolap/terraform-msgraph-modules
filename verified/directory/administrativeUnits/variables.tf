variable "displayName" {
  description = "Display name of the administrative unit, at most 256 characters. Microsoft Learn does not say that it must be unique."
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.displayName)) > 0
    error_message = "displayName must not be empty."
  }

  validation {
    condition     = length(var.displayName) <= 256
    error_message = "displayName must be at most 256 characters long."
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

variable "isMemberManagementRestricted" {
  description = "Whether the unit is a restricted management administrative unit: only administrators assigned a role at the scope of the unit can modify its member objects, and tenant-level administrators and application permissions cannot. Microsoft Learn says the setting can only be made at creation, so changing it replaces the unit, which gets a new id. Users, devices and security groups can be members of such a unit; Microsoft 365 groups, mail-enabled security groups and distribution groups cannot."
  type        = bool
  default     = false
  nullable    = false
}

variable "membershipType" {
  description = "\"Assigned\" for members that member_ids or an administrator adds, or \"Dynamic\" for members that membershipRule selects. It can be changed in place. A dynamic unit holds users or devices, not both, and no groups."
  type        = string
  default     = "Assigned"
  nullable    = false

  validation {
    condition     = contains(["Assigned", "Dynamic"], var.membershipType)
    error_message = "membershipType must be \"Assigned\" or \"Dynamic\"."
  }
}

variable "membershipRule" {
  description = "The dynamic membership rule, in the syntax of dynamic membership groups, such as (user.department -eq \"Sales\"). Required when membershipType is \"Dynamic\" and rejected otherwise."
  type        = string
  default     = null

  validation {
    condition     = var.membershipRule == null ? true : length(trimspace(var.membershipRule)) > 0
    error_message = "membershipRule must not be empty when set."
  }
}

variable "membershipRuleProcessingState" {
  description = "\"On\" to process the dynamic membership rule or \"Paused\" to stop updating the members. Null sends \"On\" for a dynamic unit. Rejected when membershipType is \"Assigned\"."
  type        = string
  default     = null

  validation {
    condition     = var.membershipRuleProcessingState == null ? true : contains(["On", "Paused"], var.membershipRuleProcessingState)
    error_message = "membershipRuleProcessingState must be null, \"On\" or \"Paused\"."
  }
}

variable "member_ids" {
  description = "Object IDs of the users, groups and devices that are the members of the unit; a device is named by its object ID, not its deviceId. Null leaves the members unmanaged and creates no member resource. A list, including an empty one, is authoritative: the module adds the IDs that are missing and removes every other member. The list itself must be known at plan time; the IDs in it can come from resources that the same apply creates. Rejected when membershipType is \"Dynamic\". The module uses the IDs in lower case."
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
  description = "Microsoft Entra role assignments that are limited to this unit, one scopedRoleMembership per entry, keyed by a name that you choose (Microsoft Learn: Add a scopedRoleMember). The keys must be known at plan time; roleId and member_id can be IDs of objects that the same apply creates. roleId is the object ID of the activated directoryRole, not the ID of its role template or role definition; member_id is the object ID of the user that holds the role. Learn documents no update, so changing a pair replaces that assignment. The map is not authoritative: an assignment that an administrator added is neither read nor removed. Each administrator needs Microsoft Entra ID P1. Null is treated as an empty map and assigns nothing. Renaming a key replaces the assignment."
  type = map(object({
    roleId    = string
    member_id = string
  }))
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for m in values(var.scoped_role_members) : can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", try(m.roleId, "")))
    ])
    error_message = "scoped_role_members roleId must be the object ID of a directory role, a GUID."
  }

  validation {
    condition = alltrue([
      for m in values(var.scoped_role_members) : can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", try(m.member_id, "")))
    ])
    error_message = "scoped_role_members member_id must be the object ID of the member, a GUID."
  }

  validation {
    condition     = try(length(distinct([for m in values(var.scoped_role_members) : "${lower(m.roleId)}/${lower(m.member_id)}"])) == length(var.scoped_role_members), false)
    error_message = "scoped_role_members must name each role and member pair once; IDs that differ only in case name the same pair."
  }
}

variable "name_pattern" {
  description = "Regular expression (RE2 syntax, not anchored unless it says so) that displayName must match, such as the pattern of a naming convention. When it is set and displayName does not match, the plan fails. Null, the default, accepts any displayName."
  type        = string
  default     = null

  validation {
    condition     = var.name_pattern == null || can(regexall(var.name_pattern, ""))
    error_message = "name_pattern must be a valid regular expression (RE2 syntax)."
  }
}
