variable "booking_business_id" {
  description = "The unique identifier of bookingBusiness"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.booking_business_id)) > 0
    error_message = "booking_business_id must not be empty."
  }
}

variable "additional_information" {
  description = "Additional information that is sent to the customer when an appointment is confirmed."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "The date, time, and time zone when the service was created. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "custom_questions" {
  description = "Contains the set of custom questions associated with a particular service."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.bookingQuestionAssignment")
    isRequired = optional(bool)
    questionId = optional(string)
  }))
  default = null
}

variable "default_duration" {
  description = "The default length of the service, represented in numbers of days, hours, minutes, and seconds. For example, P11D23H59M59.999999999999S."
  type        = string
  default     = null
}

variable "default_location" {
  description = "The default physical location for the service."
  type        = any
  default     = null
}

variable "default_price" {
  description = "The default monetary price for the service."
  type        = any
  default     = null
}

variable "default_price_type" {
  description = "Represents the type of pricing of a booking service."
  type        = string
  default     = null

  validation {
    condition     = var.default_price_type == null ? true : contains(["undefined", "fixedPrice", "startingAt", "hourly", "free", "priceVaries", "callUs", "notSet", "unknownFutureValue"], var.default_price_type)
    error_message = "default_price_type must be one of the documented enum values."
  }
}

variable "default_reminders" {
  description = "The default set of reminders for an appointment of this service. The value of this property is available only when reading this bookingService by its ID."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.bookingReminder")
    message    = optional(string)
    offset     = optional(string)
    recipients = optional(string)
  }))
  default = null
}

variable "description" {
  description = "A text description for the service."
  type        = string
  default     = null
}

variable "display_name" {
  description = "A service name."
  type        = string
  default     = null
}

variable "is_anonymous_join_enabled" {
  description = "Indicates if an anonymousJoinWebUrl(webrtcUrl) is generated for the appointment booked for this service. The default value is false."
  type        = bool
  default     = null
}

variable "is_customer_allowed_to_manage_booking" {
  description = "Indicates that the customer can manage bookings created by the staff. The default value is false."
  type        = bool
  default     = null
}

variable "is_hidden_from_customers" {
  description = "True indicates that this service isn't available to customers for booking."
  type        = bool
  default     = null
}

variable "is_location_online" {
  description = "Indicates that the appointments for the service are held online. The default value is false."
  type        = bool
  default     = null
}

variable "language_tag" {
  description = "The language of the self-service booking page."
  type        = string
  default     = null
}

variable "last_updated_date_time" {
  description = "The date, time, and time zone when the service was last updated. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "maximum_attendees_count" {
  description = "The maximum number of customers allowed in a service. If maximumAttendeesCount of the service is greater than 1, pass valid customer IDs while creating or updating an appointment. To create a customer, use the Create bookingCustomer operation."
  type        = number
  default     = null
}

variable "notes" {
  description = "Additional information about this service."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.bookingService"
  nullable    = false
}

variable "post_buffer" {
  description = "The time to buffer after an appointment for this service ends, and before the next customer appointment can be booked."
  type        = string
  default     = null
}

variable "pre_buffer" {
  description = "The time to buffer before an appointment for this service can start."
  type        = string
  default     = null
}

variable "scheduling_policy" {
  description = "The set of policies that determine how appointments for this type of service should be created and managed."
  type        = any
  default     = null
}

variable "sms_notifications_enabled" {
  description = "True indicates SMS notifications can be sent to the customers for the appointment of the service. Default value is false."
  type        = bool
  default     = null
}

variable "staff_member_ids" {
  description = "Represents those staff members who provide this service."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "webUrl"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
