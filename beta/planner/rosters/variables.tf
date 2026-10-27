variable "assigned_sensitivity_label" {
  description = "The sensitivity label applied to the roster. If mandatory labeling is enabled for the user and no label is specified, the user can't create the roster. Also, if labels are mandatory for the user, the user can't change the label of the roster to null. The possible values are: standard, privileged, auto, unknownFutureValue."
  type = object({
    odata_type         = optional(string, "#microsoft.graph.sensitivityLabelAssignment")
    assignmentMethod   = optional(string)
    sensitivityLabelId = optional(string)
    tenantId           = optional(string)
  })
  default = null

  validation {
    condition     = (var.assigned_sensitivity_label == null ? true : alltrue([(var.assigned_sensitivity_label["assignmentMethod"] == null ? true : alltrue([(var.assigned_sensitivity_label["assignmentMethod"] == null ? true : contains(["standard", "privileged", "auto"], var.assigned_sensitivity_label["assignmentMethod"]))]))]))
    error_message = "assigned_sensitivity_label: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "members" {
  description = "Retrieves the members of the plannerRoster."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.plannerRosterMember")
    roles      = optional(list(string))
    tenantId   = optional(string)
    userId     = optional(string)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.plannerRoster"
  nullable    = false
}

variable "plans" {
  description = "Retrieves the plans contained by the plannerRoster."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.plannerPlan")
    container  = optional(any)
    contentSensitivityLabelAssignment = optional(object({
      odata_type         = optional(string, "#microsoft.graph.contentSensitivityLabelAssignment")
      assignmentMethod   = optional(string)
      justificationText  = optional(string)
      sensitivityLabelId = optional(string)
      tenantId           = optional(string)
    }))
    creationSource = optional(any)
    owner          = optional(string)
    sharedWithContainers = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.plannerSharedWithContainer")
      accessLevel = optional(string)
      containerId = optional(string)
      type        = optional(string)
      url         = optional(string)
    })))
    title = optional(string)
  }))
  default = null

  validation {
    condition     = (var.plans == null ? true : alltrue([alltrue([for input0 in var.plans : (input0 == null ? true : alltrue([(input0["contentSensitivityLabelAssignment"] == null ? true : alltrue([(input0["contentSensitivityLabelAssignment"]["assignmentMethod"] == null ? true : alltrue([(input0["contentSensitivityLabelAssignment"]["assignmentMethod"] == null ? true : contains(["standard", "privileged", "auto"], input0["contentSensitivityLabelAssignment"]["assignmentMethod"]))]))])), (input0["sharedWithContainers"] == null ? true : alltrue([alltrue([for input2 in input0["sharedWithContainers"] : (input2 == null ? true : alltrue([(input2["accessLevel"] == null ? true : alltrue([(input2["accessLevel"] == null ? true : contains(["readAccess", "readWriteAccess", "fullAccess"], input2["accessLevel"]))])), (input2["type"] == null ? true : alltrue([(input2["type"] == null ? true : contains(["group"], input2["type"]))]))]))])]))]))])]))
    error_message = "plans: nested required attributes must be non-null and enum values must be supported input members."
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
