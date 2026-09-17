variable "company_id" {
  description = "The unique identifier of company"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.company_id)) > 0
    error_message = "company_id must not be empty."
  }
}

variable "calculate_discount_on_credit_memos" {
  description = "Microsoft Graph calculateDiscountOnCreditMemos property."
  type        = bool
  default     = null
}

variable "code" {
  description = "Microsoft Graph code property."
  type        = string
  default     = null
}

variable "discount_date_calculation" {
  description = "Microsoft Graph discountDateCalculation property."
  type        = string
  default     = null
}

variable "discount_percent" {
  description = "Microsoft Graph discountPercent property."
  type        = number
  default     = null
}

variable "display_name" {
  description = "Microsoft Graph displayName property."
  type        = string
  default     = null
}

variable "due_date_calculation" {
  description = "Microsoft Graph dueDateCalculation property."
  type        = string
  default     = null
}

variable "id" {
  description = "Microsoft Graph id property."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "Microsoft Graph lastModifiedDateTime property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.paymentTerm"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains([], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
