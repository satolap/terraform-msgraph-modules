variable "delegated_admin_relationship_id" {
  description = "The unique identifier of delegatedAdminRelationship"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.delegated_admin_relationship_id)) > 0
    error_message = "delegated_admin_relationship_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.delegatedAdminRelationshipOperation"
  nullable    = false
}

variable "operation_type" {
  description = "Microsoft Graph operationType property."
  type        = string
  default     = null

  validation {
    condition     = var.operation_type == null ? true : contains(["delegatedAdminAccessAssignmentUpdate", "unknownFutureValue", "delegatedAdminRelationshipUpdate"], var.operation_type)
    error_message = "operation_type must be one of the documented enum values."
  }
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["notStarted", "running", "succeeded", "failed", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "data", "id", "lastModifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
