variable "device_id" {
  description = "The unique identifier of device"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.device_id)) > 0
    error_message = "device_id must not be empty."
  }
}

variable "app_service_name" {
  description = "Microsoft Graph appServiceName property."
  type        = string
  default     = null
}

variable "error" {
  description = "Microsoft Graph error property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.command"
  nullable    = false
}

variable "package_family_name" {
  description = "Microsoft Graph packageFamilyName property."
  type        = string
  default     = null
}

variable "payload" {
  description = "Microsoft Graph payload property."
  type        = any
  default     = null
}

variable "permission_ticket" {
  description = "Microsoft Graph permissionTicket property."
  type        = string
  default     = null
}

variable "post_back_uri" {
  description = "Microsoft Graph postBackUri property."
  type        = string
  default     = null
}

variable "responsepayload" {
  description = "Microsoft Graph responsepayload property."
  type        = any
  default     = null
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null
}

variable "type" {
  description = "Microsoft Graph type property."
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
