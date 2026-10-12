variable "additional_information" {
  description = "Microsoft Graph additionalInformation property."
  type        = string
  default     = null
}

variable "creation_date_time" {
  description = "Microsoft Graph creationDateTime property."
  type        = string
  default     = null
}

variable "expiration_date_time" {
  description = "Microsoft Graph expirationDateTime property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.privilegedOperationEvent"
  nullable    = false
}

variable "reference_key" {
  description = "Microsoft Graph referenceKey property."
  type        = string
  default     = null
}

variable "reference_system" {
  description = "Microsoft Graph referenceSystem property."
  type        = string
  default     = null
}

variable "request_type" {
  description = "Microsoft Graph requestType property."
  type        = string
  default     = null
}

variable "requestor_id" {
  description = "Microsoft Graph requestorId property."
  type        = string
  default     = null
}

variable "requestor_name" {
  description = "Microsoft Graph requestorName property."
  type        = string
  default     = null
}

variable "role_id" {
  description = "Microsoft Graph roleId property."
  type        = string
  default     = null
}

variable "role_name" {
  description = "Microsoft Graph roleName property."
  type        = string
  default     = null
}

variable "tenant_id" {
  description = "Microsoft Graph tenantId property."
  type        = string
  default     = null
}

variable "user_id" {
  description = "Microsoft Graph userId property."
  type        = string
  default     = null
}

variable "user_mail" {
  description = "Microsoft Graph userMail property."
  type        = string
  default     = null
}

variable "user_name" {
  description = "Microsoft Graph userName property."
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
