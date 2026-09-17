variable "contract_type" {
  description = "Type of contract. The possible values are:  SyndicationPartner, BreadthPartner, ResellerPartner. See more in the table below."
  type        = string
  default     = null
}

variable "customer_id" {
  description = "The unique identifier for the customer tenant referenced by this partnership. Corresponds to the id property of the customer tenant's organization resource."
  type        = string
  default     = null
}

variable "default_domain_name" {
  description = "A copy of the customer tenant's default domain name. The copy is made when the partnership with the customer is established. It isn't automatically updated if the customer tenant's default domain name changes."
  type        = string
  default     = null
}

variable "deleted_date_time" {
  description = "Date and time when this object was deleted. Always null when the object hasn't been deleted."
  type        = string
  default     = null
}

variable "display_name" {
  description = "A copy of the customer tenant's display name. The copy is made when the partnership with the customer is established. It is not automatically updated if the customer tenant's display name changes."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.contract"
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
