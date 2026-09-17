variable "client_id" {
  description = "The client ID for the application. This is the client ID obtained when registering the application with the identity provider. Required. Not nullable."
  type        = string
  default     = null
}

variable "client_secret" {
  description = "The client secret for the application. This is the client secret obtained when registering the application with the identity provider. This is write-only. A read operation will return .  Required. Not nullable."
  type        = string
  default     = null
  sensitive   = true
}

variable "name" {
  description = "The display name of the identity provider. Not nullable."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.identityProvider"
  nullable    = false
}

variable "type" {
  description = "The identity provider type is a required field. For B2B scenario: Google, Facebook. For B2C scenario: Microsoft, Google, Amazon, LinkedIn, Facebook, GitHub, Twitter, Weibo, QQ, WeChat, OpenIDConnect. Not nullable."
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
