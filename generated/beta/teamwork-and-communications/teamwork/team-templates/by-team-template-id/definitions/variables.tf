variable "team_template_id" {
  description = "The unique identifier of teamTemplate"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.team_template_id)) > 0
    error_message = "team_template_id must not be empty."
  }
}

variable "audience" {
  description = "Describes the audience the team template is available to. The possible values are: organization, user, public, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.audience == null ? true : contains(["organization", "user", "public", "unknownFutureValue"], var.audience)
    error_message = "audience must be one of the documented enum values."
  }
}

variable "categories" {
  description = "The assigned categories for the team template."
  type        = list(string)
  default     = null
}

variable "description" {
  description = "A brief description of the team template as it will appear to the users in Microsoft Teams."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The user defined name of the team template."
  type        = string
  default     = null
}

variable "icon_url" {
  description = "The icon url for the team template."
  type        = string
  default     = null
}

variable "language_tag" {
  description = "Language the template is available in."
  type        = string
  default     = null
}

variable "last_modified_by" {
  description = "The identity of the user who last modified the team template."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "The date time of when the team template was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.teamTemplateDefinition"
  nullable    = false
}

variable "parent_template_id" {
  description = "The templateId for the team template"
  type        = string
  default     = null
}

variable "publisher_name" {
  description = "The organization which published the team template."
  type        = string
  default     = null
}

variable "short_description" {
  description = "A short-description of the team template as it will appear to the users in Microsoft Teams."
  type        = string
  default     = null
}

variable "team_definition" {
  description = "Collection of channel objects. A channel represents a topic, and therefore a logical isolation of discussion, within a team."
  type        = any
  default     = null
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
