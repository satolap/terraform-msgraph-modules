variable "booking_business_id" {
  description = "The unique identifier of bookingBusiness"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.booking_business_id)) > 0
    error_message = "booking_business_id must not be empty."
  }
}

variable "availability_is_affected_by_personal_calendar" {
  description = "True means that if the staff member is a Microsoft 365 user, the Bookings API would verify the staff member's availability in their personal calendar in Microsoft 365, before making a booking."
  type        = bool
  default     = null
}

variable "color_index" {
  description = "Identifies a color to represent the staff member. The color corresponds to the color palette in the Staff details page in the Bookings app."
  type        = number
  default     = null
}

variable "created_date_time" {
  description = "The date, time and timezone when the staff member was created."
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

variable "is_email_notification_enabled" {
  description = "Indicates that a staff members are  notified via email when a booking assigned to them is created or changed. The default value is true"
  type        = bool
  default     = null
}

variable "last_updated_date_time" {
  description = "The date, time and timezone when the staff member was last updated."
  type        = string
  default     = null
}

variable "membership_status" {
  description = "Microsoft Graph membershipStatus property."
  type        = string
  default     = null

  validation {
    condition     = var.membership_status == null ? true : contains(["active", "pendingAcceptance", "rejectedByStaff", "unknownFutureValue"], var.membership_status)
    error_message = "membership_status must be one of the documented enum values."
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
    condition     = var.role == null ? true : contains(["guest", "administrator", "viewer", "externalGuest", "unknownFutureValue", "scheduler", "teamMember"], var.role)
    error_message = "role must be one of the documented enum values."
  }
}

variable "time_zone" {
  description = "The time zone of the staff member. For a list of possible values, see dateTimeTimeZone."
  type        = string
  default     = null
}

variable "use_business_hours" {
  description = "True means the staff member's availability is as specified in the businessHours property of the business. False means the availability is determined by the staff member's workingHours property setting."
  type        = bool
  default     = null
}

variable "working_hours" {
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
