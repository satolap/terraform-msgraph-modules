variable "delegated_admin_relationship_id" {
  description = "The unique identifier of delegatedAdminRelationship"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.delegated_admin_relationship_id)) > 0
    error_message = "delegated_admin_relationship_id must not be empty."
  }
}

variable "action" {
  description = "Microsoft Graph action property."
  type        = string
  default     = null

  validation {
    condition     = var.action == null ? true : contains(["lockForApproval", "approve", "terminate", "unknownFutureValue", "reject"], var.action)
    error_message = "action must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.delegatedAdminRelationshipRequest"
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "lastModifiedDateTime", "status"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
