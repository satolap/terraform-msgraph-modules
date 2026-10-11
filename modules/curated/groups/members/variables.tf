variable "group_id" {
  description = "Object ID of the existing security or Microsoft 365 group whose direct members this module manages; the module does not create the group. Changing it replaces the managed collection: the provider removes every member of the old group that its state lists, then adds member_ids to the new group. The module uses it in lower case, so a change of case alone plans nothing."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", var.group_id))
    error_message = "group_id must be the object ID of a group, a GUID."
  }
}

variable "member_ids" {
  description = "Object IDs of every direct member the group must have: users, groups, devices, service principals or organizational contacts. The list is authoritative: each apply adds the IDs the group lacks and removes every direct member it does not name, including nested groups, devices, service principals and organizational contacts added outside Terraform. An empty list removes every member; null is rejected. Order does not matter and the module uses the IDs in lower case. On api_version \"v1.0\" Microsoft Graph does not list service principal members, so use \"beta\" when the group has or should have one."
  type        = list(string)
  nullable    = false

  validation {
    condition     = alltrue([for id in var.member_ids : can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", id))])
    error_message = "member_ids must contain only directory object IDs, each a GUID."
  }

  # A null element fails the validation above; try() keeps lower() from failing
  # on it here before that message is shown.
  validation {
    condition     = try(length(distinct([for id in var.member_ids : lower(id)])) == length(var.member_ids), true)
    error_message = "member_ids must name each directory object once; IDs that differ only in letter case name the same object."
  }
}

variable "api_version" {
  description = "Microsoft Graph API version for the members requests, \"v1.0\" or \"beta\". Microsoft Learn documents a known issue: listing the members of a group on v1.0 does not return service principals, and it recommends beta. On v1.0 a service principal in member_ids fails every apply after the first, and one added outside Terraform is never removed."
  type        = string
  default     = "v1.0"
  nullable    = false

  validation {
    condition     = contains(["v1.0", "beta"], var.api_version)
    error_message = "api_version must be one of \"v1.0\" or \"beta\"."
  }
}

variable "timeouts" {
  description = "Timeouts for creating, reading, updating and deleting the managed collection, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". Null keeps the provider's default (30 minutes for create, update and delete and 5 minutes for read in microsoft/msgraph 0.3.0 to 0.5.0). Create, update and delete send one request per member added or removed, and the module retries the replication delay error until the timeout, so a large change needs a longer timeout."
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
      t == null || (can(regex("^([0-9]+[hms])+$", t)) && !can(regex("^(0+[hms])+$", t)))
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }
}
