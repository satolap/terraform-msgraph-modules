variable "address" {
  description = "The street address of the business. The address property, together with phone and webSiteUrl, appear in the footer of a business scheduling page."
  type = object({
    odata_type      = optional(string, "#microsoft.graph.physicalAddress")
    city            = optional(string)
    countryOrRegion = optional(string)
    postOfficeBox   = optional(string)
    postalCode      = optional(string)
    state           = optional(string)
    street          = optional(string)
    type            = optional(string)
  })
  default = null

  validation {
    condition     = (var.address == null ? true : alltrue([(var.address["type"] == null ? true : alltrue([(var.address["type"] == null ? true : contains(["unknown", "home", "business", "other"], var.address["type"]))]))]))
    error_message = "address: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "booking_page_settings" {
  description = "Settings for the published booking page."
  type = object({
    odata_type                              = optional(string, "#microsoft.graph.bookingPageSettings")
    accessControl                           = optional(string)
    bookingPageColorCode                    = optional(string)
    businessTimeZone                        = optional(string)
    customerConsentMessage                  = optional(string)
    enforceOneTimePassword                  = optional(bool)
    isBusinessLogoDisplayEnabled            = optional(bool)
    isCustomerConsentEnabled                = optional(bool)
    isSearchEngineIndexabilityDisabled      = optional(bool)
    isTimeSlotTimeZoneSetToBusinessTimeZone = optional(bool)
    privacyPolicyWebUrl                     = optional(string)
    termsAndConditionsWebUrl                = optional(string)
  })
  default   = null
  sensitive = true

  validation {
    condition     = (var.booking_page_settings == null ? true : alltrue([(var.booking_page_settings["accessControl"] == null ? true : alltrue([(var.booking_page_settings["accessControl"] == null ? true : contains(["unrestricted", "restrictedToOrganization"], var.booking_page_settings["accessControl"]))]))]))
    error_message = "booking_page_settings: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "business_hours" {
  description = "The hours of operation for the business."
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
    condition     = (var.business_hours == null ? true : alltrue([alltrue([for input0 in var.business_hours : (input0 == null ? true : alltrue([(input0["day"] == null ? true : alltrue([(input0["day"] == null ? true : contains(["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"], input0["day"]))]))]))])]))
    error_message = "business_hours: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "business_type" {
  description = "The type of business."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "The date, time and timezone when the booking business was created."
  type        = string
  default     = null
}

variable "custom_questions" {
  description = "All custom questions of this business."
  type = list(object({
    odata_type          = optional(string, "#microsoft.graph.bookingCustomQuestion")
    answerInputType     = optional(string)
    answerOptions       = optional(list(string))
    createdDateTime     = optional(string)
    displayName         = optional(string)
    lastUpdatedDateTime = optional(string)
  }))
  default = null

  validation {
    condition     = (var.custom_questions == null ? true : alltrue([alltrue([for input0 in var.custom_questions : (input0 == null ? true : alltrue([(input0["answerInputType"] == null ? true : alltrue([(input0["answerInputType"] == null ? true : contains(["text", "radioButton"], input0["answerInputType"]))]))]))])]))
    error_message = "custom_questions: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "default_currency_iso" {
  description = "The code for the currency that the business operates in on Microsoft Bookings."
  type        = string
  default     = null
}

variable "display_name" {
  description = "A name for the derived entity, which interfaces with customers."
  type        = string
  default     = null
}

variable "email" {
  description = "The email address for the business."
  type        = string
  default     = null
}

variable "language_tag" {
  description = "The language of the self service booking page"
  type        = string
  default     = null
}

variable "last_updated_date_time" {
  description = "The date, time and timezone when the booking business was last updated."
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
    condition     = (var.scheduling_policy == null ? true : alltrue([(var.scheduling_policy["customAvailabilities"] == null ? true : alltrue([alltrue([for input1 in var.scheduling_policy["customAvailabilities"] : (input1 == null ? true : alltrue([(input1["availabilityType"] == null ? true : alltrue([(input1["availabilityType"] == null ? true : contains(["bookWhenStaffAreFree", "notBookable", "customWeeklyHours"], input1["availabilityType"]))])), (input1["businessHours"] == null ? true : alltrue([alltrue([for input3 in input1["businessHours"] : (input3 == null ? true : alltrue([(input3["day"] == null ? true : alltrue([(input3["day"] == null ? true : contains(["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"], input3["day"]))]))]))])]))]))])]))]))
    error_message = "scheduling_policy: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "web_site_url" {
  description = "The URL of the business web site. The webSiteUrl property, together with address, phone, appear in the footer of a business scheduling page."
  type        = string
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["appointments", "calendarView", "customers", "id", "isPublished", "publicUrl", "services", "staffMembers"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
