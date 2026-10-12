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
