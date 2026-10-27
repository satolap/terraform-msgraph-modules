variable "team_id" {
  description = "The unique identifier of team"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.team_id)) > 0
    error_message = "team_id must not be empty."
  }
}

variable "created_by" {
  description = "Identity of the user who created the entity."
  type        = any
  default     = null
}

variable "draft_open_shift" {
  description = "Draft changes in the openShift are only visible to managers until they're shared."
  type = object({
    odata_type = optional(string, "#microsoft.graph.openShiftItem")
    activities = optional(list(object({
      odata_type    = optional(string, "#microsoft.graph.shiftActivity")
      code          = optional(string)
      displayName   = optional(string)
      endDateTime   = optional(string)
      isPaid        = optional(bool)
      startDateTime = optional(string)
      theme         = optional(string)
    })))
    displayName   = optional(string)
    endDateTime   = optional(string)
    notes         = optional(string)
    openSlotCount = optional(number)
    startDateTime = optional(string)
    theme         = optional(string)
  })
  default = null

  validation {
    condition     = (var.draft_open_shift == null ? true : alltrue([(var.draft_open_shift["activities"] == null ? true : alltrue([alltrue([for input1 in var.draft_open_shift["activities"] : (input1 == null ? true : alltrue([(input1["theme"] == null ? true : alltrue([(input1["theme"] == null ? true : contains(["white", "blue", "green", "purple", "pink", "yellow", "gray", "darkBlue", "darkGreen", "darkPurple", "darkPink", "darkYellow"], input1["theme"]))]))]))])])), (var.draft_open_shift["theme"] == null ? true : alltrue([(var.draft_open_shift["theme"] == null ? true : contains(["white", "blue", "green", "purple", "pink", "yellow", "gray", "darkBlue", "darkGreen", "darkPurple", "darkPink", "darkYellow"], var.draft_open_shift["theme"]))]))]))
    error_message = "draft_open_shift: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "is_staged_for_deletion" {
  description = "The openShift is marked for deletion, a process that is finalized when the schedule is shared."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.openShift"
  nullable    = false
}

variable "scheduling_group_id" {
  description = "The ID of the schedulingGroup that contains the openShift."
  type        = string
  default     = null
}

variable "shared_open_shift" {
  description = "The shared version of this openShift that is viewable by both employees and managers."
  type = object({
    odata_type = optional(string, "#microsoft.graph.openShiftItem")
    activities = optional(list(object({
      odata_type    = optional(string, "#microsoft.graph.shiftActivity")
      code          = optional(string)
      displayName   = optional(string)
      endDateTime   = optional(string)
      isPaid        = optional(bool)
      startDateTime = optional(string)
      theme         = optional(string)
    })))
    displayName   = optional(string)
    endDateTime   = optional(string)
    notes         = optional(string)
    openSlotCount = optional(number)
    startDateTime = optional(string)
    theme         = optional(string)
  })
  default = null

  validation {
    condition     = (var.shared_open_shift == null ? true : alltrue([(var.shared_open_shift["activities"] == null ? true : alltrue([alltrue([for input1 in var.shared_open_shift["activities"] : (input1 == null ? true : alltrue([(input1["theme"] == null ? true : alltrue([(input1["theme"] == null ? true : contains(["white", "blue", "green", "purple", "pink", "yellow", "gray", "darkBlue", "darkGreen", "darkPurple", "darkPink", "darkYellow"], input1["theme"]))]))]))])])), (var.shared_open_shift["theme"] == null ? true : alltrue([(var.shared_open_shift["theme"] == null ? true : contains(["white", "blue", "green", "purple", "pink", "yellow", "gray", "darkBlue", "darkGreen", "darkPurple", "darkPink", "darkYellow"], var.shared_open_shift["theme"]))]))]))
    error_message = "shared_open_shift: nested required attributes must be non-null and enum values must be supported input members."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "lastModifiedBy", "lastModifiedDateTime", "schedulingGroupInfo", "teamInfo"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
