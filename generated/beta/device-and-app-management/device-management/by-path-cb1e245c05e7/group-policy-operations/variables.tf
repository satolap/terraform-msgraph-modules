variable "group_policy_uploaded_definition_file_id" {
  description = "The unique identifier of groupPolicyUploadedDefinitionFile"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.group_policy_uploaded_definition_file_id)) > 0
    error_message = "group_policy_uploaded_definition_file_id must not be empty."
  }
}

variable "last_modified_date_time" {
  description = "The date and time the entity was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.groupPolicyOperation"
  nullable    = false
}

variable "operation_status" {
  description = "Type of Group Policy operation status."
  type        = string
  default     = null

  validation {
    condition     = var.operation_status == null ? true : contains(["unknown", "inProgress", "success", "failed"], var.operation_status)
    error_message = "operation_status must be one of the documented enum values."
  }
}

variable "operation_type" {
  description = "Type of Group Policy operation."
  type        = string
  default     = null

  validation {
    condition     = var.operation_type == null ? true : contains(["none", "upload", "uploadNewVersion", "addLanguageFiles", "removeLanguageFiles", "updateLanguageFiles", "remove"], var.operation_type)
    error_message = "operation_type must be one of the documented enum values."
  }
}

variable "status_details" {
  description = "The group policy operation status detail."
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
