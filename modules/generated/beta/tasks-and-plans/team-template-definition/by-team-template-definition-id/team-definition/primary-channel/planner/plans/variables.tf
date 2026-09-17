variable "team_template_definition_id" {
  description = "The unique identifier of teamTemplateDefinition"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.team_template_definition_id)) > 0
    error_message = "team_template_definition_id must not be empty."
  }
}

variable "container" {
  description = "Identifies the container of the plan. Either specify all properties, or specify only the url, the containerId, and type. After it's set, this property can’t be updated. It changes when a plan is moved from one container to another, using plan move to container. Required."
  type        = any
  default     = null
}

variable "content_sensitivity_label_assignment" {
  description = "The sensitivity label assignment for the plan. Used to classify and protect the plan content based on organizational policies. This property is null if no sensitivity label is assigned. Optional."
  type        = any
  default     = null
}

variable "creation_source" {
  description = "Contains information about the origin of the plan."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.plannerPlan"
  nullable    = false
}

variable "owner" {
  description = "Use the container property instead. ID of the group that owns the plan. After it's set, this property can’t be updated. This property doesn't return a valid group ID if the container of the plan isn't a group."
  type        = string
  default     = null
}

variable "shared_with_containers" {
  description = "List of containers the plan is shared with."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.plannerSharedWithContainer")
    accessLevel = optional(string)
    containerId = optional(string)
    type        = optional(any)
    url         = optional(string)
  }))
  default = null
}

variable "title" {
  description = "Required. Title of the plan."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["archivalInfo", "buckets", "contexts", "createdBy", "createdDateTime", "details", "goals", "historyItems", "id", "isArchived", "tasks"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
