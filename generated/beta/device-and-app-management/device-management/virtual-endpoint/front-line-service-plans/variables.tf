variable "allotment_licenses_count" {
  description = "Microsoft Graph allotmentLicensesCount property."
  type        = number
  default     = null
}

variable "display_name" {
  description = "The display name of the frontline service plan. For example, 2vCPU/8GB/128GB Front-line or 4vCPU/16GB/256GB Front-line."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.cloudPcFrontLineServicePlan"
  nullable    = false
}

variable "total_count" {
  description = "The total number of frontline service plans purchased by the customer."
  type        = number
  default     = null
}

variable "used_count" {
  description = "The number of service plans that have been used for the account."
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
