variable "group-id" {
  description = "The unique identifier of group"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.group-id)) > 0
    error_message = "group-id must not be empty."
  }
}

variable "allowedRoles" {
  description = "List of allowed sharing or delegating permission levels for the calendar. The possible values are: none, freeBusyRead, limitedRead, read, write, delegateWithoutPrivateEventAccess, delegateWithPrivateEventAccess, custom."
  type        = list(string)
  default     = null

  validation {
    condition     = (var.allowedRoles == null ? true : alltrue([alltrue([for input0 in var.allowedRoles : (input0 == null ? true : alltrue([(input0 == null ? true : contains(["none", "freeBusyRead", "limitedRead", "read", "write", "delegateWithoutPrivateEventAccess", "delegateWithPrivateEventAccess", "custom"], input0))]))])]))
    error_message = "allowedRoles: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "isInsideOrganization" {
  description = "True if the user in context (share recipient or delegate) is inside the same organization as the calendar owner."
  type        = bool
  default     = null
}

variable "isRemovable" {
  description = "True if the user can be removed from the list of recipients or delegates for the specified calendar, false otherwise. The 'My organization' user determines the permissions other people within your organization have to the given calendar. You can't remove 'My organization' as a recipient to a calendar."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.calendarPermission"
  nullable    = false
}

variable "role" {
  description = "Current permission level of the calendar share recipient or delegate."
  type        = string
  default     = null

  validation {
    condition     = var.role == null ? true : contains(["none", "freeBusyRead", "limitedRead", "read", "write", "delegateWithoutPrivateEventAccess", "delegateWithPrivateEventAccess", "custom"], var.role)
    error_message = "role must be one of the documented enum values."
  }
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["emailAddress", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
