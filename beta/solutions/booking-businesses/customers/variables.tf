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
    type            = optional(string)
  }))
  default = null

  validation {
    condition     = (var.addresses == null ? true : alltrue([alltrue([for input0 in var.addresses : (input0 == null ? true : alltrue([(input0["type"] == null ? true : alltrue([(input0["type"] == null ? true : contains(["unknown", "home", "business", "other"], input0["type"]))]))]))])]))
    error_message = "addresses: nested required attributes must be non-null and enum values must be supported input members."
  }
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
    type       = optional(string)
  }))
  default = null

  validation {
    condition     = (var.phones == null ? true : alltrue([alltrue([for input0 in var.phones : (input0 == null ? true : alltrue([(input0["type"] == null ? true : alltrue([(input0["type"] == null ? true : contains(["home", "business", "mobile", "other", "assistant", "homeFax", "businessFax", "otherFax", "pager", "radio"], input0["type"]))]))]))])]))
    error_message = "phones: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "timeouts" {
  description = "Optional timeouts of the msgraph_resource, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". create, update and delete must be at least \"15s\": after each request the provider waits for consistent reads within the same timeout. Every value defaults to null, which keeps the provider defaults and sends no timeouts block. The reviewed replication retries of this module, where it has any, count against these timeouts."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.read, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : (can(regex("^([0-9]+[hms])+$", t)) ? !can(regex("^(0+[hms])+$", t)) : false)
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : try(sum([for m in regexall("([0-9]+)([hms])", t) : tonumber(m[0]) * lookup({ h = 3600, m = 60, s = 1 }, m[1])]) >= 15, true)
    ])
    error_message = "timeouts.create, timeouts.update and timeouts.delete must be at least \"15s\"."
  }
}

variable "select_response" {
  description = "Opt in to a configured-property GET selection; this narrows response and can remove fields consumers use."
  type        = bool
  default     = false
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
