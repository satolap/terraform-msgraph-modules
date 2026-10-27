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

  validation {
    condition     = (var.breaks == null ? true : alltrue([alltrue([for input0 in var.breaks : (input0 == null ? true : alltrue([(input0["end"] == null ? true : alltrue([(input0["end"]["notes"] == null ? true : alltrue([(input0["end"]["notes"]["contentType"] == null ? true : alltrue([(input0["end"]["notes"]["contentType"] == null ? true : contains(["text", "html"], input0["end"]["notes"]["contentType"]))]))]))])), (input0["notes"] == null ? true : alltrue([(input0["notes"]["contentType"] == null ? true : alltrue([(input0["notes"]["contentType"] == null ? true : contains(["text", "html"], input0["notes"]["contentType"]))]))])), (input0["start"] == null ? true : alltrue([(input0["start"]["notes"] == null ? true : alltrue([(input0["start"]["notes"]["contentType"] == null ? true : alltrue([(input0["start"]["notes"]["contentType"] == null ? true : contains(["text", "html"], input0["start"]["notes"]["contentType"]))]))]))]))]))])]))
    error_message = "breaks: nested required attributes must be non-null and enum values must be supported input members."
  }
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

  validation {
    condition     = (var.clock_in_event == null ? true : alltrue([(var.clock_in_event["notes"] == null ? true : alltrue([(var.clock_in_event["notes"]["contentType"] == null ? true : alltrue([(var.clock_in_event["notes"]["contentType"] == null ? true : contains(["text", "html"], var.clock_in_event["notes"]["contentType"]))]))]))]))
    error_message = "clock_in_event: nested required attributes must be non-null and enum values must be supported input members."
  }
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

  validation {
    condition     = (var.clock_out_event == null ? true : alltrue([(var.clock_out_event["notes"] == null ? true : alltrue([(var.clock_out_event["notes"]["contentType"] == null ? true : alltrue([(var.clock_out_event["notes"]["contentType"] == null ? true : contains(["text", "html"], var.clock_out_event["notes"]["contentType"]))]))]))]))
    error_message = "clock_out_event: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "confirmed_by" {
  description = "Indicates whether this timeCard entry is confirmed. Possible values are none, user, manager, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.confirmed_by == null ? true : try(alltrue([for value in split(",", var.confirmed_by) : contains(["none", "user", "manager"], lower(trimspace(value)))]), false)
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

  validation {
    condition     = (var.notes == null ? true : alltrue([(var.notes["contentType"] == null ? true : alltrue([(var.notes["contentType"] == null ? true : contains(["text", "html"], var.notes["contentType"]))]))]))
    error_message = "notes: nested required attributes must be non-null and enum values must be supported input members."
  }
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

  validation {
    condition     = (var.original_entry == null ? true : alltrue([(var.original_entry["breaks"] == null ? true : alltrue([alltrue([for input1 in var.original_entry["breaks"] : (input1 == null ? true : alltrue([(input1["end"] == null ? true : alltrue([(input1["end"]["notes"] == null ? true : alltrue([(input1["end"]["notes"]["contentType"] == null ? true : alltrue([(input1["end"]["notes"]["contentType"] == null ? true : contains(["text", "html"], input1["end"]["notes"]["contentType"]))]))]))])), (input1["notes"] == null ? true : alltrue([(input1["notes"]["contentType"] == null ? true : alltrue([(input1["notes"]["contentType"] == null ? true : contains(["text", "html"], input1["notes"]["contentType"]))]))])), (input1["start"] == null ? true : alltrue([(input1["start"]["notes"] == null ? true : alltrue([(input1["start"]["notes"]["contentType"] == null ? true : alltrue([(input1["start"]["notes"]["contentType"] == null ? true : contains(["text", "html"], input1["start"]["notes"]["contentType"]))]))]))]))]))])])), (var.original_entry["clockInEvent"] == null ? true : alltrue([(var.original_entry["clockInEvent"]["notes"] == null ? true : alltrue([(var.original_entry["clockInEvent"]["notes"]["contentType"] == null ? true : alltrue([(var.original_entry["clockInEvent"]["notes"]["contentType"] == null ? true : contains(["text", "html"], var.original_entry["clockInEvent"]["notes"]["contentType"]))]))]))])), (var.original_entry["clockOutEvent"] == null ? true : alltrue([(var.original_entry["clockOutEvent"]["notes"] == null ? true : alltrue([(var.original_entry["clockOutEvent"]["notes"]["contentType"] == null ? true : alltrue([(var.original_entry["clockOutEvent"]["notes"]["contentType"] == null ? true : contains(["text", "html"], var.original_entry["clockOutEvent"]["notes"]["contentType"]))]))]))]))]))
    error_message = "original_entry: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "state" {
  description = "The current state of the timeCard during its life cycle. The possible values are: clockedIn, onBreak, clockedOut, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["clockedIn", "onBreak", "clockedOut"], var.state)
    error_message = "state must be one of the documented enum values."
  }
}

variable "user_id" {
  description = "User ID to which  the timeCard belongs."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "lastModifiedBy", "lastModifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
