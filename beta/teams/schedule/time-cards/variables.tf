variable "team_id" {
  description = "The unique identifier of team"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.team_id)) > 0
    error_message = "team_id must not be empty."
  }
}

variable "breaks" {
  description = "The list of breaks associated with the timeCard."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.timeCardBreak")
    breakId    = optional(string)
    end = optional(object({
      odata_type           = optional(string, "#microsoft.graph.timeCardEvent")
      atApprovedLocation   = optional(bool)
      dateTime             = optional(string)
      isAtApprovedLocation = optional(bool)
      notes = optional(object({
        odata_type  = optional(string, "#microsoft.graph.itemBody")
        content     = optional(string)
        contentType = optional(string)
      }))
    }))
    notes = optional(object({
      odata_type  = optional(string, "#microsoft.graph.itemBody")
      content     = optional(string)
      contentType = optional(string)
    }))
    start = optional(object({
      odata_type           = optional(string, "#microsoft.graph.timeCardEvent")
      atApprovedLocation   = optional(bool)
      dateTime             = optional(string)
      isAtApprovedLocation = optional(bool)
      notes = optional(object({
        odata_type  = optional(string, "#microsoft.graph.itemBody")
        content     = optional(string)
        contentType = optional(string)
      }))
    }))
  }))
  default = null
}

variable "clock_in_event" {
  description = "The clock-in event of the timeCard."
  type = object({
    odata_type           = optional(string, "#microsoft.graph.timeCardEvent")
    atApprovedLocation   = optional(bool)
    dateTime             = optional(string)
    isAtApprovedLocation = optional(bool)
    notes = optional(object({
      odata_type  = optional(string, "#microsoft.graph.itemBody")
      content     = optional(string)
      contentType = optional(string)
    }))
  })
  default = null
}

variable "clock_out_event" {
  description = "The clock-out event of the timeCard."
  type = object({
    odata_type           = optional(string, "#microsoft.graph.timeCardEvent")
    atApprovedLocation   = optional(bool)
    dateTime             = optional(string)
    isAtApprovedLocation = optional(bool)
    notes = optional(object({
      odata_type  = optional(string, "#microsoft.graph.itemBody")
      content     = optional(string)
      contentType = optional(string)
    }))
  })
  default = null
}

variable "confirmed_by" {
  description = "Indicates whether this timeCard entry is confirmed. Possible values are none, user, manager, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.confirmed_by == null ? true : try(alltrue([for value in split(",", var.confirmed_by) : contains(["none", "user", "manager", "unknownfuturevalue"], lower(trimspace(value)))]), false)
    error_message = "confirmed_by must be one or more of the documented enum values, separated by commas."
  }
}

variable "created_by" {
  description = "Identity of the user who created the entity."
  type        = any
  default     = null
}

variable "notes" {
  description = "Notes about the timeCard."
  type = object({
    odata_type  = optional(string, "#microsoft.graph.itemBody")
    content     = optional(string)
    contentType = optional(string)
  })
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.timeCard"
  nullable    = false
}

variable "original_entry" {
  description = "The original timeCardEntry of the timeCard, before user edits."
  type = object({
    odata_type = optional(string, "#microsoft.graph.timeCardEntry")
    breaks = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.timeCardBreak")
      breakId    = optional(string)
      end = optional(object({
        odata_type           = optional(string, "#microsoft.graph.timeCardEvent")
        atApprovedLocation   = optional(bool)
        dateTime             = optional(string)
        isAtApprovedLocation = optional(bool)
        notes = optional(object({
          odata_type  = optional(string, "#microsoft.graph.itemBody")
          content     = optional(string)
          contentType = optional(string)
        }))
      }))
      notes = optional(object({
        odata_type  = optional(string, "#microsoft.graph.itemBody")
        content     = optional(string)
        contentType = optional(string)
      }))
      start = optional(object({
        odata_type           = optional(string, "#microsoft.graph.timeCardEvent")
        atApprovedLocation   = optional(bool)
        dateTime             = optional(string)
        isAtApprovedLocation = optional(bool)
        notes = optional(object({
          odata_type  = optional(string, "#microsoft.graph.itemBody")
          content     = optional(string)
          contentType = optional(string)
        }))
      }))
    })))
    clockInEvent = optional(object({
      odata_type           = optional(string, "#microsoft.graph.timeCardEvent")
      atApprovedLocation   = optional(bool)
      dateTime             = optional(string)
      isAtApprovedLocation = optional(bool)
      notes = optional(object({
        odata_type  = optional(string, "#microsoft.graph.itemBody")
        content     = optional(string)
        contentType = optional(string)
      }))
    }))
    clockOutEvent = optional(object({
      odata_type           = optional(string, "#microsoft.graph.timeCardEvent")
      atApprovedLocation   = optional(bool)
      dateTime             = optional(string)
      isAtApprovedLocation = optional(bool)
      notes = optional(object({
        odata_type  = optional(string, "#microsoft.graph.itemBody")
        content     = optional(string)
        contentType = optional(string)
      }))
    }))
  })
  default = null
}

variable "state" {
  description = "The current state of the timeCard during its life cycle. The possible values are: clockedIn, onBreak, clockedOut, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["clockedIn", "onBreak", "clockedOut", "unknownFutureValue"], var.state)
    error_message = "state must be one of the documented enum values."
  }
}

variable "user_id" {
  description = "User ID to which  the timeCard belongs."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "lastModifiedBy", "lastModifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
