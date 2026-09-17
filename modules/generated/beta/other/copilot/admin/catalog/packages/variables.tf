variable "acquire_users_and_groups" {
  description = "Microsoft Graph acquireUsersAndGroups property."
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.packageAccessEntity")
    resourceId   = optional(string)
    resourceType = optional(string)
  }))
  default = null
}

variable "active_users" {
  description = "The number of distinct users who actively used the package during the reporting period."
  type        = number
  default     = null
}

variable "agent_identity_id" {
  description = "Microsoft Graph agentIdentityId property."
  type        = string
  default     = null
}

variable "allowed_users_and_groups" {
  description = "Microsoft Graph allowedUsersAndGroups property."
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.packageAccessEntity")
    resourceId   = optional(string)
    resourceType = optional(string)
  }))
  default = null
}

variable "app_id" {
  description = "Microsoft Graph appId property."
  type        = string
  default     = null
}

variable "asset_id" {
  description = "Microsoft Graph assetId property."
  type        = string
  default     = null
}

variable "available_to" {
  description = "Microsoft Graph availableTo property."
  type        = string
  default     = null

  validation {
    condition     = var.available_to == null ? true : contains(["none", "some", "all", "unknownFutureValue"], var.available_to)
    error_message = "available_to must be one of the documented enum values."
  }
}

variable "categories" {
  description = "Microsoft Graph categories property."
  type        = list(string)
  default     = null
}

variable "created_date_time" {
  description = "Microsoft Graph createdDateTime property."
  type        = string
  default     = null
}

variable "deployed_to" {
  description = "Microsoft Graph deployedTo property."
  type        = string
  default     = null

  validation {
    condition     = var.deployed_to == null ? true : contains(["none", "some", "all", "unknownFutureValue"], var.deployed_to)
    error_message = "deployed_to must be one of the documented enum values."
  }
}

variable "display_name" {
  description = "Microsoft Graph displayName property."
  type        = string
  default     = null
}

variable "element_details" {
  description = "Microsoft Graph elementDetails property."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.packageElementDetail")
    elementType = optional(string)
    elements = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.packageElement")
      definition = optional(any)
      id         = optional(string)
    })))
  }))
  default = null
}

variable "element_types" {
  description = "Microsoft Graph elementTypes property."
  type        = list(string)
  default     = null
}

variable "exception_rate" {
  description = "The fraction of sessions that resulted in an exception, expressed as a value between 0 and 1."
  type        = any
  default     = null
}

variable "governance_metadata" {
  description = "Microsoft Graph governanceMetadata property."
  type        = any
  default     = null
}

variable "graph_version" {
  description = "Microsoft Graph version property."
  type        = string
  default     = null
}

variable "is_blocked" {
  description = "Microsoft Graph isBlocked property."
  type        = bool
  default     = null
}

variable "last_modified_date_time" {
  description = "Microsoft Graph lastModifiedDateTime property."
  type        = string
  default     = null
}

variable "last_used_date_time" {
  description = "The date and time when the package was last used, in ISO 8601 format and UTC."
  type        = string
  default     = null
}

variable "long_description" {
  description = "Microsoft Graph longDescription property."
  type        = string
  default     = null
}

variable "manifest_id" {
  description = "Microsoft Graph manifestId property."
  type        = string
  default     = null
}

variable "manifest_version" {
  description = "Microsoft Graph manifestVersion property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.copilotPackageDetail"
  nullable    = false
}

variable "owner_id" {
  description = "Microsoft Graph ownerId property."
  type        = string
  default     = null
}

variable "platform" {
  description = "Microsoft Graph platform property."
  type        = string
  default     = null
}

variable "publisher" {
  description = "Microsoft Graph publisher property."
  type        = string
  default     = null
}

variable "request_status" {
  description = "Microsoft Graph requestStatus property."
  type        = any
  default     = null

  validation {
    condition     = var.request_status == null ? true : contains(["pending", "approved", "rejected", "unknownFutureValue"], var.request_status)
    error_message = "request_status must be one of the documented enum values."
  }
}

variable "request_type" {
  description = "Microsoft Graph requestType property."
  type        = any
  default     = null

  validation {
    condition     = var.request_type == null ? true : contains(["publish", "activate", "access", "update", "unknownFutureValue"], var.request_type)
    error_message = "request_type must be one of the documented enum values."
  }
}

variable "sensitivity" {
  description = "Microsoft Graph sensitivity property."
  type        = string
  default     = null
}

variable "shared_with_users_and_groups" {
  description = "Microsoft Graph sharedWithUsersAndGroups property."
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.packageAccessEntity")
    resourceId   = optional(string)
    resourceType = optional(string)
  }))
  default = null
}

variable "short_description" {
  description = "Microsoft Graph shortDescription property."
  type        = string
  default     = null
}

variable "supported_hosts" {
  description = "Microsoft Graph supportedHosts property."
  type        = list(string)
  default     = null
}

variable "total_run_time_in_hours" {
  description = "Total hours worked by the agent."
  type        = any
  default     = null
}

variable "total_sessions" {
  description = "The total number of sessions served by the package during the reporting period."
  type        = number
  default     = null
}

variable "type" {
  description = "Microsoft Graph type property."
  type        = string
  default     = null

  validation {
    condition     = var.type == null ? true : contains(["microsoft", "external", "shared", "custom", "unknownFutureValue"], var.type)
    error_message = "type must be one of the documented enum values."
  }
}

variable "zip_file" {
  description = "Microsoft Graph zipFile property."
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
