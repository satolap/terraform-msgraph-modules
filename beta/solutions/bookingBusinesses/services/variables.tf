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

variable "createdDateTime" {
  description = "The date, time and timezone when the Service was created."
  type        = string
  default     = null
}

variable "customQuestions" {
  description = "Contains the set of custom questions associated with a particular service."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.bookingQuestionAssignment")
    isRequired = optional(bool)
    questionId = optional(string)
  }))
  default = null
}

variable "defaultDuration" {
  description = "The default length of the service, represented in numbers of days, hours, minutes, and seconds. For example, P11D23H59M59.999999999999S."
  type        = string
  default     = null
}

variable "defaultLocation" {
  description = "The default physical location for the service."
  type        = any
  default     = null
}

variable "defaultPrice" {
  description = "The default monetary price for the service."
  type        = any
  default     = null
}

variable "defaultPriceType" {
  description = "Represents the type of pricing of a booking service."
  type        = string
  default     = null

  validation {
    condition     = var.defaultPriceType == null ? true : contains(["undefined", "fixedPrice", "startingAt", "hourly", "free", "priceVaries", "callUs", "notSet"], var.defaultPriceType)
    error_message = "defaultPriceType must be one of the documented enum values."
  }
}

variable "defaultReminders" {
  description = "The default set of reminders for an appointment of this service. The value of this property is available only when reading this bookingService by its ID."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.bookingReminder")
    message    = optional(string)
    offset     = optional(string)
    recipients = optional(string)
  }))
  default = null

  validation {
    condition     = (var.defaultReminders == null ? true : alltrue([alltrue([for input0 in var.defaultReminders : (input0 == null ? true : alltrue([(input0["recipients"] == null ? true : alltrue([(input0["recipients"] == null ? true : contains(["allAttendees", "staff", "customer"], input0["recipients"]))]))]))])]))
    error_message = "defaultReminders: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "description" {
  description = "A text description for the service."
  type        = string
  default     = null
}

variable "displayName" {
  description = "A name for the derived entity, which interfaces with customers."
  type        = string
  default     = null
}

variable "isAnonymousJoinEnabled" {
  description = "Indicates if an anonymousJoinWebUrl(webrtcUrl) is generated for the appointment booked for this service. The default value is false."
  type        = bool
  default     = null
}

variable "isCustomerAllowedToManageBooking" {
  description = "Indicates that the customer can manage bookings created by the staff. The default value is false."
  type        = bool
  default     = null
}

variable "isHiddenFromCustomers" {
  description = "True means this service isn't available to customers for booking."
  type        = bool
  default     = null
}

variable "isLocationOnline" {
  description = "Indicates that the appointments for the service are held online. The default value is false."
  type        = bool
  default     = null
}

variable "languageTag" {
  description = "The language of the self service booking page."
  type        = string
  default     = null
}

variable "lastUpdatedDateTime" {
  description = "The date, time and timezone when the Service  was last updated."
  type        = string
  default     = null
}

variable "maximumAttendeesCount" {
  description = "The maximum number of customers allowed in a service. If maximumAttendeesCount of the service is greater than 1, pass valid customer IDs while creating or updating an appointment.  To create a customer, use the Create bookingCustomer operation."
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

variable "postBuffer" {
  description = "The time to buffer after an appointment for this service ends, and before the next customer appointment can be booked."
  type        = string
  default     = null
}

variable "preBuffer" {
  description = "The time to buffer before an appointment for this service can start."
  type        = string
  default     = null
}

variable "schedulingPolicy" {
  description = "The set of policies that determine how appointments for this type of service should be created and managed."
  type = object({
    odata_type          = optional(string, "#microsoft.graph.bookingSchedulingPolicy")
    allowStaffSelection = optional(bool)
    customAvailabilities = optional(list(object({
      odata_type       = optional(string, "#microsoft.graph.bookingsAvailabilityWindow")
      availabilityType = optional(string)
      businessHours = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.bookingWorkHours")
        day        = optional(string)
        timeSlots  = optional(any)
      })))
      endDate   = optional(string)
      startDate = optional(string)
    })))
    generalAvailability               = optional(any)
    isMeetingInviteToCustomersEnabled = optional(bool)
    maximumAdvance                    = optional(string)
    minimumLeadTime                   = optional(string)
    sendConfirmationsToOwner          = optional(bool)
    timeSlotInterval                  = optional(string)
  })
  default = null

  validation {
    condition     = (var.schedulingPolicy == null ? true : alltrue([(var.schedulingPolicy["customAvailabilities"] == null ? true : alltrue([alltrue([for input1 in var.schedulingPolicy["customAvailabilities"] : (input1 == null ? true : alltrue([(input1["availabilityType"] == null ? true : alltrue([(input1["availabilityType"] == null ? true : contains(["bookWhenStaffAreFree", "notBookable", "customWeeklyHours"], input1["availabilityType"]))])), (input1["businessHours"] == null ? true : alltrue([alltrue([for input3 in input1["businessHours"] : (input3 == null ? true : alltrue([(input3["day"] == null ? true : alltrue([(input3["day"] == null ? true : contains(["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"], input3["day"]))]))]))])]))]))])]))]))
    error_message = "schedulingPolicy: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "smsNotificationsEnabled" {
  description = "True indicates SMS notifications can be sent to the customers for the appointment of the service. Default value is false."
  type        = bool
  default     = null
}

variable "staffMemberIds" {
  description = "Represents those staff members who provide this service."
  type        = list(string)
  default     = null
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "webUrl"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
