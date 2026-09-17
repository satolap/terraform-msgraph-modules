variable "catalog" {
  description = "Microsoft Graph catalog property."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.accessPackageResourceRequest"
  nullable    = false
}

variable "request_type" {
  description = "The type of the request. Use adminAdd to add a resource, if the caller is an administrator or resource owner, adminUpdate to update a resource, or adminRemove to remove a resource."
  type        = any
  default     = null

  validation {
    condition     = var.request_type == null ? true : contains(["notSpecified", "userAdd", "userUpdate", "userRemove", "adminAdd", "adminUpdate", "adminRemove", "systemAdd", "systemUpdate", "systemRemove", "onBehalfAdd", "unknownFutureValue", "approverRemove"], var.request_type)
    error_message = "request_type must be one of the documented enum values."
  }
}

variable "resource" {
  description = "Microsoft Graph resource property."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "state"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
