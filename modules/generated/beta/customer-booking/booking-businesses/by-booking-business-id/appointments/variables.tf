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

variable "anonymous_join_web_url" {
  description = "The URL of the meeting to join anonymously."
  type        = string
  default     = null
}

variable "appointment_label" {
  description = "The user can stamp a custom label on the appointment."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "The date, time, and timezone when the appointment was created."
  type        = string
  default     = null
}

variable "customer_email_address" {
  description = "The SMTP address of the bookingCustomer who is booking the appointment."
  type        = string
  default     = null
}

variable "customer_id" {
  description = "The ID of the bookingCustomer for this appointment. If no ID is specified when an appointment is created, then a new bookingCustomer object is created. Once set, you should consider the customerId immutable."
  type        = string
  default     = null
}

variable "customer_location" {
  description = "Represents location information for the bookingCustomer who is booking the appointment."
  type        = any
  default     = null
}

variable "customer_name" {
  description = "The customer's name."
  type        = string
  default     = null
}

variable "customer_notes" {
  description = "Notes from the customer associated with this appointment. You can get the value only when you read this bookingAppointment by its ID. You can set this property only when you initially create an appointment with a new customer."
  type        = string
  default     = null
}

variable "customer_phone" {
  description = "The customer's phone number."
  type        = string
  default     = null
}

variable "customer_time_zone" {
  description = "The time zone of the customer. For a list of possible values, see dateTimeTimeZone."
  type        = string
  default     = null
}

variable "customers" {
  description = "A collection of the customer properties for an appointment. An appointment will contain a list of customer information and each unit will indicate the properties of a customer who is part of that appointment. Optional."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.bookingCustomerInformationBase")
  }))
  default = null
}

variable "end" {
  description = "Microsoft Graph end property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
    dateTime   = optional(string)
    timeZone   = optional(string)
  })
  default = null
}

variable "invoice_amount" {
  description = "The billed amount on the invoice."
  type        = any
  default     = null
}

variable "invoice_date" {
  description = "The date, time, and time zone of the invoice for this appointment."
  type        = any
  default     = null
}

variable "invoice_id" {
  description = "The ID of the invoice."
  type        = string
  default     = null
}

variable "invoice_status" {
  description = "Microsoft Graph invoiceStatus property."
  type        = string
  default     = null

  validation {
    condition     = var.invoice_status == null ? true : contains(["draft", "reviewing", "open", "canceled", "paid", "corrective"], var.invoice_status)
    error_message = "invoice_status must be one of the documented enum values."
  }
}

variable "invoice_url" {
  description = "The URL of the invoice in Microsoft Bookings."
  type        = string
  default     = null
}

variable "is_customer_allowed_to_manage_booking" {
  description = "Indicates that the customer can manage bookings created by the staff. The default value is false."
  type        = bool
  default     = null
}

variable "is_location_online" {
  description = "Indicates that the appointment is held online. The default value is false."
  type        = bool
  default     = null
}

variable "join_web_url" {
  description = "The URL of the online meeting for the appointment."
  type        = string
  default     = null
}

variable "last_updated_date_time" {
  description = "The date, time and timezone when the booking business was last updated."
  type        = string
  default     = null
}

variable "maximum_attendees_count" {
  description = "The maximum number of customers allowed in an appointment. If maximumAttendeesCount of the service is greater than 1, pass valid customer IDs while creating or updating an appointment. To create a customer, use the Create bookingCustomer operation."
  type        = number
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.bookingAppointment"
  nullable    = false
}

variable "online_meeting_url" {
  description = "Microsoft Graph onlineMeetingUrl property."
  type        = string
  default     = null
}

variable "opt_out_of_customer_email" {
  description = "True indicates that the bookingCustomer for this appointment does not wish to receive a confirmation for this appointment."
  type        = bool
  default     = null
}

variable "post_buffer" {
  description = "The amount of time to reserve after the appointment ends, for cleaning up, as an example. The value is expressed in ISO8601 format."
  type        = string
  default     = null
}

variable "pre_buffer" {
  description = "The amount of time to reserve before the appointment begins, for preparation, as an example. The value is expressed in ISO8601 format."
  type        = string
  default     = null
}

variable "price" {
  description = "The regular price for an appointment for the specified bookingService."
  type        = any
  default     = null
}

variable "price_type" {
  description = "Represents the type of pricing of a booking service."
  type        = string
  default     = null

  validation {
    condition     = var.price_type == null ? true : contains(["undefined", "fixedPrice", "startingAt", "hourly", "free", "priceVaries", "callUs", "notSet"], var.price_type)
    error_message = "price_type must be one of the documented enum values."
  }
}

variable "reminders" {
  description = "The collection of customer reminders sent for this appointment. The value of this property is available only when reading this bookingAppointment by its ID."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.bookingReminder")
    message    = optional(string)
    offset     = optional(string)
    recipients = optional(string)
  }))
  default = null
}

variable "self_service_appointment_id" {
  description = "Another tracking ID for the appointment, if the appointment was created directly by the customer on the scheduling page, as opposed to by a staff member on behalf of customer."
  type        = string
  default     = null
}

variable "service_id" {
  description = "The ID of the bookingService associated with this appointment."
  type        = string
  default     = null
}

variable "service_location" {
  description = "The location where the service is delivered."
  type        = any
  default     = null
}

variable "service_name" {
  description = "The name of the bookingService associated with this appointment.This property is optional when creating a new appointment. If not specified, it is computed from the service associated with the appointment by the serviceId property."
  type        = string
  default     = null
}

variable "service_notes" {
  description = "Notes from a bookingStaffMember. The value of this property is available only when reading this bookingAppointment by its ID."
  type        = string
  default     = null
}

variable "sms_notifications_enabled" {
  description = "True indicates SMS notifications will be sent to the customers for the appointment. Default value is false."
  type        = bool
  default     = null
}

variable "staff_member_ids" {
  description = "The ID of each bookingStaffMember who is scheduled in this appointment."
  type        = list(string)
  default     = null
}

variable "start" {
  description = "Microsoft Graph start property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
    dateTime   = optional(string)
    timeZone   = optional(string)
  })
  default = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["duration", "filledAttendeesCount", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
