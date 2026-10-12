variable "business_relationship" {
  description = "Describes the relationship between the Managed Services Provider and the managed tenant; for example, Managed, Co-managed, Licensing. The maximum length is 250 characters. Optional."
  type        = string
  default     = null
}

variable "compliance_requirements" {
  description = "Contains the compliance requirements for the customer tenant; for example, HIPPA, NIST, CMMC. The maximum length is 250 characters per compliance requirement. Optional."
  type        = list(string)
  default     = null
}

variable "contacts" {
  description = "The collection of contacts for the managed tenant. Optional."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.managedTenants.tenantContactInformation")
    email      = optional(string)
    name       = optional(string)
    notes      = optional(string)
    phone      = optional(string)
    title      = optional(string)
  }))
  default = null
}

variable "managed_services_plans" {
  description = "This is the Managed Services Plans for the customer tenant that the Managed Services Provider manages. The maximum length is 250 characters per managed service plan. Optional."
  type        = list(string)
  default     = null
}

variable "note" {
  description = "A field for the Managed Services Provider technician to input custom text to share notes between technicians within the Managed Service Providers. The maximum length is 5000 characters. Optional."
  type        = string
  default     = null
}

variable "note_last_modified_date_time" {
  description = "The date on which the note field of this entity was last modified. Optional."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedTenants.tenantCustomizedInformation"
  nullable    = false
}

variable "partner_relationship_manager_user_ids" {
  description = "The list of Entra user IDs for users in the Managed Services Provider that manage the relationship with the managed tenant. Optional."
  type        = list(string)
  default     = null
}

variable "website" {
  description = "The website for the managed tenant. Required."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["displayName", "id", "tenantId"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
