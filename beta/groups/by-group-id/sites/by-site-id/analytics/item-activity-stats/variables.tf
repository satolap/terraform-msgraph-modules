variable "group_id" {
  description = "The unique identifier of group"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.group_id)) > 0
    error_message = "group_id must not be empty."
  }
}

variable "site_id" {
  description = "The unique identifier of site"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.site_id)) > 0
    error_message = "site_id must not be empty."
  }
}

variable "activities" {
  description = "Exposes the itemActivities represented in this itemActivityStat resource."
  type = list(object({
    odata_type       = optional(string, "#microsoft.graph.itemActivity")
    access           = optional(any)
    activityDateTime = optional(string)
    driveItem        = optional(any)
  }))
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.itemActivityStat"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["access", "create", "delete", "edit", "endDateTime", "id", "incompleteData", "isTrending", "move", "startDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
