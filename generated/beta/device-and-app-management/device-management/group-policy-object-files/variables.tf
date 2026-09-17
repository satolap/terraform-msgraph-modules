variable "content" {
  description = "The Group Policy Object file content."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "The date and time at which the GroupPolicy was first uploaded."
  type        = string
  default     = null
}

variable "group_policy_object_id" {
  description = "The Group Policy Object GUID from GPO Xml content"
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time at which the GroupPolicyObjectFile was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.groupPolicyObjectFile"
  nullable    = false
}

variable "ou_distinguished_name" {
  description = "The distinguished name of the OU."
  type        = string
  default     = null
}

variable "role_scope_tag_ids" {
  description = "The list of scope tags for the configuration."
  type        = list(string)
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
