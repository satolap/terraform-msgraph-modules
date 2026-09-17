variable "commerce_subscription_id" {
  description = "The ID of this subscription in the commerce system. Alternate key."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "The date and time when this subscription was created. The DateTimeOffset type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "is_trial" {
  description = "Whether the subscription is a free trial or purchased."
  type        = bool
  default     = null
}

variable "next_lifecycle_date_time" {
  description = "The date and time when the subscription will move to the next state (as defined by the status property) if not renewed by the tenant. The DateTimeOffset type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "ocp_subscription_id" {
  description = "Microsoft Graph ocpSubscriptionId property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.companySubscription"
  nullable    = false
}

variable "owner_id" {
  description = "The object ID of the account admin."
  type        = string
  default     = null
}

variable "owner_tenant_id" {
  description = "The unique identifier for the Microsoft partner tenant that created the subscription on a customer tenant."
  type        = string
  default     = null
}

variable "owner_type" {
  description = "Indicates the entity that ownerId belongs to, for example, 'User'."
  type        = string
  default     = null
}

variable "service_status" {
  description = "The provisioning status of each service that's included in this subscription."
  type = list(object({
    odata_type         = optional(string, "#microsoft.graph.servicePlanInfo")
    appliesTo          = optional(string)
    provisioningStatus = optional(string)
    servicePlanId      = optional(string)
    servicePlanName    = optional(string)
  }))
  default = null
}

variable "sku_id" {
  description = "The object ID of the SKU associated with this subscription."
  type        = string
  default     = null
}

variable "sku_part_number" {
  description = "The SKU associated with this subscription."
  type        = string
  default     = null
}

variable "status" {
  description = "The status of this subscription. The possible values are: Enabled, Deleted, Suspended, Warning, LockedOut."
  type        = string
  default     = null
}

variable "total_licenses" {
  description = "The number of seats included in this subscription."
  type        = number
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
