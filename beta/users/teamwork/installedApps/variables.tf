variable "user-id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user-id)) > 0
    error_message = "user-id must not be empty."
  }
}

variable "chat" {
  description = "The chat between the user and Teams app."
  type        = any
  default     = null
}

variable "consentedPermissionSet" {
  description = "The set of resource-specific permissions consented to while installing or upgrading the teamsApp."
  type = object({
    odata_type = optional(string, "#microsoft.graph.teamsAppPermissionSet")
    resourceSpecificPermissions = optional(list(object({
      odata_type      = optional(string, "#microsoft.graph.teamsAppResourceSpecificPermission")
      permissionType  = optional(string)
      permissionValue = optional(string)
    })))
  })
  default = null

  validation {
    condition     = (var.consentedPermissionSet == null ? true : alltrue([(var.consentedPermissionSet["resourceSpecificPermissions"] == null ? true : alltrue([alltrue([for input1 in var.consentedPermissionSet["resourceSpecificPermissions"] : (input1 == null ? true : alltrue([(input1["permissionType"] == null ? true : alltrue([(input1["permissionType"] == null ? true : contains(["delegated", "application"], input1["permissionType"]))]))]))])]))]))
    error_message = "consentedPermissionSet: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.userScopeTeamsAppInstallation"
  nullable    = false
}

variable "scopeInfo" {
  description = "The details of the scope in which the app is installed."
  type        = any
  default     = null
}

variable "teamsApp" {
  description = "The app that is installed."
  type        = any
  default     = null
}

variable "teamsAppDefinition" {
  description = "The details of this version of the app."
  type        = any
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
