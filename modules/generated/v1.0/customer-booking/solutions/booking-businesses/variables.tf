variable "address" {
  description = "The street address of the business. The address property, together with phone and webSiteUrl, appear in the footer of a business scheduling page. The attribute type of physicalAddress is not supported in v1.0. Internally we map the addresses to the type others."
  type        = any
  default     = null
}

variable "booking_page_settings" {
  description = "Settings for the published booking page."
  type        = any
  default     = null
}

variable "business_hours" {
  description = "The hours of operation for the business."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.bookingWorkHours")
    day        = optional(string)
    timeSlots = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.bookingWorkTimeSlot")
      endTime    = optional(string)
      startTime  = optional(string)
    })))
  }))
  default = null
}

variable "business_type" {
  description = "The type of business."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "The date, time, and time zone when the booking business was created. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "default_currency_iso" {
  description = "The code for the currency that the business operates in on Microsoft Bookings."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The name of the business, which interfaces with customers. This name appears at the top of the business scheduling page."
  type        = string
  default     = null
}

variable "email" {
  description = "The email address for the business."
  type        = string
  default     = null
}

variable "language_tag" {
  description = "The language of the self-service booking page."
  type        = string
  default     = null
}

variable "last_updated_date_time" {
  description = "The date, time, and time zone when the booking business was last updated. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.bookingBusiness"
  nullable    = false
}

variable "phone" {
  description = "The telephone number for the business. The phone property, together with address and webSiteUrl, appear in the footer of a business scheduling page."
  type        = string
  default     = null
}

variable "scheduling_policy" {
  description = "Specifies how bookings can be created for this business."
  type        = any
  default     = null
}

variable "web_site_url" {
  description = "The URL of the business web site. The webSiteUrl property, together with address, phone, appear in the footer of a business scheduling page."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["appointments", "calendarView", "customQuestions", "customers", "id", "isPublished", "publicUrl", "services", "staffMembers"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
