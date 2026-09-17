variable "account_id" {
  description = "The unique ID of the account this SKU belongs to."
  type        = string
  default     = null
}

variable "account_name" {
  description = "The name of the account this SKU belongs to."
  type        = string
  default     = null
}

variable "applies_to" {
  description = "The target class for this SKU. Only SKUs with target class User are assignable. The possible values are: User, Company."
  type        = string
  default     = null
}

variable "capability_status" {
  description = "Enabled indicates that the prepaidUnits property has at least one unit that is enabled. LockedOut indicates that the customer canceled their subscription. The possible values are: Enabled, Warning, Suspended, Deleted, LockedOut."
  type        = string
  default     = null
}

variable "consumed_units" {
  description = "The number of licenses that have been assigned."
  type        = number
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.subscribedSku"
  nullable    = false
}

variable "prepaid_units" {
  description = "Information about the number and status of prepaid licenses."
  type        = any
  default     = null
}

variable "service_plans" {
  description = "Information about the service plans that are available with the SKU. Not nullable"
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
  description = "The unique identifier (GUID) for the service SKU."
  type        = string
  default     = null
}

variable "sku_part_number" {
  description = "The SKU part number; for example, AAD_PREMIUM or RMSBASIC. To get a list of commercial subscriptions that an organization has acquired, see List subscribedSkus."
  type        = string
  default     = null
}

variable "subscription_ids" {
  description = "A list of all subscription IDs associated with this SKU."
  type        = list(string)
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
