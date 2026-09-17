variable "delegated_admin_relationship_id" {
  description = "The unique identifier of delegatedAdminRelationship"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.delegated_admin_relationship_id)) > 0
    error_message = "delegated_admin_relationship_id must not be empty."
  }
}

variable "access_container" {
  description = "Microsoft Graph accessContainer property."
  type = object({
    odata_type          = optional(string, "#microsoft.graph.delegatedAdminAccessContainer")
    accessContainerId   = optional(string)
    accessContainerType = optional(string)
  })
  default = null
}

variable "access_details" {
  description = "Microsoft Graph accessDetails property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.delegatedAdminAccessDetails")
    unifiedRoles = optional(list(object({
      odata_type       = optional(string, "#microsoft.graph.unifiedRole")
      roleDefinitionId = optional(string)
    })))
  })
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.delegatedAdminAccessAssignment"
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
