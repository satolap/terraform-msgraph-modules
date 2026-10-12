variable "app_detail" {
  description = "Microsoft Graph appDetail property."
  type = object({
    odata_type           = optional(string, "#microsoft.graph.cloudPcCloudAppDetail")
    commandLineArguments = optional(string)
    filePath             = optional(string)
    iconIndex            = optional(number)
    iconPath             = optional(string)
  })
  default = null
}

variable "app_status" {
  description = "Microsoft Graph appStatus property."
  type        = string
  default     = null

  validation {
    condition     = var.app_status == null ? true : contains(["preparing", "ready", "publishing", "published", "unpublishing", "failed", "unknownFutureValue"], var.app_status)
    error_message = "app_status must be one of the documented enum values."
  }
}

variable "available_to_user" {
  description = "Indicates whether this cloud app is available to end users through the end-user portal or the Windows App. The default value is false. It changes to true if the cloud app is successfully published, and reverts to false when the admin unpublishes the cloud app. Supports $filter, $select, and $orderBy."
  type        = bool
  default     = null
}

variable "description" {
  description = "The description associated with the cloud app. The maximum allowed length for this property is 512 characters. Supports $filter, $select, and $orderBy."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name for the cloud app. The display name for the cloud app, which appears on the end-user portal and must be unique within a single provisioning policy. It uses the discovered app name as the default value. The maximum allowed length for this property is 64 characters. For example, Paint. Supports $filter, $select, and $orderBy."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.cloudPcCloudApp"
  nullable    = false
}

variable "provisioning_policy_id" {
  description = "The ID of the provisioning policy associated with this cloud app. For example, 96133506-c05b-4dbb-a150-ed4adc59895f. Supports $filter, $select, and $orderBy. Required."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["actionFailedErrorCode", "actionFailedErrorMessage", "addedDateTime", "discoveredAppName", "id", "lastPublishedDateTime", "scopeIds"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
