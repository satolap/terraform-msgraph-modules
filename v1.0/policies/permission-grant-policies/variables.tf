variable "deleted_date_time" {
  description = "Date and time when this object was deleted. Always null when the object hasn't been deleted."
  type        = string
  default     = null
}

variable "description" {
  description = "Description for this policy. Required."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Display name for this policy. Required."
  type        = string
  default     = null
}

variable "excludes" {
  description = "Condition sets that are excluded in this permission grant policy. Automatically expanded on GET."
  type = list(object({
    odata_type                                  = optional(string, "#microsoft.graph.permissionGrantConditionSet")
    clientApplicationIds                        = optional(list(string))
    clientApplicationPublisherIds               = optional(list(string))
    clientApplicationTenantIds                  = optional(list(string))
    clientApplicationsFromVerifiedPublisherOnly = optional(bool)
    permissionClassification                    = optional(string)
    permissionType                              = optional(string)
    permissions                                 = optional(list(string))
    resourceApplication                         = optional(string)
  }))
  default = null

  validation {
    condition     = (var.excludes == null ? true : alltrue([alltrue([for input0 in var.excludes : (input0 == null ? true : alltrue([(input0["permissionType"] == null ? true : alltrue([(input0["permissionType"] == null ? true : contains(["delegatedUserConsentable", "delegated", "application"], input0["permissionType"]))]))]))])]))
    error_message = "excludes: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "includes" {
  description = "Condition sets that are included in this permission grant policy. Automatically expanded on GET."
  type = list(object({
    odata_type                                  = optional(string, "#microsoft.graph.permissionGrantConditionSet")
    clientApplicationIds                        = optional(list(string))
    clientApplicationPublisherIds               = optional(list(string))
    clientApplicationTenantIds                  = optional(list(string))
    clientApplicationsFromVerifiedPublisherOnly = optional(bool)
    permissionClassification                    = optional(string)
    permissionType                              = optional(string)
    permissions                                 = optional(list(string))
    resourceApplication                         = optional(string)
  }))
  default = null

  validation {
    condition     = (var.includes == null ? true : alltrue([alltrue([for input0 in var.includes : (input0 == null ? true : alltrue([(input0["permissionType"] == null ? true : alltrue([(input0["permissionType"] == null ? true : contains(["delegatedUserConsentable", "delegated", "application"], input0["permissionType"]))]))]))])]))
    error_message = "includes: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.permissionGrantPolicy"
  nullable    = false
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
