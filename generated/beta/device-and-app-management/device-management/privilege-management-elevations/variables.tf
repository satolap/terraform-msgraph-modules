variable "certificate_payload" {
  description = "The certificate payload of the application. This is computed by hashing the certificate information on the client. Example: 32c220482c68413fbf8290e3b1e49b0a85901cfcd62ab0738760568a2a6e8a50"
  type        = string
  default     = null
}

variable "company_name" {
  description = "The company name of the application. This value is set by the creator of the application. Example: Microsoft Corporation"
  type        = string
  default     = null
}

variable "device_id" {
  description = "The Intune deviceId. Unique identifier for the managed device. Example: 92ce5047-9553-4731-817f-9b401a999a1b"
  type        = string
  default     = null
}

variable "device_name" {
  description = "The name associated with the device in the intune database. Example: JOHNDOE-LAPTOP."
  type        = string
  default     = null
}

variable "elevation_type" {
  description = "Indicates the type of elevation occured"
  type        = string
  default     = null

  validation {
    condition     = var.elevation_type == null ? true : contains(["undetermined", "unmanagedElevation", "zeroTouchElevation", "userConfirmedElevation", "supportApprovedElevation", "unknownFutureValue"], var.elevation_type)
    error_message = "elevation_type must be one of the documented enum values."
  }
}

variable "event_date_time" {
  description = "The date and time when the application was elevated. Example:2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "file_description" {
  description = "The file description of the application. This value is set by the creator of the application. Example: Editor of multiple coding languages."
  type        = string
  default     = null
}

variable "file_path" {
  description = "The full file path of the application including the filename and file extension. Example: C:/Program Files/vscode.exe"
  type        = string
  default     = null
}

variable "file_version" {
  description = "The version of the application. This value is set by the creator of the application. Example: 6.2211.1035.1000"
  type        = string
  default     = null
}

variable "hash" {
  description = "The sha256 hash of the application. Example: 32c220482c68413fbf8290e3b1e49b0a85901cfcd62ab0738760568a2a6e8a57"
  type        = string
  default     = null
}

variable "internal_name" {
  description = "The internal name of the application. This value is set by the creator of the application. Example: VS code"
  type        = string
  default     = null
}

variable "justification" {
  description = "The justification to elevate the application. This is an input by the user when the privilegeManagementElevationType is of type userConfirmedElevation or support approved elevation. This will be null in all other scenarios. The length is capped at 256 char, enforced on the client side. Example: To install debug tool.."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.privilegeManagementElevation"
  nullable    = false
}

variable "parent_process_name" {
  description = "The name of parent process associated with the elevated process. This is always populated for both parent and child process types"
  type        = string
  default     = null
}

variable "policy_id" {
  description = "Unique Identifier of the policy configured to run the application with elevated access"
  type        = string
  default     = null
}

variable "policy_name" {
  description = "The name of the policy configured to run the application in elevated access"
  type        = string
  default     = null
}

variable "process_type" {
  description = "Indicates the type of elevated process"
  type        = string
  default     = null

  validation {
    condition     = var.process_type == null ? true : contains(["undefined", "parent", "child", "unknownFutureValue"], var.process_type)
    error_message = "process_type must be one of the documented enum values."
  }
}

variable "product_name" {
  description = "The product name of the application. This value is set by the creator of the application. Example: Visual Studio"
  type        = string
  default     = null
}

variable "result" {
  description = "The result of the elevation action with 0 being success, and everything else being exit code if the elevation was unsuccessful. The value will always be 0 on all unmanaged elevation. Example: 0. Valid values 0 to 2147483647"
  type        = number
  default     = null
}

variable "rule_id" {
  description = "Unique identifier of the rule configured to run the application with elevated access"
  type        = string
  default     = null
}

variable "system_initiated_elevation" {
  description = "To identify if the elevation is initiated by system or user interaction"
  type        = bool
  default     = null
}

variable "upn" {
  description = "The User Principal Name of the user who performed the elevation. Example: john@domain.com"
  type        = string
  default     = null
}

variable "user_type" {
  description = "The type of user account on Windows that was used to performed the elevation."
  type        = string
  default     = null

  validation {
    condition     = var.user_type == null ? true : contains(["undetermined", "azureAd", "hybrid", "local", "unknownFutureValue"], var.user_type)
    error_message = "user_type must be one of the documented enum values."
  }
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
