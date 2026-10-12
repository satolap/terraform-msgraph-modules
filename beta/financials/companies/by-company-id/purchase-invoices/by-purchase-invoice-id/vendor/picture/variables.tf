variable "company_id" {
  description = "The unique identifier of company"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.company_id)) > 0
    error_message = "company_id must not be empty."
  }
}

variable "purchase_invoice_id" {
  description = "The unique identifier of purchaseInvoice"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.purchase_invoice_id)) > 0
    error_message = "purchase_invoice_id must not be empty."
  }
}

variable "content" {
  description = "Microsoft Graph content property."
  type        = string
  default     = null
}

variable "content_type" {
  description = "Microsoft Graph contentType property."
  type        = string
  default     = null
}

variable "height" {
  description = "Microsoft Graph height property."
  type        = number
  default     = null
}

variable "id" {
  description = "Microsoft Graph id property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.picture"
  nullable    = false
}

variable "width" {
  description = "Microsoft Graph width property."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains([], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
