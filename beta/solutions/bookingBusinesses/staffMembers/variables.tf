variable "bookingBusiness-id" {
  description = "The unique identifier of bookingBusiness"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.bookingBusiness-id)) > 0
    error_message = "bookingBusiness-id must not be empty."
  }
}

variable "availabilityIsAffectedByPersonalCalendar" {
  description = "True means that if the staff member is a Microsoft 365 user, the Bookings API would verify the staff member's availability in their personal calendar in Microsoft 365, before making a booking."
  type        = bool
  default     = null
}

variable "colorIndex" {
  description = "Identifies a color to represent the staff member. The color corresponds to the color palette in the Staff details page in the Bookings app."
  type        = number
  default     = null
}

variable "createdDateTime" {
  description = "The date, time and timezone when the staff member was created."
  type        = string
  default     = null
}

variable "displayName" {
  description = "A name for the derived entity, which interfaces with customers."
  type        = string
  default     = null
}

variable "emailAddress" {
  description = "The email address of the person."
  type        = string
  default     = null
}

variable "isEmailNotificationEnabled" {
  description = "Indicates that a staff members are  notified via email when a booking assigned to them is created or changed. The default value is true"
  type        = bool
  default     = null
}

variable "lastUpdatedDateTime" {
  description = "The date, time and timezone when the staff member was last updated."
  type        = string
  default     = null
}

variable "membershipStatus" {
  description = "Microsoft Graph membershipStatus property."
  type        = string
  default     = null

  validation {
    condition     = var.membershipStatus == null ? true : contains(["active", "pendingAcceptance", "rejectedByStaff"], var.membershipStatus)
    error_message = "membershipStatus must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.bookingStaffMember"
  nullable    = false
}

variable "role" {
  description = "Microsoft Graph role property."
  type        = string
  default     = null

  validation {
    condition     = var.role == null ? true : contains(["guest", "administrator", "viewer", "externalGuest"], var.role)
    error_message = "role must be one of the documented enum values."
  }
}

variable "timeZone" {
  description = "The time zone of the staff member. For a list of possible values, see dateTimeTimeZone."
  type        = string
  default     = null
}

variable "useBusinessHours" {
  description = "True means the staff member's availability is as specified in the businessHours property of the business. False means the availability is determined by the staff member's workingHours property setting."
  type        = bool
  default     = null
}

variable "workingHours" {
  description = "The range of hours each day of the week that the staff member is available for booking. By default, they're initialized to be the same as the businessHours property of the business."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.bookingWorkHours")
    day        = optional(string)
    timeSlots = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.bookingWorkTimeSlot")
      end        = optional(string)
      start      = optional(string)
    })))
  }))
  default = null

  validation {
    condition     = (var.workingHours == null ? true : alltrue([alltrue([for input0 in var.workingHours : (input0 == null ? true : alltrue([(input0["day"] == null ? true : alltrue([(input0["day"] == null ? true : contains(["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"], input0["day"]))]))]))])]))
    error_message = "workingHours: nested required attributes must be non-null and enum values must be supported input members."
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
