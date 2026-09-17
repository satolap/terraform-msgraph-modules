variable "company_id" {
  description = "The unique identifier of company"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.company_id)) > 0
    error_message = "company_id must not be empty."
  }
}

variable "address" {
  description = "Microsoft Graph address property."
  type        = any
  default     = null
}

variable "balance" {
  description = "Microsoft Graph balance property."
  type        = number
  default     = null
}

variable "blocked" {
  description = "Microsoft Graph blocked property."
  type        = string
  default     = null
}

variable "currency" {
  description = "Microsoft Graph currency property."
  type        = any
  default     = null
}

variable "currency_code" {
  description = "Microsoft Graph currencyCode property."
  type        = string
  default     = null
}

variable "currency_id" {
  description = "Microsoft Graph currencyId property."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Microsoft Graph displayName property."
  type        = string
  default     = null
}

variable "email" {
  description = "Microsoft Graph email property."
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

variable "number" {
  description = "Microsoft Graph number property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.vendor"
  nullable    = false
}

variable "payment_method" {
  description = "Microsoft Graph paymentMethod property."
  type        = any
  default     = null
}

variable "payment_method_id" {
  description = "Microsoft Graph paymentMethodId property."
  type        = string
  default     = null
}

variable "payment_term" {
  description = "Microsoft Graph paymentTerm property."
  type        = any
  default     = null
}

variable "payment_terms_id" {
  description = "Microsoft Graph paymentTermsId property."
  type        = string
  default     = null
}

variable "phone_number" {
  description = "Microsoft Graph phoneNumber property."
  type        = string
  default     = null
}

variable "picture" {
  description = "Microsoft Graph picture property."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.picture")
    content     = optional(string)
    contentType = optional(string)
    height      = optional(number)
    id          = optional(string)
    width       = optional(number)
  }))
  default = null
}

variable "tax_liable" {
  description = "Microsoft Graph taxLiable property."
  type        = bool
  default     = null
}

variable "tax_registration_number" {
  description = "Microsoft Graph taxRegistrationNumber property."
  type        = string
  default     = null
}

variable "website" {
  description = "Microsoft Graph website property."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains([], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
