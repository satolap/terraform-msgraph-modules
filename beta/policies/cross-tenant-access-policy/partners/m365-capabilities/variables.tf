variable "cross_tenant_access_policy_configuration_partner_tenant_id" {
  description = "The unique identifier of crossTenantAccessPolicyConfigurationPartner"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.cross_tenant_access_policy_configuration_partner_tenant_id)) > 0
    error_message = "cross_tenant_access_policy_configuration_partner_tenant_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  nullable    = false

  validation {
    condition     = var.odata_type == null ? true : contains(["#microsoft.graph.anonymousCalendarSharingFreeBusyDetail", "#microsoft.graph.anonymousCalendarSharingFreeBusyReviewer", "#microsoft.graph.anonymousCalendarSharingFreeBusySimple", "#microsoft.graph.crossTenantCalendarAvailabilityBasic", "#microsoft.graph.crossTenantCalendarAvailabilityLimitedDetails", "#microsoft.graph.crossTenantCalendarSharingFreeBusyDetail", "#microsoft.graph.crossTenantCalendarSharingFreeBusyReviewer", "#microsoft.graph.crossTenantCalendarSharingFreeBusySimple", "#microsoft.graph.crossTenantMailTipsAll", "#microsoft.graph.crossTenantMailTipsLimited", "#microsoft.graph.crossTenantMigration", "#microsoft.graph.crossTenantOpenProfileCard", "#microsoft.graph.crossTenantPlacesDeskBooking", "#microsoft.graph.crossTenantPlacesRoomBooking"], var.odata_type)
    error_message = "odata_type must name a concrete Graph type."
  }
}

variable "inbound_access" {
  description = "The inbound access settings for the capability."
  type = object({
    odata_type = optional(string, "#microsoft.graph.m365CapabilityInboundAccess")
    isAllowed  = optional(bool)
    resourceScopes = optional(object({
      odata_type = optional(string, "#microsoft.graph.m365CapabilityResourceScopes")
      excluded = optional(list(object({
        odata_type   = optional(string, "#microsoft.graph.m365CapabilityResourceScope")
        resourceId   = optional(string)
        resourceType = optional(string)
      })))
      included = optional(list(object({
        odata_type   = optional(string, "#microsoft.graph.m365CapabilityResourceScope")
        resourceId   = optional(string)
        resourceType = optional(string)
      })))
    }))
  })
  default = null

  validation {
    condition     = (var.inbound_access == null ? true : alltrue([(var.inbound_access["resourceScopes"] == null ? true : alltrue([(var.inbound_access["resourceScopes"]["excluded"] == null ? true : alltrue([alltrue([for input2 in var.inbound_access["resourceScopes"]["excluded"] : (input2 == null ? true : alltrue([(input2["resourceType"] == null ? true : alltrue([(input2["resourceType"] == null ? true : contains(["none", "group", "user"], input2["resourceType"]))]))]))])])), (var.inbound_access["resourceScopes"]["included"] == null ? true : alltrue([alltrue([for input2 in var.inbound_access["resourceScopes"]["included"] : (input2 == null ? true : alltrue([(input2["resourceType"] == null ? true : alltrue([(input2["resourceType"] == null ? true : contains(["none", "group", "user"], input2["resourceType"]))]))]))])]))]))]))
    error_message = "inbound_access: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "last_modified_date_time" {
  description = "The automatically updated last modified timestamp for the capability. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2024, is 2024-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "name" {
  description = "The name or identifier of the capability. Key."
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
