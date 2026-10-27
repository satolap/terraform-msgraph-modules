variable "acceptance_statement" {
  description = "Administrator-supplied explanation of the terms and conditions, typically describing what it means to accept the terms and conditions set out in the T&C policy. This is shown to the user on prompts to accept the T&C policy."
  type        = string
  default     = null
}

variable "acceptance_statuses" {
  description = "The list of acceptance statuses for this T&C policy."
  type = list(object({
    odata_type         = optional(string, "#microsoft.graph.termsAndConditionsAcceptanceStatus")
    acceptedDateTime   = optional(string)
    acceptedVersion    = optional(number)
    termsAndConditions = optional(any)
    userDisplayName    = optional(string)
    userPrincipalName  = optional(string)
  }))
  default = null
}

variable "assignments" {
  description = "The list of assignments for this T&C policy."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.termsAndConditionsAssignment")
    target     = optional(any)
  }))
  default = null
}

variable "body_text" {
  description = "Administrator-supplied body text of the terms and conditions, typically the terms themselves. This is shown to the user on prompts to accept the T&C policy."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "DateTime the object was created."
  type        = string
  default     = null
}

variable "description" {
  description = "Administrator-supplied description of the T&C policy."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Administrator-supplied name for the T&C policy."
  type        = string
  default     = null
}

variable "graph_version" {
  description = "Integer indicating the current version of the terms. Incremented when an administrator makes a change to the terms and wishes to require users to re-accept the modified T&C policy."
  type        = number
  default     = null
}

variable "group_assignments" {
  description = "The list of group assignments for this T&C policy."
  type = list(object({
    odata_type         = optional(string, "#microsoft.graph.termsAndConditionsGroupAssignment")
    targetGroupId      = optional(string)
    termsAndConditions = optional(any)
  }))
  default = null
}

variable "last_modified_date_time" {
  description = "DateTime the object was last modified."
  type        = string
  default     = null
}

variable "modified_date_time" {
  description = "DateTime the object was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.termsAndConditions"
  nullable    = false
}

variable "role_scope_tag_ids" {
  description = "List of Scope Tags for this Entity instance."
  type        = list(string)
  default     = null
}

variable "title" {
  description = "Administrator-supplied title of the terms and conditions. This is shown to the user on prompts to accept the T&C policy."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
