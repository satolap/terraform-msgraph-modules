variable "user_id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_id)) > 0
    error_message = "user_id must not be empty."
  }
}

variable "team_id" {
  description = "The unique identifier of team"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.team_id)) > 0
    error_message = "team_id must not be empty."
  }
}

variable "code" {
  description = "The code of the timeOffReason to represent an external identifier. This field must be unique within the team in Microsoft Teams and uses an alphanumeric format, with a maximum of 100 characters."
  type        = string
  default     = null
}

variable "created_by" {
  description = "Identity of the creator of the entity."
  type        = any
  default     = null
}

variable "display_name" {
  description = "The name of the timeOffReason. Required."
  type        = string
  default     = null
}

variable "icon_type" {
  description = "Supported icon types are: none, car, calendar, running, plane, firstAid, doctor, notWorking, clock, juryDuty, globe, cup, phone, weather, umbrella, piggyBank, dog, cake, trafficCone, pin, sunny. Required."
  type        = any
  default     = null

  validation {
    condition     = var.icon_type == null ? true : contains(["none", "car", "calendar", "running", "plane", "firstAid", "doctor", "notWorking", "clock", "juryDuty", "globe", "cup", "phone", "weather", "umbrella", "piggyBank", "dog", "cake", "trafficCone", "pin", "sunny", "unknownFutureValue"], var.icon_type)
    error_message = "icon_type must be one of the documented enum values."
  }
}

variable "is_active" {
  description = "Indicates whether the timeOffReason can be used when creating new entities or updating existing ones. Required."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.timeOffReason"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "lastModifiedBy", "lastModifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
