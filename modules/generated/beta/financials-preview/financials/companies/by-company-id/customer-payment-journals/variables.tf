variable "company_id" {
  description = "The unique identifier of company"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.company_id)) > 0
    error_message = "company_id must not be empty."
  }
}

variable "account" {
  description = "Microsoft Graph account property."
  type        = any
  default     = null
}

variable "balancing_account_id" {
  description = "Microsoft Graph balancingAccountId property."
  type        = string
  default     = null
}

variable "balancing_account_number" {
  description = "Microsoft Graph balancingAccountNumber property."
  type        = string
  default     = null
}

variable "code" {
  description = "Microsoft Graph code property."
  type        = string
  default     = null
}

variable "customer_payments" {
  description = "Microsoft Graph customerPayments property."
  type = list(object({
    odata_type             = optional(string, "#microsoft.graph.customerPayment")
    amount                 = optional(number)
    appliesToInvoiceId     = optional(string)
    appliesToInvoiceNumber = optional(string)
    comment                = optional(string)
    contactId              = optional(string)
    customer               = optional(any)
    customerId             = optional(string)
    customerNumber         = optional(string)
    description            = optional(string)
    documentNumber         = optional(string)
    externalDocumentNumber = optional(string)
    id                     = optional(string)
    journalDisplayName     = optional(string)
    lastModifiedDateTime   = optional(string)
    lineNumber             = optional(number)
    postingDate            = optional(string)
  }))
  default = null
}

variable "display_name" {
  description = "Microsoft Graph displayName property."
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
  default     = "#microsoft.graph.customerPaymentJournal"
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
