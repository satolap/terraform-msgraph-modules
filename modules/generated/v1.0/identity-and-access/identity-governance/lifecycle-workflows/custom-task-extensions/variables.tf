variable "authentication_configuration" {
  description = "Configuration for securing the API call to the logic app. For example, using OAuth client credentials flow."
  type        = any
  default     = null
}

variable "callback_configuration" {
  description = "The callback configuration for a custom task extension."
  type        = any
  default     = null
}

variable "client_configuration" {
  description = "HTTP connection settings that define how long Microsoft Entra ID can wait for a connection to a logic app, how many times you can retry a timed-out connection and the exception scenarios when retries are allowed."
  type        = any
  default     = null
}

variable "created_by" {
  description = "The unique identifier of the Microsoft Entra user that created the custom task extension.Supports $filter(eq, ne) and $expand."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "When the custom task extension was created.Supports $filter(lt, le, gt, ge, eq, ne) and $orderby."
  type        = string
  default     = null
}

variable "description" {
  description = "Description for the customCalloutExtension object."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Display name for the customCalloutExtension object."
  type        = string
  default     = null
}

variable "endpoint_configuration" {
  description = "The type and details for configuring the endpoint to call the logic app's workflow."
  type        = any
  default     = null
}

variable "last_modified_by" {
  description = "The unique identifier of the Microsoft Entra user that modified the custom task extension last.Supports $filter(eq, ne) and $expand."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "When the custom extension was last modified.Supports $filter(lt, le, gt, ge, eq, ne) and $orderby."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.identityGovernance.customTaskExtension"
  nullable    = false
}

variable "reply_mode" {
  description = "Microsoft Graph replyMode property."
  type        = string
  default     = null

  validation {
    condition     = var.reply_mode == null ? true : contains(["none", "callback", "response", "unknownFutureValue"], var.reply_mode)
    error_message = "reply_mode must be one of the documented enum values."
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
