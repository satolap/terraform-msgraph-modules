variable "displayName" {
  description = "Partner display name"
  type        = string
  default     = null
}

variable "groupsRequiringPartnerEnrollment" {
  description = "User groups that specifies whether enrollment is through partner."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.deviceManagementPartnerAssignment")
    target     = optional(any)
  }))
  default = null
}

variable "isConfigured" {
  description = "Whether device management partner is configured or not"
  type        = bool
  default     = null
}

variable "lastHeartbeatDateTime" {
  description = "Timestamp of last heartbeat after admin enabled option Connect to Device management Partner"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.deviceManagementPartner"
  nullable    = false
}

variable "partnerAppType" {
  description = "Partner App Type."
  type        = string
  default     = null

  validation {
    condition     = var.partnerAppType == null ? true : contains(["unknown", "singleTenantApp", "multiTenantApp"], var.partnerAppType)
    error_message = "partnerAppType must be one of the documented enum values."
  }
}

variable "partnerState" {
  description = "Partner state of this tenant."
  type        = string
  default     = null

  validation {
    condition     = var.partnerState == null ? true : contains(["unknown", "unavailable", "enabled", "terminated", "rejected", "unresponsive"], var.partnerState)
    error_message = "partnerState must be one of the documented enum values."
  }
}

variable "singleTenantAppId" {
  description = "Partner Single tenant App id"
  type        = string
  default     = null
}

variable "whenPartnerDevicesWillBeMarkedAsNonCompliantDateTime" {
  description = "DateTime in UTC when PartnerDevices will be marked as NonCompliant"
  type        = string
  default     = null
}

variable "whenPartnerDevicesWillBeRemovedDateTime" {
  description = "DateTime in UTC when PartnerDevices will be removed"
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
