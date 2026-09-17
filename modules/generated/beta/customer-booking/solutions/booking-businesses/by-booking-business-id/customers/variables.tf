variable "booking_business_id" {
  description = "The unique identifier of bookingBusiness"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.booking_business_id)) > 0
    error_message = "booking_business_id must not be empty."
  }
}

variable "addresses" {
  description = "Addresses associated with the customer, including home, business and other addresses."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.physicalAddress")
    city            = optional(string)
    countryOrRegion = optional(string)
    postOfficeBox   = optional(string)
    postalCode      = optional(string)
    state           = optional(string)
    street          = optional(string)
    type            = optional(any)
  }))
  default = null
}

variable "created_date_time" {
  description = "The date, time, and timezone when the customer was created."
  type        = string
  default     = null
}

variable "display_name" {
  description = "A name for the derived entity, which interfaces with customers."
  type        = string
  default     = null
}

variable "email_address" {
  description = "The email address of the person."
  type        = string
  default     = null
}

variable "last_updated_date_time" {
  description = "The date, time, and timezone when the customer was last updated."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.bookingCustomer"
  nullable    = false
}

variable "phones" {
  description = "Phone numbers associated with the customer, including home, business and mobile numbers."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.phone")
    number     = optional(string)
    type       = optional(any)
  }))
  default = null
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
