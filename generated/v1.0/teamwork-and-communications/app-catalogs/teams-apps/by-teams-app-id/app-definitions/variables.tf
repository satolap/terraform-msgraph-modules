variable "teams_app_id" {
  description = "The unique identifier of teamsApp"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.teams_app_id)) > 0
    error_message = "teams_app_id must not be empty."
  }
}

variable "authorization" {
  description = "Authorization requirements specified in the Teams app manifest."
  type        = any
  default     = null
}

variable "bot" {
  description = "The details of the bot specified in the Teams app manifest."
  type        = any
  default     = null
}

variable "created_by" {
  description = "Microsoft Graph createdBy property."
  type        = any
  default     = null
}

variable "description" {
  description = "Verbose description of the application."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The name of the app provided by the app developer."
  type        = string
  default     = null
}

variable "graph_version" {
  description = "The version number of the application."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "Microsoft Graph lastModifiedDateTime property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.teamsAppDefinition"
  nullable    = false
}

variable "publishing_state" {
  description = "The published status of a specific version of a Teams app. The possible values are:submitted—The specific version of the Teams app was submitted and is under review.published—The request to publish the specific version of the Teams app was approved by the admin and the app is published.rejected—The admin rejected the request to publish the specific version of the Teams app."
  type        = any
  default     = null

  validation {
    condition     = var.publishing_state == null ? true : contains(["submitted", "rejected", "published", "unknownFutureValue"], var.publishing_state)
    error_message = "publishing_state must be one of the documented enum values."
  }
}

variable "short_description" {
  description = "Short description of the application."
  type        = string
  default     = null
}

variable "teams_app_id_2" {
  description = "The ID from the Teams app manifest."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
