variable "bookingBusiness-id" {
  description = "The unique identifier of bookingBusiness"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.bookingBusiness-id)) > 0
    error_message = "bookingBusiness-id must not be empty."
  }
}

variable "additionalInformation" {
  description = "Additional information that is sent to the customer when an appointment is confirmed."
  type        = string
  default     = null
}

variable "anonymousJoinWebUrl" {
  description = "The URL of the meeting to join anonymously."
  type        = string
  default     = null
}

variable "appointmentLabel" {
  description = "The user can stamp a custom label on the appointment."
  type        = string
  default     = null
}

variable "createdDateTime" {
  description = "The date, time, and timezone when the appointment was created."
  type        = string
  default     = null
}

variable "customerEmailAddress" {
  description = "The SMTP address of the bookingCustomer who is booking the appointment."
  type        = string
  default     = null
}

variable "customerId" {
  description = "The ID of the bookingCustomer for this appointment. If no ID is specified when an appointment is created, then a new bookingCustomer object is created. Once set, you should consider the customerId immutable."
  type        = string
  default     = null
}

variable "customerLocation" {
  description = "Represents location information for the bookingCustomer who is booking the appointment."
  type        = any
  default     = null
}

variable "customerName" {
  description = "The customer's name."
  type        = string
  default     = null
}

variable "customerNotes" {
  description = "Notes from the customer associated with this appointment. You can get the value only when you read this bookingAppointment by its ID. You can set this property only when you initially create an appointment with a new customer."
  type        = string
  default     = null
}

variable "customerPhone" {
  description = "The customer's phone number."
  type        = string
  default     = null
}

variable "customerTimeZone" {
  description = "The time zone of the customer. For a list of possible values, see dateTimeTimeZone."
  type        = string
  default     = null
}

variable "customers" {
  description = "A collection of the customer properties for an appointment. An appointment will contain a list of customer information and each unit will indicate the properties of a customer who is part of that appointment. Optional."
  type        = any
  default     = null
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

variable "invoiceAmount" {
  description = "The billed amount on the invoice."
  type        = any
  default     = null
}

variable "invoiceDate" {
  description = "The date, time, and time zone of the invoice for this appointment."
  type = object({
    odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")
    dateTime   = optional(string)
    timeZone   = optional(string)
  })
  default = null
}

variable "invoiceId" {
  description = "The ID of the invoice."
  type        = string
  default     = null
}

variable "invoiceStatus" {
  description = "Microsoft Graph invoiceStatus property."
  type        = string
  default     = null

  validation {
    condition     = var.invoiceStatus == null ? true : contains(["draft", "reviewing", "open", "canceled", "paid", "corrective"], var.invoiceStatus)
    error_message = "invoiceStatus must be one of the documented enum values."
  }
}

variable "invoiceUrl" {
  description = "The URL of the invoice in Microsoft Bookings."
  type        = string
  default     = null
}

variable "isCustomerAllowedToManageBooking" {
  description = "Indicates that the customer can manage bookings created by the staff. The default value is false."
  type        = bool
  default     = null
}

variable "isLocationOnline" {
  description = "Indicates that the appointment is held online. The default value is false."
  type        = bool
  default     = null
}

variable "joinWebUrl" {
  description = "The URL of the online meeting for the appointment."
  type        = string
  default     = null
}

variable "lastUpdatedDateTime" {
  description = "The date, time and timezone when the booking business was last updated."
  type        = string
  default     = null
}

variable "maximumAttendeesCount" {
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

variable "onlineMeetingUrl" {
  description = "Microsoft Graph onlineMeetingUrl property."
  type        = string
  default     = null
}

variable "optOutOfCustomerEmail" {
  description = "True indicates that the bookingCustomer for this appointment does not wish to receive a confirmation for this appointment."
  type        = bool
  default     = null
}

variable "postBuffer" {
  description = "The amount of time to reserve after the appointment ends, for cleaning up, as an example. The value is expressed in ISO8601 format."
  type        = string
  default     = null
}

variable "preBuffer" {
  description = "The amount of time to reserve before the appointment begins, for preparation, as an example. The value is expressed in ISO8601 format."
  type        = string
  default     = null
}

variable "price" {
  description = "The regular price for an appointment for the specified bookingService."
  type        = any
  default     = null
}

variable "priceType" {
  description = "Represents the type of pricing of a booking service."
  type        = string
  default     = null

  validation {
    condition     = var.priceType == null ? true : contains(["undefined", "fixedPrice", "startingAt", "hourly", "free", "priceVaries", "callUs", "notSet"], var.priceType)
    error_message = "priceType must be one of the documented enum values."
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

  validation {
    condition     = (var.reminders == null ? true : alltrue([alltrue([for input0 in var.reminders : (input0 == null ? true : alltrue([(input0["recipients"] == null ? true : alltrue([(input0["recipients"] == null ? true : contains(["allAttendees", "staff", "customer"], input0["recipients"]))]))]))])]))
    error_message = "reminders: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "selfServiceAppointmentId" {
  description = "Another tracking ID for the appointment, if the appointment was created directly by the customer on the scheduling page, as opposed to by a staff member on behalf of customer."
  type        = string
  default     = null
}

variable "serviceId" {
  description = "The ID of the bookingService associated with this appointment."
  type        = string
  default     = null
}

variable "serviceLocation" {
  description = "The location where the service is delivered."
  type        = any
  default     = null
}

variable "serviceName" {
  description = "The name of the bookingService associated with this appointment.This property is optional when creating a new appointment. If not specified, it is computed from the service associated with the appointment by the serviceId property."
  type        = string
  default     = null
}

variable "serviceNotes" {
  description = "Notes from a bookingStaffMember. The value of this property is available only when reading this bookingAppointment by its ID."
  type        = string
  default     = null
}

variable "smsNotificationsEnabled" {
  description = "True indicates SMS notifications will be sent to the customers for the appointment. Default value is false."
  type        = bool
  default     = null
}

variable "staffMemberIds" {
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["duration", "filledAttendeesCount", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
