variable "team_id" {
  description = "The unique identifier of team"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.team_id)) > 0
    error_message = "team_id must not be empty."
  }
}

variable "channel_id" {
  description = "The unique identifier of channel"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.channel_id)) > 0
    error_message = "channel_id must not be empty."
  }
}

variable "configuration" {
  description = "Container for custom settings applied to a tab. The tab is considered configured only once this property is set."
  type = object({
    odata_type = optional(string, "#microsoft.graph.teamsTabConfiguration")
    contentUrl = optional(string)
    entityId   = optional(string)
    removeUrl  = optional(string)
    websiteUrl = optional(string)
  })
  default = null
}

variable "display_name" {
  description = "Name of the tab."
  type        = string
  default     = null
}

variable "message_id" {
  description = "Microsoft Graph messageId property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.teamsTab"
  nullable    = false
}

variable "sort_order_index" {
  description = "Index of the order used for sorting tabs."
  type        = string
  default     = null
}

variable "teams_app" {
  description = "The application that is linked to the tab."
  type        = any
  default     = null
}

variable "teams_app_id" {
  description = "App definition identifier of the tab. This value can't be changed after tab creation. Because this property is deprecated, we recommend expanding teamsApp to retrieve the application that is linked to the tab."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "webUrl"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
