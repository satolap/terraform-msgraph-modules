variable "action_name" {
  description = "Type of action this operation is going to perform. The actionName should be concise and limited to as few words as possible."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the resource operation. The description is used in mouse-over text for the operation when shown in the Azure Portal."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.resourceOperation"
  nullable    = false
}

variable "resource_name" {
  description = "Name of the Resource this operation is performed on."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["enabledForScopeValidation", "id", "resource"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
