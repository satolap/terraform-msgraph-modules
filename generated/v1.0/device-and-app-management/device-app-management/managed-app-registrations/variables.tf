variable "app_identifier" {
  description = "The app package Identifier"
  type        = any
  default     = null
}

variable "application_version" {
  description = "App version"
  type        = string
  default     = null
}

variable "applied_policies" {
  description = "Zero or more policys already applied on the registered app when it last synchronized with managment service."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.managedAppPolicy")
    createdDateTime      = optional(string)
    description          = optional(string)
    displayName          = optional(string)
    lastModifiedDateTime = optional(string)
    version              = optional(string)
  }))
  default = null
}

variable "created_date_time" {
  description = "Date and time of creation"
  type        = string
  default     = null
}

variable "device_name" {
  description = "Host device name"
  type        = string
  default     = null
}

variable "device_tag" {
  description = "App management SDK generated tag, which helps relate apps hosted on the same device. Not guaranteed to relate apps in all conditions."
  type        = string
  default     = null
}

variable "device_type" {
  description = "Host device type"
  type        = string
  default     = null
}

variable "flagged_reasons" {
  description = "Zero or more reasons an app registration is flagged. E.g. app running on rooted device"
  type        = list(string)
  default     = null
}

variable "graph_version" {
  description = "Version of the entity."
  type        = string
  default     = null
}

variable "intended_policies" {
  description = "Zero or more policies admin intended for the app as of now."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.managedAppPolicy")
    createdDateTime      = optional(string)
    description          = optional(string)
    displayName          = optional(string)
    lastModifiedDateTime = optional(string)
    version              = optional(string)
  }))
  default = null
}

variable "last_sync_date_time" {
  description = "Date and time of last the app synced with management service."
  type        = string
  default     = null
}

variable "management_sdk_version" {
  description = "App management SDK version"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.managedAppRegistration"
  nullable    = false
}

variable "operations" {
  description = "Zero or more long running operations triggered on the app registration."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.managedAppOperation")
    displayName          = optional(string)
    lastModifiedDateTime = optional(string)
    state                = optional(string)
    version              = optional(string)
  }))
  default = null
}

variable "platform_version" {
  description = "Operating System version"
  type        = string
  default     = null
}

variable "user_id" {
  description = "The user Id to who this app registration belongs."
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
