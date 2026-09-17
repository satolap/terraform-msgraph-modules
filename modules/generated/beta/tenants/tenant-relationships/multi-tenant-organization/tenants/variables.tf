variable "deleted_date_time" {
  description = "Date and time when this object was deleted. Always null when the object hasn't been deleted."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Display name of the tenant added to the multitenant organization."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.multiTenantOrganizationMember"
  nullable    = false
}

variable "role" {
  description = "Role of the tenant in the multitenant organization. The possible values are: owner, member (default), unknownFutureValue. Tenants with the owner role can manage the multitenant organization but tenants with the member role can only participate in a multitenant organization. There can be multiple tenants with the owner role in a multitenant organization."
  type        = any
  default     = null

  validation {
    condition     = var.role == null ? true : contains(["owner", "member", "unknownFutureValue"], var.role)
    error_message = "role must be one of the documented enum values."
  }
}

variable "tenant_id" {
  description = "Tenant ID of the Microsoft Entra tenant added to the multitenant organization. Set at the time tenant is added.Supports $filter. Key."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["addedByTenantId", "addedDateTime", "id", "joinedDateTime", "state", "transitionDetails"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
