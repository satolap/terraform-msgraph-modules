variable "added_date_time" {
  description = "The date and time when the impactedResource object was initially associated with the recommendation."
  type        = string
  default     = null
}

variable "additional_details" {
  description = "Additional information unique to the impactedResource to help contextualize the recommendation."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.keyValue")
    key        = optional(string)
    value      = optional(string)
  }))
  default = null
}

variable "api_url" {
  description = "The URL link to the corresponding Microsoft Entra resource."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Friendly name of the Microsoft Entra resource."
  type        = string
  default     = null
}

variable "last_modified_by" {
  description = "Name of the user or service that last updated the status."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time when the status was last updated."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.impactedResource"
  nullable    = false
}

variable "owner" {
  description = "The user responsible for maintaining the resource."
  type        = string
  default     = null
}

variable "portal_url" {
  description = "The URL link to the corresponding Microsoft Entra admin center page of the resource."
  type        = string
  default     = null
}

variable "postpone_until_date_time" {
  description = "The future date and time when the status of a postponed impactedResource will be active again."
  type        = string
  default     = null
}

variable "rank" {
  description = "Indicates the importance of the resource. A resource with a rank equal to 1 is of the highest importance."
  type        = number
  default     = null
}

variable "recommendation_id" {
  description = "The unique identifier of the recommendation that the resource is associated with."
  type        = string
  default     = null
}

variable "resource_type" {
  description = "Indicates the type of Microsoft Entra resource. Examples include user, application."
  type        = string
  default     = null
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["active", "completedBySystem", "completedByUser", "dismissed", "postponed", "unknownFutureValue", "riskAccepted", "thirdParty", "planned", "alternateMitigation", "needsMoreAction"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "subject_id" {
  description = "The related unique identifier, depending on the resourceType. For example, this property is set to the applicationId if the resourceType is an application."
  type        = string
  default     = null
}

variable "tags" {
  description = "Microsoft Graph tags property."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.recommendationTag")
    displayName = optional(string)
  }))
  default = null
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
